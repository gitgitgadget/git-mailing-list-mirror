From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Does CVS has a easy way to compare file with its previous version?
Date: Wed, 01 Jul 2009 01:28:37 +0200
Message-ID: <4A4A9FA5.7000009@gnu.org>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com> <m3hbxxx5jk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dtletmn <dtletmedn@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 01:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLmks-0002V8-2S
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 01:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760415AbZF3X2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 19:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760290AbZF3X2i
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 19:28:38 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58815 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760457AbZF3X2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 19:28:37 -0400
Received: by ewy6 with SMTP id 6so655954ewy.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=m8dz07j6muu7lO2RsTgesrFQu0mEcouvr2pnpOIo1t4=;
        b=L+99vrAnODOJMsxTwLP92EKPiiEumCIjQyYxCIXA/o9iLaXQAU97Z55yrkzSODhVOC
         MBqaKobt5Ds0RGgIsQnluTgUu9bRjmbGvrXbgcQqZKQx1HsEGU2OB1OS5pzMbeUfw5AE
         yjwl+nbjZFKHBQaYLREsZicychtEHpFl6oEhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=O6TL49B0Yc2QLZ7+11O8FxrlnkG7zTTSPtBctLvpMGLGhW/sTZwOoWVhS5aWumbb63
         0aQpuhNIKmNO/vXnt0h+ALGXxnIfWGNzUuimZr+Z5QfKK4kC+aeGvDdr8jV3mOZWW5wJ
         S144LcMuAqBgICYFXysP0K7QgDVT2i2K1XBBo=
Received: by 10.210.127.10 with SMTP id z10mr5032566ebc.2.1246404519309;
        Tue, 30 Jun 2009 16:28:39 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-str.redhat.com [66.187.229.200])
        by mx.google.com with ESMTPS id 28sm540282eyg.24.2009.06.30.16.28.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 16:28:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <m3hbxxx5jk.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122553>

On 06/30/2009 02:36 PM, Jakub Narebski wrote:
> dtletmn<dtletmedn@gmail.com>  writes:
>
>> Hi,All,
>>
>>       I am wondering if cvs has an easy way to compare a file with its
>> previous version.
>>
>>       In clearcase,I can use  :
>>         cleartool diff -pred file.cc
>>
>>       how can I acheive it in CVS?
>>       any help would be highly appreciated!
>
> In CVS or in Git?
>
> In CVS: "cvs diff -r<previous revision>  <file>".
> In Git: "git diff HEAD^ --<file>".

I think he wants something more like

git diff `git log -2 --pretty=format:%h` <file> -- <file>

In CVS it should not be hard, but I definitely have no idea.

Paolo
