From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Tue, 24 Mar 2015 13:02:35 -0700
Message-ID: <xmqqsicu5fl0.fsf@gitster.dls.corp.google.com>
References: <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:02:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaV2H-0002ib-9N
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 21:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbbCXUCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 16:02:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752780AbbCXUCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 16:02:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6255D42FCF;
	Tue, 24 Mar 2015 16:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zHlAH4IcqpZ5ppDrDEpCBHLGfYo=; b=tj0DaV
	1fj9VwKIXT6MG8ZFR0VPs34hNjRM6fHL4PRfjnRccyLYFoIM0wUPDSQtJabZaG7D
	iZ6Z1eHT3WXHRhPzH+llUZRqSuJzjON8OqD2/L1wY+rUKLntMn6inf4gVW/G/bzQ
	c3bETlUQpyniANRCbXoX77GPmQ+5cjQBXN+zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MF0YeIHjIzt4AFzkhPT7ATgOYxMfTbWR
	dEnAfPlzjbd464FBPhIfsACe9lbd5McY7Qm0TCminG25pvoC0M4lyAUC9kaYjyue
	ekpMWf0pSYIlvu73/zXyR74mNdP2E1tYonboOWlZ3xPceg6hWo6WIMremz5YutA8
	51XJhWdS48w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B80742FCE;
	Tue, 24 Mar 2015 16:02:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF89442FC7;
	Tue, 24 Mar 2015 16:02:36 -0400 (EDT)
In-Reply-To: <xmqqmw338khu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Mar 2015 14:35:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7B3998C-D260-11E4-A17A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266223>

Junio C Hamano <gitster@pobox.com> writes:

> * jk/test-chain-lint (2015-03-22) 28 commits
>  - t6039: fix broken && chain
>  - t9158, t9161: fix broken &&-chain in git-svn tests
>  - t9104: fix test for following larger parents
>  - t4104: drop hand-rolled error reporting
>  - t0005: fix broken &&-chains
>  - t7004: fix embedded single-quotes
>  - t0050: appease --chain-lint
>  - t9001: use test_when_finished
>  - t4117: use modern test_* helpers
>  - t6034: use modern test_* helpers
>  - t1301: use modern test_* helpers
>  - t0020: use modern test_* helpers
>  - t6030: use modern test_* helpers
>  - t9502: fix &&-chain breakage
>  - t7201: fix &&-chain breakage
>  - t3600: fix &&-chain breakage for setup commands
>  - t: avoid using ":" for comments
>  - t: wrap complicated expect_code users in a block
>  - t: use test_expect_code instead of hand-rolled comparison
>  - t: use test_might_fail for diff and grep
>  - t: fix &&-chaining issues around setup which might fail
>  - t: use test_must_fail instead of hand-rolled blocks
>  - t: use verbose instead of hand-rolled errors
>  - t: assume test_cmp produces verbose output
>  - t: fix trivial &&-chain breakage
>  - t: fix moderate &&-chain breakage
>  - t: fix severe &&-chain breakage
>  - t/test-lib: introduce --chain-lint option
>
>  People often forget to chain the commands in their test together
>  with &&, leaving a failure from an earlier command in the test go
>  unnoticed.  The new GIT_TEST_CHAIN_LINT mechanism allows you to
>  catch such a mistake more easily.
>
>  What I queued here has fix to the issue J6t found in 15/25 squashed
>  in, and also has 26/25 and 27/25 follow-up fixes from Michael, plus
>  28/25 follow-up from Torsten.  If everybody involved is happy with
>  it, we can just proceed with this copy, otherwise I'll let Peff
>  reroll.  I am happy either way.

I'll merge this to 'next' soonish, unless I hear otherwise.  I
double checked 15/25 (i.e. $feature{"forks"}{"default"} = [1];)
so I think we are in good shape.

Thanks.
