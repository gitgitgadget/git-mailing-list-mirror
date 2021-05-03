Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD541C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8D961283
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhECVKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhECVKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 17:10:42 -0400
X-Greylist: delayed 770 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 May 2021 14:09:48 PDT
Received: from silly.haxx.se (silly.haxx.se [IPv6:2a02:750:7:3305::2aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DEC061573
        for <git@vger.kernel.org>; Mon,  3 May 2021 14:09:48 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 42C805E554; Mon,  3 May 2021 23:09:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 3E5157D66D;
        Mon,  3 May 2021 23:09:47 +0200 (CEST)
Date:   Mon, 3 May 2021 23:09:47 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@silly
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     'Jeff King' <peff@peff.net>, 'Daniel Carpenter' <dc@ammonit.com>,
        =?ISO-8859-15?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: RE: http.sslVersion only specifies minimum TLS version, later versions
 are allowed
In-Reply-To: <000c01d7405f$823fd090$86bf71b0$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.2105032306580.30150@fvyyl>
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com> <87pmy7x6le.fsf@evledraar.gmail.com> <YJAEVMeY9v/j6PeS@coredump.intra.peff.net> <ed63aa37ef0547bd97a5d965fb5e123f@ammonit.com> <YJBhH0eLKRSpPFy3@coredump.intra.peff.net>
 <000c01d7405f$823fd090$86bf71b0$@nexbridge.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 May 2021, Randall S. Becker wrote:

> What if http.sslVersion=v1[,v2]... were supported, so there would be an 
> enumeration of allowed versions.

That doesn't map very well to the options libcurl provide.

> The benefit of an enumeration is that you could force something like 
> 3.0-fips if your environment requires a FIPS-certified version for 
> communication. Admittedly this is a different use case than discussed above.

Yes, and as "3.0-fips" is not a TLS version at all I think it would complicate 
matters in a wrong direction.

You can build libcurl to use use a FIPS compatible crypto library today, but 
if you do then you still select TLS version using the same options like 
before.

-- 

  / daniel.haxx.se
