From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 21/26] fetch: define shallow boundary with --shallow-exclude
Date: Sun, 5 Jun 2016 01:03:57 -0400
Message-ID: <CAPig+cR--0YV7Loh7fVZb4LA9oYPwNT2+QpL1tzSr-1dZu+mhw@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com> <1460552110-5554-22-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 07:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9QG7-0003wW-Eb
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 07:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcFEFD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 01:03:59 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36904 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcFEFD6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 01:03:58 -0400
Received: by mail-it0-f54.google.com with SMTP id z123so20494457itg.0
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5ytC40E2ttRkekDHFqkjSXY3oHiFoMU8NkxTLDuTj4s=;
        b=FEuAr/u/E69OvTSAM8tns4Tej6HOXVd1Ovrfjb+FHWPJSlkP6CJK7v5nYFGxl7f+dJ
         MMyaNbLZ1qzB666WbVd3p8l7gRHhf3ef8revv6sDgxSBtqLIRYuWB5aozOncXGFPAy/T
         lGLSleDZPOmfbVlFRg9dXsGmfGcmTWIw7TRQZkEpSCSz/62UWSLx3B57k0q1d8983GIO
         kFeSkp/8gHxUfHilPWBl4zXhH2dn01V1j04Cwzpo33rkwcPZzBoa+muHY76wDUVLaneG
         cnJJw4UUjrQyqOUdNgjznKdxHIL+TCBPS6v8QQ1xdAmRGFURVnoUWddGELKy96y6NdCO
         pbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5ytC40E2ttRkekDHFqkjSXY3oHiFoMU8NkxTLDuTj4s=;
        b=hZeew/CE3STkDJnUoYl7WxTOTRQxyuAsaivtnHkJCBfEb27V8h4xnoAsxGHm5T/hH1
         g3BkZOYKHFKlN7BxPcDZwJzAE+LzUvlzeqKdOOK/T1A5X6/yxX71mrcnBPBQXQt+RyL4
         NXEg9o2zu9ib0FnkyJE4seGy8NUXaMsDJBJP76MCYbeBoOdPNCZheQ0RYyZubzvtmNyF
         xy3moB9UwVEOjZi4BAzAwUxKAVLN2QII+hcYa0YouT5ZARHzTzgwqfBMqqndJ2kgTVIe
         zFumofGXAr//LsIcSqZL+wOAsAk1T9Kvy0P2Oj+oynICnUD2n1btnrw9xqfkIWKcMC1/
         YSqw==
X-Gm-Message-State: ALyK8tJfMu6gBUdrTyVjdbaBwlk1raCZp/1sClNN8JdMtUPfUlF/BCdcDQEp+BcOKSsDmfVYbhOqVSEQfb7Fdw==
X-Received: by 10.36.55.138 with SMTP id r132mr8653533itr.73.1465103037686;
 Sat, 04 Jun 2016 22:03:57 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Sat, 4 Jun 2016 22:03:57 -0700 (PDT)
In-Reply-To: <1460552110-5554-22-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 2sdxgCr7vmf2hGkTDM8nMv4etVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296466>

On Wed, Apr 13, 2016 at 8:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> @@ -41,6 +41,7 @@ static int max_children =3D 1;
> +static struct string_list deepen_not =3D STRING_LIST_INIT_NODUP;
> @@ -50,6 +51,13 @@ static int shown_url =3D 0;
> +static int option_parse_deepen_not(const struct option *opt,
> +                                  const char *arg, int unset)
> +{
> +       string_list_append(&deepen_not, arg);
> +       return 0;
> +}
> +
> @@ -118,6 +126,9 @@ static struct option builtin_fetch_options[] =3D =
{
>                    N_("deepen history of shallow clone")),
>         OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
>                    N_("deepen history of shallow repository based on =
time")),
> +       { OPTION_CALLBACK, 0, "shallow-exclude", NULL, N_("revision")=
,
> +                   N_("deepen history of shallow clone by excluding =
rev"),
> +                   PARSE_OPT_NONEG, option_parse_deepen_not },

Is this a candidate for OPT_STRING_LIST()?

>         { OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
>                    N_("convert to a complete repository"),
>                    PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
