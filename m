Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E9A202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 16:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbdGIQly (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 12:41:54 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35734 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIQlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 12:41:53 -0400
Received: by mail-pg0-f49.google.com with SMTP id j186so37983600pge.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=O1pV7L+GEb4tHKMqnI3PDjhuuxJcj+O7JMRBucqkicI=;
        b=answ4FO7AyyQHPOynBIIZo1zpLoHLmD8W4SjXIKgDdTTYM01Ylh4jS9BJApKqG9Pbw
         t6/0ctG2N4/XRkN+50E8NyQ19ArHUgABtFC7hLJlUSuHRHVA0YsnlTNOph3lBMzEyo/1
         gSbHWIobEuy14eScuHO3lWJlRw7UniCG71TgC/bHwDED1YbIqb1qo6CmXiopIIwMpTj5
         OFyzBNN/CAErbIRDnd8nVC4NydH3mqfIvrBzvwqp4zdwsgOXqM+tP4cDaGdMc86MbQrh
         SQQWhowLC/ukj3yGkJdEhoUSWS1YYETrCM62unvJxNq/yRHVPdUIVbyVDRYzEqjjLJD1
         ZfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=O1pV7L+GEb4tHKMqnI3PDjhuuxJcj+O7JMRBucqkicI=;
        b=TaWV9xWOAZXz+Ugd5SUSGpv2nFYaJ4GXovQarTE4dXGGECRw2/r1SaFmh6DKejb2Mb
         8Bc20sbRCow6/WB61r/q5XcxFzlhqFUplx0/1cbXnv/4Gb0jgl9az0rQZLr1GTA6Evrl
         nBw8mAErNq6PAHynCnaxZSBOfz780G7M1gGzgSOMVvqzO41Y2PbT8NKDJn0fFfSrIsZO
         krfzwk2D6Yy56/2FaIUGe63PpI5F3ffB7Cf5M7R9QvHdrK7lBdIOFYA+Npruw0itBr8Z
         lfyv+At+IlsHVXP4/izu2lJOhKzkjesCQ6tYEa+I1/+eJyrlhS/kzrGU9n0M32RJmkPm
         GJWg==
X-Gm-Message-State: AIVw112whE7XyLlhMtVBILZPTanIiWnZCv677peASHloePV9UQ9Oi4s4
        VLkUaUOTCrVzcs26JLU=
X-Received: by 10.99.159.1 with SMTP id g1mr10672542pge.255.1499618512993;
        Sun, 09 Jul 2017 09:41:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id v17sm23900652pgn.4.2017.07.09.09.41.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 09:41:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] sha1_file: add slash once in for_each_file_in_obj_subdir()
References: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
        <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net>
Date:   Sun, 09 Jul 2017 09:41:51 -0700
In-Reply-To: <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 9 Jul 2017 07:00:17 -0400")
Message-ID: <xmqqy3rx8svk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jul 08, 2017 at 10:59:06AM +0200, René Scharfe wrote:
>
>> Add the slash between loose object subdirectory and file name just once
>> outside the loop instead of overwriting it with each readdir call.
>> Redefine baselen as the length with that slash, and add dirlen for the
>> length without it.  The result is slightly less wasteful and can use the
>> the cheaper strbuf_addstr instead of strbuf_addf without losing clarity.
>
> This patch looks correct to me.
>
> I'm a little lukewarm on it overall, though. I'd be shocked if the
> efficiency change is measurable. What I really care about is whether the
> result is easier to read or not.
>
> On the plus side, this moves an invariant out of the loop. On the minus
> side, it has to introduce an extra variable for "length we add on to"
> versus "dir length to pass to the subdir_cb". That's not rocket science,
> but it does slightly complicate things (though I note we already have
> "origlen", so this is bumping us from 2 to 3 length variables, not 1 to
> 2).
>
> So I dunno. It's fine with me if we take it, and fine if we leave it.

Unlike origlen, base vs dir lengths are not strictly needed; we
prepare the base including '/', and we know we always have just one
'/' at the end, so anybody that uses dirlen to truncate it back to
the original before passing it down can truncate to (baselen-1), no?

In other words, something like this (not an incremental but a
replacement) to keep calling "baselen" the length of the leading
constant part we append to?

 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5862386cd0..d277b32bf1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3760,7 +3760,6 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	origlen = path->len;
 	strbuf_complete(path, '/');
 	strbuf_addf(path, "%02x", subdir_nr);
-	baselen = path->len;
 
 	dir = opendir(path->buf);
 	if (!dir) {
@@ -3770,12 +3769,15 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		return r;
 	}
 
+	strbuf_addch(path, '/');
+	baselen = path->len;
+
 	while ((de = readdir(dir))) {
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
 		strbuf_setlen(path, baselen);
-		strbuf_addf(path, "/%s", de->d_name);
+		strbuf_addstr(path, de->d_name);
 
 		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2)  {
 			char hex[GIT_MAX_HEXSZ+1];
@@ -3801,7 +3803,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	}
 	closedir(dir);
 
-	strbuf_setlen(path, baselen);
+	strbuf_setlen(path, baselen - 1); /* chomp the '/' that we added */
 	if (!r && subdir_cb)
 		r = subdir_cb(subdir_nr, path->buf, data);
 

