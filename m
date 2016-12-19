Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE77D1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 20:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbcLSUo1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 15:44:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53556 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932184AbcLSUoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 15:44:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73687597C9;
        Mon, 19 Dec 2016 15:44:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B7opTt9TVhHwvRKG0Q0b1QBl93Y=; b=ISpMGg
        l6C6bkI6khCI6kJ3JQIpo3mY5bxsa6P1ArDU7s9nk5t+b2P1Vxzn45ry/p/P4pTh
        JPXEXd3FtEQJFhTmQpRi9cjU3SOGP90SWRJbVArbxlvntKlzRn1BuLhYBjWwhv0Z
        TQ9kC6xdt+KoJavkbIsfzFWvUe63t3YRzkGFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DUGBQ40Pvj4whxnlohxhPRayrdPve9QO
        gMr8umznQlJu3zlnKbLJ8NUaSCzueWqBmlbqaTst+0FMvR6Szd8+Oo2BARh0UQxx
        Y2UB0az+6/U5pmkD3kRA6LkF4ZIWfWJMZi6iIJONJm7vvfN/aTQmof/b3r/Cp06x
        3y5AzVJqP2A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BEFB597C8;
        Mon, 19 Dec 2016 15:44:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D46D4597C5;
        Mon, 19 Dec 2016 15:44:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Josh Bleecher Snyder <josharian@gmail.com>, vascomalmeida@sapo.pt,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: $program_name in error message
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
        <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
        <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
        <CAGZ79ka=RzAjrb=7u7p5xnveo=kcNCoGn=TC=0j-CBp8Oby7OA@mail.gmail.com>
Date:   Mon, 19 Dec 2016 12:44:22 -0800
In-Reply-To: <CAGZ79ka=RzAjrb=7u7p5xnveo=kcNCoGn=TC=0j-CBp8Oby7OA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 19 Dec 2016 09:07:55 -0800")
Message-ID: <xmqqk2avodi1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECB9CE42-C62B-11E6-A3CD-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> + Vasco Almeida, who authored d323c6b641,
> (i18n: git-sh-setup.sh: mark strings for translation, 2016-06-17)

Comparing these changes that involve "\$variable" ...

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c48139a494..2eda134800 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -2,6 +2,9 @@
 # to set up some variables pointing at the normal git directories and
 # a few helper shell functions.
 
+# Source git-sh-i18n for gettext support.
+. git-sh-i18n
+
 # Having this variable in your environment would break scripts because
 # you would cause "cd" to be taken to unexpected places.  If you
 # like CDPATH, define it for your interactive shell sessions without
@@ -83,16 +86,16 @@ if test -n "$OPTIONS_SPEC"; then
 else
 	dashless=$(basename -- "$0" | sed -e 's/-/ /')
 	usage() {
-		die "usage: $dashless $USAGE"
+		die "$(eval_gettext "usage: \$dashless \$USAGE")"
 	}
 
 	if [ -z "$LONG_USAGE" ]
 	then
-		LONG_USAGE="usage: $dashless $USAGE"
+		LONG_USAGE="$(eval_gettext "usage: \$dashless \$USAGE")"
 	else
-		LONG_USAGE="usage: $dashless $USAGE
+		LONG_USAGE="$(eval_gettext "usage: \$dashless \$USAGE
 

... and these that appear in the same patch ...

@@ -190,13 +193,16 @@ cd_to_toplevel () {
 require_work_tree_exists () {
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
-		die "fatal: $0 cannot be used without a working tree."
+		program_name=$0
+		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
 	fi
 }
 
 require_work_tree () {
-	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
-	die "fatal: $0 cannot be used without a working tree."
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true || {
+		program_name=$0
+		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
+	}
 }
 
tells me that the latter needs to be eval_gettext?
