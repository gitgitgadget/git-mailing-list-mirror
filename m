Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07AE20229
	for <e@80x24.org>; Fri, 21 Oct 2016 21:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754732AbcJUV0c (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 17:26:32 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:10681 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbcJUV0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 17:26:31 -0400
Received: from PhilipOakley ([92.22.39.21])
        by smtp.talktalk.net with SMTP
        id xhKebja5EgKstxhKebnFHx; Fri, 21 Oct 2016 22:26:29 +0100
X-Originating-IP: [92.22.39.21]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=M/56MiBvTVP0PjbKCVvbEg==:117
 a=M/56MiBvTVP0PjbKCVvbEg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=anyJmfQTAAAA:8 a=hZl4FlbxAAAA:8 a=QyRJ8Xq4AAAA:8
 a=YqSQ4YgN2u6P-ACc7MsA:9 a=wPNLvfGTeEIA:10 a=0l2taYnuBkIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=YJ_ntbLOlx1v6PCnmBeL:22
 a=zNGlSMxTWkni11D5GzKz:22 a=bU4N5Dn6QmUNwQ-LvVBy:22
Message-ID: <D861234B3E78496DBA70EE63B2BCDB96@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <20161020234009.1768-1-philipoakley@iee.org> <xmqqa8dyeebj.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] doc: fix merge-base ASCII art tab spacing
Date:   Fri, 21 Oct 2016 22:26:29 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOxAcbTDqboBSwFcbs1+bGgDfuYzXDVXM9WMsrUeqgu5QovmhjPqTdvd+OIkIyZzRWl4AcU+fx8cI28TRPsWZL/38jChtdGzASS3ZTTIzhaPBch9Agof
 me6mmrmwWU47785MnXbs2dFweiON/bCUFXLajYrk/G4ryVHdjf6hUAq8Bj8/rBJHiTf+7CTdRnpw/bdodggqx0pRkbceyjgJpCkBKyUy3Kp7DXTePxzaZzID
 nl5NYsMU5ZsaxMyY41K8qg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The doc-tool stack does not always respect the 'tab = 8 spaces' rule,
>> particularly the git-scm doc pages 
>> https://git-scm.com/docs/git-merge-base
>> and the Git generated html pages.
>
> Sorry, but I do not understand this change.
>
> https://git.github.io/htmldocs/git-merge-base.html is "Git generated
> HTML page" and I do not see any breakage around the drawings this
> patch touches, and the fp-path series does not touch these drawings,
> either.
>

I'd been looking the Git for Windows output, which has the same breakage, 
rather than yours. Apologies for failing to check there.

> If a broken "doc-tool stack" breaks the formatting, I'd prefer to
> see that "doc-tool stack" fixed, instead of working around by

The doc-tool stack is question is asciidoctor. It looks like it is an 
explicit decision that the the 8 space tab substitution is deprecated in 
these case (see http://asciidoctor.org/docs/user-manual/#migrate-deprecated 
#96.3)

It appears that acciidoctor sees the art as being a separated mono-spaced 
block, with border/background as locally appropriate. While the asciidoc 
looks to simply change to mono-spaced text.

> updating the source they work on.  Otherwise, the broken "doc-tool
> stack" will keep producing broken output next time a source that
> respects "tab is to skip to the next multiple of 8" rule is fed to
> it, no?

By avoiding tabs *within the art* we would also be tolerant of those who may 
not have a set their tab spacing to 8 when viewing the raw text.

It's particularly the criss-cross diagram that needs fixed one way or 
another (for the doc/doctor differences).

The update of the asciidoctor version for git-scm, as reported by peff isn't 
sufficient for this case.

also cc'ing dscho as this breakage shows in GfW (issue 923)

Philip


