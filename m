Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB9E201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 19:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbdBUTc6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 14:32:58 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36396 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdBUTc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 14:32:56 -0500
Received: by mail-pg0-f67.google.com with SMTP id z128so919287pgb.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 11:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mTtsIhjBOeWYGs6+QO790nXwZXB1vFXyz6r48NYjpqc=;
        b=Sg/s7f2Zgl5oZZ8ZnbvG8cNfRMjNdqKxOQ5cpvQ/TguCJCk5qj2r7Sn8ipv+WB5YXE
         xiPHxVsYAN79FhvHpN3hw1PvQT2Hi3BLcc6LPiHdr8xcB3BolaexAoD5Q+YUP+tMjyJh
         3Ils/Qnt+wn/2chHQoP0NcD2GsFeDlfd7bhoXpfgH0JXfgJ7JUyCdtgibcyUn8hwKDTv
         BRXdJUHWMOJwaZ/rw1FvFeZmZc087t5gYgMppzfxRqoQRD17r/KUlhIwSrf7pAsphxvG
         Rig1ZZZY9bVCOccThXUVLxU5SgJsaeakWxG2lbgr0BZhKp3OPQWL9fTaMsSh2zEqK9aa
         WbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mTtsIhjBOeWYGs6+QO790nXwZXB1vFXyz6r48NYjpqc=;
        b=HXnrXXItnkrCND5n45pjRs7D/PcYbTxKGkcd2d5dnuO+hK2YjQV2+ky8uhzWvZA6hi
         EYP/2JIQIFwLcofpsBhd60JNqnHze9Xp4hSWei0rAwmMsL6wD+v2hr1l/PESk7LikEBJ
         IgNXFU87WFIUUa5itT0ZEoIb2j1xfe8IJ40bLBQdWMUaepoBDj5ag5VhL0M9Yi3pL9TF
         An3rVOcyjiTqxmng7kVhGbjVI1pVsxDPhz0PBDRei/BzuMNI7rRWAWDjCser8Z0Q8Kgw
         Gn73U0SvrxF3GN+50I1iPaN0VxOp8MiCdHhtx2cmuzISTyM0F6LFztiSDGsKAUJzRfda
         vpHg==
X-Gm-Message-State: AMke39mMX/w0rBqN3yCHD19/2cU4YzPSgFT98pSXg4msQza5TqduoAQGNv9klycuqAwnHQ==
X-Received: by 10.99.122.2 with SMTP id v2mr21366630pgc.31.1487705575594;
        Tue, 21 Feb 2017 11:32:55 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id r74sm42410572pfb.67.2017.02.21.11.32.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 11:32:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ross Lagerwall <rosslagerwall@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: Ignore failure to remove missing branch.<name>.merge
References: <20170218002341.23099-1-rosslagerwall@gmail.com>
Date:   Tue, 21 Feb 2017 11:32:54 -0800
In-Reply-To: <20170218002341.23099-1-rosslagerwall@gmail.com> (Ross
        Lagerwall's message of "Sat, 18 Feb 2017 00:23:41 +0000")
Message-ID: <xmqqtw7nfift.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ross Lagerwall <rosslagerwall@gmail.com> writes:

> If a branch is configured with a default remote but no
> branch.<name>.merge and then the remote is removed, git fails to remove
> the remote with:
> "fatal: could not unset 'branch.<name>.merge'"
>
> Instead, ignore this since it is not an error and shouldn't prevent the
> remote from being removed.
>
> Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
> ---

I was waiting for others to comment on this patch but nobody seems
to be interested.  Which is a bit sad, because except for minor
nits, this patch is very well done.

The explanation of the motivation and solution in the proposed log
message is excellent.  It would have been perfect if you described
HOW you get into a state where branch.<name>.remote is pointing at
the remote being removed, without having branch.<name>.merge in the
first place, but even if such a state is invalid or unplausible,
removing the remote should be a usable way to recover from such a
situation.

And the proposed solution in the diff seems to correctly implement
what the description of the solution in the log message (modulo a
minor nit).

>  builtin/remote.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index e52cf3925..5dd22c2eb 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -769,7 +769,9 @@ static int rm(int argc, const char **argv)
>  				strbuf_reset(&buf);
>  				strbuf_addf(&buf, "branch.%s.%s",
>  						item->string, *k);
> -				git_config_set(buf.buf, NULL);
> +				result = git_config_set_gently(buf.buf, NULL);
> +				if (result && result != CONFIG_NOTHING_SET)
> +					die(_("COULd not unset '%s'"), buf.buf);

With s/COUL/coul/, the result would be more in line with our
existing practice.

>  			}
>  		}
>  	}

We do want an additional test so that this fix will not be broken
again in the future by mistake, perhaps in t5505.

As it is unclear to me how you got into a state where branch.*.remote
exists without branch.*.merge, the attached patch to the test manually
removes it, which probably falls into a "deliberate sabotage" category.
If there are a valid sequence of operations that leads to such a state
without being a deliberate sabotage, we should use it instead in the
real test.

Thanks.

 builtin/remote.c  |  4 +++-
 t/t5505-remote.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index e52cf3925b..01055b7272 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -769,7 +769,9 @@ static int rm(int argc, const char **argv)
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				git_config_set(buf.buf, NULL);
+				result = git_config_set_gently(buf.buf, NULL);
+				if (result && result != CONFIG_NOTHING_SET)
+					die(_("could not unset '%s'"), buf.buf);
 			}
 		}
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8198d8eb05..af85a624fc 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -153,6 +153,25 @@ test_expect_success 'remove errors out early when deleting non-existent branch'
 	)
 '
 
+test_expect_success 'remove remote with a branch without configured merge' '
+	test_when_finished "(
+		git -C test checkout master;
+		git -C test branch -D two;
+		git -C test config --remove-section remote.two;
+		git -C test config --remove-section branch.second;
+		true
+	)" &&
+	(
+		cd test &&
+		git remote add two ../two &&
+		git fetch two &&
+		git checkout -t -b second two/master &&
+		git checkout master &&
+		git config --unset branch.second.merge &&
+		git remote rm two
+	)
+'
+
 test_expect_success 'rename errors out early when deleting non-existent branch' '
 	(
 		cd test &&

