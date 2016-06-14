From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] fetch: document that pruning happens before fetching
Date: Mon, 13 Jun 2016 23:14:36 -0700
Message-ID: <CA+P7+xpk6HqeJfUcAkpTbW_hO6dyjanXoqaaKqdTU363n=-Stw@mail.gmail.com>
References: <20160613235850.GA8009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Tom Miller <jackerran@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 08:15:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bChcq-00049y-RX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 08:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbcFNGO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 02:14:57 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36764 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcFNGO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 02:14:56 -0400
Received: by mail-yw0-f194.google.com with SMTP id w195so7966092ywd.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SSErr0p7+6Ufav6GTBIRJ2VPONz9V0nw8MiCiQoFGUw=;
        b=f3QBpj1iStXBltyAB6jzSTpH89aYnjovc3E46I1tJMg8oTTlZma3rHeDkm3Uk2fJWC
         BgszoNirUujIcw2uJqjKK7wg8rQlxRFlbn7tS1OLR4upNwdgPWNzCdCx6ziux+Rmx9lp
         H/aBZQFzDqHVr0hxAK68bEap2Liz3qqT45kY1ZRzPUrCYqeN/9J+/oGCnnzDm5ClfOFn
         bn01fLd5ULBXboqhn6s5oXO7GuiiwUT80k/dmc0MML1OGb30N/gf0puTCWrtuZobwmch
         +7PCtmoYayWJFiQSWxqH/dH8x0eCEKOMD0PCswl6r3OWoOoknVEphai+hB3FFXJR5cot
         nULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SSErr0p7+6Ufav6GTBIRJ2VPONz9V0nw8MiCiQoFGUw=;
        b=lu1qZ/YRXUqQ7GBxqYIfAuCHOHV15NtPaQYvriluJLsIZgxPnlwcVujXzBgYGGTxlT
         R3DQ/SVn3KpjxTZbt6GF88tPabGpN7ABssZyBw51MdsAkMGlK7gALYxkW5i/80W+qdYx
         jLWdY0VHe/mEfm+RjWIZ871NfZbK9w2tdz0CN924TFYeknjTZmJ0snMLZ5YRX2lpExKi
         lI+NgG+p9oB2kPVu8UYR1ZPs2zeKaa4gDLmdM4yBVfvbDDEjxvu7XKfo39L6861I4QvN
         V9ZhpNOGc4uMt8jcAKHtwijfCufKoO2Ujjv/g/5nDVdnlu2oRCGicvWYnjAnHQjYRyTM
         k7Vg==
X-Gm-Message-State: ALyK8tJ9FmJ0AWyNX39UU5I3bks8xrTHhBbfacYizD2Bh9P9onfgj81/4LYbAGjNqS4YONVQ5WMfZyepJloFNA==
X-Received: by 10.129.31.134 with SMTP id f128mr929134ywf.284.1465884895538;
 Mon, 13 Jun 2016 23:14:55 -0700 (PDT)
Received: by 10.37.34.133 with HTTP; Mon, 13 Jun 2016 23:14:36 -0700 (PDT)
In-Reply-To: <20160613235850.GA8009@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297265>

On Mon, Jun 13, 2016 at 4:58 PM, Jeff King <peff@peff.net> wrote:
> This was changed in 10a6cc8 (fetch --prune: Run prune before
> fetching, 2014-01-02), but it seems that nobody in that
> discussion realized we were advertising the "after"
> explicitly.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I include myself in that "nobody" of course. :)
>
>  Documentation/fetch-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 036edfb..b05a834 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -52,7 +52,7 @@ ifndef::git-pull[]
>
>  -p::
>  --prune::
> -       After fetching, remove any remote-tracking references that no
> +       Before fetching, remove any remote-tracking references that no
>         longer exist on the remote.  Tags are not subject to pruning
>         if they are fetched only because of the default tag
>         auto-following or due to a --tags option.  However, if tags

What's the difference in behavior due to pruning before instead of
after? Curious. It seems like pruning after would make more sense?
