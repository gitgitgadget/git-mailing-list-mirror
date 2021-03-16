Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74950C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EAC65017
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhCPJLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhCPJKo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 05:10:44 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D74C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 02:10:43 -0700 (PDT)
Received: from [2400:4160:1877:2b00:9884:91a6:82c8:afa1] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1lM5ij-0002rx-F7; Tue, 16 Mar 2021 09:10:34 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1lM5ic-000HP6-74; Tue, 16 Mar 2021 18:10:26 +0900
Date:   Tue, 16 Mar 2021 18:10:26 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.31.0
Message-ID: <20210316091026.wta7wpxdyr75xo6x@glandium.org>
References: <xmqqwnu8z03c.fsf@gitster.g>
 <20210316051459.oqsl7bhwh6he5cql@glandium.org>
 <875z1rfpmr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875z1rfpmr.fsf@evledraar.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 09:51:08AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 16 2021, Mike Hommey wrote:
> 
> > On Mon, Mar 15, 2021 at 12:30:15PM -0700, Junio C Hamano wrote:
> >>  * Two new ways to feed configuration variable-value pairs via
> >>    environment variables have been introduced, and the way
> >>    GIT_CONFIG_PARAMETERS encodes variable/value pairs has been tweaked
> >>    to make it more robust.
> >
> > For the record, this is backwards incompatible with git-programs in
> > $PATH that were expecting the old format (e.g. git-cinnabar releases
> > using an older version of libgit.a).
> 
> What isn't noted there is that we're still parsing the old format in
> some cases, see f9dbb64fad (config: parse more robust format in
> GIT_CONFIG_PARAMETERS, 2021-01-12).
> 
> But I suspect you mean that you have your own parser that expects the
> old format only, I didn't find which way it was by grepping
> git-cinnabar's sources.

git-cinnabar is using git's libgit.a, so when using a pre-compiled
version built against git < 2.31.0, it fails to parse
GIT_CONFIG_PARAMETERS when used with git 2.31.0.
There's not much I can do apart from releasing a new version.

Mike
