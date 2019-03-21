Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB4620248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfCUJq0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:46:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33438 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfCUJq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:46:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so5851587wrp.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MI5vOhaj9izS5H3gZyZO2zX3qn6o9/1QEHYvFMnkMyU=;
        b=F8obrHn9qFC2nRrpzSK4qUFannL3r2U8cJI1c1H34cF8AoBtDINlLjRP0dQ06VVWo/
         jkw/qujDCtxB3mryZevG0lwVYCzHaV6uTUVYaTYwtUsVdcPEHyIFhh6nGD7qEXPO5ejt
         rV9gV9XD5g2QKdEAn9a2LhWJG0j8MATehFh0h6YvvEYSVDFj3wztMa7Lv/cVYAPqhjG2
         9Za412vVAx84gjqY1CwByeQPPz0MU8xop+LLtyLQKCnueQTot+OyYTvN5RMAnbHnsa2C
         amG193y8AnRPTj4TdOsLS8yClPISHbFuKB+0PYHxbjz33S7kmxBYmtQykmL9tJ3yHpio
         s60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MI5vOhaj9izS5H3gZyZO2zX3qn6o9/1QEHYvFMnkMyU=;
        b=B+7dBlwr4/hGPjCuoLEwBHXcbyiGaPdT0yQMwYgLo0RDRQeOo/Nyq7msoG4Vr9sbxq
         S+06goiGNML8xNyXd36cOfid5SROG3tbaJ/N9HYTyT+VHwkuggIeYEo9tyqwdOl/ZIbh
         kCXFv9wUx9dkphgDit54u0MKYDWL/XqGjBNnWLFBBs/OphZ9DWiymh8CoDP4JAZzki1c
         chgFcDQM0sXxWvEtKi+3jzzFeH9b+3YLrA9U3hKIqh3n7mmCbRxfspK+TIwpvTQO479R
         UoLRDR/k+jrfsSlbK4cYnkDiJWft967qzx27TnLiwND3i2HvTJeEif9Z/Hq3ujS6q9FD
         05BQ==
X-Gm-Message-State: APjAAAUgvBVtAjjLRP4fz1Kr+8fppa0G19C4fB/8xYZpGri0cMnfsmYd
        WAkaTLiJNj4kZ+1UnD6XXKc=
X-Google-Smtp-Source: APXvYqyNDz33+vnPt1t8i/PtWgZtBHAMTIjMS4SsfyJ/1YfeYGi9CMhw+SfN3YpFLrmzE5BhuheGWA==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr1808783wrd.254.1553161584094;
        Thu, 21 Mar 2019 02:46:24 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z20sm6702077wma.9.2019.03.21.02.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 02:46:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
        <871s31dv6o.fsf@evledraar.gmail.com>
        <xmqqef71uk8t.fsf@gitster-ct.c.googlers.com>
        <xmqqpnqkst2e.fsf@gitster-ct.c.googlers.com>
        <87va0cd1zp.fsf@evledraar.gmail.com>
Date:   Thu, 21 Mar 2019 18:46:23 +0900
In-Reply-To: <87va0cd1zp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 21 Mar 2019 10:13:14 +0100")
Message-ID: <xmqq7ecssgpc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>     	graph_version = *(unsigned char*)(data + 4);
>     <<<<<<< HEAD
>     	if (!graph_version || graph_version > 2) {
>     		error(_("unsupported graph version %X"),
>     		      graph_version);
>     =======
>     	if (graph_version != GRAPH_VERSION) {
>     		error(_("commit-graph version %X does not match version %X"),
>     		      graph_version, GRAPH_VERSION);
>     		return NULL;
>     	}
>
>     	hash_version = *(unsigned char*)(data + 5);
>     	if (hash_version != oid_version()) {
>     		error(_("commit-graph hash version %X does not match version %X"),
>     		      hash_version, oid_version());
>     >>>>>>> commit-graph-fix-segfault-and-exit-3
>     		return NULL;
>     	}
>
> Needs to be resolved as:
>
> 	graph_version = *(unsigned char*)(data + 4);
> 	if (!graph_version || graph_version > 2) {
> 		error(_("commit-graph the graph version %X is unsupported"),
> 		      graph_version);
> 		return NULL;
> 	}
>
> I.e. there's a test that greps out "graph version".

Yikes.

Given the common ancestor version's phrasing, and also the updated
phrasing of the other message since we started supporting v2 of the
commit-graph file, I resolved this message to 

	 "unsupported commit-graph version %X"

instead.  Of course, I wasn't expecting the test to be depending on
the exact error message's phrasing X-<.

Thanks.


