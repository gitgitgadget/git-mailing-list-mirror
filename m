Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764DA211B5
	for <e@80x24.org>; Thu, 24 Jan 2019 20:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAXUw3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:52:29 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38999 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfAXUw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 15:52:29 -0500
Received: by mail-wr1-f45.google.com with SMTP id t27so7998600wra.6
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tkCM3UrdqtLCFopfh54/NHpnwdAcgBF9YdgfRvj3vvE=;
        b=dJzOassK0RV18tjZDOLa5AJAWjk/F34+jEeQQ/nqCAWrlYkXMUErVWi5fg0Eonb4d5
         Cjf+3BZXzhe5PtmLAKMQZNPvaNL2FePHfkmglatRaYj1zsCF6u4a1IK6K5JqcXECQYjb
         Yp6WTJz6In0ChIuMgoKGh2/LcJkUWK8UZvrji8MDpfC0ASTQlRuH5S3C0NnblCUcDX+5
         wWAx7DPQl1ZSYZGbJ4qLb/xnaIFzJ4L6s9uoiNgOpXbb2big17TkFi0XPdA2caipQPPU
         Vhmv1tj/D2/DASFBHDNvOcv84Dmr+NlHQOBCuMC+PVbbV+3DQJ03/ugPAaPZNKn2Cl8E
         fwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tkCM3UrdqtLCFopfh54/NHpnwdAcgBF9YdgfRvj3vvE=;
        b=g9sIquNtSpiA9gdfZm5oTP4DKVCPb4NuDnn4IenpzOyQtbgtRhct74azaP++0xymcG
         Wf8/dVqA5wE09ppg0Djp+0SeYTq8Y18EZj8LYd525nLxSPDdgB5FiM021qDtrO5TD3KR
         RnU3ITNEG6qNEK96YaB8QPLBEdvliQhh4ddTDdj5ATQp0xSV5Kj+mPEC93vQH4PCgBlc
         VVtoA99+jz0NfASz14HdpovZCQZ76n3MeJpWcI42XDF0A/UzCqahLFhnAfjCsaFLHRah
         UdgLlZHoXVv8WMKMXWB9rub4Nyj1bk9MaUQOhSSC6l20w85ZMpPsXHQPnxKZMffs82m1
         vsBg==
X-Gm-Message-State: AJcUuke+ugI9cKpglllMIx0DS7HoD0d8MUY1bTsDA0ztnS4sy2jTfI3Z
        aHpoWWMj/8Epy/ZjllOXSA4=
X-Google-Smtp-Source: ALg8bN6s7O4UzIdIrM9ThWZ0roCsdKmSaEtM8aT5Or3YhSVFAENO5uXgyW2t7tbZRS2QtaGcYBishQ==
X-Received: by 2002:adf:e383:: with SMTP id e3mr8274348wrm.31.1548363147255;
        Thu, 24 Jan 2019 12:52:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o16sm147014170wrn.11.2019.01.24.12.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:52:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Arti Zirk <arti.zirk@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, peff@peff.net, jnareb@gmail.com,
        flavio@polettix.it, wil@nohakostudios.net
Subject: Re: [PATCH v1] git-instaweb: Add Python builtin http.server support
References: <20190124161331.25945-1-arti.zirk@gmail.com>
Date:   Thu, 24 Jan 2019 12:52:26 -0800
In-Reply-To: <20190124161331.25945-1-arti.zirk@gmail.com> (Arti Zirk's message
        of "Thu, 24 Jan 2019 18:13:31 +0200")
Message-ID: <xmqqpnslhj79.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arti Zirk <arti.zirk@gmail.com> writes:

> With this patch it is possible to launch git-instaweb by using
> Python 3 http.server CGI handler via `-d python` option.
>
> git-instaweb generates a small wrapper around the http.server
> (in GIT_DIR/gitweb/) ...

I know this follows an existing pattern (psgi and webrick also
writes nontrivial amount of code inside GIT_DIR/gitweb), but can we
somehow clean it up so that we can do instaweb out of a repository
without writing so much into it first, before adding yet another one
to make the situation even worse, I wonder?

For now I'll queue this so that we won't lose sight of the topic,
but I am not exactly enthused.






