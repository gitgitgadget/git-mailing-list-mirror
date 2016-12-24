Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81191FF40
	for <e@80x24.org>; Sat, 24 Dec 2016 12:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbcLXMzw (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Dec 2016 07:55:52 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53151 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753619AbcLXMzv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Dec 2016 07:55:51 -0500
X-AuditID: 12074412-5ddff700000009b5-d2-585e70489e9e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.81.02485.8407E585; Sat, 24 Dec 2016 07:55:38 -0500 (EST)
Received: from [192.168.69.190] (p57906E9F.dip0.t-ipconnect.de [87.144.110.159])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBOCtXCc016471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 24 Dec 2016 07:55:34 -0500
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
 <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
 <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
 <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
 <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net>
 <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com>
 <xmqq8tr6e46o.fsf@gitster.mtv.corp.google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <653b67e6-9dba-d331-c396-932a59cdb4da@alum.mit.edu>
Date:   Sat, 24 Dec 2016 13:55:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tr6e46o.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1PUqiIsw2LSVyaLrSjeTRUPvFWaL
        E8cWsljsXtzPbPH6zgQmix8tPcwObB47Z91l91i85yWTx7PePYweFy8pe3zeJBfAGsVlk5Ka
        k1mWWqRvl8CVsfTAcfaCadwVX6b0MTUwfuboYuTkkBAwkZi5rJ+5i5GLQ0jgMqPE1yX9LBDO
        BSaJl2v2s4BUCQv4SBx+dZkVxBYRcJQ48eA6K0RRE4vEymU7mEAcZoGdjBITz7Yxg1SxCehK
        LOppZgKxeQXsJSZt/gkWZxFQlbi44wojiC0qECJxec5RNogaQYmTM5+AbeMUsJZY2XoQrJ5Z
        QE9ix/VfrBC2vMT2t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW
        6Zrp5WaW6KWmlG5ihAS20A7G9SflDjEKcDAq8fAu6I6NEGJNLCuuzD3EKMnBpCTKq7Y5JkKI
        Lyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+ciLgIId6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp
        2ampBalFMFkZDg4lCd5zMUCNgkWp6akVaZk5JQhpJg5OkOE8QMNXgdTwFhck5hZnpkPkTzEq
        Sonz6oMkBEASGaV5cL2wxPOKURzoFWHepyBVPMCkBdf9CmgwE9Bg2+ZokMEliQgpqQbGKrmn
        //Rmnt5z1JB1Isfe/frbfOSWPQtY//iRgPwm2Q6BxudemueLuAyenF+3xy/z5jrW0IDfTBKb
        XTY6Pzn3LsT1+lcj/vraOz6vE2ZoHn3CU/N9dYnzYp5nOXHHnLL7959qLah5/mJuXYL09Ixm
        97ub3COEl6hoet+Yl+6/TqT3YUHBEQMZJZbijERDLeai4kQAFXbN4RcDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/23/2016 10:17 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I guess both you and Michael are in favor of just removing compaction
>> variant without any renames, so let me prepare a reroll and queue
>> that instead.  We can flip the default perhaps one release later.
> 
> -- >8 --
> Subject: [PATCH] diff: retire "compaction" heuristics
> 
> When a patch inserts a block of lines, whose last lines are the
> same as the existing lines that appear before the inserted block,
> "git diff" can choose any place between these existing lines as the
> boundary between the pre-context and the added lines (adjusting the
> end of the inserted block as appropriate) to come up with variants
> of the same patch, and some variants are easier to read than others.
> 
> We have been trying to improve the choice of this boundary, and Git
> 2.11 shipped with an experimental "compaction-heuristic".  Since
> then another attempt to improve the logic further resulted in a new
> "indent-heuristic" logic.  It is agreed that the latter gives better
> result overall, and the former outlived its usefulness.
> 
> Retire "compaction", and keep "indent" as an experimental feature.
> The latter hopefully will be turned on by default in a future
> release, but that should be done as a separate step.

The whole patch looks good to me. Thanks for taking care of this.

Michael

