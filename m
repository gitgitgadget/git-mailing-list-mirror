Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959B3201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 16:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdF3QGE (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 12:06:04 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35225 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdF3QGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 12:06:03 -0400
Received: by mail-oi0-f43.google.com with SMTP id 191so13876883oii.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JwORBlkOVgLEPL0uJKdqx5zr+MVY5lN2Y/ceMlGZAFM=;
        b=TPXkmdACk+Rrb6mGCIcs6LNPwWuVKPdLl9ZB+xEJpZk42qqBjb1dgHFvg+UzYAU0If
         9hxOcMkst7SU6AvShQwJ1W6junf2Hk9p5lnUFjnaMeqTi71Q8+e3/+SQIlnQ90nywNah
         hAcF0MBew2kGRFRl79qk7v/Jk3RLvhDEDtmwDYemeUHDsj7jsCvrbPblwGM1EHklbQyh
         lzcQz6BG5ST2SV4XVWt3HwB0M6TLvPOoyuDr/dNZ3VuZZDQr6otf05lzKboDlKmpPIWe
         b07x+TeLqtMoSzHNXCb9A/8y+5axnfSinvu+V6vk1KozeY8Fx5zIpbxKw9jYMmVqFFz8
         6rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JwORBlkOVgLEPL0uJKdqx5zr+MVY5lN2Y/ceMlGZAFM=;
        b=qt3h4xFxaKZy3uiznSR49kb3T8CcNgMwRf53s+RkLSqYYH7yLAI26j1A+mUbol/bIF
         K5klO0jKHfSDUYSZBdsh0htlLqDF0c33jNOKiYqBqneOHGekoLeDNX5UfOj5xRM4LTWV
         dsdsEHj6HPD7kZFW3l7WMtM4+f7+dwDiwGOlbzAzssbTUT0DvdLZcoJd4/wJhYz1N2Au
         +CuEr67hGiI/fwuJ/9u0+FrBQiD5Flpo7x4eLQLk5EjdMiafrDZMX8rBt7wtwxh5WXj5
         VBmLQtBxZuJN/nBEpYHS1R1onhZraqysrXeFR+W6EiAj5BcJd8Dm0DS59m6m8mVVYiU2
         KgXQ==
X-Gm-Message-State: AKS2vOzaEyuwu00yJQUrDQxLV3RpXxME05AX4xrF//R2bA0+XbYCt5b8
        N5OgD0dfcTSjfiGaPyMIFVxEM8THox0j3OA=
X-Received: by 10.202.212.9 with SMTP id l9mr14885074oig.120.1498838763088;
 Fri, 30 Jun 2017 09:06:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.104.26 with HTTP; Fri, 30 Jun 2017 09:06:02 -0700 (PDT)
From:   Shaun Uldrikis <stuldrikis@gmail.com>
Date:   Fri, 30 Jun 2017 12:06:02 -0400
Message-ID: <CADHEqX_fiUhnpn6WAFrbDaNJTb1Vbom7Ndn-n6WmQ0gkQ69ZeA@mail.gmail.com>
Subject: git log use of date format differs between Command Line and script usage.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you supply a non-standard format to the date configuration for git
log, something like:
[log]
        date = format:%Y-%m-%d %H:%M

then, when you run 'git log' inside a script, or when using gitk
(anywhere), it fails on decoding the format.

fatal: unknown date format format: %Y-%m-%d %H:%M


However, that format works correctly on the command line.
I do not have a patch to address this issue.

-Shaun
