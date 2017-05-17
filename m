Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F982023D
	for <e@80x24.org>; Wed, 17 May 2017 03:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdEQD4S (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 23:56:18 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34524 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdEQD4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 23:56:17 -0400
Received: by mail-pg0-f52.google.com with SMTP id u28so525842pgn.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vGJIqx+GGKUZ89amBM+thsoBiK2zhx/KAuR9MqGa3z0=;
        b=BcKj4drZ5IP+yzpJ4Ih2SFHgG5DAT7PKqzRRi79IWzpInFqOTshwsnqN3A8+3IXVI9
         43ZBf8wLe1oYPwOflzilmv9RONaUcFml7A5+c0kcQQO/il5VS8hmH7VFLSM2gOD1ro/I
         aGbGzG6MjCaZGYW1U00cmgamOcX5IPgAmB2wDitSuHDBtaTEVu3sdXB2xa5+q0Uc2yYK
         dKdCntceKCydjh31sSr7Md/aFd5VlWkk7nKla/3338ikiSGc1Dv+tSwcBUyURJMTFPx6
         UILf09IH5gMcgvnIdUIi9GzU+PL8g6Sjh2M/8gKeZCYvFVyjxx3vCC5dodYpUQnRQZC8
         RaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vGJIqx+GGKUZ89amBM+thsoBiK2zhx/KAuR9MqGa3z0=;
        b=jIBkuazE7KCp3WD1Z151bvl/A0n5spFz9F8/VpGdd2UHGhlnRGpFooSEfa1T5Msc9y
         +8UyZZqsUyfQgreauC7Rbh5S+nGoMA/n2Hy9VrQEZ6ErwZOM0Gq5aVBlja9zBLVpPkMH
         +18g5Pxj6t4LQkvLnkSilcQ+o1aNSZTPdg9TGBuMSlIGO2Kk9W4LAlANk1FlAKGO5BAy
         PoYkPrd9TTVJ9u8yQ3rq2A/IRzfHWXL6WbbtcZnl/ubmGHqIeyk5E/R4d8vuGUF4zh2W
         KcmIMXE4zkIfEns92Wa+ZiR5nOy3szyGMHKIH53r/RGUI2JU1ibpzfpmkAGZM2FWDUA5
         39KQ==
X-Gm-Message-State: AODbwcC2ecXs/qFeftxLf6y+si7xsdVnnckQJaeJCuP6NKCxFoKKOlZ7
        jpYEm127qboveAzocca8cQ==
X-Received: by 10.98.79.210 with SMTP id f79mr1522156pfj.148.1494993376955;
        Tue, 16 May 2017 20:56:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id 66sm829628pgd.47.2017.05.16.20.56.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 20:56:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t5545: reduced test coverage
References: <ca942ab1-db57-5794-4587-1a756686c833@ramsayjones.plus.com>
        <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 17 May 2017 12:56:15 +0900
In-Reply-To: <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 17 May 2017 11:40:12 +0900")
Message-ID: <xmqqmvacxhk0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It appears to me that only a few tests in the entire script wants to
> work with HTTP server, so perhaps moving them to the end, together
> with the inclusion of lib-httpd and start_httpd that 438fc684 ("push
> options: pass push options to the transport helper", 2017-02-08)
> introduced, may be sufficient?

Probably not, as lib-httpd, when it gives up, does the
"skip_all=message; test_done" thing, which makes test_done
to trigger this:

	# Maybe print SKIP message
	if test -n "$skip_all" && test $test_count -gt 0
	then
		error "Can't use skip_all after running some tests"
	fi

So a bit more work is needed, than just moving things around, I am
afraid...
