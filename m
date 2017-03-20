Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88A32095B
	for <e@80x24.org>; Mon, 20 Mar 2017 14:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbdCTOZf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 10:25:35 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53226 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753307AbdCTOZ3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 10:25:29 -0400
X-AuditID: 12074413-f67ff700000077e1-e2-58cfe6575557
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.67.30689.756EFC85; Mon, 20 Mar 2017 10:25:27 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KEPOIE002725
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 10:25:25 -0400
Subject: Re: [PATCH v3 2/4] refs: introduce get_worktree_ref_store()
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170216120302.5302-1-pclouds@gmail.com>
 <20170318100206.5980-1-pclouds@gmail.com>
 <20170318100206.5980-3-pclouds@gmail.com>
 <b841a674-7b2b-420d-7faa-e5b836fb534e@alum.mit.edu>
 <CACsJy8B85TH0DOViEmfh8mOz_u7rVotKJa-HYk6TJ81kvV4xPg@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <0d437f43-30d6-3920-5298-0c426b098c1a@alum.mit.edu>
Date:   Mon, 20 Mar 2017 15:25:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8B85TH0DOViEmfh8mOz_u7rVotKJa-HYk6TJ81kvV4xPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqBv+7HyEwaJGA4uuK91MFg29V5gt
        uqe8ZbTYvLmdxYHFY+esu+weCzaVely8pOzxeZNcAEsUl01Kak5mWWqRvl0CV8bj9uWMBU+4
        K/Yduc7YwHiSs4uRk0NCwETi0eHNTF2MXBxCAjuYJI4/vsACkhASuMAkMXGlJIgtLOAisW/D
        dbC4iICSxJuObcwQDV1MEvtfvmYEcZgF2hglmlY+ZwWpYhPQlVjU08wEYvMK2EvMOHaXHcRm
        EVCVOHDvMTOILSoQIjFn4QNGiBpBiZMzn4Bt4BQIlJjw8A1YDbOAusSfeZegbHmJ7W/nME9g
        5J+FpGUWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJW+Ed
        jLtOyh1iFOBgVOLhXXHlfIQQa2JZcWXuIUZJDiYlUd6nt4FCfEn5KZUZicUZ8UWlOanFhxgl
        OJiVRHiNQXK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQnej0+AGgWL
        UtNTK9Iyc0oQ0kwcnCDDeYCGzwOp4S0uSMwtzkyHyJ9iVJQS593/GCghAJLIKM2D64WllVeM
        4kCvCPN6PQWq4gGmJLjuV0CDmYAGL7txBmRwSSJCSqqBkeNot2VnbPbRPcpMnqURW86nT+yU
        9k7Z4W5zPn9emovWvHMJ7upL9mXzdndJmGlszercq3HsteOeaa+cgrxeZdd8Wbelu0ssWkd6
        Z6p+s2pXoXdFCcurc9Yz/eo5uF5f3dW+POrfX51eVYvLSdbvLSW/VBXuF/INnn02/6Vp9rFV
        z3t71r1XYinOSDTUYi4qTgQA+52HWQYDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20/2017 01:01 PM, Duy Nguyen wrote:
> On Mon, Mar 20, 2017 at 1:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> I guess I can hold my nose and accept storing worktree and submodule
>> `ref_store`s together in a single hashmap
> 
> Release your nose, I'll add a new hashmap :)

Thanks :-)

> But while we're here,
> what are your thoughts about moving submodule-specific to submodule.c?
> That includes the hashmap, get_submodule_ref_store() and all other
> submodule stuff, to submodule.c where submodule-specific stuff stays.
> The same for worktree stuff, to worktree.c. That keeps refs.c to core
> refs business. And the hashmap can be used for more than just refs.
> For example, submodule has configs, and worktree also has bunch of
> other stuff that I would like to just cache and not readdir() and
> parse every time.

I can't think of any objections, though there might be some devils in
the details. I assume you mean that the submodule-specific hashmap
wouldn't be `{name -> struct ref_store}` anymore, but rather `{name ->
struct submodule}`, and `struct submodule` would hold the associated
`ref_store`? That sounds very reasonable.

Instead of moving all of the `for_each_*_submodule()` functions over, I
encourage you to consider getting rid of them entirely and let the
end-users call the `refs_for_each_*()` versions of the functions. Again,
I'm not sure that there won't be friction in doing so, but it seems like
it's worth a try.

Michael

