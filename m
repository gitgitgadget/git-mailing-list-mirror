Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497A61F424
	for <e@80x24.org>; Mon, 16 Apr 2018 11:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeDPLgN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 07:36:13 -0400
Received: from ao2.it ([92.243.12.208]:39804 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753393AbeDPLgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 07:36:12 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f82PX-0002o2-0S; Mon, 16 Apr 2018 13:35:03 +0200
Date:   Mon, 16 Apr 2018 13:36:10 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC 07/10] FIXME: wrap-for-bin.sh: set 'core.submodulesFile'
 for each git invocation
Message-Id: <20180416133610.b0c85e131fe58819e62560f6@ao2.it>
In-Reply-To: <CAGZ79kagFY_AnLJ0Zjcu++e567JHYeHaW-0k8=4Q4rsyqtnU9w@mail.gmail.com>
References: <20180412222047.5716-1-ao2@ao2.it>
        <20180413080733.6380-1-ao2@ao2.it>
        <CAGZ79kagFY_AnLJ0Zjcu++e567JHYeHaW-0k8=4Q4rsyqtnU9w@mail.gmail.com>
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

On Fri, 13 Apr 2018 13:05:18 -0700
Stefan Beller <sbeller@google.com> wrote:

> Hi Antonio,
> 
> On Fri, Apr 13, 2018 at 1:07 AM, Antonio Ospite <ao2@ao2.it> wrote:
> > This is to test custom gitmodules file paths. The default path can be
> > overridden using the 'GIT_MODULES_FILE' environmental variable.
> >
> > Maybe In the final patch the option should be set only when running
> > tests and not unconditionally in the wrapper script, but as a proof of
> > concept the wrapper script was a convenient location.
> >
> > Also, in the final patch a fixed custom file path could be used instead
> > of the environmental variable: to exercise the code it should be enough
> > to have a value different from the default one.
> >
> > The change to 't0001-init.sh' is needed to make the test pass, since now
> > a config is set on the command line.
> 
> Missing sign off.
> 
> So you'd think we'd have to rerun the test suite with GIT_MODULES_FILE set?
> That makes for an expensive test. Can we have just a few tests for a few
> commands to see that the basics are working correctly?
>

This approach of running the test suite twice was only "exploratory",
see the script in 10/10: it was never meant as a the final mechanism.

That's also why the FIXME patches do not have a sign-off.

As I tried to comment above a final version could just
replace the references to '.gitmodules' with some fixed non-default
value, provided that the same value is passed to git via
core.submodulesfile 

If the tests pass with a custom value they'll pass with the default
'.gitmodules' one which is a particular case.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
