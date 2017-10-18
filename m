Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3399D1FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 02:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755306AbdJRCeg (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 22:34:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60489 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755186AbdJRCee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 22:34:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CA5CA622D;
        Tue, 17 Oct 2017 22:34:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/dR6wHRfPZm5Uir3IixcKr5Kwa4=; b=ifEPXa
        eEWJS0TEunhYA1Op4yMbSmTBfQCV/e97zHmHvRinU8gs/lc4mFygRc+Zf9nOUgsG
        lHFmYRie9D078ZjewN1hurM8wuU1DiW1W0Ibw8U4BDRJF28ml1I61SH3ixLyIpNj
        WW+pv10/tOX+oXWXyV6GydjqZKso0oc3/IGko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NMbDEeTlQDpQQVwMiYABrWrJM+N/tbDy
        9chwdrd12gRVa/0oCTTdQ0SBFe4Yb4OJZnDDyWWKy57tuDnKPW8tcEMQeUKJsdfa
        EWAXnQzMhPCBEC+yhhSmOvM2YraLYUF/NXh94N/Urr2Y4jeXkUgeP1+HkIqboigg
        JSFSPyi1vFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30F45A622C;
        Tue, 17 Oct 2017 22:34:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A02BBA622A;
        Tue, 17 Oct 2017 22:34:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
        <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
        <87zi8psli3.fsf@linux-m68k.org>
        <xmqq1sm1o5k5.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 18 Oct 2017 11:34:31 +0900
In-Reply-To: <xmqq1sm1o5k5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 18 Oct 2017 05:58:02 +0900")
Message-ID: <xmqqfuahkwug.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFB05594-B3AC-11E7-8DF2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> On Okt 16 2017, Jeff King <peff@peff.net> wrote:
>>
>>> We do have some hacks/workarounds for broken versions of the toolchain.
>>> You can try tweaking various knobs you find in Documentation/Makefile).
>>> DOCBOOK_SUPPRESS_SP sounds promising, but I think it actually does the
>>> opposite (removes extra spaces).
>>
>> An easy workaround would be to add a comma between `-f` and 'git
>> branch'.
>
> That sounds like a good idea, regardless of the mark-up issue.

-- >8 --
branch doc: sprinkle a few commas for readability

The "--force" option can also be used when the named branch does not
yet exist, and the point of the option is the user can (re)point the
branch to the named commit even if it does.  Add 'even' before 'if'
to clarify.  Also, insert another comma after "Without -f" before
"the command refuses..." to make the text easier to parse.

Incidentally, this change should help certain versions of
docbook-xsl-stylesheets that renders the original without any
whitespace between "-f" and "git".

Noticed-by: Lars Schneider <larsxschneider@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index fe029ac6fc..d6587c5e96 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -104,8 +104,8 @@ OPTIONS
 
 -f::
 --force::
-	Reset <branchname> to <startpoint> if <branchname> exists
-	already. Without `-f` 'git branch' refuses to change an existing branch.
+	Reset <branchname> to <startpoint>, even if <branchname> exists
+	already. Without `-f`, 'git branch' refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status. In combination with
 	`-m` (or `--move`), allow renaming the branch even if the new


