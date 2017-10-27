Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CE020560
	for <e@80x24.org>; Fri, 27 Oct 2017 20:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdJ0UEt (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 16:04:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:56150 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdJ0UEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 16:04:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id 17so5658154pfn.12
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p1U1aN5pXuIftsWv1C4ZeF1pKbP3rP4/VcxJNL7HvVw=;
        b=n8Tq3zZJpDhZLIQ6ASAZFuosG+8MCMgiNhGz4WLY9ruiSEdyFpQ77msETPt+HoTPLa
         aIAOYmHV/GFxpJKT0oQBB7ny8j1aBfOT4PMtmhsHbYyj1WktcI9Z8ST/Ph2KPDEB/F9/
         mGZrEl1Ml0HLpPHE5lM8K4sYJLWflbxMnA6mw2wNdX0e4X5M5/Z3hiQT/qaWXAE7jZDz
         mGI46KaWxxFHVx/jF/YnDYWcoRrK2Z80Ry6HpkVuTNj4BOURvfRM5npQjWgpr2Oh38yv
         0oDt6pgELrg+I/2Ew0XWy5on0XU03eTMkf08lRExT6Dxl0ESBVVDi27I/zKt3RyT8mgb
         T15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p1U1aN5pXuIftsWv1C4ZeF1pKbP3rP4/VcxJNL7HvVw=;
        b=IP0ZeN5IhDpdzG7QWHrr2fWueI4dwLjXGc2J0jycXvAX9EahZIlSYOLSRFcY1OqXzZ
         MgYgqnxythZV/dHvQ01P6Rb16ziFKEWRfl9F3ClRHvDXAHunpD9fqj/RAyZWwrJpJs2/
         1tNDif14UerDySa1IvJVWbE6GPAwQ2l8/61Iiwo6eXt8pIVkXJVf3ukeWI5CxsanZ45p
         4fQlM5XHAitWMJnA8Ubz8z0YJiRacJm7j+IRSl7ARyrcMuKxuSMKZPOsecJgbEqgjDdK
         4AZYHrera/rReGWNjKivGKeDkiUHv407HL94oMGLCttCcf1EcqGk3JSotOk/rXR9UXAG
         +G9A==
X-Gm-Message-State: AMCzsaUoIDyCEvXoRPuFTzmzv1TbAiydFzrBqEU6W2xVdYktNSWtu49n
        2gxhlOkZzavInaM4fSfvxx8vQYtqwn0thN8NSWo=
X-Google-Smtp-Source: ABhQp+QdAAa6hlJrCOnfNuYfSYGpnGkKCnevTPLJq2dOqzLnIDXKCSgmK/6Va8uV4jEseljFqjLsK7j8m5ogLtB+Gho=
X-Received: by 10.99.189.65 with SMTP id d1mr1249763pgp.48.1509134688394; Fri,
 27 Oct 2017 13:04:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Fri, 27 Oct 2017 13:04:47 -0700 (PDT)
In-Reply-To: <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 27 Oct 2017 22:04:47 +0200
Message-ID: <CAN0heSrWbgNEfeXj0D0SBiyC_9i++qecBcb5Kuf4WtS1wFxKDQ@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 6/8] bisect--helper: `get_terms` &
 `bisect_terms` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> +       for (i = 0; i < argc; i++) {
> +               if (!strcmp(argv[i], "--term-good"))
> +                       printf(_("%s\n"), terms->term_good);
> +               else if (!strcmp(argv[i], "--term-bad"))
> +                       printf(_("%s\n"), terms->term_bad);

You seem to have lost --term-old and --term-new. I also wonder why these
would need translating. You break GETTEXT_POISON here, then fix it in
patch 8/8.

I'm not even sure you need patch 8/8. If I drop these two `_()`, I can
run `git rebase -ix "make GETTEXT_POISON=Yes test"` on the entire series
without failure. Patch 8/8 also switches to `test_i18ngrep` for some
usages of `git branch` and for some checks on `.git/BISECT_START`. I'm
not sure that's needed.

> +               else
> +                       error(_("BUG: invalid argument %s for 'git bisect terms'.\n"
> +                                 "Supported options are: "
> +                                 "--term-good|--term-old and "
> +                                 "--term-bad|--term-new."), argv[i]);
> +       }
