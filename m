From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] clone: allow to clone from .git file
Date: Mon, 22 Aug 2011 10:08:15 +0700
Message-ID: <CACsJy8BaCwT+fd-KORsqXqQEtWZUpTDwgoSGU9+pMfNdero5=Q@mail.gmail.com>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com> <7v7h66y4s5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 05:08:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvKsd-0003ny-JB
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 05:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab1HVDIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 23:08:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34803 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1HVDIq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 23:08:46 -0400
Received: by bke11 with SMTP id 11so3361296bke.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 20:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YnrbfhDjGx6Vg8s37MO5f02x2umfKfyqmCRHVfsPpVE=;
        b=C9/W5JS2qMT0M+zDc3uFLSAXjDsoSpULPHCKj7vvQQuQYKe4gQl+QojV5Iy8lLOz9L
         29vmDWrRw5GpFEZsKc1CiCcta7aq5xmBes+j51lIYYQCuhMKpvonJ2um/AAzxIT8ka0q
         T0g6MqFWgOvaqj161QgVY6rIUrkjyMzUde1dI=
Received: by 10.204.155.81 with SMTP id r17mr677600bkw.19.1313982525249; Sun,
 21 Aug 2011 20:08:45 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Sun, 21 Aug 2011 20:08:15 -0700 (PDT)
In-Reply-To: <7v7h66y4s5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179838>

2011/8/22 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (S_ISREG(st.st_m=
ode) && st.st_size > 8) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Despite the name read_gitfile_gently can be
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0cruel on non .git file, check for signature
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ourselves */
>
> Didn't somebody add "is this '.git' thing a valid git metadirectory?"=
 API
> quite recently for exactly this?
>

You mean resolve_gitdir() in abc0682 (rev-parse: add option
--resolve-git-dir <path> - 2011-08-15)? That function would barf on a
bundle file. I'm not aware of any other functions.
--=20
Duy
