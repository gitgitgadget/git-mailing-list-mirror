Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C76202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbdKUBGO (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:06:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51815 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751195AbdKUBGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:06:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79B6CBB3A7;
        Mon, 20 Nov 2017 20:06:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TQ/zyTaas4Fk1o2qT6hffJvApPY=; b=xxnVh+
        ElHSdodXd3r3LpO+ovBZE9/P9NxGnHKXpYcH6Kho9OZTooXMrpntYpwpljIB7lkP
        Y76WvPFV7lohWeqJ83gS5W6wbZw+EPf/RCVepu3rcaRx5fdUOlFRlGewh1bf2o/D
        gg1nHOuHdoMaJJOHTDCxe5Ak9dfi1IZRhDaFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XIhQCZmVXzLvLbLB2pgpsvOxaRU+y9zo
        ljWeaVHIDuk9JyBPP3SsIUfkUcB6oJE6kKbtdMdDhOmLaVM6oHiHfKUO15hiKr0S
        JsCHxQR+AWD0Y6LT9bvpsogMwDRlo51FBkKsK1SXQw+UXPjaNqpFiXM3LQ0ehdIK
        gCfZ9ChuZSQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F659BB3A6;
        Mon, 20 Nov 2017 20:06:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2EDEBB3A5;
        Mon, 20 Nov 2017 20:06:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     vmiklos@suse.cz, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: make sign_off_header a file local symbol
References: <cc945f53-9452-9165-96c2-ab7f5f46c146@ramsayjones.plus.com>
Date:   Tue, 21 Nov 2017 10:06:11 +0900
In-Reply-To: <cc945f53-9452-9165-96c2-ab7f5f46c146@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 20 Nov 2017 20:27:07 +0000")
Message-ID: <xmqqy3n0jv98.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AD97EE0-CE58-11E7-B8E9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Miklos,
>
> If you need to re-roll your 'mv/cherry-pick-s' branch, could you
> please squash this into the relevant patch (commit 5ed75e2a3f,
> "cherry-pick: don't forget -s on failure", 14-09-2017).

What automated procedure are you using to produce these comments?

The commit is from 14-09-2012, not from a few months ago, and is
part of Git 1.8.0 and upwards, which won't be rerolled.  Please add
a check to see if the culprit is already in 'next' or something.

Will queue as _your_ fix, not a potential squash into another
commit.

Thanks, as always, for your attention to detail.





>  sequencer.c | 2 +-
>  sequencer.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 53b5100a7..b8c0ed170 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -26,7 +26,7 @@
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> -const char sign_off_header[] = "Signed-off-by: ";
> +static const char sign_off_header[] = "Signed-off-by: ";
>  static const char cherry_picked_prefix[] = "(cherry picked from commit ";
>  
>  GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
> diff --git a/sequencer.h b/sequencer.h
> index 77cb174b2..688b0276d 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -53,8 +53,6 @@ int check_todo_list(void);
>  int skip_unnecessary_picks(void);
>  int rearrange_squash(void);
>  
> -extern const char sign_off_header[];
> -
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
>  void append_conflicts_hint(struct strbuf *msgbuf);
>  int git_sequencer_config(const char *k, const char *v, void *cb);
