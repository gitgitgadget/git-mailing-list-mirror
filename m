From: Jerome Martin <tramjoe.merin@gmail.com>
Subject: Private/public branches/repos workflow
Date: Thu, 5 May 2011 17:16:34 +0200
Message-ID: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 17:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI0IC-0004k1-PM
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 17:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab1EEPQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 11:16:35 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63372 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab1EEPQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 11:16:35 -0400
Received: by ywj3 with SMTP id 3so783629ywj.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=my6WIND99khjNFmyCTqT3tZqmlbv0FidqV5Mk8JhBbw=;
        b=Eqp4GdVi1mHlXyqE2Yc1CRSVvgi/jz92iFzBMGZb2/e44p9HI5yLI3y7DZNsEdLIpP
         u+xQu7G7Rg++EfxoWPoSNhiteiQjEB18wFTHBW3vHK2b8pmlh0FBg2DSAgFC5hPtIfo5
         GOywOC1fpOXGKg0WS8vDJqi+KyNFxF5O0cwKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=qqFJgj9U6ynDxuoM28UVhXj5hF/wyMx5S/6VHpfBcv7gxAZuUcAMHsM4kl3heg04hQ
         UdsNO/FS38hKS7YR1CTAlkelhQgXqUjhzKiRA760I9Xm7ESfzydY1S8NR+f3z6+QPJBD
         3in8G5pEHJLUnHlhaSgDGn/eXRmTKqq48gI+0=
Received: by 10.236.66.75 with SMTP id g51mr2861761yhd.524.1304608594774; Thu,
 05 May 2011 08:16:34 -0700 (PDT)
Received: by 10.147.167.8 with HTTP; Thu, 5 May 2011 08:16:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172837>

Hello list,

I have an application that lives in a git tree. That application is a
commercial product, but we have decided to dual-licence it and release
an open-source version of it, along with all further commits to it.
Preparatory work for this has been done, and I now have two (let's
ignore the other) branches in my git tree, 'public' and 'private'.

The problem is, I cannot simply push the public branch on a public
repository, because the history contains a lot of stuff that are not
to be publicly released.

I thought I could squash all commits on that 'public' branch for the
initial public release and resume working from there, keeping the
ability to happily merge subsequent commits between 'public' and
'private', but this does not work: I am always left with the initial
commit of my whole tree (which unfortunately is not releasable) and
the big sqashed commit.

So what we did for now is to create a new git tree completely from
scratch, containing only the public code tree. However, I am afraid
this will lead to a nightmarish workflow, as it involves me working on
our internal tree 'public'/'private' branches, and from there,
replicate the commits to my internal 'public' branch to that published
repository. As pushing/pulling there results in having all the history
committed back to the published repo, I must resort to either having
to cherry pick all those commits one by one, or manually apply them to
the published repo. Maintenance hell.

Is there any recommended workflow to achieve the result I am looking
for ? How are other people doing it ?

Best Regards,
--=20
J=E9r=F4me Martin
