Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1408B1FCC7
	for <e@80x24.org>; Sun, 25 Dec 2016 23:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbcLYXt3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Dec 2016 18:49:29 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33566 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753757AbcLYXt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2016 18:49:28 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so46999101wjc.0
        for <git@vger.kernel.org>; Sun, 25 Dec 2016 15:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=T2G5i8+TbZC5X+BEBcWhmKBEbgdK6kt59e7f/s2qFNo=;
        b=jirPCs1gmN1bw47MYvB52AH3fLQhZcjJVcEzl5+ijhJ8kUIYYzzE3AM+Q0rJ4lkV+t
         6TL0wzdv8kxrwEzdtAUbwPGVRxv9u7sNazi/fl3IETdKNK4vAoijqnGRtMuiMkctfrJ6
         8CBZ+Ess3TrPvLiUnyLilIlFeLOrxJ+cDu2UBYLXFOMVXNubvP8KxX3beu/BHVlpL9ey
         yjqEy7TlQuGPhtm5YqKMwz/8A4kMuK+H4bvf0+JTtn/l1PQIv2tkMIM3SLYvqEADXz/n
         ObDEfvnRqVfBJadz4nOAXjEpAaLvpQslCT/p/GpUTM9tLjbtEzFE5SHqTMNXV3z0C1ZW
         rDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=T2G5i8+TbZC5X+BEBcWhmKBEbgdK6kt59e7f/s2qFNo=;
        b=G2Yf0nHc/7gepmGTKGLKZKHSwqS9leMtKAS8gvvlq1vCpfmUMfayADXAV30IYqHrsh
         A6jG661swj7oJImJC7IKYA3MQ2IBgp7+FY0WgoFEOtCyRY1SIDGzCS4QOVk7cwA/MO+3
         aRiwUmmVt1GYN9V52uoMysaWTs2WYPXOsO+IoPjSyjkPPP/4J+wWlskDWhX0LYGCFK3V
         g5M/R2OLWBebsQdfC7pY4y+UNHiMvQxbmWEtQzj3eOEbWmrNuGUR9GB7vtMQsdgFBQK7
         y0nFc0nu1upIuFfEpE/p7vfnB9eEyuBgKZpyUfv8RZooKE3MV6zRMVNnydDgDHMe850k
         HWuA==
X-Gm-Message-State: AIkVDXIXJKYGJ5o718wdLKFo02tR32uX5WvvE4foGip9XxS4styctKdqmD3LpKmx1f5jww==
X-Received: by 10.194.109.168 with SMTP id ht8mr21675087wjb.36.1482709766710;
        Sun, 25 Dec 2016 15:49:26 -0800 (PST)
Received: from [192.168.5.102] ([87.116.181.111])
        by smtp.gmail.com with ESMTPSA id yj10sm52366071wjb.3.2016.12.25.15.49.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Dec 2016 15:49:26 -0800 (PST)
X-Mozilla-News-Host: news://news.gmane.org:119
To:     git@vger.kernel.org
From:   Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Subject: git-apply: warn/fail on *changed* end of line (eol) *only*?
Message-ID: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com>
Date:   Mon, 26 Dec 2016 00:49:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi to all,

This is a follow-up of a message posted at git-users Google group[1],
as the topic may actually be better suited for this mailing list
instead. If needed, some elaboration on the context can be found there,
as well as a detailed example describing the motive for the question
itself (or directly here[2], second half of the message).

In short -- git-apply warns on applying the patch with CRLF line endings
(new), considered whitespace errors, even when previous hunk version
(old) has/had that very same CRLF line endings, too, so nothing actually
changed in this regards. Even worse, it happily applies a patch with LF
line endings (new) without any warning/hint, even though previous (old)
line endings were CRLF, thus effectively (and silently) breaking the
(previous) line endings.

I understand that what should be considered "correct" line endings can
be set explicitly (and should be communicated on the project level in
the first place), but would it make sense to have an additional
git-apply --whitespace option (like "warn-changed" and "error-changed",
or something) to warn/fail on *changed* end of line *only*, without any
further knowledge needed?

So not to have Git need to assume or know which line endings should be
considered "correct", nor to think/bother too much with it, but just to
warn/fail on actual line ending *change* (in comparison between old and
new part/hunk of the patch).

This seems more intuitive to me, and much more cross-platform
collaboration friendly, at least as an option, as one wouldn`t need to
think much about "correct" project/file line endings (which would still
be advised, anyway), but would be promptly warned about possibly
breaking previous/existing line endings, maybe even with an option to
keep those previous ones, or force the new ones... yet as I`m still new
around, I accept that I might be missing some bigger picture here :)

Thanks, BugA

P.S. I`m discussing git-apply and end-of-line handling here in
particular as that`s what I`m currently concerned with, and for the sake
of simplicity, but might be that whole thing could theoretically be
broadened to other Git tools (like git-diff) and whitespace (error)
handling in general, too (warn/fail only if actually introduced in new
hunk, not previously being present in the old one).
--
[1] https://groups.google.com/d/msg/git-users/9Os_48yJdn0/j9S_W7h-EAAJ
[2] https://groups.google.com/d/msg/git-users/9Os_48yJdn0/5S9Ja1fEEAAJ
