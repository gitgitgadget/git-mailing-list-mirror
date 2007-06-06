From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 6 Jun 2007 13:27:57 +0200
Message-ID: <81b0412b0706060427l1846bde7racabcfea5d15bdb4@mail.gmail.com>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
	 <7v3b157b4j.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0706060142h2df41f11pa0157a360831736@mail.gmail.com>
	 <7vps495uvs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "J Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 13:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvtgO-0005Vq-BF
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 13:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760748AbXFFL2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 07:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761490AbXFFL2A
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 07:28:00 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:56868 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761076AbXFFL17 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 07:27:59 -0400
Received: by ik-out-1112.google.com with SMTP id b32so91509ika
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 04:27:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a1lVDdohCwe2HoHZacIUnY4jTLeE5QV5o7qAZffI6lPjIOmoD5QbPTa9POclqRQ1CkNoT2meVpDKa6UU4bbgVvfQkdehvCHw0Gl9ne49zR2wWVdzc+ghmwTSyjsKPyKfTW52PtXrjw38NQddCFoWgWsx54NtMP+8blnTr6vgBro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oV3tB9do0Pf9LRdxMevDlveFaounvdq6DicykpNvLqb1RWjO2rPTGY3nn+hEMY44GdCoysguyssN84QbJWY1kGozGlBJgHKFVvzLENzzglPmlsj2Yvkn6f0GqUWDYRYuLHdeP7Vxvjzx5J2SqimGlG+xR327frdqkthBo9eKIm0=
Received: by 10.78.201.2 with SMTP id y2mr120556huf.1181129277810;
        Wed, 06 Jun 2007 04:27:57 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 6 Jun 2007 04:27:57 -0700 (PDT)
In-Reply-To: <7vps495uvs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49285>

On 6/6/07, J Junio C Hamano <gitster@pobox.com> wrote:
> > Which one was fetched when? /home/user/a or /home/user/a.git?
>
> I am half tempted to say that this is very close to "doctor, it
> confuses me when I have both of them".  Imagine the case where
> the source were a remote repository _and_ there was no way other
> than interacting with it via git protocol.  You cannot really
> tell (well, you can tell half, by trying both and if a worked
> but a.git didn't you can tell that a.git does not exist) nor you
> do not really care.

Of course you can! Just print the path to the remote EXACTLY
how the user entered it!

> > Besides, I just noticed git-clone is broken WRT the .git
> > as well: I can clone a "a.git" into "b" (and it ignores -l and -s!),
> > but I can't fetch the "a" (aka "origin") being in "b". And of
> > course, "origin" in "b" is setup as "/path/a", not "/path/a.git".
>
> This probably is worth fixing, independent from what the message
> says before or after your patch.

And "probably" means: it is broken, but this is ok?
