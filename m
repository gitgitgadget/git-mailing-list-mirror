Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E2213EDD
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414419; cv=none; b=D6V+pZahVRFGB2vyaQ0vO85UaUpoCfiUunow3CauEUKXNpTIdvNjCCoDDDcltbI79+1hAek6QfHnVqorAfstscZXzV4Tc34Qk0QarjMiC1ycE3ANZtdBClVFPMk1U8ij4LNs+xhKNrFuRSdXNZc+hu150MA8Y8KbB0hisdcU10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414419; c=relaxed/simple;
	bh=KVfmgfgb9412s5mkG3wMOT1JoiYiIaySnokMHiKlStY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8WayGipN7y/dROSC1ZVvS6gzAp2nGNBFZrcUXMe797Cb44QUGojF88jy7P0umQ+8hDPtYlzu5JqyqfRfkEaU8T0Vpl3WOIu3bYdGRVeGnZt50p7mgRoTrXvTxwegMSY1IX5ihP4trr9WwAkPoGzHenib6T8dtNl13VQdqtZBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=HhGoZnmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z29dmOWg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="HhGoZnmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z29dmOWg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A3FF1140171;
	Tue,  8 Oct 2024 15:06:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Oct 2024 15:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728414416; x=1728500816; bh=yOKkLhHEo+Qq4TBxsVLtmSVZt7Xiqhvm
	AB4DPoSC2jE=; b=HhGoZnmV1GtuahEhZnmL/K9CU9CQOEFyeV40mMSccPn1FkRD
	GUotD9Wo/E+FkTX/fDzD0Jydb6t3e09uX5bliyypzSJs8ZXwTFQFSwX01MgWo60L
	AjXvcun4vlbBe4Ym71FWCf9Xe1oUGLZZeWBf/NtYFcNRKwUxPh5nPZHivOM/RoHi
	Oqv+xKd75Ttjo4RW/hSw2sVy2+rRPsng3BkQs/ulLLsT2CP9PVIDkDBpOmSzAai2
	y5FLyLWOpfkxxA/ZhLWb5/SX0ATQGSi9UNxEq2rPsDj+XdSZ+9TyexzlxjHC+0lS
	aDL1k5fDpWSw1IFIulgxr6wFj7dLbchfWk5fIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728414416; x=
	1728500816; bh=yOKkLhHEo+Qq4TBxsVLtmSVZt7XiqhvmAB4DPoSC2jE=; b=Z
	29dmOWgBDg4cc++lJQ69oe5j/Dy8f0ENosLxc8hAI9byxIRIN57ih07SwWBC3F6k
	uFnsc0EwDhtYgKIHFCEamMU2EPb6yIEVAi8pt4KdQYOFkTaPphNDbBQPvUTkikwN
	lZ07h8p7o4Z3OQ99jxOX3aIP42FcWp7VR6wUVHqRnN37MpTzQvup91ame0exJCwz
	uFN6JP43/lbFRpL+3SSQIk7DcOeLFt4edHSpS4ivtqXEBOadhJn3ilALYrtYSCH6
	jpv0AUm3KG2BUYwQI8EF12xuwGuXqErFfD9zWJXY9qGNsfyQ2pwydTnGaG3EJvR+
	bF5lxyPxMXJk6zmmq2dzw==
X-ME-Sender: <xms:z4IFZ5YuM23BBHbVATwENiJk31lRVwwuFxqfftsiGB3WgPmG7Q4YprM>
    <xme:z4IFZwa248g1EZ4nj_qZZr4GTFZ4Qbr8PdX_Q8sWuCPo9BkOEG6xLqC2f2yvVHMNI
    _3ZrbB-BYhAANjBXA>
X-ME-Received: <xmr:z4IFZ788Zhegzp0d4C6Cqs5FuSxFf2D2x1JSlgcSLzmsbHU1pLeqcGnOeAhQmvyfcQH8xDWCFxeD9Z9Si3OVuPZhS7oVfugZA9R-DOkhm7mDhleH2ofa7SbNJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeeg
    jeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:z4IFZ3rjErh5mNXqumPFyIvLhB8xM7yLlhTZlCYQJo_LezyNQb_PRw>
    <xmx:z4IFZ0o7JhXgDITP0r8S1cf3EbykftnfVik3ghaY8xXozGAwQnkU4A>
    <xmx:z4IFZ9RWqq--AUvwnNJXJv8J96widbUdc_Exoq_EQbSB7-H9aV3hLA>
    <xmx:z4IFZ8oBlyupl4_ckTkIld53tAGjTQwmKIAGADTVDFziXfTLRDViiA>
    <xmx:0IIFZ9k_t3Wuk1DTt6eQOI0djpWL9_EpRSJj-c_R4HpBASpApRi-n4yc>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 15:06:54 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	newren@gmail.com
