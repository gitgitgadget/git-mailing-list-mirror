Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D021F404
	for <e@80x24.org>; Wed, 10 Jan 2018 23:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeAJXJ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 18:09:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57787 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeAJXJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 18:09:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DCF5D42A9;
        Wed, 10 Jan 2018 18:09:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AdwBD3vpvd0evigeen4ZDWGxcjU=; b=hq7Q/v
        C2qzwz19pvK71D3geti8ilQxtK0SQ6sz7FEXc85sJkJo6ByznWGfIHGQH/e+2dSi
        RRaTVRbYEpshd3ZZFGBJw1wtWmu7pjEF0JjO2uKITE4P/Z+uou41n1Y99DBN6R+B
        5i2UDZyQ1/YP49l4sN3r5dDxG08wsk6wiI6bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p+ymi83BGoRgvHNv+CLbSGf99hRd8QXJ
        DhQHoCYygMZvPAwpBITlTN+YqOs2SR0hk3LiG8UxDxLaHGlHprEdj6GjD5xbhyQP
        W17y15aVmsuilRQtcK3iSRgUW+Jewb6Id8+pbY7V8c0oZIlijq1iMJ9P6jPTTRzl
        6cWP//zP/LQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75A79D42A8;
        Wed, 10 Jan 2018 18:09:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA12DD42A7;
        Wed, 10 Jan 2018 18:09:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH v2] t3900: add some more quotes
References: <CAPig+cTmgp3=jkG2Kb3x+3n4Dsq1V6GMGkfVE3=p6KGMBnNMkQ@mail.gmail.com>
        <20180110223840.1481-1-dev+git@drbeat.li>
Date:   Wed, 10 Jan 2018 15:09:52 -0800
In-Reply-To: <20180110223840.1481-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Wed, 10 Jan 2018 23:38:40 +0100")
Message-ID: <xmqqfu7dz4xr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E031F1C-F65B-11E7-84C0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> In 89a70b80 ("t0302 & t3900: add forgotten quotes", 2018-01-03), quotes
> were added to protect against spaces in $HOME. In the test_when_finished
> handler, two files are deleted which must be quoted individually.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>
> Diff to v1:
>
> s/hander/handler/ in the message.
> ...

OK, but that forgets to fix a more important issue raised in the
discussion, no?

Here is what I ended up queuing in the meantime.  Thanks.

-- >8 --
From: Beat Bolli <dev+git@drbeat.li>
Date: Wed, 10 Jan 2018 10:58:32 +0100
Subject: [PATCH] t3900: add some more quotes

In 89a70b80 ("t0302 & t3900: add forgotten quotes", 2018-01-03), quotes
were added to protect against spaces in $HOME. In the test_when_finished
command, two files are deleted which must be quoted individually.

[jc: with \$HOME in the test_when_finished command quoted, as
pointed out by j6t].

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3900-i18n-commit.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 9e4e694d93..b92ff95977 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -40,7 +40,7 @@ test_expect_success 'UTF-16 refused because of NULs' '
 '
 
 test_expect_success 'UTF-8 invalid characters refused' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"\$HOME/stderr\" \"\$HOME/invalid\"" &&
 	echo "UTF-8 characters" >F &&
 	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
 		>"$HOME/invalid" &&
@@ -49,7 +49,7 @@ test_expect_success 'UTF-8 invalid characters refused' '
 '
 
 test_expect_success 'UTF-8 overlong sequences rejected' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"\$HOME/stderr\" \"\$HOME/invalid\"" &&
 	rm -f "$HOME/stderr" "$HOME/invalid" &&
 	echo "UTF-8 overlong" >F &&
 	printf "\340\202\251ommit message\n\nThis is not a space:\300\240\n" \
@@ -59,7 +59,7 @@ test_expect_success 'UTF-8 overlong sequences rejected' '
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"\$HOME/stderr\" \"\$HOME/invalid\"" &&
 	echo "UTF-8 non-character 1" >F &&
 	printf "Commit message\n\nNon-character:\364\217\277\276\n" \
 		>"$HOME/invalid" &&
@@ -68,7 +68,7 @@ test_expect_success 'UTF-8 non-characters refused' '
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"\$HOME/stderr\" \"\$HOME/invalid\"" &&
 	echo "UTF-8 non-character 2." >F &&
 	printf "Commit message\n\nNon-character:\357\267\220\n" \
 		>"$HOME/invalid" &&
-- 
2.16.0-rc1-187-g8dee184084

