From: Vitaly <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 09:55:19 +0400
Message-ID: <4BBC1E47.80308@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com> <4BBB53F5.9010106@op5.se> <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com> <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com> <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 07:55:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzOEw-000497-Qn
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0DGFzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 01:55:46 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41248 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab0DGFzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 01:55:45 -0400
Received: by bwz1 with SMTP id 1so497194bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=R1z8lWRcY5YJBxn4EYaQF6R8rdH+gTBsQFaeKYcHqFs=;
        b=RAJdNVT5wd0bdSt//i7u5CNZOCGpeuLsyaHapFtGoiwO9n/8rtSlkWS5iCSPLmtDFf
         gdOtjPwq28E+j+fAQELkbFGSmRn4e8W/OOKfejLNAdl87scc9J1V8LKhMo+IcfyCh6Ip
         NaP5w2IRHL9XY1YPdyj7GgNPXqN1Wrz4FrtGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aCrONQZ5/qtbF9Cf5qYjaqQpurxlSlzpZiQjOHBRoiBsbSWFL8/A4gNbx/kcTcYoXx
         AvStfOi84wlaKdDo/q+2tNz8AUlQ5oO7qucDY2f5R3jfJ91k+ly6REmR+V1Xljwm9uuW
         E8ZHXJ2DMvqXY5pzMhAlPTf887/z7TN7c9K48=
Received: by 10.204.25.145 with SMTP id z17mr8457844bkb.181.1270619743769;
        Tue, 06 Apr 2010 22:55:43 -0700 (PDT)
Received: from [172.16.11.219] ([195.218.191.171])
        by mx.google.com with ESMTPS id 14sm6631708bwz.2.2010.04.06.22.55.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 22:55:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144198>

I suspected the security reasons.

Ok, we work in trusted environment. How can we turn this behavior off?

On 04/07/2010 01:09 AM, Nicolas Pitre wrote:
> On Tue, 6 Apr 2010, Vitaly Berov wrote:
>
>    
>> Why does git compute checksums on the client side? Isn't it already
>> calculated on the "server" side?
>>      
> Yes.  But Git clients can't trust the server like that.
>
> The only way to make sure the server didn't send you crap data, or worse
> maliciously altered data, is actually to not transfer any checksum data
> but to recompute and validate the received payload locally.
>
> This being said, you should never have to wait 6 hours for that phase to
> complete.  It is typically a matter of minutes if not seconds.
>
>
> Nicolas
>
>    
