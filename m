From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Fri, 19 Mar 2010 13:17:35 -0400
Message-ID: <32541b131003191017rdc4e87fgcc4fabc76e0709be@mail.gmail.com>
References: <4B67227A.7030908@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> 
	<4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 
	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> 
	<32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> 
	<b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com> 
	<32541b131003181033p7916d92frc1269b95c292e3db@mail.gmail.com> 
	<4BA335B6.4000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 19 18:26:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsfxZ-0007xy-3b
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab0CSRZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 13:25:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55441 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0CSRZz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 13:25:55 -0400
Received: by gyg8 with SMTP id 8so1646182gyg.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rAglmODxEzAZLr0VRx55GBx/9nYe4qCgjqo2Jm3XlyY=;
        b=gIcH/ijksm3F4hksKeVN2KdkCtsTGDne0eUgzH+GH4F8VcLloKIovneB/zOEsS7H/D
         CiC4Mrec0WcwrNLhLxgqRKt8oTXWlpmCdAGHtXkgdTGfQ/m1Tka+Z0/NX+YT2Ls6uF/O
         hYWzzSp+HoAIYTwys4Or4u6X8gBmhqGxVBjoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=U4sM0N3gk1HXInU0X6Cpenk6ilcQKnH99ldXD5caD/IH77pKDNQ/vzQY5B1o0hgKZN
         6/tl3EhS/JProE0mIOA4Z9sPy19EuQRMWw2JM/mlzDM33dSsvLHujzj+GSEraJ7mT1tS
         6K28HgQc20A9THT8NwvkNUHJgEmGcMvL0hK88=
Received: by 10.150.56.35 with SMTP id e35mr135118yba.118.1269019075120; Fri, 
	19 Mar 2010 10:17:55 -0700 (PDT)
In-Reply-To: <4BA335B6.4000103@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142624>

On Fri, Mar 19, 2010 at 4:28 AM, Markus Elfring <Markus.Elfring@web.de>=
 wrote:
>> The stash can contain multiple entries. =A0They're stored in a stack=
,
>> but you can pull prior entries out of the stack if you want.
>
> I am missing a semantic relationship of the stashed files to the work=
 that they
> belong to in various branches. I would appreciate to see a clear conn=
ection
> between them.

Then what you want is just a temporary commit.

I think your mental model has exaggerated the cost of a commit.
Commits cost almost exactly zero.

    git commit -a -m 'FIXME temporary'

And there you have it.  When you want to undo the commit or update it,
you just do

    git reset HEAD^

and it's as if the commit never happened.  Or don't reset, but just
make further changes and replace the commit:

    git commit -a --amend

Which part isn't acceptable?

Have fun,

Avery
