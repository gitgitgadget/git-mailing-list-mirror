Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8978620281
	for <e@80x24.org>; Wed, 27 Sep 2017 00:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967963AbdI0AEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 20:04:22 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:54001 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965047AbdI0AEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 20:04:21 -0400
Received: by mail-pg0-f51.google.com with SMTP id j70so6780242pgc.10
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UnYJGMRzV0yqdXLy9t2Sj0fVBHEFnvB6oZRi0fzBOZQ=;
        b=JWAKx1PrJmIaBU8jIcsyzU+VnQktYu+qxc2e2WO6iPQKl8ltyveHOjfL6RrX814igG
         cKlOMcuO4vZhwp8RYyxuSeRq9ixuONPlf7jYJSBetVytAEmfGzj1hCR2LbvTantuHLd2
         sihBU6K0HjzI62hMyJl0oQupjgbl96NtB0XsY1YBvp3gFRCqZq5ja2mifuOnC2J88AbD
         OxR+bpPdtS2/67PQTmI3UjE4ENQJX+shEPnW3XWEEPTlvqMcx/ObvL6CqKBJVctbEOd/
         Qh3wemG0YVD+nkLvaVgXBPoBiyhHWUsDOqqIMHXObb86LU+myFEYIZY525bycHP9nUjl
         jxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UnYJGMRzV0yqdXLy9t2Sj0fVBHEFnvB6oZRi0fzBOZQ=;
        b=TBSpsVOo1Q9DxhomHEerAl2dRu4Qch1xg3f5XhI25tnA+u/upkYqfdB2C0awsz5/9P
         Pez1vf/PhP1QQDRw15ynpjGwP2vPpDDY4T7HmovvPKNXrZqMcGZwVucWHUiPAKnd+GuP
         g0KE5UO03a6cIIpYthD+NQYcRDYokppqpwbR86tHgmXC0VXEUgb61+TqSQaclykrxYG5
         /QfFgrKqLeu8bkTajLnp5PkpiHSVqIy/YRaGeWsq3Tqi0ce5GtbHXS1ZXIMxud9J/Wm/
         EPLSNYTD0vHSNacea2bb5B1AokmugqbM3C7THdtWMQSLiJYUXgqdsAaDcs/oRysLme6k
         k74g==
X-Gm-Message-State: AHPjjUh28T+oMPtqWJqmaGbBYT0l/Rfq7HpUqDZd83i4RfLhvmTR/DUZ
        zwG750CLfV95EXDlskz1M5U=
X-Google-Smtp-Source: AOwi7QDP87RVJGAWfQY6FIGnNu0MnR/tbmgObBe9dsmS2zCHm5OPZqf1yb44lRNe+1ov70K06xvcZQ==
X-Received: by 10.84.194.226 with SMTP id h89mr12281000pld.54.1506470660852;
        Tue, 26 Sep 2017 17:04:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id n12sm19516275pfb.131.2017.09.26.17.04.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 17:04:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roberto Tyley <roberto.tyley@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Roberto Tyley <robertotyley@gmail.com>
Subject: Re: [PATCH v2 0/9] Teach 'run' perf script to read config files
References: <CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com>
        <xmqqbmm0h6h1.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1C80cHnMtdZ-iTYQpNNErUEJ9TmQ9baG1J2w+pv1ceSw@mail.gmail.com>
        <CAFY1edZ6FX6s+H_XWa-=nKqr4NA9BNVxR6fcOo+5gn-Z1XKdUg@mail.gmail.com>
Date:   Wed, 27 Sep 2017 09:04:18 +0900
In-Reply-To: <CAFY1edZ6FX6s+H_XWa-=nKqr4NA9BNVxR6fcOo+5gn-Z1XKdUg@mail.gmail.com>
        (Roberto Tyley's message of "Tue, 26 Sep 2017 20:33:16 +0100")
Message-ID: <xmqq4lrp9fct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roberto Tyley <roberto.tyley@gmail.com> writes:

> I had a quick look at git-send-email.perl, I see the trick is the `time++` one
> introduced with https://github.com/git/git/commit/a5370b16 - seems reasonable!
>
> SubmitGit makes all emails in-reply-to the initial email, which I
> think is correct behaviour,
> but I can see that offsetting the times would probably give a more
> reliable sorting in
> a newsreader. ...
> ...so the only way SubmitGit can offset the times is to literally
> delay the sending of the emails,
> which is a bit unfortunate for patchbombs more than a few dozen commits long!

As this matters mostly for a series that is longer than several
patches, it indeed is unfortunate.  If SubmitGit needs to send and
sleep for a dozen messages, does it mean the end user has to wait 12
(or is it 11? ;-)) seconds?  If the human is the only thing that
needs waiting, it may be OK (after all, it all happens in the web
browser and the human can switch to other tasks after clicking
"submit"), but that may not be acceptable if this artificial delay
can cause a timeout in a moving part among many.

Thanks for looking into this.  
