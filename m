Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7E51F404
	for <e@80x24.org>; Wed,  4 Apr 2018 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDDV54 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 17:57:56 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52841 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752171AbeDDV5z (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Apr 2018 17:57:55 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E6F9227FE;
        Wed,  4 Apr 2018 17:57:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 04 Apr 2018 17:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=giQJkQQb1yISev9kDk7lOwFbZ36aUDT2PcuG2v7VjKI=; b=Or1J6hRP
        T7LNqocA3JDFOKuJMqp9EjGyJbZPJhLBKUztb+jnCqOWbUzQM9pfAAXA2LtPYf+w
        XbRMDQfKkC3LuKdLhdMIx+cqKoiN7hs5bSyK3qUZNHx/b2i6BGKsF5ntCglpf5ik
        3my9Glpi1KxJz/XmN3tyOqQnN+8PuOFojBs5kn50UBv9BzAzmlxheBgmSzZILt3N
        fP+z3OiXAcZPf0OdDKB3wSgk1FdTfUntBipVR/hP+xIfIA19tDeFm/HYLyw+IQk6
        K2J4UbiuidwdFxieNoVIAsTTJzn0Unh1eyEIhtjaXuO9C16pLUhYybGW2rcB/WKw
        lzYFC08uGBYe1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=giQJkQQb1yISev9kDk7lOwFbZ36aU
        DT2PcuG2v7VjKI=; b=l7oglwikQErOG3duJxHcZhSVtjLMAKqx9UhdIA5hgn+mL
        TixDe8HGXIhxWcJzoNw8SFbh4+z8CxE/g3qlSS0E18p+Dy8x0Kgjujx23RNvNEzz
        1H+0sTsHH0gKY9zoKRVZje2XIlrXjcbFXPvLUEInx0bzt/10nkqqjkO58m7L+Hpw
        kXqim+AWufVqfoYfXNHcvGk7bZ7JNJ1/M9zJsQ7idPhusuvtg/9LaB2rLiq/9Acm
        qpp3w2PEjNEOQO8iTTqhO7jFo08z3QQ5+7+IFKk85gXnvs2hc8oZdHV9yFqW0LOR
        tEjzp/PQjw6g48xtKgkGIA0e5NXJXKhOx9ZFhyB6w==
X-ME-Sender: <xms:YkrFWiIk1jaKGqhxzezvbdElEY3uuj2SNBhytMJ1FxfvLqJjsC0QAw>
Received: from localhost (afei159.neoplus.adsl.tpnet.pl [95.49.112.159])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B334E46C2;
        Wed,  4 Apr 2018 17:57:53 -0400 (EDT)
Date:   Wed, 4 Apr 2018 23:57:52 +0200
From:   Jan Palus <jpalus@fastmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Timing issue in t5570 "daemon log records all attributes"
Message-ID: <20180404215752.6qsipaaskrzwiv4q@kalarepa>
References: <1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com>
 <20180403203233.GB15157@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403203233.GB15157@sigill.intra.peff.net>
User-Agent: NeoMutt/20180323
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.04.2018 16:32, Jeff King wrote:
> I'm tempted to say we should just scrap this test. It was added
> relatively recently and only shows the fix for a pretty minor bug.
> It's probably not worth the contortions to make it race-proof.

Thanks for your reply Jeff.

It appears race condition in reading/writing daemon.log is not the only issue of
t5570. On a different machine I've just randomly got:

t5570-git-daemon.sh[163]: can't create git_daemon_output: Interrupted system call

which I believe might also be associated with concurrent processing of piped
data connected with a fact that test restarts daemon few times. I can barely
wrap my head around it but I guess it's somewhat around "shell still tries to
read fifo while attempt to create new one is made".


Regards
Jan
