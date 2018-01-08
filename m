Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560EA1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758095AbeAHWiw (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:38:52 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36363 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757912AbeAHWiu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:38:50 -0500
Received: by mail-wr0-f180.google.com with SMTP id b76so12333792wrd.3
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Krp/1M3cQDF9kALIoBcTBS/GAC6A14RxwSRyvclqDEU=;
        b=jB38771WeYBS+EJixvPfflOeZKZ/APu72/N7yp2qFYfEikLnbQJuEWLJh34X9PVqG4
         XSEIVkY44vLlsjZgDprdY9IT+tDSkqj+MGjOcJnn+34XThYLvOkf6yc/Swt7GivZbyo8
         9/vcmJESYwm6eXzUv+Nj5oDF/Gkz4POimEuGKCMTOJQrUe+CKb5vTemYWla+yj0GtBSZ
         rvDfHGXChB5VwPLRPQJr+NP4yBt4ej+132MdzWVlOX3GbPXcY4Z+pleYDT4TCpgpSnGm
         uB8wfM625ZdfsupQBtHbtKniJ2KZjFRiAH6vqg7aA0sJxtQcLRhqm0zgZjQhK0GxdWow
         Ij+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Krp/1M3cQDF9kALIoBcTBS/GAC6A14RxwSRyvclqDEU=;
        b=shSoGpGv4goslDZ1fWGanbJwYhAGKnRazQWwdoAJs03mLY330y8WATHmjtchERKk9f
         +cGZ1ZMQ8Ll59BcNqWuxfBGNGxt7uAEGuPz4v7evslnE8d8Eiv5ST9iXbO3aAETLPyg2
         KvCSYTm5MFS71kIbcqANTDPIJqP53QwWxQ/bIG+cu34b7c4PtnXXlIfd3+ZUMjF6BUGS
         5eSs1x6zLBFv1CDvsq/gCa8ari7J5cIGLqqhWCB4LeOkD2GirbJmnnHcyltBfiyECKCx
         4ZbFxk7yEGLLFmxxhHRUf5f7/KEgde37UbGL2Wy62RZHehvKGdZkjfxFdE7pTQHmolN6
         IkrQ==
X-Gm-Message-State: AKGB3mJVTi6Wl8eYsY6Soo+jSL0HLhXbXzYkYhVKAs/4S2urgDAwE0C9
        aGnCqTlpX0ASA5IB1G7MSQc=
X-Google-Smtp-Source: ACJfBovT38Npo/VWoA4SfEFyjuwFxZznz+o7aRx4FSqBaDfGw+LBjJEx+mpCFU3TYq0f5J1Nf4lyZw==
X-Received: by 10.223.162.195 with SMTP id t3mr11089845wra.237.1515451129183;
        Mon, 08 Jan 2018 14:38:49 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB58C2.dip0.t-ipconnect.de. [93.219.88.194])
        by smtp.gmail.com with ESMTPSA id p15sm11161020wre.64.2018.01.08.14.38.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 14:38:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 8 Jan 2018 23:38:44 +0100
Cc:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>
References: <20180108172214.23615-1-szeder.dev@gmail.com> <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Jan 2018, at 23:07, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>=20
>> The reason why Travis CI does it this way and why it's a better
>> approach than ours lies in how unsuccessful build jobs are
>> categorized.  ...
>> ...
>> This makes it easier, both for humans looking at the Travis CI web
>> interface and for automated tools querying the Travis CI API,...
>> ...
>> A verbose commit message for such a change... but I don't know why we
>> started with building Git in the 'before_script' phase.
>=20
> Thanks for writing it up clearly.  TBH, I didn't even realize that
> there were meaningful distinctions between the two cases after
> seeing that sometimes our tests were failing and sometimes erroring
> ;-)

I understand the reasons for the proposed patch. However, I did this=20
intentionally back then. Here is my reason:

If `make` is successful, then I am not interested in its output.
Look at this run: https://travis-ci.org/szeder/git/jobs/324271623

You have to scroll down 1,406 lines to get to the test result=20
output (this is usually the interesting part).

If this is a valid argument for you, would it be an option to
pipe the verbose `make` output to a file and only print it in case
of error (we do something similar for the tests already).

- Lars=
