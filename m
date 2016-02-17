From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] merge-recursive: more consistent interface
Date: Tue, 16 Feb 2016 20:52:15 -0500
Message-ID: <CAPig+cQMutC1rDoLTZHu6zYi2i7s9jYkO8Nb29q8tJwEjq+ADg@mail.gmail.com>
References: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
	<1455671495-10908-3-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 02:52:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVrHz-0001yo-DJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 02:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbcBQBwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 20:52:16 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33510 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901AbcBQBwP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 20:52:15 -0500
Received: by mail-vk0-f42.google.com with SMTP id k196so2149959vka.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 17:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=HYVsApKn0l4BPWncrhTi6IFUtG+dsitLXt7xHXkq2Bo=;
        b=aCf0H8Zs74EhXL93O5yTWhRWiUSTOJaIluC4+1yz1keELZkGJfrg8ycOjl5JmRTbUe
         JQmalLl18ih4d48myH41ENan5s5TFV2msFe2/Tvs0Z/hJzAFmAmBRdCWzrAMTNStH2wc
         xSmWfUOaQEETkPyr9tWQ57QPZ+wrEqlphnD/fl+P0eX5Kgb73R6gnpeNi03XJRTpQVI1
         0cBND4lcRpQuYPl+G0fldJ/EcP79dAvktBtSef9sGyPqAVmFrMYVtkqxQAihUpXBu/6V
         D68EA4aCd8r5+andS0Iq5oxkDG/QHLoJ/Z+rIOzVniOxjm9vbiH20rUYjUPRwHEMBF2v
         KfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HYVsApKn0l4BPWncrhTi6IFUtG+dsitLXt7xHXkq2Bo=;
        b=i6vttU9Mj2JqwX+cyITcTZEO+Y+8uvpeROXyXQ446qrbF24VJIR2xKK5v3htmBrBnS
         Po86hJ/xGEcA+8ij2umotjRhjOom3+R9sB22682PmrzcF1xkek+i1Yut99wCKyGQUn5Q
         g8qi/VTKkV3ueJuAk35V5FpuBXqEhHXKorYW9/BKaKCM9DjrNprDDzaz/H3EIAME+J2O
         wUkVVDnIOYqFXVofEolnCKaB8sL2U6g/F/85j2CMYnWMGrlOYRKS5pnIcUmY71pDHaBx
         45dOCrh+RhnfbS/3ByGbPwnZesGPcU0+bFCimg7YzbEnW3lb0MLBIXRxk1BweWA+uRmg
         9zvQ==
X-Gm-Message-State: AG10YOQr0ClClUjZEeMFgRU/quz+t0bV3oZMUZcce73hdzPKhK/VrMXrUcqIPmD6KTwY8ErojGaRw8kWXl2nMQ==
X-Received: by 10.31.141.2 with SMTP id p2mr20820293vkd.37.1455673935063; Tue,
 16 Feb 2016 17:52:15 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 16 Feb 2016 17:52:15 -0800 (PST)
In-Reply-To: <1455671495-10908-3-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: iwjzMOIEiUg4h6-pSazFspCB6JY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286474>

On Tue, Feb 16, 2016 at 8:11 PM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> Add strategy option find-renames, following git-diff interface. This
> makes the option rename-threshold redundant.

Missing sign-off.

> ---
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge=
-strategies.txt
> @@ -85,11 +85,15 @@ no-renames;;
>         Turn off rename detection.
>         See also linkgit:git-diff[1] `--no-renames`.
>
> -rename-threshold=3D<n>;;
> +find-renames[=3D<n>];;
>         Controls the similarity threshold used for rename detection.
>         Re-enables rename detection if disabled by a preceding
>         `no-renames`.

This may need some enhancement. It doesn't, for instance, talk about
what bare --find-renames (without "=3Dn") means.

> -       See also linkgit:git-diff[1] `-M`.
> +       See also linkgit:git-diff[1] `--find-renames`.
> +
> +rename-threshold=3D<n>;;
> +       Synonym for `find-renames=3D<n>`. Present for historical reas=
ons.
> +       New scripts should prefer the `find-renames=3D<n>` syntax.

It might be sufficient to say merely:

    Deprecated synonym for `--find-renames=3D<n>`.

which implies the bits about "historical reasons" and "new scripts
should prefer...".

>  subtree[=3D<path>];;
>         This option is a more advanced form of 'subtree' strategy, wh=
ere
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 6dd0a11..700febd 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2094,7 +2094,10 @@ int parse_merge_opt(struct merge_options *o, c=
onst char *s)
>                 o->renormalize =3D 0;
>         else if (!strcmp(s, "no-renames"))
>                 o->detect_rename =3D 0;
> -       else if (skip_prefix(s, "rename-threshold=3D", &arg)) {
> +       else if (!strcmp(s, "find-renames"))
> +               o->detect_rename =3D 1;
> +       else if (skip_prefix(s, "find-renames=3D", &arg) ||
> +                skip_prefix(s, "rename-threshold=3D", &arg)) {
>                 if ((o->rename_score =3D parse_rename_score(&arg)) =3D=
=3D -1 || *arg !=3D 0)
>                         return -1;
>                 o->detect_rename =3D 1;
> --
> 2.7.1.288.gfad33a8
