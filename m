Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD869208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 09:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeHGLd2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 07:33:28 -0400
Received: from ao2.it ([92.243.12.208]:60834 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbeHGLd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 07:33:28 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fmy8O-0006eJ-Jt; Tue, 07 Aug 2018 11:18:32 +0200
Date:   Tue, 7 Aug 2018 11:19:58 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option
 to the 'config' sub command
Message-Id: <20180807111958.1494e8cc1e376a19b54bb788@ao2.it>
In-Reply-To: <xmqq7el3pf8z.fsf@gitster-ct.c.googlers.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-7-ao2@ao2.it>
        <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com>
        <20180803130334.3979eedb0733c609815e9fd5@ao2.it>
        <xmqqbmajzadt.fsf@gitster-ct.c.googlers.com>
        <20180806125828.66fc99ef0b118e26e0b3e60d@ao2.it>
        <xmqq7el3pf8z.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 06 Aug 2018 10:38:20 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> >> I also do not see a reason why we want to stop referring to
> >> .gitmodules explicitly by name.  We do not hide the fact that
> >> in-tree .gitignore and .gitattributes files are used to hold the
> >> metainformation about the project tree, saying that it is an
> >> implementation detail.  Is there a good reason why .gitmodules
> >> should be different from these other two?
> >
> > Not sure about that, but one difference I can see
> > between .gitignore/.gitattributes and .gitmodules is that I got the
> > impression that editing the latter by hand is strongly discouraged, if
> > that is indeed the case a layer of indirection can make sense IMHO to
> > make the actual file path less relevant.
> 
> I do not think we discourage hand editing of .gitmodules more than
> others, say .gitignore; and I do not see a sane reason to do so.
> 
> "If you commit broken .gitmodules and let another person clone it,
> submodules will not be checked out correctly" is *not* a sane
> reason, as exactly the same thing can be said for incorrect checkout
> of files with broken .gitattributes.
>

OK, I see, maybe I got the wrong impression because
while .gitignore/.gitattributes are expected to be hand edited, in my
limited usage of submodules I never had to edit .gitmodules manually
since git did it for me; I guess that does not necessarily mean it's
discouraged and it may even be necessary for more advanced usages.

> Quite honestly, I just want to get over with this minor detail that
> won't help any scripts (after all submodule--helper is not meant to
> be used by humans) and focus on other parts of the patch series.

Agreed, let's drop 06 and 07 then.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
