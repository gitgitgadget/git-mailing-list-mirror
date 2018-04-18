Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08381F404
	for <e@80x24.org>; Wed, 18 Apr 2018 20:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeDRU4j (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 16:56:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60701 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeDRU4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 16:56:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3A35EBB0D;
        Wed, 18 Apr 2018 16:56:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=x1UTes04jAGhfAChIY1WBF+Iu5k=; b=NPdavJu
        YiKil/g6JyVw83cZdZ8PaWPTljHOMaDPXo+TCM/4MS7GvYMBkTPx6HzS6ttVBS/u
        oLHgFxJKseKcH/byWlPfh7klbq2ech2Ha09YTCuVqY/csO4ABTWXnNfFCEcx99X1
        gXdw4zDkdup/Lhpsnoo/D/hmDAlzaMh7y2k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=vV+UDYc6wSIofGy8RZRb91VInMuWvDzT6
        GDp8pCfLCQsEMKx/iEIeZTIBx8FUyCbgCQSQr8otS3MnHmw165ZT2h/lavslCMCw
        v6TemdzVRCGOdd6fpVokK7a4uiJOgDPh/UhboVnUP9+Za6JV9OAaR+p2saOLb7nn
        76cYpmREoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA823EBB0C;
        Wed, 18 Apr 2018 16:56:37 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 401BEEBB0B;
        Wed, 18 Apr 2018 16:56:37 -0400 (EDT)
Date:   Wed, 18 Apr 2018 16:56:35 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
Message-ID: <20180418205635.GU29831@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
 <87y3hn5drx.fsf@linux-m68k.org>
 <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
 <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
 <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
 <alpine.LFD.2.21.1804170831190.6019@localhost.localdomain>
 <CA+P7+xrebnWe_6P0uGu2yEmXZ0+qjpykjrv39Nhd2hUPzO_96g@mail.gmail.com>
 <xmqqd0yxl6n9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0yxl6n9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: FC3C8A7E-434A-11E8-A7E6-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
>> Maybe something like:
>>
>> "Note that the push URL and the fetch URL, even though they can be set
>> differently, are expected to refer to the same repository. For
>> example, the fetch URL might use an unauthenticated transport, while
>> the push URL generally requires authentication" Then follow this bit
>> with the mention of multiple remotes.
>>
>> (I think "repository" conveys the meaning better than "place".
>> Technically, the URLs can be completely different as long as they end
>> up contacting the same real server repository.)
> 
> Sounds sensible.  Let's see if there is any further input and then
> somebody pleaes wrap this up in a final patch ;-)

A pointer to the "GIT URLS" section in git-fetch(1) might
also be useful?  That section is provided via urls.txt and
urls-remotes.txt and is included the git-clone, git-fetch,
git-pull, and git-push man pages.

We could also include urls-remotes.txt in git-remote, though
that seems like a lot of text to add to yet another man
page.  Maybe a giturls.txt could be created and referenced
(as a further enhancement if someone is inclined).

Tangentially (and I don't know if it's worth fixing), while
poking around the documentation which includes urls.txt I
noticed that git-clone.txt refers readers to the "URLS
section below" when the name of the section is "GIT URLS".

I doubt any readers would be confused, but it would be
consistent with the other files which include urls.txt to
use "GIT URLS" as the referenced section name.

-- >& --
Subject: [PATCH] doc/clone: update caption for GIT URLS cross-reference

The description of the <repository> argument directs readers to "See the
URLS section below".  When generating HTML this becomes a link to the
"GIT URLS" section.  When reading the man page in a terminal, the
caption is slightly misleading.  Use "GIT URLS" as the caption to avoid
an confusion.

The man page produced by asciidoc doesn't include hyperlinks.  The
description of the <repository> argument simply

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-clone.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 42ca7b5095..b844b9957c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -260,7 +260,7 @@ or `--mirror` is given)
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
-	<<URLS,URLS>> section below for more information on specifying
+	<<URLS,GIT URLS>> section below for more information on specifying
 	repositories.
 
 <directory>::
-- 
2.17.0

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The ultimate result of shielding men from the effects of folly is to
fill the world with fools.
    -- Herbert Spencer

