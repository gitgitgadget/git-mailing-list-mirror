Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2639A2095B
	for <e@80x24.org>; Sun, 19 Mar 2017 09:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdCSJ5v (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 05:57:51 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33525 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCSJ5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 05:57:50 -0400
Received: by mail-oi0-f54.google.com with SMTP id q19so11579208oic.0
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WxjdpBoK4NC/uTbBsnsPtrRedlwfPFBFy8AC+xK+QqA=;
        b=YxnOcjB+DuUNpZ+Rdwcudk8RSb4mav2JgZu+lh2LvK9WSdbdJQ6iin27hUyoqiSOOd
         TCS8lgJ5RllGS8SVJq6KIA/TvpDey3Bb08srR++a/k8MNOYK1bftpAHFZPU6fPl4CyAE
         qdLUwryctgb3EVPdfFyB2FQn0TYYpxDXwtLFDsIBjekapnQGLekYxt/NCxHFHkjA9x0x
         98UsAhX2Gu11PdzbmY0EuhflZ6lFRTeCZEAgOR8yiKAHcJoUFsWpHSM2AU6kyPxa8OGX
         OFOhVuOn+cK+dTey+JxZ47jQfd8ag0A+QQYh8vECfwTup8MmaW8vsOmS4kRZEBIIWOBC
         GmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WxjdpBoK4NC/uTbBsnsPtrRedlwfPFBFy8AC+xK+QqA=;
        b=ZOTfTET3bsqLBrj1p5jCnay5JI/inFJ2xA2MJqjhFcfI/yGdW2N5zZaGBsdwnd5zAi
         dHLKjz1G8OS2qjO1XBYo5GEGYgava4Xy2TOMBJsNGuyagewlgYOG1lXpYzT8CS0YD6Kn
         3JG4Y5EzeUdY5/PXHtbqpt88FejTnW7r2lQZzxYIDIIQqWEn1W4g7RMWk3plDQgkBbD2
         67SmJoDELeThCBqZrWwz9/bcbxQeiZ3gADJWbs+CvF6COX3zN1HIo6pIYU0RJUymxPRg
         kkDEUBWduPEbZOZi9ikamciHalIgzbM1hNIcfZ6D/Gvl6ojEOZwSubU5XH9qX1GjaS6W
         idRw==
X-Gm-Message-State: AFeK/H3UQjMO0enSmMZ+4xcO7FUyU+G3X5tXFHTVXpwDz/ABMXTu7HWhS/Gmk5eCPE42bGJaXMTN+vj3AY9nag==
X-Received: by 10.202.83.20 with SMTP id h20mr12340146oib.65.1489917469450;
 Sun, 19 Mar 2017 02:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sun, 19 Mar 2017 02:57:19 -0700 (PDT)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 19 Mar 2017 16:57:19 +0700
Message-ID: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
Subject: Add configuration options for some commonly used command-line options
 (Was: [RFH] GSoC 2015 application)
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 19, 2015 at 5:32 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> +### Add configuration options for some commonly used command-line options
> +
> +This includes:
> +
> +* git am -3
> +
> +* git am -c
> +
> +Some people always run the command with these options, and would
> +prefer to be able to activate them by default in ~/.gitconfig.

I was reading the .md file to add a new microproject and found this.
Instead of adding new config case by case, should we do something more
generic?

We could have a new group defaultOptions.<command> (or
<command>.options) which contains <option-name> = <value> where option
names are the long name in parse-options? Then we don't have to
manually add more config options any more (mostly, I'm aware of stuff
like diff options that do not use parse-options).

If we want to stop the users from shooting themselves in the foot, we
could extend parse-options to allow/disallow certain options being
used this way. Hmm?
-- 
Duy
