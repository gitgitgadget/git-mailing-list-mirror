Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B7D1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 19:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeCGTfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 14:35:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35076 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeCGTfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 14:35:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id x7so6885078wmc.0
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 11:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kpL4hNRWvsQeHlpOkkB0vohYX2pwYcIeo6izdf6+/sU=;
        b=YELoaoccg1QE61sjXmO1JQPAVWqfgNzzW0y+H+0tRYlx2+WujzX1Xtd8X11wKvvjZ/
         Bg38r0zmntpq+/bMh7kMVObbiLWtgjVSsW70LXeyJlgqR3bg5oVqROik4HBrNx3CvXlQ
         pLOADb3tHFMmhMzOPcHPNIbv9Z/qkDoE6Ojh2HYukKIpizAFl6k5Zwiu8yA4PAHEY9If
         GNdzoG5ArxH7vUyd0Iy8NPjNUnNTyWX5/q0BNyxwAtN02Ubs7utSZ7gF57f9Mvc8guIm
         HG/4a91/UxGWiWunIVfljeWsE8lPabkCdarBajTmGANWpFG1mXg+XU1nMrzs0tPFD4qr
         1xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kpL4hNRWvsQeHlpOkkB0vohYX2pwYcIeo6izdf6+/sU=;
        b=QrMxg9EJWta9EPOKA5wB4jEKlaMekLEfxG2ht274yaFYEJI6OLTBIJPZM0q+SC9Bk0
         7V4pnjgF3z2y/16M9N3hMvCATOaxmAO0mp0pzBtj0LJh3p318zZtGhbIXDKPx77ZaEXm
         OBu4YAjkrx88oEtlXuFvi+6pr9LMRtEUou7UFq6ufZcuiReoJ3PzG3Vzzi+oZ8m67P+I
         1inw5NOMgA2EDRbatfGZ273nJl6ZD4O+LAVmsHehQy7lJfs8PaILMNlLa60x88PeO0UA
         WV6kx10EYRW8JYuiywXl2MH4J2T0j82yWzgOeE7ltQOPh87DEfGAYmkhcCDldP31cOlh
         KlxA==
X-Gm-Message-State: AElRT7E62vmlEBNluGZQ2qN518paheol66XvUVARq5uRLN922ADK72S6
        hOlaveMKLE2VLijeq7PB7As=
X-Google-Smtp-Source: AG47ELvJ250O2yYpSn+EIYJEKu++voHUnipiq/EHa8/7UjgOIEx4VP6k4CYLR67YGP1zVL9BmVcXRw==
X-Received: by 10.28.239.8 with SMTP id n8mr16086543wmh.120.1520451309649;
        Wed, 07 Mar 2018 11:35:09 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z3sm15359744wme.3.2018.03.07.11.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 11:35:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v10 6/9] convert: add 'working-tree-encoding' attribute
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-7-lars.schneider@autodesk.com>
Date:   Wed, 07 Mar 2018 11:35:08 -0800
In-Reply-To: <20180307173026.30058-7-lars.schneider@autodesk.com> (lars
        schneider's message of "Wed, 7 Mar 2018 18:30:23 +0100")
Message-ID: <xmqqvae7znkj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +static const char *git_path_check_encoding(struct attr_check_item *check)
> +{
> +	const char *value = check->value;
> +
> +	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
> +	    !strlen(value))
> +		return NULL;

This means that having "* working-tree-encoding" (without "=value")
in your .gitattributes file is silently ignored.  

Thinking aloud.  I wonder if that is something we would want to warn
about so that the project can fix it, perhaps?  Or would that become
too noisy to use an older version of Git that includes this series
when a newer version that defines new meanings to boolean
(set/unset) values for w-t-e attribute becomes available and
projects adopt it?  On the other hand, with this code as-is or with
an additional warning, such an "older version" of Git by definition
behaves differently from such a "newer version" that does something
different when the attribute is not a non-empty string, so it is
quite likely that we won't be able to redefine or extend the meaning
of w-t-e in a way like that.

Which means that the only sensible way to make sure we _could_ later
extend the meaning of w-t-e and make it behave differently when set
to a non-empty string is to make it an error in _this_ "older"
version.  That way, of course people cannot use the "older" version
on a newer project that depends on the way how "newer" Git treats
w-t-e that is set to, say, "true", but we won't silently (or loudly)
do wrong things to the project's data.

