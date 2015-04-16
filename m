From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Use -m when running p4 changes
Date: Thu, 16 Apr 2015 11:56:31 -0700
Message-ID: <xmqqfv7zj40w.fsf@gitster.dls.corp.google.com>
References: <CALM2SnY62u3OXJOMSqSfghH_NYwZhzSedm3-wcde-dQCX6eB9Q@mail.gmail.com>
	<CAE5ih79UcJfuhzgTdTPy2K51sa6--4bvaVaKL3nsUcC2kq4Ffg@mail.gmail.com>
	<CALM2SnafBHz8YeWtUtQDUgLBP_s9AiJy=9UC6XveqP0zrYMEqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 20:56:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yioxs-0007sS-1S
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbbDPS4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:56:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755140AbbDPS4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:56:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B8D74AACA;
	Thu, 16 Apr 2015 14:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Z1tL33SXik11MbrXMRgVX/1qvQ=; b=yhauKr
	2hXaD3E4oGkoTjKaPQeWg/uVa8D8HGd2AyFjpuvlXKDxkqtPMrHhYR+YNMPgSo/f
	JLB78XQVc7gMuInFGsicqFI252BhEj/dei87bWQwHxk9BV6Wx9hQ0nTt7Jg7RoSL
	M18sgFebt5I5eE7D3OuvFclTIOWq383nOzsTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jC1AKNbMcqgqUPl/4g68l3I+4ka4PVQn
	GsCWcTnRmg1QXN2d5bXtkflHrPrQQJRqY/dr1l7F89a9hSzrlPEUrr2c4CO6EKH7
	ASx1TxdUzd/L0pkJz5Hiw+SEHr3w1LafR3C+swPIn9z+Z6hnYC6z85ChSHseF+2A
	v6u5eub6tqo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 224B34AAC9;
	Thu, 16 Apr 2015 14:56:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75E374AAC7;
	Thu, 16 Apr 2015 14:56:32 -0400 (EDT)
In-Reply-To: <CALM2SnafBHz8YeWtUtQDUgLBP_s9AiJy=9UC6XveqP0zrYMEqA@mail.gmail.com>
	(Lex Spoon's message of "Tue, 14 Apr 2015 23:47:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C413116-E46A-11E4-8063-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267327>

Lex Spoon <lex@lexspoon.org> writes:

> From 9cc607667a20317c837afd90d50c078da659b72f Mon Sep 17 00:00:00 2001
> From: Lex Spoon <lex@lexspoon.org>
> Date: Sat, 11 Apr 2015 10:01:15 -0400
> Subject: [PATCH] git-p4: Use -m when running p4 changes

All of the above is duplicate and shouldn't be added to the message;
the recipient can pick them up from the e-mail headers.

Please explain what this change intends to do (e.g. Is it a fix?  If
so, what is broken without this change?  Is it an enhancement?  If
so, what cannot be done without this change, and how and why is the
new thing the change enables a good thing?), and why it is a good
idea to use "-m" to realize that objective.

> Signed-off-by: Lex Spoon <lex@lexspoon.org>
> ---
> Updated to include a test case
>
>  git-p4.py               | 51 ++++++++++++++++++++++++++++++---------
>  t/t9818-git-p4-block.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+), 11 deletions(-)
>  create mode 100755 t/t9818-git-p4-block.sh
>
> diff --git a/git-p4.py b/git-p4.py
> index 549022e..2fc8d9c 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -740,17 +740,43 @@ def
> createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/",
> silent
>  def originP4BranchesExist():
>          return gitBranchExists("origin") or
> gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")

It appears that the patch is severely linewrapped.

> diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
> new file mode 100755
> index 0000000..73e545d
> --- /dev/null
> +++ b/t/t9818-git-p4-block.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description='git p4 fetching changes in multiple blocks'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> + start_p4d
> +'

We do not do one-SP indent.  Indent with tab instead.

> +
> +test_expect_success 'Create a repo with 100 changes' '
> + (
> + cd "$cli" &&
> + touch file.txt &&

Do not use "touch" when the only thing you are interested in is that
the file exists and you do not care about its timestamp.  I.e. say

    >file.txt &&

instead.

> + p4 add file.txt &&
> + p4 submit -d "Add file.txt" &&
> + for i in 0 1 2 3 4 5 6 7 8 9
> + do
> + touch outer$i.txt &&
> + p4 add outer$i.txt &&
> + p4 submit -d "Adding outer$i.txt" &&
> + for j in 0 1 2 3 4 5 6 7 8 9
> + do
> + p4 edit file.txt &&
> + echo $i$j > file.txt &&
> + p4 submit -d "Commit $i$j"
> + done
> + done
> + )

What happens when any of these commands in the &&-chain fails?

	(
        	cd "$cli" &&
                >file.txt &&
		p4 ... &&
                for i in $(test_seq ...)
                do
                	>"outer$i.txt" &&
                        p4 ... &&
			for j in $(test_seq ...)
			do
				p4 ... &&
				p4 ... || exit
			done
		done
	)

or something like that, perhaps?
