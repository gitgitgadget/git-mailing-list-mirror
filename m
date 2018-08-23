Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E481F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHXA7P (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:59:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:55443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeHXA7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:59:15 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlHsg-1gQdCE2VPC-00b5Or; Thu, 23
 Aug 2018 23:27:32 +0200
Date:   Thu, 23 Aug 2018 23:27:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>, gitster@pobox.com
Subject: Re: [GSoC][PATCH v6 15/20] rebase -i: rewrite write_basic_state()
 in C
In-Reply-To: <3da3ce19-38f8-0c46-47a1-9510f203b65f@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1808232309570.73@tvgsbejvaqbjf.bet>
References: <20180731180003.5421-1-alban.gruin@gmail.com> <20180810165147.4779-1-alban.gruin@gmail.com> <20180810165147.4779-16-alban.gruin@gmail.com> <3da3ce19-38f8-0c46-47a1-9510f203b65f@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HHLFtQbiqJbIWRYdNOdMeotVjtPRrK61CHINPSvTfxIL6S9aP5y
 RLlaU/I6YWbb8UH2QZXuRqvo+VgxS1CSdGcz02nLqfLPY1xy/pTjPyqATjNYPKsBHxQOT78
 GY0hKL9Mq0BpTCTF4bzI5WV2WtX6QK1b0ibNpyCZOiAommNiimy3Za71XAG64wKjbq62vqi
 nigBN20eDJvlQGZFDuofw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cZM4ed2iEjw=:QqhRux/JvSfIcl3Gz46mdS
 37QmNq4dhQ+fs4eSeEIEzH+PJ1AUUbfcFBVV+HaoOg5K1Bi1QOe7t6t1LAesXEqdj/DcFFes/
 eeFsD0hpuwydNF8P3oPAEaP624WFS3ZurG2R4Lj9Z8UpVGeSPVWEW0PaPFQxMRHYSlSZfo45h
 ULYEiQEKGVkg/LC7Pc5qNaCw25j//4zJZqch+LnVV6WG1iTDm1UHZIKHNryNFqWwfpR+D+/c1
 gPz8DM+KyMl3fymcJTGCQyBT2aaKwfHzr9Km8VNnTv864BWN/fdhTwjjMOYB6CKvUvZli903o
 ED04lufX03MWrWo6mwOtIEa/8XT+wuixL0MLa1L4gfSKZ42STw7ZPxp0uxisMidhof58sulac
 8foZvz82Fs7bKK7b0qvF6qWFL/Zi4hKlQ5sdPId5LKl3NedR3he7xv/eK4tSDmz9VPl2ImO5I
 0fh9S6RfNp/E8r9I5vQVIm+FwtDXqsTokQ1lbem2ZjcF8yIpkDjm2PvkuYnBZ++1AT3kdbYc5
 rJqNSxtOJznEZT7T3kpiESLi6q3yfwMv+0/K6qrAVOVHq1294cRxh6gv7ul8DNRQLt2+cRKty
 cQYPzttFZuhi44c7bZUnug1EBSFa+cMO5EiyItXYWSYSrgGsa0QG2AjCLqOSzhDmC2gCgxAcF
 2FikM1K77xMOGIONDNtZDAqVQhAmM+YegkBZi2l3sayECGjEErpxYNIn/bDqs+45qt7ydmrWN
 6cX01mHs1Fgfj/GuAgd4LI8MQkxWtvFJfq2nJx9bH1GXqTKxRWu6VNfCp1iwet7Bd8bCXhdKT
 Z5wp9pQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 17 Aug 2018, Phillip Wood wrote:

> On 10/08/2018 17:51, Alban Gruin wrote:
> 
> > +{
> > +	const char *quiet = getenv("GIT_QUIET");
> > +
> > +	if (head_name)
> > +		write_file(rebase_path_head_name(), "%s\n", head_name);
> 
> write_file() can call die() which isn't encouraged for code in libgit.
> I'm not sure how much it matters in this case. Rewriting all these as
> 
> 	if (head_name && write_message(onto, strlen(onto), rebase_path_onto(), 1))
> 		return -1;
> 
> is a bit tedious. An alternative would be it leave it for now and in the
> longer term move this function (and the ones above which I've just
> noticed also call write_file()) to in builtin/rebase.c (assuming that
> builtin/rebase--interactive.c and builtin/rebase.c get merged once
> they're finalized - I'm not sure if there is a plan for that or not.)

This came up in the review, and Alban said exactly what you did.

I then even dragged Peff into the discussion, as it was his idea to change
`write_file()` from returning an `int` to returning a `void` (instead of
libifying the function so that it would not `die()` in error cases and
`return 0` otherwise):

	https://github.com/git/git/pull/518#discussion_r200606997

Christian Couder (one of Alban's mentors) then even jumped in and *agreed*
that libifying code "could be seen as unnecessary code churn and
rejected."

In light of these two respected community members suggesting to Alban to
go and not give a flying fish about proper error handling, I have to admit
that I am sympathetic to Alban simply using `write_file()` as-is.

I do agree with you, of course, that the over-use of `die()` in our code
base is a pretty bad thing.

But that's neither Alban's fault, nor should he be punished for the advice
he has been given.

In short: I agree with you that `write_file()` should be libified
properly, and I would suggest not to burden Alban with this (Alban, of
course you should feel free to work on this if this is something you care
about, too).

Ciao,
Dscho
