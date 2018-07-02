Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA45C1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeGIWio (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:38:44 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36899 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeGIWii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:38:38 -0400
Received: by mail-pf0-f174.google.com with SMTP id x10-v6so4786499pfm.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-original-authentication-results:x-gm-message-state:resent-from
         :resent-date:resent-message-id:resent-to:date:from:to:cc:subject
         :message-id:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=LvKP8YYNMKdeGUeBcJtjkmp8gcGbR2O1H293GDkH7Y4=;
        b=YTszQh8nrlU6ruyGnTJfDqriBjPq50SA0hoSr6xOqh7oBMNMFmjei1Lf+55bxyFv43
         bd5ICqnS+h2hP9r5//u+Jeu+xn8UxBOUpjLKYkEpzKUT5QSO6VJA836e29tpjNL8SiyA
         DQGLU1oMfmhDV4w99nROUvcUBt3sOnOdlDe34nhrA1/dJUBR6tGqIa7I4xnPgFPP7wGP
         fd93arWprfIVKG6Bs1q689ClP0FPT357f2cAtiJLS2zwy81GFbdOorhAwkQNrpVhpOGo
         ImUb+bcUiLdLcOt32D50hjdxfzHan++nEzo+dTr7cLOsD1DN3T0WYaoy9EY2VVyWWVYa
         rFLw==
X-Original-Authentication-Results: peff.net; auth=none
X-Gm-Message-State: APt69E2Z2foLNJjSnbUI8zP0yJDhLSIxnEP7PZMMf8H1JukBTGc/kmXJ
        lJtpovP94ENADi0OcfdZKA8HqqST
X-Google-Smtp-Source: AAOMgpflwonEWIQNmsdItBRmgbLfolgTAYilTh5hnfHboQKzuzi3DLRwFHdyCXYIMcI3XdiR1SCjWQ==
X-Received: by 2002:a63:a1a:: with SMTP id 26-v6mr20515841pgk.221.1531175917175;
        Mon, 09 Jul 2018 15:38:37 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b1-v6sm29533567pff.141.2018.07.09.15.38.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:38:36 -0700 (PDT)
Authentication-Results: peff.net; auth=none
Authentication-Results: cloud.peff.net; auth=none
Received: by 2002:a6b:c8cc:0:0:0:0:0 with SMTP id y195-v6csp457054iof;
        Mon, 2 Jul 2018 14:17:06 -0700 (PDT)
X-Received: by 2002:a0c:9e5d:: with SMTP id z29-v6mr24106803qve.15.1530566226588;
        Mon, 02 Jul 2018 14:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1530566226; cv=none;
        d=google.com; s=arc-20160816;
        b=lpTnGa5rdvWG1MhMcl5jqVphyWUU2y045Oe3BkKELrbXCKFwvFA4LhOl6fuoLSrWpR
         PX87TIEQQ1Uwl82UE5Dl0REREIwNJZnSSlVNhCkPxv6p/1PMZzCZrgzgWplHBCrBCzRQ
         I7VarfKNltoiR3FgEufOlChQwZIZkwq4oKTO1QPoSAETUsLfHEkD8O16IPgBZokQZ79J
         RXvgLNDy4ZS1xPPoDFfH0uI5xUeet5Karij3AxcJ0UvQgSkWpc1aaLsq9a6xdcNHYZ/D
         TzczbPZOo5VQRcKcOvFAf9PiDE01S55Ll38OzB9TZUZDNOAqrnhLfyTU7Gj6fuODmpWw
         ZEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=LvKP8YYNMKdeGUeBcJtjkmp8gcGbR2O1H293GDkH7Y4=;
        b=UKfoMq/Y3ThkgV2S0kcK0/o4IRXlETGH+z7qfcWWuD++SGNSNk5S+Aw7QaEQPLD3aN
         kxJ4L+2YcttZAjn921Wj1hkao0ao95FGTAIlQe1h8bzyMQAMwde/DscYTDZpBX5VYnUO
         u7KGY6+h8XxDVWOhxw/9dOfx6Xp9+/aQpKZT9aFW2Og+OW7Qm3W/kvfx0X1C3CK7wu8l
         c8OkaADFAwsHNIbhcuIpQlianY7AGVegzufOSNvIuKkPK74FHUi3RRgKweFF87iRkfDc
         XEa6mW3N/Z8VY6hsnBt63pqhVxbeo5Wc5heaokpL12/5V5W51Ork5luIULS3eivob9EK
         Iwhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) smtp.mailfrom=peff@peff.net
Received: from cloud.peff.net (cloud.peff.net. [104.130.231.41])
        by mx.google.com with SMTP id a139-v6si178980qkb.405.2018.07.02.14.17.06
        for <jrnieder@gmail.com>;
        Mon, 02 Jul 2018 14:17:06 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) client-ip=104.130.231.41;
Received: (qmail 8155 invoked by uid 109); 2 Jul 2018 21:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 21:17:06 +0000
Received: (qmail 27578 invoked by uid 111); 2 Jul 2018 21:17:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 17:17:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 17:17:04 -0400
Date:   Mon, 2 Jul 2018 17:17:04 -0400
From:   Jeff King <peff@peff.net>
To:     Akilsrin <Akilsrin@apple.com>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Christian Couder <christian@gitlab.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
Message-ID: <20180702211704.GA23484@sigill.intra.peff.net>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
 <20180702195016.GA17102@sigill.intra.peff.net>
 <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
 <9AE01C9B-7D10-45F2-8910-1607A19DF722@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9AE01C9B-7D10-45F2-8910-1607A19DF722@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 02, 2018 at 01:58:21PM -0700, Akilsrin wrote:

> Could “ProdsecOSS " <prodsecoss@apple.com> also be added to the
> git-security mailing list. It’s another account I control to ensure my
> team and I track open source bugs.
> 
> The git repo: could you add https://github.com/product-security-OSS
> <https://github.com/product-security-OSS> and
> https://github.com/Akilsrin <https://github.com/Akilsrin> to the
> GitHub cabal repo please.

Done, done, and done.

-Peff
