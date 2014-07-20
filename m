From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Sun, 20 Jul 2014 19:50:03 +0700
Message-ID: <CACsJy8DtYrP4CndD+Ud2qpYT3J7NehukL9a_sgiq7vZ82KH-0g@mail.gmail.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
 <1405858399-23082-1-git-send-email-pclouds@gmail.com> <232C089CF449490C9F5B398996DD314C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:50:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8qZd-0004qr-Rx
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 14:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaGTMuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 08:50:37 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:64441 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbaGTMuh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2014 08:50:37 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so4283268qab.8
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Gkerc21S8juy9gYMaIa07y+lVmAg0hrr2HPNvU5crak=;
        b=0w4zbKgA0PuXffLi7L4kzmzmpoZEH0BVNHZuQiOw46vQGAyTnwa652KrjwJzOtKHJy
         UXSIiLoP0BW6Qvfbp5m40LO1LLgXlu/f+4s3DqN4/7goKM3o/zsaPS1H1dY60LsqlhkN
         InzFHd031RPIK5LuaGFnFYtwd7BBGCrNJc6h5eexoNSDNrVdNfo61n4Hz7LgcihE5KaQ
         E4PkB1XKyg5S0EkJ+Tm6VBJnxkhyJaXvyKGBwfYGRsYWHQx+Gx4DgPLYbrba79fHR12p
         X4kZIFPuZ3Jj5VDN5hbztoX/hdS3GV4u5/vuFuhqt7rbcCA6Lz+CaNQsfYU5zNClNcHJ
         /RqQ==
X-Received: by 10.224.122.83 with SMTP id k19mr30359244qar.78.1405860633591;
 Sun, 20 Jul 2014 05:50:33 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sun, 20 Jul 2014 05:50:03 -0700 (PDT)
In-Reply-To: <232C089CF449490C9F5B398996DD314C@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253925>

On Sun, Jul 20, 2014 at 7:47 PM, Philip Oakley <philipoakley@iee.org> w=
rote:
> From: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
>
>> Something extra is, because struct lock_file is usually used as stat=
ic
>> variables in many places. This patch reduces bss section by about 80=
k
>> bytes (or 23%) on Linux.
>
>
> This didn't scan for me. Perhaps it's the punctuation. Maybe:
>
> Additionally, because the struct lock_file variables are [were] in ma=
ny
> places static, this patch reduces the bss section size by about 80k
>
> bytes (or 23%) on Linux.
>
> Does my tweak reflect your intent?

Yes. But I should probably put that below the "---" line. We're not
busybox. 80k is pratically nothing.
--=20
Duy
