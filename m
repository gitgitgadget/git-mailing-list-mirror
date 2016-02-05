From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/25] fetch-pack: use a common function for verbose printing
Date: Thu, 4 Feb 2016 23:03:58 -0500
Message-ID: <CAPig+cQCyH8nRViwt=_9SHT-5a_m4xDomu4xcGcWpKu2X2mPgQ@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 05:04:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRXdS-0002AX-9E
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 05:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbcBEED7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 23:03:59 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34194 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbcBEED6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 23:03:58 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so2188162vkh.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=AJTlS2Ju+oY6/uofeWBzri7DuL7xKcM/wx2F4/YQXQc=;
        b=Qx39D3pmuoNyqBlbK/ZIRpAiYactuZoFbW+4z6yIrhuOR7YgMITm+QRRW1QqVHmbTK
         gsBgohoaRL/UIyaBEJNfB4OO/ml3h0y5APwDTK2fGDHEwkzjCpf8PeACSQ5rvSTAYC8W
         wWv0/lgo5xy/i1IQGuIv4vkUOu9eOFIMA+BeuCBxm5Np/qkiS3pzdM84nVjvz5cXl7Lb
         xlwNnN+pKzsvNRBAy6avqcQRxFgY1DMXhQshkpl1ZYz/rIP9JBOlvK2RO2qA0KvGb/zI
         aP35/SHwCOyNi2ObL5Z2iTNVPxn6DT5MWJwap6q4snNu0HA9v5NFWMa45mwLSrdj+zkw
         gWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AJTlS2Ju+oY6/uofeWBzri7DuL7xKcM/wx2F4/YQXQc=;
        b=E77MHp0O+5LEAlAVsQaXCFsoFVDc8nOv1ZN0/XDycH4cxT/sOLiFoFCBcFTTgis/LM
         E4GnQIvcDIba3bjHkmFblLhouTBWhlDNZy82tC2chMx4TSD6fc5Jcj80dNhi7jna68kB
         jf5UwBbyuFjBpPZ4/pM8jvoMQWM+okMNR4NNJNG0Eqf+SstnIszu3Na3IooeK+eJ13fv
         P0AsV+g4AVfLFxMK7BBI968B3WASDhvrhTcozL91eEjqO+XhUK7XMsFn+DRkTE7V9aGa
         Dyy5fqhUkvf4Zlwpldym5cuGd9Ithd1U/XiEtHhmzpotAnkSs+hgeMj4nU8l6oP/dRji
         WUSA==
X-Gm-Message-State: AG10YOQaf8V+vVi3A+N8qsYF7HPI8H2o0G4bgSKy80XNQnsQjlID2q9G3sBh7yQRPstO0ViIsEcYj3krfrDfZA==
X-Received: by 10.31.168.76 with SMTP id r73mr8069483vke.117.1454645038105;
 Thu, 04 Feb 2016 20:03:58 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 20:03:58 -0800 (PST)
In-Reply-To: <1454576641-29615-13-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: NuDivGLOkZrJIQA0CyWOdC2caHE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285536>

On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This reduces the number of "if (verbose)" which makes it a bit easier
> to read imo. It also makes it easier to redirect all these printouts,
> to a file for example.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/fetch-pack.c b/fetch-pack.c
> @@ -810,39 +814,32 @@ static struct ref *do_fetch_pack(struct fetch_p=
ack_args *args,
>         else if (server_supports("side-band")) {
> -               if (args->verbose)
> -                       fprintf(stderr, "Server supports side-band\n"=
);
> +               print_verbose(args, "Server supports side-band");
>                 use_sideband =3D 1;
>         }
>         if (server_supports("allow-tip-sha1-in-want")) {
> -               if (args->verbose)
> -                       fprintf(stderr, "Server supports allow-tip-sh=
a1-in-want\n");
> +               print_verbose(args, "Server supports allow-tip-sha1-i=
n-want");
>                 allow_unadvertised_object_request |=3D ALLOW_TIP_SHA1=
;
>         }
>         if (server_supports("allow-reachable-sha1-in-want")) {
> -               if (args->verbose)
> -                       fprintf(stderr, "Server supports allow-reacha=
ble-sha1-in-want\n");
> +               print_verbose(args, "Server supports allow-reachable-=
sha1-in-want\n");

I think you want to drop the newline here as you did with all the
other call-sites since print_verbose() adds its own.

>                 allow_unadvertised_object_request |=3D ALLOW_REACHABL=
E_SHA1;
>         }
>         if (!server_supports("thin-pack"))
