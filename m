Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E044B2021E
	for <e@80x24.org>; Wed, 16 Nov 2016 01:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbcKPBdr (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 20:33:47 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34446 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbcKPBdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 20:33:46 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so12820781pgc.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 17:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=5NxheIOOkMyL0mVGjSjW1Qcd2Z2PAETYvUzmqk+PSUg=;
        b=CXAWYYTcbpYQLt4EO61CYHZydM+d3E/X2bIRGkhZpdFvjatmNRNEfsz3SxINg7lWqq
         7Xs+GHwPNELzhyIQH/6V01tJfyJFDN+pUOOlCqRvCzwxaR1yRJzQFrtVMNSkyPXrmXyJ
         8VMrJw1rXzSLFjTHiZbeqbpjVHLYzbIhak79gapkUUEtiYDwBBSNSdbPs8ZMhjhtbJOe
         KMONOeB3kmokjdcwelvqxl+rt1KqOfrE9q2rbseursvCGMiLOhk1j1+yTunp6HIGdq2j
         n2D3CZLuutv8JXmqVb5yHWekep1AQiHfEzHxC6DJzeGIc/QKUhfNIVOYLO9/O593qZGG
         swUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=5NxheIOOkMyL0mVGjSjW1Qcd2Z2PAETYvUzmqk+PSUg=;
        b=kToDWT8GO6pZvVHFsqNinhUuNqNsBO24SEM73j2Pv1EAeZiwDoX/jdFfUBtUIZeGID
         JsMPzYEVebI2O3DSvWp8JLVBZ1lw/EIVGFfk6x1U9TwTTfHzI3uoexWwbCzYdxUiPOVD
         2x89HvPAEJbDQQaYQjxjalfhwd8vR1NJJtoeYon4QM5QQR9KZaRsW419LzG+yTWpKN8T
         /n/UyV//36dg4scboyrcGsyotG6qENDSVfyGC2d2otLweCj4Lv9Z2lWEDKEPm/PrvlJl
         LCUx2RUnpiRhUonbbIOIBzOKCSVdw9sXKbVmf7rR3m1VSCP5MW885ofjWpAa0ENw4OIj
         cXNA==
X-Gm-Message-State: ABUngvfscvZxU8bZIqkC4fLfwd0Vve0dW8tzAaZRdiaPVjns3ullWnec0yj0vVfoxMYntg==
X-Received: by 10.99.157.129 with SMTP id i123mr2428659pgd.148.1479260025828;
        Tue, 15 Nov 2016 17:33:45 -0800 (PST)
Received: from [10.175.10.198] ([134.134.139.93])
        by smtp.gmail.com with ESMTPSA id s8sm46879771pfj.45.2016.11.15.17.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2016 17:33:29 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com> <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com> <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com> <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com> <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com> <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com> <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 15 Nov 2016 13:19:04 -0800
To:     Junio C Hamano <gitster@pobox.com>
CC:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <FAA5CD51-8772-4AA9-A9BF-F32C9D0A47CA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 15, 2016 9:42:03 AM PST, Junio C Hamano <gitster@pobox.com> wrote:
>I think you are going in the right direction.  I had a similar
>thought but built around a different axis.  I.e. if strip=1 strips
>one from the left, perhaps we want to have rstrip=1 that strips one
>from the right, and also strip=-1 to mean strip everything except
>one from the left and so on?.  I think this and your keep (and
>perhaps you'll have rkeep for completeness) have the same expressive
>power.  I do not offhand have a preference one over the other.

I prefer strip implemented with negative numbers. That is simple and expressive and if we need we can implement rstrip if necessary.

>
>Somehow it sounds a bit strange to me to treat 'remotes' as the same
>class of token as 'heads' and 'tags' (I'd expect 'heads' and
>'remotes/origin' would be at the same level in end-user's mind), but
>that is probably an unrelated tangent.  The reason this series wants
>to introduce :base must be to emulate an existing feature, so that
>existing feature is a concrete counter-example that argues against
>my "it sounds a bit strange" reaction.

It may be a bit strange indeed. What is the requirement for this?

I think implementing a strip and rstrip ( if necessary ) with negative numbers would be most ideal.

Thanks
Jake


