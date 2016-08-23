Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193671FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbcHWRhD (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:37:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33452 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbcHWRhC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:37:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so19079053wme.0
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v14vxvUWym/RrZl3E21xC3gnDP6LPk0sPi/sydGMUQc=;
        b=xi6eVIvac1JS7Q8Pe6/KfCUHj5UulAlxOu+VkAquCJlOwrJtE5M9q/dbhS+BxpB5mY
         +ouTrI7t1VwNgkI63PZ5UU0q8CKPXnV5fpt7OmKWfaTDWtuir8/pGvu3aVr6pyUNZblo
         mxTz/+ZRLLH699LgyZWfLDKCh9PdXNCFkyaYjNHtKEib1yJFcM3k2QyBrfos9CjvDWSB
         WULp6fozXY7jAxGm0PUb+8Sx017ohrYNg7WMQYu7ftbDhcgj3tzrQRxzfuXwznSCJ3WB
         hhRqCZK/armHcioPF0DzoLDLOtGEdcJE2aO9VyTB7o917pmnSpLcB0v2mhsVOSKbn4XZ
         Fasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v14vxvUWym/RrZl3E21xC3gnDP6LPk0sPi/sydGMUQc=;
        b=lOUp1o0YGd6Y7RrAF7OJvzTSo8SR2obuf6I46kAzOqzH6Ud8NQCm5J9OI/JITzZbHN
         WpUINI3C9TIYCF925lzibZDmU6LSCIZ/lc0tY27qIw+RrHuzcqAvKFYYex2PerNdquNh
         Tq58a+3Sau6VoLC2b+/AnxkcHns32yxHqn6yC37nl73v22vamzRuSoO63RViEB/bS7EU
         oIpZzS9mEwIi+4wXY/fXHIMVmTJmKAbnPZGsBB0GhN9NLVsmMp9WA0ssS3u2JC3iG7cA
         CmRdyDGnGpMvUzjOvejeVbzkby/mpAJ1cICXleWuKj1TV0MeCxxCK5oVA67YyGEkOABL
         2EOA==
X-Gm-Message-State: AEkoouu6LbNqlPmOIwkEkaWssEquHj0QcXk3dDkA/vTWENgyl+5NuqohQ6qg40OJ8twbPeIyOCqu5tGy1vsBRQ==
X-Received: by 10.194.235.166 with SMTP id un6mr22608569wjc.169.1471973821101;
 Tue, 23 Aug 2016 10:37:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Tue, 23 Aug 2016 10:37:00 -0700 (PDT)
In-Reply-To: <1462477081.1237058.1471595951145.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
 <20160818185719.4909-1-ralf.thielow@gmail.com> <20160818185719.4909-2-ralf.thielow@gmail.com>
 <1462477081.1237058.1471595951145.JavaMail.zimbra@ensimag.grenoble-inp.fr>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 23 Aug 2016 19:37:00 +0200
Message-ID: <CAN0XMO+4u+XY2F-mVoLXegz_uom+ffcUuFJqf8aRMiW83dydbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] help: introduce option --command-only
To:     Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-08-19 10:39 GMT+02:00 Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr>:
> Hi Ralf,
>
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>> [...]
>> +test_expect_success "works for commands and guides by default" "
>> +        git help status &&
>> +        git help revisions
>> +"
>> +
>> +test_expect_success "--command-only does not work for guides" "
>> +        git help --command-only status &&
>> +        cat <<-EOF >expected &&
>> +                git: 'revisions' is not a git command. See 'git --help'=
.
>> +        EOF
>> +        (git help --command-only revisions 2>actual || true) &&
>
> I think you want to use
>   `test_must_fail git help --command-only revisions 2>actual`
> here to make sure that the command does fail.
>

Thanks!

> Thanks,
> R=C3=A9mi
