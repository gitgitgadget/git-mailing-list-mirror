Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC4B20281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbdF2Sev (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:34:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34668 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbdF2Seq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:34:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id d5so14153401pfe.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zQlAropaOwSp5b18gQJDYoSZK2YM0UiNO3NEXB8KVOc=;
        b=OiaJppmvkzZ18WFq0xlTPYNLYrqtGmg2RX3tfLVUpBnlsSv22HlJkCOIzHfibwxy3V
         g/AiFPP++nDskJ+OPvBBWWIr4NNkbvTfVINKQidBpR1yg5CF+kQG/htfT8KUvyTnb7bg
         J2XK2PeQSjWLf4XzJsSySRJFpoqdFL6Hv6CHZWgMe3+fn7drR2jVlIR6DILxhLm/b+4j
         u5CHlysCEdFwWRQjOo3ZbwwrKg59YebOlkz278ieRERoP6Ph4l5Kg0snnD2UcBh9EStZ
         1MwObgUoOQ04y5QKzHkuzlH3a2PxvcUzX1qNc/T5C2yVy3tqKnhBihIlfHZbFkWc0H1n
         lUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zQlAropaOwSp5b18gQJDYoSZK2YM0UiNO3NEXB8KVOc=;
        b=DutiTOfGeg6MZN3A8LbQtCjwJ8dARlENpl3sa0Vy9IkHTIfZRHj0B+RQgSoRNfS81O
         cTyvEWKfpBeuQrTptuWRhhEp/iE47udjzOLSgKWp277KnGSfA50y0UH75RpBtG2Kb9yh
         EndMoi+ER7gbZnfOdhcoiF5GsrscXatdFFcEUwLQB4w1n7yiKm7GkEQuEdxiHrFTk6go
         u2aqegDqNmwG/snaIe6D22U9eQuTVmC87T9pmZsjTe/HpreusWDmcLOaPBpn4Of7LNUS
         uvQewO2n0bTM/l9lEM/m4+ll/QYM+TBhFIye377sSmWJaEaz75lH5Iqy4KpyGv2hMfSt
         BSQQ==
X-Gm-Message-State: AKS2vOzRTlO56Y6/JDtXpUbpZ2Dn1yW6DXG95pfm7RNrvJvMYpyEpOgI
        aDz0c3MLYnfWBA==
X-Received: by 10.101.76.3 with SMTP id u3mr16769262pgq.119.1498761285607;
        Thu, 29 Jun 2017 11:34:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9846:b2e3:b31e:8976])
        by smtp.gmail.com with ESMTPSA id l4sm10043424pgn.34.2017.06.29.11.34.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:34:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v8 6/6] convert: add "status=delayed" to filter process protocol
References: <20170628212952.60781-1-larsxschneider@gmail.com>
        <20170628212952.60781-7-larsxschneider@gmail.com>
Date:   Thu, 29 Jun 2017 11:34:43 -0700
In-Reply-To: <20170628212952.60781-7-larsxschneider@gmail.com> (Lars
        Schneider's message of "Wed, 28 Jun 2017 23:29:52 +0200")
Message-ID: <xmqqinjetzgc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You seem to have squashed an unrelated "table-driven" clean-up into
this step.  While I think the end result looks good, I would have
liked to see it as a separate step, either as a preparatory "now we
are going to add the third one, let's make it table-driven before
doing so" step, or a follow-up "now we have done everything we
wanted to do, let's make this clean-up at the end" step.

Thanks.
