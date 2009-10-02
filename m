From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 1/2] do not mangle short options which take arguments
Date: Fri, 02 Oct 2009 09:46:11 +0200
Message-ID: <4AC5AFC3.7000706@gnu.org>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091002061159.GA24892@coredump.intra.peff.net> <20091002073628.GA9444@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 02 09:46:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtcqK-0002My-PK
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 09:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZJBHqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 03:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbZJBHqL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 03:46:11 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:35141 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbZJBHqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 03:46:10 -0400
Received: by ewy7 with SMTP id 7so893313ewy.17
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=wTg7mReLwrhCK4vq8CXWkV8MD9EbqH/Jm1i7Lc64yR0=;
        b=knQy69hO8Jprkc+0r5Og4eMrOxPauGfnIhtCPeyTrK7gVBcvsx58hgmorLfaSr2wBx
         jk0pBQFhVTA9UBlCHBm8J8XRBQH+36aNy04NE5PvPEE/DO1dCALIK+ebfLusI4g3j/38
         8GvQEVEoHobfermd2v4Wut1/lKmbKEhY2PrYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lw3n9cMAGpbRYLJUaCYf9FCQX9kRl2Ng0sZMCHVCaKVi09SuO+k5+Yu0FczPcUmv2y
         dx3/3xh/SFBrdKGzpQsV015c8fTkYKzefmvEAWZyyk5J3wVsnGpfrfZ6Chm0zyhBN4p2
         wtB4L/1cVVk7y1tC1ILRfxdesGAc0Eh6fUPiY=
Received: by 10.210.95.3 with SMTP id s3mr2642226ebb.47.1254469573694;
        Fri, 02 Oct 2009 00:46:13 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 28sm1578100eyg.20.2009.10.02.00.46.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 00:46:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <20091002073628.GA9444@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129425>

On 10/02/2009 09:36 AM, Clemens Buchacher wrote:
> Well, an error message is a lot safer than executing something you did not
> intend.

If this is just for double --amend typos I don't see the need.  What you 
intended is just one "git rebase -i HEAD^^" away.

Notice that in Shawn's original example the guy actually passed -a too, 
so he would not even have the problem of overwriting the index due to -a.

If you have bouncy fingers, you can just make an alias

    ammend-fix = git reset --soft HEAD^ && git gui citool

Paolo
