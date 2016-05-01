From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 27/41] grep.c: use error_errno()
Date: Sun, 1 May 2016 14:46:14 -0400
Message-ID: <CAPig+cQ4hGKSG6aMkGTUPNs5+i3TOA66QmD97sSnMsR7DYsgbg@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462101297-8610-28-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awwO5-00041r-CV
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 20:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbcEASqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 14:46:16 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34807 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcEASqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2016 14:46:15 -0400
Received: by mail-ig0-f196.google.com with SMTP id qu10so8578180igc.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=jmww0/abuf/XHtMspXD5UAEayP12M8gg4gyaTn0aew4=;
        b=X+84iar+NBMQnTNnXtde4U9x+r6wBgkvjHLvbHNGsAzWRfXo/1+VURbUhyd96cEz3Y
         CteRZI4hlN4shbJiCydF0vyIA0uXnbcNCkQJd0wz01O68WjSpn+YQOICc+3EGtSCRTzU
         v/v9TkhvEfGu1nIaVvti8Jxn2aLxuBwh/X3qJnLgnJpx8tHg9kzVQqNpI40nroqsGrYj
         f/Wl/v9nij5BkXVNKP/qzWvujAKwUqVCMqJWejSDQ7PEZfYeyr39bhQeIcJH7h82d9gK
         R6KKb1XHcff0Ftg0LwAfFh+hHJd0FIFgR5Pk3SYfmD8OVN/Jd/S2ekNVxX5o2XZFXk3H
         Bs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=jmww0/abuf/XHtMspXD5UAEayP12M8gg4gyaTn0aew4=;
        b=PsRx3iadUtszSgdKtM7IhdS+y+sveKLlzcw2WKCYmtCdcTM2I0Y06px4w9N2J2roSA
         JP4A9JBZ8mVMzs24dkmuHiVjKj5n+kvAflYgSO5uPypg0dXRF68WVJzNMy7jIbiwBhEv
         ZyoMVuR/oGR53/NUVsL1QjWa1k5mSltj8ridbMFcljElO+l9waNKDqibd3G41/w4wHNh
         h7SE17XvPXpaKFnqxhz3uv2q1/zu/7xtTBTcpykKyHCTfpDBj+iQ+JtGXbueWkG5gViS
         vc9H5F5W6TIXQ1DC9Q67J2yJ7cB80xOt8VzT2Vh2k3hAKYuhu5+NUnAKgt5c2UwIrbF2
         tZjw==
X-Gm-Message-State: AOPr4FVDM20/ZGXQUSIVJwNUANRxg8l6dy9HF4OsBMu9Uo4CMVP0tMeymHMGSbHYJjAPhv4HRncmmKomN81MmQ==
X-Received: by 10.50.36.9 with SMTP id m9mr16681608igj.91.1462128374748; Sun,
 01 May 2016 11:46:14 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 11:46:14 -0700 (PDT)
In-Reply-To: <1462101297-8610-28-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: R7zkJtfX0uaV6hl57XTxKSr9eSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293206>

On Sun, May 1, 2016 at 7:14 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/grep.c b/grep.c
> @@ -1732,7 +1732,7 @@ static int grep_source_load_file(struct grep_so=
urce *gs)
>         if (lstat(filename, &st) < 0) {
>         err_ret:
>                 if (errno !=3D ENOENT)
> -                       error(_("'%s': %s"), filename, strerror(errno=
));
> +                       error_errno(_("'%s'"), filename);

Does this still need to be wrapped in _(...)? (Did it ever?)

>                 return -1;
>         }
>         if (!S_ISREG(st.st_mode))
> @@ -1743,7 +1743,7 @@ static int grep_source_load_file(struct grep_so=
urce *gs)
>                 goto err_ret;
>         data =3D xmallocz(size);
>         if (st.st_size !=3D read_in_full(i, data, size)) {
> -               error(_("'%s': short read %s"), filename, strerror(er=
rno));
> +               error_errno(_("'%s': short read"), filename);
>                 close(i);
>                 free(data);
>                 return -1;
