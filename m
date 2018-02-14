Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2A61F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161757AbeBNSMw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:12:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52678 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161664AbeBNSMs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:12:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id j199so12284463wmj.2;
        Wed, 14 Feb 2018 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9ieVfPoNoT9MEys5knC+HMdjx8ZVwIu0pylRiRxzUEc=;
        b=IaoAmTkinu/s0a4SkIn3nThvR5kt33UewrQk/CcIC2FFYly9bzwyZNWkrYHbxHX6mY
         aRrbucBg7vqrZSCQlyzuP1fEJxn5rNeEgfLe0wvLUFIYhR24TE3r+4RG9o1tbcIM8V73
         4RATrSPdtwQL+XTqAHhgoxjPRNNS9aWxl5aUi6+nH2CmTcMsjPOH2WTiny8r6wcUNg0l
         XcjqIyphB0BnCCVqZjR7i6tNlRDyanVFyo1lxScw3q5/RBqYNZeIZP5xmnpbSSv502Pk
         JdrbE/9R5SgcUa6FKGk1cs5gSTGLb2ApQU/JARJHUNd8y/FEeIKNRcVKOyXaPMxUazm3
         gNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9ieVfPoNoT9MEys5knC+HMdjx8ZVwIu0pylRiRxzUEc=;
        b=qnDsQa6drh44nIf5H8DH/XfQa1q8YeFvdrocUgrLP7DetA+6yYevliPIWjRvFn40YF
         otiGd90vQE4c/KcBAytQLnh1taRZt2bN3wDWIGA3x2uLMIeOV+sLfTY+OvUeoYrNzCuM
         JXHZed0cYcIU3UKZQUt8XJOy1MRRry8afa+RntslqAywhWcJTeD+N34LHT8SNBlI3YVq
         2H5MsVfnELiIK4xYggvrJy36PhvqJxyNh3X1g68qGIrI/iMfdMkKYM86T28QjzUSmtgT
         tjp/Tfsz/5NOoyA9drTPi1wePH9s0dTkI19WIjn681qJIV98oRT5PBbaJw1DDlOUEulu
         0qAA==
X-Gm-Message-State: APf1xPB18A7vLDmlF+BCV33VvGcckAsf/YmcOa6EAAmG+hK0SCtyHGkr
        wydvj93zGEBqJGWciqqmNzw=
X-Google-Smtp-Source: AH8x227N6kJI4xBdlc31tnHh1qgMpVFrgK6NXMrM2LmwOki9dUw3tGuuljjR7gpv/c6mcmDIYLkO4Q==
X-Received: by 10.28.216.149 with SMTP id p143mr75292wmg.140.1518631965688;
        Wed, 14 Feb 2018 10:12:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z1sm13821131wre.25.2018.02.14.10.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 10:12:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
        <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
        <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
        <20180212222157.0a3bd472@vento.lan>
        <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxkYTeY9h=VHFXi=gbXsnsHCRMAVZ9=1_EsFGSqr0sj9g@mail.gmail.com>
Date:   Wed, 14 Feb 2018 10:12:44 -0800
In-Reply-To: <CA+55aFxkYTeY9h=VHFXi=gbXsnsHCRMAVZ9=1_EsFGSqr0sj9g@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 13 Feb 2018 09:33:02 -0800")
Message-ID: <xmqqfu63o2xv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Feb 13, 2018 at 9:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> That makes me wonder if another heuristic I floated earlier is more
>> appropriate.  When merging a tag object T, if refs/tags/T exists and
>> it is that tag object, then an updated "merge" would default to "--ff";
>> otherwise, it would keep the current default of creating a merge even
>> when we could fast-forward, in order to record that tag T in the
>> resulting history.
>
> Oooh. Yes, that sounds like the right thing to do.
>
> So the "no fast-forward" logic would trigger only if the name we used
> for merging is one of the temporary ones (ie .git/{FETCH,MERGE}_HEAD),
> not if the mentioned tag is already a normal tag reference.
>
> Then it's very explicitly about "don't lose the signing information".
>
> I'd still have to teach people to use "--only-ff" if they don't do the
> "fetch and merge" model but literally just do  "git pull upstream
> vX.Y", but at least the case Mauro describes would automatically just
> DTRT.
>
> Me likey.

