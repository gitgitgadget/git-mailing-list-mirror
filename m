From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: unexpected behavior with `git log --skip filename`
Date: Fri, 7 Oct 2011 17:54:36 -0400
Message-ID: <CAG+J_DwnUOeDTiUW-UUJGLLg8jJ4EhXN21B7o_hOMnyowM9a8g@mail.gmail.com>
References: <20111007171503.GB16607@mcnabbs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew McNabb <amcnabb@mcnabbs.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:54:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCINO-0002tc-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 23:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539Ab1JGVyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 17:54:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63015 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab1JGVyh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 17:54:37 -0400
Received: by gyg10 with SMTP id 10so4026279gyg.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jTH8ovFqovULUobXHGm/uN1/VQPDmkIozaytdIRzdrA=;
        b=SgclPNVO0m/SH3dG3frgkGSrYWXhQaHOrCHL3oBDKlxgFA+JoT82oIlMs3qYa+Z8qX
         cSUyyUolXFnjAJPgT4bvP35v9uRGDgcK1FqnL5Eyktt71Hd6RJzLBNd2Nc/yEcP1G+tr
         eXTc4FdU/+3mMwjWD+XxqV7ppkJMKDABLcTS0=
Received: by 10.147.5.21 with SMTP id h21mr1939815yai.26.1318024476882; Fri,
 07 Oct 2011 14:54:36 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 7 Oct 2011 14:54:36 -0700 (PDT)
In-Reply-To: <20111007171503.GB16607@mcnabbs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183115>

On Fri, Oct 7, 2011 at 1:15 PM, Andrew McNabb <amcnabb@mcnabbs.org> wro=
te:
> The "--skip" option to "git log" did not behave as I expected, but I'=
m
> not sure whether this was user error, unclear documentation, or a bug=
=2E
> Specifically, I ran the following, intending to find the previous
> revision of a given file:
>
> git log --skip=3D1 -n 1 --oneline some-filename
>
> My expectation was that this would behave the same as:
>
> git log -n 2 --oneline some-filename |tail -n 1
>
> Instead, the --skip=3D1 parameter seemed to be ignored. =C2=A0After I=
 tried
> several different values, it appears that the commits are skipped bef=
ore
> path matching with "some-filename".

Hmm:

$ git log --oneline GIT-VERSION-GEN | head -2
7f41b6bbe3 Post 1.7.7 first wave
703f05ad58 Git 1.7.7

$ git log --oneline --skip=3D1 -n 1 GIT-VERSION-GEN
703f05ad58 Git 1.7.7

j.
