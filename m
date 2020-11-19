Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD8C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F73221EB
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 09:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="elB2fofo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgKSJXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:23:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:58537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgKSJXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 04:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605777752;
        bh=I82HHOng+Fv2Fmjb0K/G85IUMaOIWqWbAF0qsVoknIk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=elB2fofooNl8UOJZOBj6vIYsC40kWdfVK+0B0vERMHZow6ENcvzTW+oc7U0uc0ceg
         /cilpgiLR318XxHPK8X7kdFtsjHqRTrZo+HMjda1BS5EBqo4ALqhocB25sG7gnqBfQ
         DSk/iOpu0rcu+3IE6kjY/iDP82s21jT2oFEZqwGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1kKxtc0LEa-00yklg; Thu, 19
 Nov 2020 10:22:32 +0100
Date:   Thu, 19 Nov 2020 10:22:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH 00/28] Use main as default branch name
In-Reply-To: <xmqq1rgq4qn3.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011191012430.56@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <87r1oraewl.fsf@x220.int.ebiederm.org> <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com> <20201117233313.GB642410@coredump.intra.peff.net> <xmqqr1or4jen.fsf@gitster.c.googlers.com>
 <20201118012544.GC650959@coredump.intra.peff.net> <20201118024028.GE360414@google.com> <xmqqima343vb.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2011181207220.56@tvgsbejvaqbjf.bet> <xmqq1rgq4qn3.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WDy8h6/Tf/r9oDDc+2amRDUnSmoAgPkwOAPh1g0kRlzwhS1wxir
 grBJfMaZN0th6OYcuU5pdQwpHL2w0Rt9JPjrcAqs0pmijAHLzACzWw3Qu0jQB0DjGOJvGf4
 /q5XrusJJWIykYSfE+h5JKN+xFhnowNVdzIlQ0v4iogI9NPs/RWzR+lZNNaGxqQ5/ha0fHu
 onSo6pq2s+zqK7uNeXh5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6pYN09RhpiE=:r/SwMXritdpnKcCUBDRCio
 nKjcxLLzSmvCzyfH5Lp45Rs9iLR7piGmeYaOk2pEBrm/v/AnRMJVONdVvBZkCiQBUqKHbspfD
 ijpmK50KuTEDn9izPbkLMqCqCt45EunRq3qBOwbXqTUia5lbMyYxRAntFfcn+lyKlnFnnFkNm
 bZtBPwB2H25i7//CAz9TY4OOTVw32yMLHZvwHydAFbQJCT0gVgKDTJtPzrZ5uLsxlZ87DQaoO
 K1bQlokl44PkJi6h5/DfvflmcgH1BtbGmOj5M6D9aROuyCGOqD5CTORpIobdvB5H+BOF6nxC3
 g3ZqmrFxamuwdlgILfv6v6X6+OFOIGMYk8ceanxHKtSYxsZi1DJEtvC6m5JC/xzjzIWr2Hg+n
 gdWtbZ8z7yJBWARVQU3ZBCYqODu7gdHbzvtUc2Q3d4Cw0G18e6tQ4gU3vb7Ue49cXRkIKC/id
 RcReHPwhavp51JSRdOvu3KEQoM38YnkbX2uaqd+g/c8kXJP9iQVPKQJVJy8++XqNZN8qAMGjY
 f/6U0VIT44y1o0v4Fo8NSHBrtuhefpjLdZDntp5xPu8+73kIwK4MYJSS0BfEHJBlCPLOiBWFU
 8w5DbZUO2b6Qji7obWR85M2Tpv0FUakJNvHn7BAtt3WP1vMkUIljF/rw30REeSUMFF/SIMhZA
 6vwg5vzu96X90Jf2+xtzVj69dmMttpj6iFh/vt5nIYaQ7qgpaPIUl0Locf0CTH9tebC5e66oy
 t18Gu5t39RmeJZAidpuTFgLWH7AQIO2NKDEbHZC9jFZBoE0Sy9w8nj2IVqCc8y0dNnzZZfJYy
 dczn7LNMc8hRnTItO5fT2u5VVbfYlTbtPlA7i27yh1RYDzHdC2zmEBXigWPXju25OKVdGXoZ2
 2nNlfWOCCqfY5BvvAZ+sK+9X2A3WRoc5ncOfnC5QE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > So yes, I totally agree that triggering an interactive prompt by the e=
mpty
> > value is not really a good idea (nor a particularly intuitive behavior=
).
>
> Puzzled.
>
> Nobody talked about going interactive so far and I didn't suggest
> it---even though I think it is a cute idea to give a "what branch
> name do you want to use?" prompt, I do not think it is practical.

The interactive prompt was what I understood your "a notation that asks
for the basename behaviour" comment. The "ask" was what tripped me up, I
always interpret that as interactive. But now that I re-read it, I
understand that you had not thought that far yet.

> I thought it was obvious, but the key to coming up with a name
> dynamically instead of using a fixed string is to derive from a cue
> the end user gives, not directly use what the end user gives.  I do
> not think anybody in the discussion meant by "the <basename> thing"
> to literally use $(basename $(cwd)) output, but use it to derive a
> token that check-ref-format likes.  As you may have already known
> when you wrote them, "My Documents" or the root directory case are
> red herring---it would be trivial to derive "MyDocuments" or
> "my-documents" for the former, and for the latter, it is totally OK
> for the deriving rule to come up with any of "unnamed", "initial",
> etc.

The more magic you introduce, the less intuitive the whole thing gets, and
the more disruptive the change.

> Most of the thing you said in the message I am responding to did not
> make much sense to me.  Perhaps you can retry after reading the
> message you are responding to again?

Could you be a bit more specific?

Was it the "I already use the empty string to force a fall-back, it cannot
also mean something else" that did not make sense?

Or my comment that special-casing values that start with a colon would
look saner to me?

Or the comment about the basename in a root directory?

Or referencing the SFC statement that we want to minimize disruption?

Or my stated preference to go with `main` in order to fulfill that promise
of minimizing the disruption to users?

Or my current plan to introduce an `advise()` call when running `git init`
that tells users that the fall-back for `init.defaultBranch` will change
soon and that users are encouraged to configure it if they care about
keeping the current fall-back?

Or that all of this needs to be done with care?

The message you refer to might not have been the best example of clear
communication, but it hardly deserved _that_ response.

Ciao,
Dscho
