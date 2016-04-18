From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 3/6] verify-tag: change variable name for readability
Date: Mon, 18 Apr 2016 13:20:30 -0400
Message-ID: <CAPig+cTV=RG-fprFwmY+f4Fy_rm77p0B0x652=f+p5vVOX4=Lw@mail.gmail.com>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
	<1460932021-27633-4-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 18 19:20:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asCqi-0003vB-O3
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 19:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbcDRRUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 13:20:32 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34330 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbcDRRUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 13:20:31 -0400
Received: by mail-ig0-f195.google.com with SMTP id qu10so11757129igc.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=3DbBnRjVwDrHDK43PlNrGiI2RGwVyBKCnRA31jbbtkg=;
        b=y7aHGpTjB5GtmQlO3lEOT9KAb7s2g233V5DEFumuJmKs244ofOcGiR2q//oTEAbRdX
         D2Y9BxY29INYLzm3dh+x3rNvBJWKhgy/n9Lgw3zcrdXVz5MJyKSPC7+5mQOFlJVJEKVY
         bGTL3NxQTEYs32FRjG5nJ5JW5A7vewWYbxV4MgBQo6rf20iixwo0ggfxn4FunaKEVEo4
         dsTs76W7Iv5uQvbgJbsH0QVzZt19h9y5iZshsQ6mXmf+VgxPbuROD4TVRsfMo+ES+z04
         1bFLoUh1KO/s0WopgGie4LNkg/sDzppR5D7/y5kaZfFEt/LJiHSDblNDGuXvcJy5cGP0
         sIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3DbBnRjVwDrHDK43PlNrGiI2RGwVyBKCnRA31jbbtkg=;
        b=VQpu7727PFwCCu5VrTms9DExSCI1sktUt4gyckGjYokG/ZCR/bIrb5czb2ahIRBSzt
         ET6HAV722pQxtgZSvL1YUTCS4LKNvfT7a3LuW7tIZq/QWvvoup2DXh90cDWmB4nG42v1
         EK0qlF7hGbHxaGj6wXmcHlvvDMjsEJwbGSSFSh97GDLLvAhW0Nw8UhRHUoWS026v+6KR
         jhv+t6Mll5o58ErzLi/6MTNFEGFX81t2zbY3j2kqSx4V3XXYwA4uodE2/pZ4rNBsOyJA
         VuJ4//htrRvngBuB4xgc1rkTx7RPjRB0pbTEnO5Kr6L/b9RX90XhMbLlQgfVU/iXogNa
         /F1w==
X-Gm-Message-State: AOPr4FVFII1eoEceB6XohfSBXrhsysh20UjVIFG3cKwON4NRZndg5dWfkud0bD+y81bY1tAswuzshBrIMpV2qg==
X-Received: by 10.50.8.40 with SMTP id o8mr16970877iga.17.1461000030517; Mon,
 18 Apr 2016 10:20:30 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 18 Apr 2016 10:20:30 -0700 (PDT)
In-Reply-To: <1460932021-27633-4-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: nCRQhwzwx4pdPwf5uV9o_3g4mu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291812>

On Sun, Apr 17, 2016 at 6:26 PM,  <santiago@nyu.edu> wrote:
> The run_gpg_verify() function has two variables, size and len.
>
> This may come off as confusing when reading the code.  Clarify which
> one pertains to the length of the tag headers by renaming len to
> payload_length.

The commit message talks about 'payload_length', but the code names it
'payload_size'.

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  builtin/verify-tag.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 77f070a..010353c 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -21,20 +21,21 @@ static const char * const verify_tag_usage[] = {
>  static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
>  {
>         struct signature_check sigc;
> -       int len;
> +       int payload_size;
>         int ret;
>
>         memset(&sigc, 0, sizeof(sigc));
>
> -       len = parse_signature(buf, size);
> +       payload_size = parse_signature(buf, size);
>
> -       if (size == len) {
> +       if (size == payload_size) {
>                 if (flags & GPG_VERIFY_VERBOSE)
> -                       write_in_full(1, buf, len);
> +                       write_in_full(1, buf, payload_size);
>                 return error("no signature found");
>         }
>
> -       ret = check_signature(buf, len, buf + len, size - len, &sigc);
> +       ret = check_signature(buf, payload_size, buf + payload_size,
> +                               size - payload_size, &sigc);
>         print_signature_buffer(&sigc, flags);
>
>         signature_check_clear(&sigc);
> --
