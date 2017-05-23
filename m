Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D7620281
	for <e@80x24.org>; Tue, 23 May 2017 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031386AbdEWWIc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 18:08:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35158 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968426AbdEWWI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 18:08:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so30216976pfd.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6G3o2h4bE5fkqOw54/hG3GBntnNOH5QXjVg9mhPbG9M=;
        b=AHJsG1cZbxda0JZfuR63jdx8+nK9Zz1KWVmVpPOxa4E0AnvSjKXd/9zYxiT16dt3qm
         bIMAXJ32b5ozzkG2hgbkYFzxCSa1OksFlixtYHjRUHpQkGlfYmKyFeQBYPRbm2y1AgLb
         g2K+fLo2UgT7SquCXl5dNNTPMvW3h/PRZWyRNshpv0QRpvxmU2KTSXaYUq7k/zAnh7St
         dKfxZ+jyBxAW4YMkTTsZSnQED2sNNhuf1kaTdjPUvgqeE5W80WAJp1sjqZG1aWB8G+pi
         Plylf6+XGf2sYrqYmGqgaEBHqZXq0XGUMTpktP7XICcR8B6o6ISYqL9Qv1j6EC5YTRdD
         F6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6G3o2h4bE5fkqOw54/hG3GBntnNOH5QXjVg9mhPbG9M=;
        b=RWBUD930ZlDRxn2+235orFTkrgoYvh15ARy+/UtwMGVOA5zSqGaNdvUjbWO4GBiwtp
         69F5K+L1hFuIf6G67SGS/GH0gajkPAcbM7JDUULPYvCOXX6pbAW4/8eu/VCv7ljbVT64
         URflV5meLTLY6jcQuile+bdkPoDpKtdposzXyP9zMcf+iIsDi7QVsjhbl+pqLHGrBq4K
         bkLAr7CkiWKHyiQs9MSwPBj4fxJu/M29dgX2gpRrORpPK0UHhYvmPvgDz/BeQdoSpeil
         GvcfRlISZwzCH1P+18+cNaoTMEKnG36LH+8P4qzWhHt9lGT0C3ZjtpuHnmN37L9r3qdi
         j5Ng==
X-Gm-Message-State: AODbwcDSs2kP4FtAZnwhSZx5xf9F+IzllpVnG1gThQ/jzS3HIRQYNAUk
        31ZSyq2hvTcAOA==
X-Received: by 10.98.18.157 with SMTP id 29mr33558371pfs.75.1495577307664;
        Tue, 23 May 2017 15:08:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id l186sm3428299pgd.42.2017.05.23.15.08.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 15:08:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, stefan.naewe@atlas-elektronik.com,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows paths
References: <cover.1495261020.git.j6t@kdbg.org>
        <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
        <alpine.DEB.2.21.1.1705221600100.3610@virtualbox>
        <1542d54f-d530-b60d-3270-d9b4e94c814d@kdbg.org>
        <alpine.DEB.2.21.1.1705231245300.3610@virtualbox>
Date:   Wed, 24 May 2017 07:08:24 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705231245300.3610@virtualbox> (Johannes
        Schindelin's message of "Tue, 23 May 2017 12:46:24 +0200 (CEST)")
Message-ID: <xmqqinkrjkfb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In this case, the warning occurs because I build with nd/fopen-errors.
>
> Ah. So the base commit Junio chose for your v1 is completely
> inappropriate. It should be nd/fopen-errors instead.

Actuallly, Hannes's patch text and problem description are
confusingly inconsistent, and I have to say that the above statement
is wrong---do not react to this statement just yet, because I'll
also say "but you are right" real soon.

Because "git fetch a/b" your UNIXy friends run will not consider
"a/b" as a remote nickname, "a\b" in "git fetch a\b" Windows folks
run must not be taken as a remote nickname either.  That is a
justification enough for Hannes's patch text, and that does not
change whether we take nd/fopen-errors or discard it.  So in that
sense, the patch text does not have anything to do with the other
topic.

But you are right (as promised ;-) to say that nd/fopen-errors needs
a bit more polishing to work correctly on Windows.  I unfortunately
do not think Hannes's patch addresses the real issue.  

Isn't the root cause of "Invalid argument" a colon in a (mistakenly
identified) remote nickname, not a backslash?  I doubt that it would
help to loosen valid_remote_nick() to pay attention to backslashes.
Surely, it may hide the issue when the path also has a backslash,
but wouldn't Windows folks see the same warning for "git fetch c:c"
for example even with Hannes's patch?

We use the pattern "try to open a path, and treat a failure to open
as indicating that the path is missing (and take information we
would have obtained from the contents of the path, if existed, from
elsewhere, as necessary)" pretty much everywhere, not just when
accessing a remote.  And nd/fopen-errors tries to tweak the "treat a
failure to open as a sign of missing path" to be a bit more careful
by warning unless the error we get is ENOENT or ENOTDIR (otherwise
we may treat a file that exists but cannot be read as if it is
missing without any indication).

The solution for the problem Hannes's proposed log message describes
lies in warn_on_fopen_errors() function that was introduced in the
nd/fopen-errors topic.  It appears that in Windows port, open() and
fopen() return EINVAL for a file that does not exist and whose name
Windows does not like, so we probably should do something like the
attached to work around the EINVAL (I do not know about the symbol
checked for #ifdef---there may be a more appropriate one).

I am not entirely happy with the workaround, because I do not know
if EINVAL can come _ONLY_ due to a colon in the pathname on Windows,
or if there are some other cases that deserve to be warned that also
yield EINVAL, and the attached will sweep the problem under the rug
for the "other cases", partially undoing what nd/fopen-errors topic
wanted to do.  But it does not make it worse than before the topic
happened [*1*].

And that kind of solution does belong to nd/fopen-errors.

So in short:

 (1) Hannes's patches are good, but they solve a problem that is
     different from what their log messages say; the log message
     needs to be updated;

 (2) In nd/fopen-errors topic, we need a new patch that deals with
     EINVAL on Windows.

Thanks.


[Footnote]

*1* An alternative that may allow us to avoid sweeping the issue
    under the rug may be to have a more precise logic to see if the
    open failure is due to missing file in the implementation of
    open() and fopen() emulation---at that level, the logic can be
    built with more platform knowledge (e.g. EINVAL?  Let's see what
    path we got---ah, there is a colon)---and turn EINVAL into
    ENOENT, or something like that.  I do not have a strong opinion
    if that is a better solution or the attached workaround is good
    enough.

 wrapper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 6e513c904a..7b6d3e3f94 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -418,9 +418,18 @@ FILE *fopen_for_writing(const char *path)
 	return ret;
 }
 
+static int is_an_error_for_missing_path(int no)
+{
+#if WINDOWS
+	if (errno == EINVAL)
+		return 1;
+#endif
+	return (errno == ENOENT || errno == ENOTDIR);
+}
+
 int warn_on_fopen_errors(const char *path)
 {
-	if (errno != ENOENT && errno != ENOTDIR) {
+	if (!is_error_for_missing_path(errno)) {
 		warn_on_inaccessible(path);
 		return -1;
 	}

