Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEC820248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfCNMpP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:45:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:34339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfCNMpC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:45:02 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5a9E-1gp5js2IEy-00xZ8o; Thu, 14
 Mar 2019 13:44:48 +0100
Date:   Thu, 14 Mar 2019 13:44:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache
 bug
In-Reply-To: <xmqqimwmcl93.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903141344010.41@tvgsbejvaqbjf.bet>
References: <pull.161.git.gitgitgadget@gmail.com> <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com> <xmqqimwmcl93.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0HIj5UaJGo0ge/W/Bob7PIGx5DUvm93jXFpkD89hlDck4V8+pUe
 kOjyUGDBP19vAaIBxC3jgEN29oZTWDVpyt1BobuWte3DeKMdbzfFxdYyDkppnBDTASuSxQc
 64zb3Xot1wu+B/jBDRwOvBtjhk01rzrnFoivrGzgKs3A2Jiw7DDaiVmyV2BPAiHhxxnvT8A
 /mriCWhq8KPODFCBHKGaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s9NjjRAr1zo=:8rYx0nUA3RVYwhjT6KRdd+
 e0csYC0xt8OcF9+qNiGlQTCsz0qj+M7r8UeQNA3wHQXzBAaTZignaVzkc5r+4g0hmbS/9p3hl
 onAhkFbkwEgHZV0rM3k4/wu+eURv6sZqkmFr3Z6z8WKVzHymHeW+RYYMaMOsadfNflq+8PcBF
 sm0quOfU49DcdYeHcR0aT7xgAB7BAY3phleRuzJCRzdK5epzF0cZQ6HrIGKiPsLrMJmdEMb2N
 NQPUYPhu7Jzz0YGTCadIM7UjV+d4hcc8Zu+rkuGR5y9SMtPGGSEMTBast7IrB3I32ZLf0Mh/+
 Gsf11CLNyJxD601cUncO86hyVpZWrzAeFD0RbWMHg7QTIe/3QjQvxHAgPyt8cdEgwg1n+Os+m
 7+bodZfLKgktCzysNo5hQrufB4wfL8aQMqxQBQqwiQR4unl7wXlimSrgFS3Jb/rAgAclRBlpt
 Tkt+Zet/Cy3OfTkr0X+1w94KU1z7pLim46/GU0KBjWUlMIjUeCaw92Sz3kXFG7reDGtzXgv2F
 FTZAjKZ47j1CbbIDtHLctoNLziWxQv0kAmU7CyQYvEc2H37cJ6DN0ecUeD64qWR519gnMYIP3
 5oawlbpGtArhIxpFgiK0e6JROvOWii4WNGhWV4M+7tIL/Gv6MvKLXViW10d9j7MwNNqCJhfZM
 P/zLg0Z9fWNnJr/kYfanT39nOQIcBgAR5E+4YuCtuley0xtOuVKqXSArvCAqiZeeVLxh8a+2E
 YoAjspeUPlgkPuwk10ef0U9HU76PfcjWC5ID5/+UyWPFb2FGxVmxXln2hZYbWweRmJFSuUGZK
 cQ3gX7oJQMs03h9BCq6mgvmxlc0OFazXTMM5/GknmtfF4xAOiKncVGiRI7n3tjWTsOO55FhHC
 fpyPjEkMw0myk5rxdL08CNEviqbfCfkfrw2qnrQvZc4WC0xJUscWJ8qAONkdCTXRVe3PDAt1P
 717cXg2GN+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 14 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > +test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
> > +	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
> > +	export GIT_REBASE_TODO &&
> > +	write_script append-todo.sh <<-\EOS &&
> > +	# For values 5 and 6, this yields SHA-1s with the same first two digits
> > +	echo "pick $(git rev-parse --short \
> > +		$(printf "%s\\n" \
> > +			"tree $EMPTY_TREE" \
> > +			"author A U Thor <author@example.org> $1 +0000" \
> > +			"committer A U Thor <author@example.org> $1 +0000" \
> > +			"" \
> > +			"$1" |
> > +		  git hash-object -t commit -w --stdin))" >>$GIT_REBASE_TODO
> 
> In the generated append-todo.sh, as the <<EOS above is quoted, we
> will see ">>$GIT_REBASE_TODO" literally (not the actual pathname
> that begins with .git, but a reference to the variable).  test-lint
> may or may not catch it, but redirecting into variable reference
> would trigger a(n arguably misguided) warning when run with some
> versions of bash.  Quoting
> 
> 		echo ... >>"$GIT_REBASE_TODO"
> 
> would work it around, of course.
> 
> > +	shift
> > +	test -z "$*" ||
> > +	echo "exec $0 $*" >>$GIT_REBASE_TODO
> 
> Likewise.

Yep. As a rule of thumb, I should always quote variable expansions.

Thanks,
Dscho

> 
> > +	EOS
> > +
> > +	git rebase HEAD -x "./append-todo.sh 5 6"
> > +'
> > +
> >  test_done
> 
