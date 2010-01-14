From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 09:27:26 +0800
Message-ID: <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 02:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVEUl-0005Bt-14
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab0ANB11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 20:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501Ab0ANB11
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:27:27 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:56336 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab0ANB11 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 20:27:27 -0500
Received: by iwn32 with SMTP id 32so108702iwn.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MWk+1PZl4LUrXpHFhIyqrSlCqA2ZG8mpM8ogo1xX9GU=;
        b=l6PTfitVfsjfGx1baHbNJx+Pd7FEqc5N4HR2fQpyEum0CeKuLOLCBQ/857zVGNxzre
         GpX/9tWe8nM+qFFQHSWgSMBMhU3ypJ/kDCwMLu5XlHBA3Y1Ttnc8aJx0blmniugE096V
         Oitpxv+1njuhNohLjkd9OpoB0QqA0NDN7JZ90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Co6KFLrodkN15CiTWyeqQ91auyNNz0sZDYjsAjUbTCdvvJIjMzy0aXKMkbB3JwkUzb
         CcSiThTOr7qwiFZvhaijf+4jj4YknxtDQlYu6+xWjkqLVOQUgS3+PjfYUjoGELAW6JsK
         1WbSZsSV+FPO9atr8ZQV1aQ7HP4W7fLrzKUcE=
Received: by 10.231.25.160 with SMTP id z32mr135481ibb.5.1263432446421; Wed, 
	13 Jan 2010 17:27:26 -0800 (PST)
In-Reply-To: <op.u6g8jnixg402ra@nb-04>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136919>

Hi,

On Wed, Jan 13, 2010 at 11:12 PM, Rudolf Polzer <divVerent@alientrap.or=
g> wrote:
> Hi,
>
> I'd like a feature to automatically "transform" a non-tracking local =
branch
> into a tracking branch on push. A patch to do that is attached.
>
> Usage:
>
> git branch mybranch
> git checkout mybranch
> ...
> git push --track origin mybranch:mybranch
>
> will not just perform the push, but also write a block
>
> [branch "mybranch"]
> =A0 =A0 =A0 =A0remote =3D origin
> =A0 =A0 =A0 =A0merge =3D refs/heads/mybranch
>
> to the git configuration so the branch becomes tracking.
>
> This should be a simpler alternative to the otherwise usual procedure
>
> git push origin mybranch:mybranch
> git config branch.mybranch.remote origin
> git config branch.mybranch.merge refs/heads/mybranch
>
> Are there any chances for this getting added to official git - or an
> alternate convenient way convert a local to a tracking branch?

before I put up my comments on the patch, I wonder if git-push is the
best place to add this feature, as git-push usually deals with
"pushing" data to another repo.

I think git-branch would be a better place to do this.

--=20
Cheers,
Ray Chuan
