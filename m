Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034D0207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 00:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbdFXAd1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 20:33:27 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35176 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754727AbdFXAd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 20:33:26 -0400
Received: by mail-pg0-f41.google.com with SMTP id 132so27146364pgb.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9kQds2zesZ4g/mXADN8gEi5Quaved8qr1Z+hOCJYQE0=;
        b=e843l5ZpgL8UZ1mEbD1I1MuxxEiMR5QMkyNtxf/9qKcAThurjmuHsp28H1u1tev3nK
         gr1WLhgV3uh+Ed52Z8myWgyEx7o76yZBpnPXwC1XvoHhIn2eQZJ6NrndxMuuiBtZ7TeY
         4WqY+U+IgK4MdrA4x+rzbcUy6dcOZN+NOjegZcmimTqhw8Yk7rLR2p2D0mV8dSwX+oFY
         MigS0jCymPkHwHRoLQPDe9brkGxMg2qxtGI/fPWJUQwltKmLCEoAZ2RjpJpZdUMrYPUE
         oSZ8MnDjI1Ss/cWLYNGKJTAzjngnzUsKgWFPeHqe5Qpva/8qywd4croFhIVU3nTEEIjD
         j/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9kQds2zesZ4g/mXADN8gEi5Quaved8qr1Z+hOCJYQE0=;
        b=gkVlXIyXE5ROGhoJXecB0wU8j336WNnvbAEBJKwICiBeC7kIO3Hmbce4TPc5erw3A8
         WUS4Z91hsiYQ72M5fTE4XamDovCbvup8iOqfL2YND2IDEQ7a30AfOpzg+EQ9kvXVH48M
         MLgYT+hNoPZ7vQfh8vj07FNCvbmhBl4N6eSnbtunnS74DZvUVN3nvoAHqeUv4hzw4Ej+
         7fLbObqWTx0K4ksSmQ3y+w2bwDaiFxtUKZ89Bh08/ZhS8cQQcv/hanjmfIyaJkewPCdb
         vSyzRMPvdELiJSAfNN5chlIl+3wDwfz6Bq0uH+VSGEADvC2XhcUe2S9du9AAV1O5YkkN
         m7Jw==
X-Gm-Message-State: AKS2vOyyXgsob52se7OSKAN/9UYIWOhAljCvIoeaLRVNsvZxdUOAbFyA
        glWMeEYkivJM5w==
X-Received: by 10.84.216.13 with SMTP id m13mr11645032pli.201.1498264406040;
        Fri, 23 Jun 2017 17:33:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id c10sm10632568pfl.81.2017.06.23.17.33.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 17:33:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
        <871sqajrgi.fsf@gmail.com>
Date:   Fri, 23 Jun 2017 17:33:24 -0700
In-Reply-To: <871sqajrgi.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Fri, 23 Jun 2017 23:59:25 +0200")
Message-ID: <xmqqa84yb4x7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This is bad:
>
>     $ ./git --exec-path=$PWD -c diff.colorMoved=crap show
>     fatal: unable to parse 'diff.colormoved' from command-line config
>
> Fixed with:
>
>     diff --git a/diff.c b/diff.c
>     index 7cae4f1ddb..036dbc1c3c 100644
>     --- a/diff.c
>     +++ b/diff.c
>     @@ -278,7 +278,7 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>             if (!strcmp(var, "diff.colormoved")) {
>                     int cm = parse_color_moved(value);
>                     if (cm < 0)
>     -                       return -1;
>     +                       die("bad --color-moved argument: %s", value);
>                     diff_color_moved_default = cm;
>                     return 0;
>             }

You would want to model this after an existing practice nearby.

    $ git -c color.diff.new=frotz diff
    error: error: invalid color value: frotz
    fatal: unable to parse 'color.diff.new' from command-line config

It could be argued that it would even be better to show "here is the
list of valid values the configuration takes", but generally we do
not do that in other configuration variables.
