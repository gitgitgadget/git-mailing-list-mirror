From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: cherry picking several patches at once
Date: Sat, 23 Jan 2010 01:57:40 +0200
Message-ID: <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com>
References: <20100121161157.GA3628@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: me@felipebalbi.com
X-From: git-owner@vger.kernel.org Sat Jan 23 01:05:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTUz-0003G4-Gp
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0AWAFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2010 19:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622Ab0AWAFA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:05:00 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:56798 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0AWAE7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 19:04:59 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2010 19:04:59 EST
Received: by iwn16 with SMTP id 16so601705iwn.33
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9toMg/qqdJKacXYawJcQFw4oUu6U9BIYcvW0eEaRohU=;
        b=NyUgH4xSdl7Wo0BCROcld1TDK4NXPqvDq7mnItUf5kK1T9NAMOXFTdjGzUm5JvV8CV
         x5Z5NhEVtReOiH++/UhI2l8m9+D42IvyhH3FYbGE+miAopY1jBOLkiHcHPVULgyq8Ujj
         qDwn99PB8ccoT2n5lnULVUL9mRtPjZ/7p7/28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=btHaCG0X440ChBHeNA3kewTj7Q50It7o//XmZbv+SM2s+oUys0WJYzANrIrE34V4Sj
         IYouF3oDwcL89Z9OxuBbdR1Af5hrhpHpEwnLgBgSTMNNCagkq0hVw3mRysCFcmSwJyJ6
         MQwwOUF9Jo2EBkiFpoT+S5S0/TzhQ+4D7YUH8=
Received: by 10.231.149.12 with SMTP id r12mr3743070ibv.86.1264204660166; Fri, 
	22 Jan 2010 15:57:40 -0800 (PST)
In-Reply-To: <20100121161157.GA3628@gandalf>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137789>

Heippa,

On Thu, Jan 21, 2010 at 6:11 PM, Felipe Balbi <me@felipebalbi.com> wrot=
e:
> I wonder if it's possible to cherry several patches at once ?
> Can't find anything on any docs, but something like:
>
> $ git cherry-pick <commit_id_start>..<commit_id_end> -- \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/path/to/directory
>
> I want to do that because I keep patches to the musb driver (on linux
> kernel) based on top of linus' mainline tree and on top of internal
> tree.
>
> The internal tree is outdated (not following mainline), but the musb
> driver is basically in sync, so cherry picking works, but it's a bit
> painful when I have to pick patches from community and manually
> cherry-pick to the other branch based on my internal tree.
>
> If there's a way (besides git rebase --onto) to do that I would very
> much like to know.

Have you tried something like:
git format-patch old-base --full-diff -- /path
git am -3 *.patch

> Another thing that would be nice to have, is to pass the HEAD to whic=
h
> we want to cherry-pick, so we can cherry-pick to not-checked-out
> branches.

I think that would not be possible because of the challenges when
dealing with conflicts.

Cheers.

--=20
=46elipe Contreras
