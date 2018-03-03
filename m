Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E0C1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 08:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbeCCIm7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 03:42:59 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38405 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeCCIm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 03:42:59 -0500
Received: by mail-qk0-f195.google.com with SMTP id s198so14946059qke.5
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 00:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=v+74oAspi+jIaa61q0kz3pZpaHGVq/qNJByx7o9H7Nw=;
        b=YoDFH5LvoSSjrq9uS9CYt0e+uYnvlGQhhpWKsp+X93QIwYl/5kHe71ypuyPzeT9yLu
         i0QFRcZKWZuhCrdHkK39bqMJ8Dn/pZgdL7rOfF/LZyF3TjCgf1pNnDxk9eIEYopJUjsw
         q/oXFfIPhfW/WDpnv202V6jJQ888nP2d0v9m0zjIFh4NIMwNK8fHb/OHJH+dqfvJaZ/U
         tt/zxnDNAh2vf7+rKg6uxqBnk0xA8EJBQ+JR2ijqwDQ3cTtifpmfrb8I9YljGa67FuN4
         V8y2TLNp40lRuw0tQHrrhun0ZXFw+HslSOUsXFhtyNl8le1Yq7ypi7HgCqvkuWAw1VlS
         /vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=v+74oAspi+jIaa61q0kz3pZpaHGVq/qNJByx7o9H7Nw=;
        b=rpIMWYdt0IqwUwCHwNXNR1QHWEiGRiDJcM0yi4Er1l3gy0ICe+4msrwsXqaMB41GyJ
         +x22n2/f+7M8zPchzfvzEjm3+nYlOniYeGfUYp/xpxWt+KKcN1TBnVMtVLJf0b7lO550
         VLnOP5ivvgIm/rDbqCou2kgIqIbSa5YpPOzaq6Itn1wcH9N1LF91YR9IuCgfRtKCED7J
         JHjaFkaaRLKsyWstjbBpaLGP8k8SxxsI4LFAgEwDK+qUjeDeOp6ARborJtMVlByjpQ3P
         jGUJETzUMEglN8cZXYocdsaHhQA/CXEeOaUwbEx8yfrTa4xMlFmHBG33X7KuusLg/8kW
         sDHg==
X-Gm-Message-State: AElRT7FsKHbSmLrW2FVuy5SCM9bGKlBTxXnTAv6EP7xuV8i6XhonFJkl
        72i0rMrpEQQEWH1R12g2kfdfyH6uqXLoxK2Ct60=
X-Google-Smtp-Source: AG47ELvMCbwH9RlczOM4oF6LFiWbzk465MZ9ONEpzWsC/cIXrSn9FF2cBhSje+PGLH57NxiJDRnejDy9UQHFni5whnE=
X-Received: by 10.55.133.131 with SMTP id h125mr12589044qkd.79.1520066578362;
 Sat, 03 Mar 2018 00:42:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 00:42:57 -0800 (PST)
In-Reply-To: <20180303034803.21589-1-dorabpatel@gmail.com>
References: <20180303034803.21589-1-dorabpatel@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 03:42:57 -0500
X-Google-Sender-Auth: 3_sF1VQjV3d9pdcwLWa8ntDGl8w
Message-ID: <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
To:     Dorab Patel <dorabpatel@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 10:48 PM, Dorab Patel <dorabpatel@gmail.com> wrote:
> The previous version only looked at core.excludesfile for locating the
> excludesfile.  So, when core.excludesfile was not defined, it did not
> use the possible default locations.
>
> The current version uses either $XDG_CONFIG_HOME/git/ignore or
> $HOME/.config/git/ignore for the default excludesfile location
> depending on whether XDG_CONFIG_HOME is defined or not.  As per the
> documentation of gitignore.

Perhaps take $HOME/.gitignore into account too?

> Signed-off-by: Dorab Patel <dorabpatel@gmail.com>
