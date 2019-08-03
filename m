Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604961F731
	for <e@80x24.org>; Sat,  3 Aug 2019 08:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbfHCIbm (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 04:31:42 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42358 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbfHCIbm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 04:31:42 -0400
Received: by mail-qt1-f175.google.com with SMTP id h18so76402579qtm.9
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BVPAlLpzPXgoEZip8dn/qmYnUPckj2Yr6eSnnllDwkA=;
        b=OELdFlLTILDs2/RqsBDsauBCyzEd6cGvetO8LUxvs/1ePbpiQNeV30fvXfG0AZzrQT
         sjPpV2r9yGbjuD7cidFapgoSy2/s4odTRt56jlqEnbBjsLsYplxmPkeW43s2fAaUMr3U
         VWuRn+FNM6Us1YNoGCujvmKRRD7Fi6t8HpjxdnNwIR0TMub8XQRFziiKUxodwams8E/5
         e9mPvw12YcoADQZX5VHB68+Z91BwLSugK7WGIDaDIx2V7mM30X38bvhfaKuhBLCB0GRd
         xdbiH31LxAZ7cO73dktVhNoYMRVl7i2s8HuWJl+3aNpmiidOjikctrNZTf2KoVs/ymz8
         Qgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BVPAlLpzPXgoEZip8dn/qmYnUPckj2Yr6eSnnllDwkA=;
        b=FJPYBgs0ucqOax3I08g5xArAz1+yDgCdb25X/U5cXlCRZBmYEjupj16bWbiTeXNHZK
         c0hsqNrWh9rlvBanK8jVHxqysSomXADIu56ifjn2Jj7/TT+rHaZSXJC8k034cF/baEep
         6dHXBe4dUXRWrBPxsohNiezYhwOxl97m+aJaLMiU24+/xEUlJswu/VBz3pE0TfEKEuG/
         G3OYoRHydagl472QyijcfbGxZTzgFAbWJOkgsKc30JFq5Ki338xEhAHVYB3qplDuF+6S
         NsePm/fBkf/8r9WdZz96RCqUCgin2RjdHT/rn9FVoHknPPn0bDTiL/UdueDYgJzLzHOF
         ix9A==
X-Gm-Message-State: APjAAAUtgKsTnHx5jprA6DhaBroskIJ7abzZu2OJzONPu4AC0RcCGigI
        6grLQSAOY5eT9/QlS4sja+z8oeq/a0FpkKfj/24=
X-Google-Smtp-Source: APXvYqxrTrTKZA2YKqRFKN45vSEHXofUXPuUNQYeoVZ1LlC33F31yE85xo4h5GCiasiKx5QkOEWlk0IQBhb7W4IxHZo=
X-Received: by 2002:ad4:490c:: with SMTP id bh12mr3536975qvb.59.1564821101183;
 Sat, 03 Aug 2019 01:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01Csp=g08N4+S1HKAjV2a12VJNSJU0UYdAU6LW1jGWLD9SLQ@mail.gmail.com>
 <05c77291-48d1-a592-6296-d8a8bdb16b02@gmail.com> <CAA01CspHCKA3itmTxFO1NeNB6DpdFx3CTbXKtO=TvtznLn_zAg@mail.gmail.com>
 <xmqqtvazjrcj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvazjrcj.fsf@gitster-ct.c.googlers.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Sat, 3 Aug 2019 10:31:28 +0200
Message-ID: <CAA01CspYgcBwGsJhD3n1u7kDUy+wtjoY7bimqg7C2P3DojhfhQ@mail.gmail.com>
Subject: Re: git-log on a file, and merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 2, 2019 at 9:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
> > At this moment I'm not sure myself if I consider this a bug or not.
>
> This definitely is not a bug but is a designed and intended
> behaviour.

(generally speaking)
By "bug" I mean wrong behaviour. Designs can be buggy too.


> Think of running "git log" without "--full-history" that is limited
> with a pathspec as a tool to ask Git to show _one_ way (preferrably
> the simplest one) to explain how the current contents in paths that
> match the pathspec came to be.  The "just explain to me one way" is
> not about machine performance but reducing the clutter in the output
> to help human reader(s) reading an otherwise complex history.

From this point of view, the current behavior is good.

Although it's inconsistent. It works only for merges. If I'm on one
branch and change a file and then revert the change, "git log -- file"
will still show the commits. From your explanation, I'd expect those
commits to be skipped, since they are "no-op".


Also, I did read git-log docs before posting here, but still could not
find clear explanation for this behavior. Is it possible to improve
docs?

For example:

    [--] <path>=E2=80=A6
    Show only commits that are enough to explain how the files that
match the specified paths came to be. See History Simplification below
for details and other simplification modes.

For me, the commits which modify the file are relevant to "how the
file come to be". They show what was tried and that finally the
original solution was choosen as the best. So not showing them is not
"enough to explain".
Also "History Simplification" is not very clear.

So maybe something like this? (just a rfc)


diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b406bc4c48..bfb3d68b8b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -91,9 +91,10 @@ include::line-range-format.txt[]
        section of linkgit:gitrevisions[7].

 [--] <path>...::
        Show only commits that are enough to explain how the files
-       that match the specified paths came to be.  See 'History
+       that match the specified paths came to be. Some commits may be
+       not shown even if they modify the specified paths. See 'History
        Simplification' below for details and other simplification
        modes.
 +
 Paths may need to be prefixed with `--` to separate them from
diff --git a/Documentation/rev-list-options.txt
b/Documentation/rev-list-options.txt
index bb1251c036..d2de33b219 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -317,13 +317,15 @@ endif::git-rev-list[]
 History Simplification
 ~~~~~~~~~~~~~~~~~~~~~~

 Sometimes you are only interested in parts of the history, for example the
-commits modifying a particular <path>. But there are two parts of
-'History Simplification', one part is selecting the commits and the other
-is how to do it, as there are various strategies to simplify the history.
+commits modifying a particular <path>. This is a two-step process:

-The following options select the commits to be shown:
+* initialial list of commits is selected
+
+* the list is simplified - some commits may be not shown
+
+The following options select the initial list of commits:

 <paths>::
        Commits modifying the given <paths> are selected.

@@ -337,9 +339,11 @@ The following options affect the way the
simplification is performed:
 Default mode::
        Simplifies the history to the simplest history explaining the
        final state of the tree. Simplest because it prunes some side
        branches if the end result is the same (i.e. merging branches
-       with the same content)
+       with the same content). This may happen for example when there
+       were commits which changed files, but then those changes were
+       reverted. Such commits will not be shown.

 --full-history::
        Same as the default mode, but does not prune some history.


--=20
Piotr Krukowiecki
