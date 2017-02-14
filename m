Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F9C1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750782AbdBNV4V (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:56:21 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35898 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdBNV4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:56:20 -0500
Received: by mail-it0-f68.google.com with SMTP id f200so7500781itf.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VVOMk8gzRzaeM7Dkewt24BCa9DSRKccqQARM4Ttu5rM=;
        b=tOrQ6RJQlsud0GDOzoyBx2CYMbqXe3u5cqmQ2uRzqldp5jBvOjMnieBHZaU+7Z3HBC
         SZbazvhSetn+rObnLfKRlHPi7zvCVSYSl3wXPbjCEoNMM6B8y3Pu3uKKxfophSXZb+3H
         Urq5t26f3Ng3eOEkWGPV09sNMLW9LzvvpWaR+RlYXqndeBWQGrpX+4wPph9kOXqD26Kl
         JAv5wRds1Ssi7wOrBqnxD62Q/N8qlBR68eRJdN2Gy29/kTKb8XYaBDD5j1HK+uUQM6l+
         QY0DP6+4W63pWuDr0rIC6ZdiYi3AkEXYNry2I3g78Dz6Fjl6jZht25E6wWvahrN1eTTu
         m1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VVOMk8gzRzaeM7Dkewt24BCa9DSRKccqQARM4Ttu5rM=;
        b=jUq2icJRgyWfrBsjuLVcz5kQKkiNUID4mjH29ALH0fBRTFe+ky5IhPhfytPnDiZ/bx
         OEqVUmYFzPXLTzM3CaW2tCjyD9NOnsSfqeKg++yX6fgEHrlUN52XMqYPCXtX81E6lFIj
         DXi4rYyvrUJA5GayayW9Ta+1/qFRvdz0+S4SCMI+570e7a8Os5br9c8gAfLa7KXOyhP+
         uQ9qrpPwpQIqR/nsLsEz96p1ks/N+n8lrjLtPUB2Uqu8Lj5QvIkeDl5B1VmrlrvNABpY
         cxLybbktDV3px0+pvrh2KhudPQwYTe5eLpWxx+duXz10i5v1lIzSA4X5oEVM3NGVozJn
         nWJg==
X-Gm-Message-State: AMke39k1eLwqzg3EXURRv0wiy8xQz0k+tzUjzkE1fkoJ2hoSGhkV0ynMSih8sMrGhmAXew==
X-Received: by 10.99.94.198 with SMTP id s189mr34939749pgb.211.1487109379283;
        Tue, 14 Feb 2017 13:56:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id m20sm3089026pgd.17.2017.02.14.13.56.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 13:56:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC-PATCHv2] submodules: add a background story
References: <20170209020855.23486-1-sbeller@google.com>
        <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com>
Date:   Tue, 14 Feb 2017 13:56:17 -0800
In-Reply-To: <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Feb 2017 13:46:09 -0800")
Message-ID: <xmqq4lzw8mim.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> If we were to redesign the .gitmodules file, we might have it as
>
>     [submodule "path"]
>         url = git://example.org
>         branch = .
>         ...
>
> and the "path -> name/UID" mapping would be inside $GIT_DIR.

I am not sure how you are going to keep track of that mapping,
though.  If .gitmodules file does not have a way to tell that what
used to be at "path" in its v1.0 is now at "htap" (instead the above
seems to assume there will just be an entry for [submodule "htap"]
in the newer version, without anything that links the old one with
the new one), how would the mapping inside $GIT_DIR know?  Don't
forget that name was introduced as the identity because we cannot
assume that URL for a single project will never change.

I fully agree that our documentation and user education should
stress that names must be unique and immultable throughout the
history of a superproject, though.