The implementation cannot exactly be "did the user give FETCH_HEAD
or v4.16-rc1 from the command line?", because we'd want to catch it
when Mauro says "git fetch linus && git merge v4.16-rc1" and behave
identically as "git pull linus v4.16-rc1" (and the latter internally
gets turned into "git merge FETCH_HEAD").

So, instead, we read the "tag" line from the tag object to learn the
tagname T, see if refs/tags/T exists and points at that object, to
see if we are Mauro who follows your tags, or if we are you who
fetch and merge contributors' "for-linus" signed tag (which I am
assuming you won't contaminate your refs/tags/ hierarchy with).

There are a few fallouts in the testsuite if we go this route.  I am
not quite decided if I like the approach.

 builtin/merge.c          | 42 ++++++++++++++++++++++++++++++++++++++----
 t/t6200-fmt-merge-msg.sh |  2 +-
 t/t7600-merge.sh         |  2 +-
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..45c7916505 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -33,6 +33,7 @@
 #include "sequencer.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "tag.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -1125,6 +1126,42 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 	return remoteheads;
 }
 
+static int merging_a_throwaway_tag(struct commit *commit)
+{
+	const char *tag_ref;
+	struct object_id oid;
+
+	/* Are we merging a tag? */
+	if (!merge_remote_util(commit) ||
+	    !merge_remote_util(commit)->obj ||
+	    merge_remote_util(commit)->obj->type != OBJ_TAG)
+		return 0;
+
+	/*
+	 * Now we know we are merging a tag object.  Are we downstream
+	 * and following the tags from upstream?  If so, we must have
+	 * the tag object pointed at by "refs/tags/$T" where $T is the
+	 * tagname recorded in the tag object.  We want to allow such
+	 * a "just to catch up" merge to fast-forward.
+	 */
+	tag_ref = xstrfmt("refs/tags/%s",
+			  ((struct tag *)merge_remote_util(commit)->obj)->tag);
+
+	if (!read_ref(tag_ref, &oid) &&
+	    !oidcmp(&oid, &merge_remote_util(commit)->obj->oid))
+		return 0;
+
+	/*
+	 * Otherwise, we are playing an integrator's role, making a
+	 * merge with a throw-away tag from a contributor with
+	 * something like "git pull $contributor $signed_tag".
+	 * We want to forbid such a merge from fast-forwarding
+	 * by default; otherwise we would not keep the signature
+	 * anywhere.
+	 */
+	return 1;
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	struct object_id result_tree, stash, head_oid;
@@ -1322,10 +1359,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&commit->object.oid));
 		setenv(buf.buf, merge_remote_util(commit)->name, 1);
 		strbuf_reset(&buf);
-		if (fast_forward != FF_ONLY &&
-		    merge_remote_util(commit) &&
-		    merge_remote_util(commit)->obj &&
-		    merge_remote_util(commit)->obj->type == OBJ_TAG)
+		if (fast_forward != FF_ONLY && merging_a_throwaway_tag(commit))
 			fast_forward = FF_NO;
 	}
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 2e2fb0e957..a54a52aaa4 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -512,7 +512,7 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 
 	test_when_finished "git reset --hard" &&
 	annote=$(git rev-parse annote) &&
-	git merge --no-commit $annote &&
+	git merge --no-commit --no-ff $annote &&
 	{
 		cat <<-EOF
 		Merge tag '\''$annote'\''
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index dfde6a675a..28a1c43ca7 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -718,7 +718,7 @@ test_expect_success GPG 'merge --no-edit tag should skip editor' '
 	git tag -f -s -m "A newer commit" signed &&
 	git reset --hard c0 &&
 
-	EDITOR=false git merge --no-edit signed &&
+	EDITOR=false git merge --no-edit --no-ff signed &&
 	git rev-parse signed^0 >expect &&
 	git rev-parse HEAD^2 >actual &&
 	test_cmp expect actual



