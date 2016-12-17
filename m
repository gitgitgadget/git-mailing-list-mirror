Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411451FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 20:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756524AbcLQUYQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 15:24:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:49264 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752410AbcLQUYP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 15:24:15 -0500
Received: from [192.168.178.43] ([88.71.237.80]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwJFG-1cfvYC3F7e-0185sm; Sat, 17
 Dec 2016 21:23:54 +0100
Subject: Re: [PATCH v2 01/34] sequencer: support a new action: 'interactive
 rebase'
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de>
 <xmqqy3ziwbpk.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <f0762491-63ca-0814-0005-b2cbdd4dc505@gmx.net>
Date:   Sat, 17 Dec 2016 21:23:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3ziwbpk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:uC9zS2iux1T6zWVTrGcPKutHpySsAAlf9YFi6nl6IDCBGtTMNOT
 rUgZFYhGmlx6kEKc+ck8zLBc37u01TIfwO8v6NmJnkqyQTytQh2N3QeUKyV1tMTHKo7dVL8
 29PQ7vqo55dbmz4LvW+kqHOXeAh6hDGJTzN4ljFpe7eCXJDH52ClZu/URTniSy5G3ruLlZ5
 xFfGtU+lN9YEyl0PftcUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MW4o7rGQYrE=:Pkt7c4lLs5Z+LEKzUaYqtA
 fLpURRev+zUkDM1UiJ6FlppQIK2LiAgK8TNkbNtHvKqNRVTMwSmUamFwRYBofN9qDCc1gRabN
 SHzn5kEYvGKrtrnU/gxzku6c3LFzAerdxDqDBnG7CYTz1J5nLhv1b2wWGnRMADhd2sB0JTrhx
 YsmVlr18w/NuugfuaVzrOdwd40s+FFSRHWqeat9XJB2DEgglGB/fciR9ekZLHPWBR53IKNYOG
 D5cThRi4WpjzPof7/lV8Z0Q+e0Ijw7ILUSl1TWDFIvRKYkDmM3TliGcaWv30sPZshKN6J378X
 NeIqYXDiFz/e1y9oll7SXBhrMOeQ89+iyxOAVqqtFpsTF48OCIjS4jSFnop4RN28w74h5h0sf
 57Jr1yNXE39lfgftUotBN6eonO20SUv+J8v7RtB2/KPSVOmYI4HMjUj/XS+/APX4jnzg8YXRA
 UflocbaZW7T4LznfcR1Urbi+5PNC6PkKPoXNoQFF+hoET9WxYlOt3jbOENs9g6XaFe6eKO1Xv
 //kpWY7pgAo35nuFe4XHmedrSLLXI6rgpO+8fRQgn8MAhmkfe11Qy6AiOOJ4WA2dl6+E8heHo
 9RP4ZTS0sH9qk1pp5W2ZtWQnlBjoDNfQEEN8Eo3ruxRaa//rnfa7tGL+ETDkUt2uZTi/S31xu
 guJOE7QBnSI8dlyDa/LUxm+c6Q8kh13gFstpX2NPC5xmdQC3D4+6SPOrEiixCOOvH5fLITmJb
 LW/Lry8/i2Zy7bc3KRw7XWgsbDmfKCHDk+wIBNhXPUFsayJcReR7WIaRUxAnPpjeGk/s0O167
 s0Xjxu/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 12/14/2016 08:29 PM, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> -/* We will introduce the 'interactive rebase' mode later */
>>  static inline int is_rebase_i(const struct replay_opts *opts)
>>  {
>> -	return 0;
>> +	return opts->action == REPLAY_INTERACTIVE_REBASE;
>>  }
>>  
>>  static const char *get_dir(const struct replay_opts *opts)
>>  {
>> +	if (is_rebase_i(opts))
>> +		return rebase_path();
>>  	return git_path_seq_dir();
>>  }
> 
> This obviously makes the assumption made by 39784cd362 ("sequencer:
> remove useless get_dir() function", 2016-12-07) invalid, where the
> "remove useless" thought that the callers of this function wants a
> single answer that does not depend on opts.
> 
> I'll revert that commit from the sb/sequencer-abort-safety topic (as
> the topic is in 'next' already) to keep this one.  Please holler if
> that is a mistaken decision.

It seems to be the right decision if one wants to keep the internal-path
backwards-compatibility of "git rebase -i" (and it seems that Dscho
wants to keep it).

However, maintaining more than one directory (like "sequencer" for
sequencer state and "rebase-merge" for rebase todo and log) can cause
the necessity to be even more careful when hacking on sequencer... For
example, the cleanup code must delete both of them, not only one of them.

Hence, I think that it's a wiser choice to keep one directory for
sequencer state *and* additional files.
If we (a) save everything in "sequencer", we break the internal-path
backwards-compatbility but we can get rid of get_dir()...
If we (b) save everything in "rebase-merge" when using rebase -i and
save everything in "sequencer" for pick/revert, we are 100%
backwards-compatible, but we have to change every occurrence of
git_path_seq_dir() to get_dir() and the GIT_PATH_FUNC definitions of
git_path_{todo,opts,head}_file must be replaced by definitions using
get_dir().

Best
  Stephan
