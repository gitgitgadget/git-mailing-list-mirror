Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AA188917
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492862; cv=none; b=m2piRabLopMOiX8rV25O+vAdpPeL8ntY2xG/NKB7oIpLlDaEpW9G++DFILZNFmpS7I+7Y9b8tyGWlT8uULoPF4f/16eoNvZn/K4pnp13ub/Us0hb2/sC23mxkFh5AkwL0tUdH6KMAixEeP271XwuafAAq/z/EXegENTkZ9vH5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492862; c=relaxed/simple;
	bh=qIz/6lg66NWAh5Z0ehGK0TxBZO7osQM/0m0I6ZtJfRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cffEZbg4/KPSJs3NZzZxCCw/Nta1e/cBQmqTTHYTuwrajZwNv4psN2p4Bt2jaW0QWjuv6CNO1rCqzUopbc6V4tacy+eHB/v/gaGqyNmCQJ9TpU/wkboxyiiGU21sIdiLlKRqaiYZUviWK0sFZMl6xHvMuyy0p5f3+9GvIbqbTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=fmzvJgmR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=By+iQrCs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="fmzvJgmR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="By+iQrCs"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DAD111401D4;
	Wed,  9 Oct 2024 12:54:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 09 Oct 2024 12:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728492859; x=1728579259; bh=pck7MofyRALaisy4LzNgNbhGeBJZ9DnV
	jcRjJIPl8rI=; b=fmzvJgmRbRD+gRPJe2rLkGG+Ux9yPB1Z4fiLS8+5UOJequZt
	CT5dqBHaj1sp2c/YTGNuoUhOALjlKuXEUOznp726pkjpnJaVfjPM632TaRFUS8uf
	D4mn3JVpZ33mwbjOfJN4GoId4Z3VJ4dt33PrG2DELyUJABqamWFc8qgUliQhxwma
	Fvr6TLaMhMJKE3VfteB77ptx4uzSssJ+7HFUrkzetAZnCqXpRcJwNZzKz9K15RkX
	jq0UwSoVYxGiMjDOYFeTAMt597j1/X5HvC2KeTTQ6dfpRTSYx6LR/8yePWc7I3V1
	bfb1VJZkT7XrJXu9KYLmc8iadcsaTmsufvD8Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728492859; x=
	1728579259; bh=pck7MofyRALaisy4LzNgNbhGeBJZ9DnVjcRjJIPl8rI=; b=B
	y+iQrCsopFzsahC8Sb3OMN1k74VDE7jVHY1/k6Nm75lI3PCGfatNtWLzC+TGMZFk
	Xu9uUIusvjxucbRmrNzvzd7kkBMD9EAGcbXg2okLTRC6P68noGTwmtQfTqksggr1
	VYAit94nIDuyxohorsUolj/Zx34ujZy9vJyLsfHqhGt/RGO6VxIXvGzyniEYIIE3
	6K+NyeEz1tCWmRdj9Op+Bs+gxFeXJg31LAwlpDbOUg8c9Jtf/USNGOD7rwGx/xDE
	43WO8xgC4TSPRaJ/2V24kkLmCUXgG0B2C+yn4THVJaA/Qoer7vI/02dauTZaQdBO
	jup3LC1DOSsCws8dssrAw==
X-ME-Sender: <xms:OrUGZ8UHNZigdljcX6ZC82xPNItzSjJ-kbhUIdeoZRyufj1kqYrZtsA>
    <xme:OrUGZwlpIbv92uphco7A-NNkp6dEXmVUF4BrE7hjuUxcW5fdh3UGk_CbkHkfS0o_f
    tl4I84a3NyjD7a2kg>
