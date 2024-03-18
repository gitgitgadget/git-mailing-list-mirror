Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67354BF6
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781422; cv=none; b=GTxiS7JeyJT+RGtI+k9PDUG5VIZr+rk43xCcS+gr7q/LqbhrbzjdhbLqfAoF9HSgrzco7D0LtuKj+s76HB4Upi5Xa1tApjfvB477TtErghrOREJj8yOUr1YhdgNUryUodoFyb1gwNXB3IGP/upzLGBo6p4IsSp1Vawwn8sYkvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781422; c=relaxed/simple;
	bh=AHBowRYgbrg+h2/DufZ7l8Y156NoQa794a4zBYDqFco=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXTnKuOoBB5kJm58YsTLUZWuInVYZI+mPt87qYiZ/wjSTACzRJ83HNOpyxl5RagmYlpLGiLBB+lplW1b1y7dPHjPmcioH1QzL13N1b+0pkaN04/QnOrMjrHF2c+4af8ikix+dTFJ6QbMwmvrjAzHQde3s7O8AAlKdSXgmE8ZvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=W+ZOLZ4Y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="W+ZOLZ4Y"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710781411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5Tk76wSZvstfGUSWSZpIRxUUmpIAS1XYiR5Na3jlYc=;
	b=W+ZOLZ4YfhEdE1VWTnn67Rw5kIMiS3OorWTK2zVMNAd2J0GlP1XZhLxnyHXx8402eWRBbx
	DLIVVAEf+hPteL3iWDDekk7mNKeQqKaGuUWSSQRVmCuVKX9u8WjAUebjckzH3Z/Bb40CUw
	wxVh1MwHhDD2mqF87C/F2U8cYcpAzXNFijcqiR/ukOWcWtlsZLa9zyFJkJY8O+HAkP8Ssb
	YAkKMoSauA3xwKVx3ZsLlxev9hVFBm2m8STS8CNehS9wA/x+tANMRDqZ+LqiYUo4qDhHxT
	InUxpV25XLXctPjbw0KkdwQ1zwWYy/nMsuAyaM6RveRFtJ6h0KvOLaQgrDTUPw==
To: git@vger.kernel.org
Subject: [PATCH 2/5] grep docs: describe --recurse-submodules further and improve formatting a bit
Date: Mon, 18 Mar 2024 18:03:22 +0100
Message-Id: <784912a8d9156fa00ddee218fd600254d7bab160.1710781235.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710781235.git.dsimic@manjaro.org>
References: <cover.1710781235.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Clarify that --recurse-submodules cannot be used together with --untracked,
and improve the formatting in a couple of places, to make it visually clear
that those are the commands or the names of configuration options.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/config/grep.txt | 2 +-
 Documentation/git-grep.txt    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index e521f20390ce..10041f27b0c8 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -24,5 +24,5 @@ grep.fullName::
 	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
+	If set to true, fall back to `git grep --no-index` if `git grep`
 	is executed outside of a git repository.  Defaults to false.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 0d0103c780af..ade69f00ebdd 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -65,8 +65,8 @@ OPTIONS
 	Recursively search in each submodule that is active and
 	checked out in the repository.  When used in combination with the
 	<tree> option the prefix of all submodule output will be the name of
-	the parent project's <tree> object. This option has no effect
-	if `--no-index` is given.
+	the parent project's <tree> object.  This option cannot be used together
+	with `--untracked`, and it has no effect if `--no-index` is specified.
 
 -a::
 --text::
@@ -178,7 +178,7 @@ providing this option will cause it to die.
 	Use \0 as the delimiter for pathnames in the output, and print
 	them verbatim. Without this option, pathnames with "unusual"
 	characters are quoted as explained for the configuration
-	variable core.quotePath (see linkgit:git-config[1]).
+	variable `core.quotePath` (see linkgit:git-config[1]).
 
 -o::
 --only-matching::
