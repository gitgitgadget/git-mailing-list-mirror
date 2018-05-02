Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD0D21847
	for <e@80x24.org>; Wed,  2 May 2018 01:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbeEBBnG (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 21:43:06 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33483 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEBBnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 21:43:05 -0400
Received: by mail-wr0-f182.google.com with SMTP id o4-v6so12252856wrm.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 18:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZY7oPK8jrntrm9o53zBjDv6NyYcHr46gjkyWrEdFuGE=;
        b=BFfFGrddxe2CBIpirYFsUTFHgz1co5TugnejFfuSKokvCrQmom3KfVnsx1n+P9traE
         lml1Fs9UOFPW5Qolu7CmudBfH6PmpGJMyTW+3HDbxsPBGyCVn5Hw2Qqq10Yk7SyByorX
         um33W4R0t1TeQ8sUHKhfyD/odNFJbk5aG6vMCnlQwigpyHFx2gMlBnhCnw8E6IRLKBP6
         tFP3al/fT3egCnI+oPEFvtmxc9jeNIR82MisA48xxFyaIv6wHkzbCBq+TKMSM9Sr8IDC
         LzCCYfMCgol5s8teMVg7/nsrAaMaUvLeY+x/eOtiX8qmTVbJ1tdZx4SimPxpiSkP9uWQ
         4+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZY7oPK8jrntrm9o53zBjDv6NyYcHr46gjkyWrEdFuGE=;
        b=P1hj0E1ZGaqMhy4LJDI9FJ+fkb3DBjK4NTl7dc8Uv3Vzw5M6Ivd366Yj5JE5dhJb7z
         9LT2JQxuBqbdoqfIqVbxvH9knVSPgKxDbaRY61fo2u0fqLrMmHgNjgD6DQYB8tjZi9AV
         z9KOqgbY1TqBg8Ss1YrbHZ6+gD/IHEOlg28E0CZa/Kci4w4JfCsZa0G4DpHPA0QmTbSc
         /E38jPdTCavRRrGOBznUUoVErJLA7VGSkyODw+NfmtaO5bbGOnH88DT8UpRduC1+bmnO
         wBFur4aodR1owmrPE3lbv49PJqAhEmw6bFnSOu+Fm+aK9vRuz8k7QASJ29MOv5025oop
         yREw==
X-Gm-Message-State: ALQs6tAYXl+U16AfOR/8oHUVpX/1X5MlugBJqPpPbFEf+QOrC6EBzH4b
        GUKDtohOYi2EpPhJ5QGRZmo=
X-Google-Smtp-Source: AB8JxZqNV4wGQR72UPAmbD+SIn4kMcWc9h2I89rrKMZ8CBo0FRMR060BxZWbgsLk0PG8rgUsbdwOJQ==
X-Received: by 2002:adf:8607:: with SMTP id 7-v6mr12894188wrv.255.1525225383581;
        Tue, 01 May 2018 18:43:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c124sm10869576wmd.36.2018.05.01.18.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 18:43:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: js/no-pager-shorthand [
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
        <918c69be-89ce-c66d-92ee-4821e9412793@kdbg.org>
        <nycvar.QRO.7.76.6.1805011351330.79@tvgsbejvaqbjf.bet>
        <5cd81e58-7cd4-f5df-14e8-2ba3d221e128@kdbg.org>
        <CAPig+cS9pKSXG-9uZo7dhnz2yAnv9VnnuS_B-DMG2cWmGuKcow@mail.gmail.com>
Date:   Wed, 02 May 2018 10:43:02 +0900
In-Reply-To: <CAPig+cS9pKSXG-9uZo7dhnz2yAnv9VnnuS_B-DMG2cWmGuKcow@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 1 May 2018 14:10:19 -0400")
Message-ID: <xmqq4ljqygrd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Although paged output is generally nice, I frequently find myself
> typing --no-pager numerous times during the day, so I, for one,
> welcome having a short option (and would be sad to see this patch
> retracted). As with Hannes, I too find -P a reasonably intuitive and
> easy-to-remember short option.

Yeah, we often see in other people's tools that the -X option means
opposite of the -x option, and even though "git --paginate" may not
have short-and-sweet "git -p" short-hand (or does it?) it would be
natural to expect "-p" to mean that, and I do not find it a stretch
for "-P" to mean opposite of it by extension.

    ... goes and looks ...

Ah, "-p" does mean "--paginate", it seems.  So I am not opposed to
resurrecting the patch with s/N/P/, if that is what people want.  On
the other hand, I am perfectly OK if the patch stays retracted.