X-ME-Received: <xmr:OrUGZwYnREv8HXcTSG0EMvEwQUHXsp5jfnE2AmOS5Y7TZ-Sdm-NWNxEYMhsi4_7y7mGjIdirYZLQtWAeLnem_AeExUrvHLxi8OAL806bDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeeg
    jeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OrUGZ7Vtf7numWkYQvgzDVWiotkUPaMwDXfyVztahlhJteroJhz7HA>
    <xmx:OrUGZ2kY8szg5qW7XWs8cMM0ouyNN7RaR9pmVM5p8ndEE5DsoxfQDA>
    <xmx:OrUGZwdXtdS5AzzVM8CFHy1gkcAC_UkjKtd4LtCaqZ2BG7XI0oam-Q>
    <xmx:OrUGZ4Hpdzx76ZftDX0nxN28xQcENSfnZASUcfdn-gLoitSmprTe1w>
    <xmx:O7UGZ0boNyCBeHUarClfJeKdMHKIZxMQ-Fx6CMX0PS1eAg5TXUcQD2ml>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 12:54:17 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	newren@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 0/1] doc: merge-tree: improve the script example
Date: Wed,  9 Oct 2024 18:53:44 +0200
Message-ID: <cover.1728492617.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728413450.git.code@khaugsbakk.name>
References: <cover.1728413450.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: c7e0d76e71eef56c6279e0f7e82a2d194f78d2a4
X-Previous-Commits: 4057d6386125e51fd934f92abd11c62a9d24a832 fef203471f4492af1468a0c91088324c394effd5 b1ca5cae76845f84147d385cc5ff47f219cd471e 13e0f3bed5dd894ee692c672b301697e0a909e04
Content-Transfer-Encoding: 8bit

§ Changes since v2

• Squash into one patch
• Use `vi message.txt` before `git commit-tree`
• Also declare the branches
  • Fully qualified for `BRANCH1` since it is passed to
    git-update-ref(1)

Kristoffer Haugsbakk (1):
  doc: merge-tree: improve example script

 Documentation/git-merge-tree.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Interdiff against v2:
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 41dfb16476d..0b6a8a19b1f 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -211,11 +211,14 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
 linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
 used as a part of a series of steps such as:
 
+       vi message.txt
+       BRANCH1=refs/heads/test
+       BRANCH2=main
        NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
            echo "There were conflicts..." 1>&2
            exit 1
        }
-       NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
+       NEWCOMMIT=$(git commit-tree $NEWTREE -F message.txt \
            -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
 
Range-diff against v2:
1:  b1ca5cae768 < -:  ----------- doc: merge-tree: provide a commit message
2:  13e0f3bed5d ! 1:  c7e0d76e71e doc: merge-tree: use || directly
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: merge-tree: use || directly
    +    doc: merge-tree: improve example script
     
    -    Use `||` directly since that is more straightforward than checking the
    -    last exit status.
    +    • Provide a commit message in the example command.
     
    -    Also use `echo` and `exit` since `die` is not defined.
    +      The command will hang since it is waiting for a commit message on
    +      stdin.  Which is usable but not straightforward enough since this is
    +      example code.
    +    • Use `||` directly since that is more straightforward than checking the
    +      last exit status.
    +
    +      Also use `echo` and `exit` since `die` is not defined.
    +    • Expose variable declarations.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    @@ Documentation/git-merge-tree.txt: linkgit:git-commit-tree[1], linkgit:git-write-
      
     -       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
     -       test $? -eq 0 || die "There were conflicts..."
    +-       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
    ++       vi message.txt
    ++       BRANCH1=refs/heads/test
    ++       BRANCH2=main
     +       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
     +           echo "There were conflicts..." 1>&2
     +           exit 1
     +       }
    -        NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
    -            -p $BRANCH1 -p $BRANCH2)
    ++       NEWCOMMIT=$(git commit-tree $NEWTREE -F message.txt \
    ++           -p $BRANCH1 -p $BRANCH2)
             git update-ref $BRANCH1 $NEWCOMMIT
    + 
    + Note that when the exit status is non-zero, `NEWTREE` in this sequence
-- 
2.46.1.641.g54e7913fcb6

