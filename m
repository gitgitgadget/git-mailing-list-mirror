From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 6/6] xdiff/xprepare.c: reduce scope of variables
Date: Wed, 16 Apr 2014 11:55:49 +0200
Message-ID: <CABPQNSajC5vj78U7nk+656_V+poCZ1GNDBFRn_KWKwR-1QYg0Q@mail.gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com> <1397640811-17719-6-git-send-email-gitter.spiros@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 11:56:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMa3-0000Pr-3C
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbaDPJ4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:56:31 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46992 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834AbaDPJ4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:56:30 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so10309239iec.16
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BXrD6jnSvoFB9EtK/d5FP7Epiof9HRANzIPG4gediVw=;
        b=kbbDEy0lyi2T67bud16bmaVaCKNtZZYpssMwbrM7vQS6FQ1lxTPJmi2J+wN8BE2Ku5
         /zz8XOpLr9Yw2d4BDfwq+xP4JHsqPaEZSnx7w7ECtOVqMAgbXgYs/9cg8q9J7de+xf6n
         Cx0AW/0eO0mIZnHerrK4Px87K1PwfEVi7yhWQYQA3KJAuieOsX577+9R2+BlrgMEUwoW
         9HiI2xSMre7Elf9KfQ74ID63C4tnSEpENZ8v0iwI9tXNdj92JbmNF4nGVg2Tyz+Ip72A
         OHAntQdsqW7uF8xkiXq6bi9x1MiUq9y7bqvRZN8RbOVJ4l4xw5wDFtbXdwQmcpIMnI/5
         8izg==
X-Received: by 10.42.235.79 with SMTP id kf15mr3143677icb.32.1397642189651;
 Wed, 16 Apr 2014 02:56:29 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 16 Apr 2014 02:55:49 -0700 (PDT)
In-Reply-To: <1397640811-17719-6-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246328>

On Wed, Apr 16, 2014 at 11:33 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  xdiff/xprepare.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 63a22c6..e0b6987 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -161,8 +161,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>                            xdlclassifier_t *cf, xdfile_t *xdf) {
>         unsigned int hbits;
>         long nrec, hsize, bsize;
> -       unsigned long hav;
> -       char const *blk, *cur, *top, *prev;
> +       char const *blk, *cur, *prev;
>         xrecord_t *crec;
>         xrecord_t **recs, **rrecs;
>         xrecord_t **rhash;
> @@ -193,7 +192,9 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>
>         nrec = 0;
>         if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
> +                char const *top;
>                 for (top = blk + bsize; cur < top; ) {
> +                        unsigned long hav;
>                         prev = cur;

We do not indent with spaces.
