From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 24/25] worktree move: accept destination as directory
Date: Wed, 11 May 2016 13:32:23 -0400
Message-ID: <CAPig+cTB8tdPo=wd5UdB84owKJ6c5hj6H9d4_YGDRecBdUE0vA@mail.gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
	<1460553346-12985-25-git-send-email-pclouds@gmail.com>
	<CAPig+cRtajkynLFj5Fknd72QQ=Eqevh1T9i9MvApwXfNmtMAFQ@mail.gmail.com>
	<CACsJy8CCAan9ALxULPFeGSU7wsfwbrywRWFr4Hsjx3=PGwosLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 19:32:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Xzn-0003Rj-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 19:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbcEKRcZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 13:32:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35396 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbcEKRcY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 13:32:24 -0400
Received: by mail-io0-f194.google.com with SMTP id i75so6507577ioa.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=/bdM1NqaydFzDkBemJdxPyOP5AmlzWemc5iTR2nbowM=;
        b=vNGFbb+b3aPdcgOd4lhZVtahZhCBE+YZi3Zv2l/frpL7Cr6Le4kC+0xNZ5Qm0Bo5kh
         96P41DVPpixtFU1KOi8qJYZ5Gt9VcvzDs4rpYI6A94cBe5r2mxlteG3R8SlXXIIOspt/
         dcEIiirWMSZZO0d5YNwNB3Frz71BjCeGTMhNEeo5E/58VHU5wMyaR78zBn6qPUzbFmEE
         mQdh37k5p31kMq2+ufaTn9LYrnAoJczoEk176g3gDyZNF+JAtrtQvyjvz8sULvMSPZ0H
         m/eSTj2hrZVvrbh6ijJiIvexjRGc1sxX7W/9wJX59p++gb+MWM6kdALYh4cVy5u8Iufq
         Aghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=/bdM1NqaydFzDkBemJdxPyOP5AmlzWemc5iTR2nbowM=;
        b=eRUoKxTlJWYNdRJg7yfULHeNWBf/4mfZAShkQylP9puaeu1hkjvepS9mMS5SRIpgli
         ashE+wTxHQR8dWEJiuV83XoNAO5HEiX/J2nZvlvSHWCGBr+J+XiH8ozQtuUQz2ySFZiM
         Hr/Fg9ImXIJxk4ZNEy/UFgWb888HEVtHpp06TIv17T9GaiZqAlY0PUrfRmdh68wRi/JM
         L6/XRNjFUgECzYVla4cjov9e6G8HLNZZsczo6maUPHXuRyXsijF2p3mQR0qzDQbjK9+t
         S3NwuXlxIpG4ir5ZLktvHeTHM0vqLA/pzLkDI/lP4lK+/gA5ybVyNDYZJkbuWv+nWSQz
         v1bw==
X-Gm-Message-State: AOPr4FUjK8Fy5ucQFnIBRuck9Etq+IrCVKYBPhBu4/cSiqEUI0O3X1Lz4M+e3xJrUkGv/iUxrrjAgnPNjKSkBA==
X-Received: by 10.107.47.37 with SMTP id j37mr4183392ioo.168.1462987943341;
 Wed, 11 May 2016 10:32:23 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 11 May 2016 10:32:23 -0700 (PDT)
In-Reply-To: <CACsJy8CCAan9ALxULPFeGSU7wsfwbrywRWFr4Hsjx3=PGwosLA@mail.gmail.com>
X-Google-Sender-Auth: fyKjXHe7TcfW4G1oCBzGs7t6q3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294356>

On Wed, May 11, 2016 at 9:34 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 11, 2016 at 11:43 AM, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>> On Wed, Apr 13, 2016 at 9:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> +       if (is_directory(dst.buf)) {
>>> +               const char *sep =3D strrchr(wt->path, '/');
>>
>> Does this need to take Windows into account?
>
> wt->path comes from $GIT_DIR/worktrees/xxx/gitdir, which normally use=
s
> forward slashes, so we should be safe. We already rely on forward
> slashes in get_linked_worktree()
>
>> Perhaps git_find_last_dir_sep()?
>
> But this is probably a good thing to do anyway, to be more robust in
> future. But it could confuse the reader later on why it's necessary
> when backward slashes can't exist in wt->path. I don't know. Maybe
> just have a comment that backward slashes can't never appear here?

As this path is read from a file git itself creates, and if we know
that it will always contain forward slashes, then I agree that it
could be potentially confusing to later readers to see
git_find_last_dir_sep(). So, keeping it as-is seems correct.

Not sure if it needs a comment. I reviewed this rather quickly since
(I think) you plan on re-rolling it and I'm far behind on my reviews.
Consequently, I didn't check the existing code, and reviewed only
within the context of the patch itself. If the end result is that it's
clear from reading the code that it will always contain forward
slashes, then a comment would be redundant. You could perhaps mention
in the commit message that the slash will always be forward, which
should satisfy future reviewers and readers of the code once its in
the tree.

> There is also a potential problem with find_worktree_by_path(). I was
> counting on real_path() to normalize paths and could simply do
> strcmp_icase (or its new name, fspathcmp). But real_path() does not
> seem to convert unify slashes. I will need to have a closer look at
> this. Hopefully prefix_filename() already makes sure everything uses
> forward slashes. Or maybe we could improve fspathcmp to see '/' and
> '\' the same thing on Windows.

If we look at fspathcmp() as a function which performs whatever magic
is needed to make comparisons work on a platform/filesystem, then it
might indeed be reasonable to enhance it to recognize '/' and '\' as
equivalent (with possible caveats for Windows corner cases).
