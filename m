Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949052018F
	for <e@80x24.org>; Wed, 13 Jul 2016 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbcGMRe3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:34:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932229AbcGMRd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:33:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDC652B66E;
	Wed, 13 Jul 2016 13:32:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XaZh4iP1B1ygS+BiGV+WKmVvuJs=; b=htLD52
	1DyRE7P0W1OuXBbrAv+w0hb78bc2hRV6em62Ufc6R9XuLJLVK+mkzZMPc34uQ9Im
	U+uvsmgv29Ej2qn66IYcS4uG2nAvj4QMtBSiueOv9oE9RJbPEFabv3OZkvAbwk/R
	ob+XUS7SidgZaxTXRDFQVpvxTs2GUq0AeZ8yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j8l5hUtJL2JzNOpBwMcfm5F+gm6qiLo5
	xepz0AuaPzqOMPt0rmnCmBkSoP8/8yWNWrrQDjvEMGaCoabaMjdp5iJ/oKj+nByS
	RjLN4Q9YGpmQGobvIl0uzSWRuaeZSMUi74Kbgk7yvdR/X4v2kkxWE/qENpD5tXZt
	10B+PVzmk/c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C492C2B66D;
	Wed, 13 Jul 2016 13:32:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 501AE2B66C;
	Wed, 13 Jul 2016 13:32:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY7pWUG7Q0fDhieHCBCpR5RCongzHth6DWOJaEkcGqMEA@mail.gmail.com>
Date:	Wed, 13 Jul 2016 10:32:55 -0700
In-Reply-To: <CAGZ79kY7pWUG7Q0fDhieHCBCpR5RCongzHth6DWOJaEkcGqMEA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Jul 2016 10:27:44 -0700")
Message-ID: <xmqqpoqh1m0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6877E00-491F-11E6-A422-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * sb/push-options (2016-07-12) 5 commits
>>  - add a test for push options
>>  - push: accept push options
>>  - SQUASH???
>
> Squash? I do not find a squashable commit in what you pushed,
> do you intend to squash the first 2 patches instead?

$ git log --oneline --first-parent master..pu | grep push-options
f8e50d4 Merge branch 'sb/push-options' into pu
$ git log --oneline master..f8e50d4^2
d6fd535 add a test for push options
ef00034 push: accept push options
6c5282d SQUASH???
ed0c716 receive-pack: implement advertising and receiving push options
f7c760f push options: {pre,post}-receive hook learns about push options
$ git show 6c5282d
commit 6c5282d7c5b50f362aaee2059c0253ab17b4fcd3
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Jul 12 14:54:58 2016 -0700

    SQUASH???

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 754db6e..4d8041a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1503,8 +1503,6 @@ static struct string_list *read_push_options(void)
 {
 	int i;
 	struct string_list *ret = xmalloc(sizeof(*ret));
-	string_list_init(ret, 1);
-
 	/* NEEDSWORK: expose the limitations to be configurable. */
 	int max_options = 32;
 
@@ -1518,6 +1516,7 @@ static struct string_list *read_push_options(void)
 	 */
 	int max_size = 1024;
 
+	string_list_init(ret, 1);
 	for (i = 0; i < max_options; i++) {
 		char *line;
 		int len;

i.e. compilation fix for decl-after-stmt.

>>  - receive-pack: implement advertising and receiving push options
>>  - push options: {pre,post}-receive hook learns about push options
>>
>>  "git push" learned to accept and pass extra options to the
>>  receiving end so that hooks can read and react to them.
>>
>>  Discussion continues, expecting a further reroll.
>>  ($gmane/299156)
>
> Yeah there were some late comments, so I did not reroll right away.
> I think Shawns proposal to have a receive.maxCommandBytes is a
> good way for an overall upper bound, but how does it stop us from
> going forward with this series?

If we were to do maxcommandbytes, then max_options would become
irrelevant, no?