Subject: [PATCH v2 0/2] doc: merge-tree: improve the script example
Date: Tue,  8 Oct 2024 21:06:04 +0200
Message-ID: <cover.1728413450.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728298931.git.code@khaugsbakk.name>
References: <cover.1728298931.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 13e0f3bed5dd894ee692c672b301697e0a909e04
X-Previous-Commits: 4057d6386125e51fd934f92abd11c62a9d24a832
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

§ Changes since v1

Patches:

• v1 1: v2 1: use a file instead of `-mMerge` for the commit message
• v1 2: dropped (lower-case variables)
• v1 3: v2 2: no changes

Kristoffer Haugsbakk (2):
  doc: merge-tree: provide a commit message
  doc: merge-tree: use || directly

 Documentation/git-merge-tree.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 46091da022d..41dfb16476d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -211,14 +211,15 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
 linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
 used as a part of a series of steps such as:
 
-       newtree=$(git merge-tree --write-tree $branch1 $branch2) || {
+       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
            echo "There were conflicts..." 1>&2
            exit 1
        }
-       newcommit=$(git commit-tree $newtree -mMerge -p $branch1 -p $branch2)
-       git update-ref $branch1 $newcommit
+       NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
+           -p $BRANCH1 -p $BRANCH2)
+       git update-ref $BRANCH1 $NEWCOMMIT
 
-Note that when the exit status is non-zero, `newtree` in this sequence
+Note that when the exit status is non-zero, `NEWTREE` in this sequence
 will contain a lot more output than just a tree.
 
 For conflicts, the output includes the same information that you'd get
Range-diff against v1:
1:  6b05526c327 < -:  ----------- doc: merge-tree: provide a commit message
2:  7d4deaee6c4 ! 1:  b1ca5cae768 doc: merge-tree: use lower-case variables
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: merge-tree: use lower-case variables
    +    doc: merge-tree: provide a commit message
     
    -    This is easier to read.
    +    Provide a commit message in the example command.
    +
    +    The command will hang since it is waiting for a commit message on
    +    stdin.  Which is usable but not straightforward enough since this is
    +    example code.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    Unlike on some other manuals you probably won’t end up running these
    +    commands directly to test things out.  But you might end up copying and
    +    modifying it when playing around with the command.
    +
      ## Documentation/git-merge-tree.txt ##
    -@@ Documentation/git-merge-tree.txt: linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
    - linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
    - used as a part of a series of steps such as:
    +@@ Documentation/git-merge-tree.txt: used as a part of a series of steps such as:
      
    --       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
    -+       newtree=$(git merge-tree --write-tree $branch1 $branch2)
    +        NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
             test $? -eq 0 || die "There were conflicts..."
    --       NEWCOMMIT=$(git commit-tree $NEWTREE -mMerge -p $BRANCH1 -p $BRANCH2)
    --       git update-ref $BRANCH1 $NEWCOMMIT
    -+       newcommit=$(git commit-tree $newtree -mMerge -p $branch1 -p $branch2)
    -+       git update-ref $branch1 $newcommit
    - 
    --Note that when the exit status is non-zero, `NEWTREE` in this sequence
    -+Note that when the exit status is non-zero, `newtree` in this sequence
    - will contain a lot more output than just a tree.
    +-       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
    ++       NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
    ++           -p $BRANCH1 -p $BRANCH2)
    +        git update-ref $BRANCH1 $NEWCOMMIT
      
    - For conflicts, the output includes the same information that you'd get
    + Note that when the exit status is non-zero, `NEWTREE` in this sequence
3:  1b60dc810e3 ! 2:  13e0f3bed5d doc: merge-tree: use || directly
    @@ Documentation/git-merge-tree.txt: linkgit:git-commit-tree[1], linkgit:git-write-
      linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
      used as a part of a series of steps such as:
      
    --       newtree=$(git merge-tree --write-tree $branch1 $branch2)
    +-       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
     -       test $? -eq 0 || die "There were conflicts..."
    -+       newtree=$(git merge-tree --write-tree $branch1 $branch2) || {
    ++       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
     +           echo "There were conflicts..." 1>&2
     +           exit 1
     +       }
    -        newcommit=$(git commit-tree $newtree -mMerge -p $branch1 -p $branch2)
    -        git update-ref $branch1 $newcommit
    - 
    +        NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
    +            -p $BRANCH1 -p $BRANCH2)
    +        git update-ref $BRANCH1 $NEWCOMMIT
-- 
2.46.1.641.g54e7913fcb6

