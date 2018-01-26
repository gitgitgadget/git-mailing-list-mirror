Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72F61F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeAZTIq (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:08:46 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33324 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeAZTIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:08:31 -0500
Received: by mail-vk0-f68.google.com with SMTP id w201so918347vkw.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a1v8qJ4HdKiOQ7kK0tfXtjl5JNsuScmjmkS+KuQOvFQ=;
        b=sy6lV0wYr+vkP3m+pZ12xogdeLeZRAkj66V8tYM1UV5DmlieqtNVCHtmqXaAeEZtTh
         5Rfp1oeecI+eQsCDs/u71ZwSD+EhEWPGCvtEoYlXpt/WsF19R94lZJbzQeW7aFE4+bI/
         gvc/Pom4EKQkLa5Gf6ULSrB4cZVl/y8ShghGPpWfIWLUAq3L9lXFo51CyereH1ufmN5r
         pl2l2yX0TQm2EH/9lcNf4da4bqCihuiOsjoiHQQln/psxStWpztnt6y3QsX/JkFH3Amb
         Xcxr4+iZ0GF+ZK5ioZ/pWonRHMSkwpqOzsuslrQnmSAu/x57jTwJ4d4URWbh8P9R1C4/
         KL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a1v8qJ4HdKiOQ7kK0tfXtjl5JNsuScmjmkS+KuQOvFQ=;
        b=rzyzKkcHRZeqAg+YkhQTr9pPfhbGWuBVJ2mklJduoWH0zNyCU/IXGynnsiPp7sB3DQ
         rZMAT7RM4qdGtfEJC2jEU1COspywIENAmf7mnf/y2BFGd4EZT5jqTlB6j+IvDfGDJXdr
         uHCCcp4f3bJxK6iE53bFbm5/Ytk50MdaRnpLwCBxtea6lRe8MK+xdXOoUR9OG7A5o1Qc
         jngtzh3C9gpmq6msoNxf4g4spblHWA83gu6q6PS/UH3txy/BerXx46CJxNj2SPO1WJwa
         psWhGoZMkmdWvLhiIdnR0xxtYA/dH7BmnvA2G6THwx5fEVXPl2cix2jex/9J3I1wbWEd
         C6fg==
X-Gm-Message-State: AKwxyteSr69X7ih529DG43fo5xX0IGidzqyuftDqj8cwIchuhMRcXMIQ
        QtGL1E8CtW9wfkhEzQ3UTtH6y1eIp1YyydV3zhk=
X-Google-Smtp-Source: AH8x2263ymvCdfyC9Cbr0wzPIKtJw7owKokKXhqwxEZUdGR5WAZCNrma02MnCd4L0CVTYFuJ66MKcjjoB9bytPlLX74=
X-Received: by 10.31.221.131 with SMTP id u125mr9739594vkg.80.1516993710509;
 Fri, 26 Jan 2018 11:08:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 26 Jan 2018 11:08:30 -0800 (PST)
In-Reply-To: <xmqq607o8ouy.fsf@gitster.mtv.corp.google.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com> <20180126123708.21722-8-szeder.dev@gmail.com>
 <xmqq607o8ouy.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 20:08:30 +0100
Message-ID: <CAM0VKjn1uzO8JB_0eGV_LHRdrBPgd8rmjwoW1BTJgSV49AOdCA@mail.gmail.com>
Subject: Re: [PATCH 07/10] t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 7:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> Both 'test_i18ncmp' and 'test_i18ngrep' helper functions are supposed
>> to be called from our test scripts, so they should be in
>> 'test-lib-functions.sh'.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
>>  t/test-lib.sh           | 26 --------------------------
>>  2 files changed, 26 insertions(+), 26 deletions(-)
>
> Hmph.  I do not care too much either way, but I had an impression
> that test-lib-functions.sh is meant to be more generic (i.e. those
> who want can steal it from us and use it in their project without
> dragging too much of the local convention we employ in this project)
> than what is in test-lib.sh, which can heavily be specific to Git,
> and I also had an impression that gettext-poison build is quite a
> local convention we use in this project, not applicable to other
> people.

Well, there are a lot of Git-specific functions in
'test-lib-functions.sh' already:

test_set_index_version
test_tick
debug
test_commit
test_merge
test_chmod
test_unconfig
test_config{,_global}
test_cmp_rev
test_create_repo
test_ln_s_add
test_normalize_bool
nongit
