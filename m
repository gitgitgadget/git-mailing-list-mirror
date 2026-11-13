Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576610;
	b=TM3hIANcE3TxW+5lpjleT11LIdZRJhgsmEwCgJ8RPut4ICQmg70zZ2BJ9Wnw/xW1VtQf
	 UYuZjJg31yLMCCejkoWQoLrG8WXPxxrw8AJrfHBIlrRUQ76w8t/qlhccPARdkspj3rdU0
	 onH9/6kyfQu6xAe54MhoOgTocP5iY+qKQGZPVrMUZBtl7DDY6q4f9YN+pDvdg+s6MopXV
	 /bPi/ru4QxToIuzkJ/vMnh3UdifidaEJ+t2MW6v0nMBDLxmwZaMDchDdWvZGCw21xbYrc
	 hPlj+Mv/euoMpz7RzYj/5LlLUkp9IeuZq7WVSaWX12O975/K9e08jGRcPJzjtXp0Xvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=bR9NMNCBf4ATs5CLmd99M6HNx7u+I77aVIH25ccvLcs=;
	b=SqdrKWWh3LVNo9N4YsyZcwDKMQoKhXjF1lihjiP4rhxx0kDvNa1NWvLWpX9qsP1fTFN2
	 G2KqUOyUnGqzuvBKyyEla/dW2wkXKYSQlKHjhC/Xbf7CwSFApKDrVaujZAQyG2w3Z3hzW
	 Hm8fzPixi566JeEKQnT/jvs6FeapoAr0aY+/sIG0eAzC6NLvqWjNJEzBnYkBbKjJUwqz5
	 o1q1oUQp1YonNXSag/dlWvKguIH4Luy7+WLNXxsfqYhFdmTclbLQltFEbQVOuJ2G2ASvL
	 CL0WIWK5GLP/9+Pahod3SxNpAyCUdpDLbfN4f52l900ZcU7EVhw4/4HtBovKmjRFdQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPDJtpdp;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7F606ABAE
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B7F606ABAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPDJtpdp
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso21885236d6.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576608; x=1795181408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bR9NMNCBf4ATs5CLmd99M6HNx7u+I77aVIH25ccvLcs=;
        b=tPDJtpdpZ89TvoeA5I094EGGr+r8NtmjVmjAHm4Hz5IAndhz99BltlzCltPa8nOnln
         O5IE6egE4VSCmdtIgzOmw2NugozjT9yks2H/dSdchKEAf1AN1qOyvujJI0Co2sTdALRr
         NhOhGnJ6OWZGhyi6+I7Eo9hH/Bg0O/6BkuFFohhR51GZk+kwpsxrpIEmPlw8EmaR2wLa
         YVCJwZk+RYKdX4XdYUmxfGOkyWHyVd4DOPbemE5n44elmwkWwm/KJCa2QIrnga7gvsDX
         OnniDRydRbcNlqYK0wU/qDuOzu6YmKgRCASz44MhT2KhnxZwHETJ99u0XaAuvQq/JRfo
         omgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576608; x=1795181408;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bR9NMNCBf4ATs5CLmd99M6HNx7u+I77aVIH25ccvLcs=;
        b=am5MpREHfFqVHdleLPMwpeh/+xKomjei/+2AuAC6d61npt1PK4+4JffGptECmc2lUe
         UezoEERCdL2AqDY+tL8e8sh0uq7w2/Q1fqcN8MUfpJuo2obKG18TDA3S1WtHcM02Vs3l
         fp+KG03SSiJicHoLsJZq1zhv+jLxMuoDxWI40HsJM/4yVMJLnMvWFeSbjFZYxTZ6ENcr
         Y7lWr+IptNoBQaWS+qg+3DDuXcxmU1UzW0BzH+61ldR+LtbwpNO/8y64D2JcVP1I6lz1
         LF1ZYBkYKWcBNfnpVhFOxQn2jawesGyC56Te0lNt6Yy9yJ0tDlgf/nCyI7Wb7lXvG84j
         xiWQ==
X-Gm-Message-State: APuU4Z+wGwhyGwJxheCqPIZHAk6idSr8adCUV2VJP/pk5AkjCdinjRBM
	kTLmUaNGS1aHafkG4mQhzQK/1eoOU+OyU9qb7CfwTMrxpkhi81HilDVBiuI3Pg==
X-Gm-Gg: AYBFou0eAjiofEtXnZRzOg15JSLCSb4B3asOwiR19QOWGXlRHzHsddw1OdCZUUmE9Tj
	knlrWolvyrmP9gNBx1XJO5UAKk6s/PdpMKYh/qFAQk0kuhXJ3GEFhKFUe4OfUwWA4LfQvxQ+5gz
	x2flRKM6dsuFAh0uWDiYbwKnh8irjlaYcBvOcdAMQijnS80uxIiSbo9kPe+gpp7c+obWuED0Tcz
	E6FB/ecug16puhlzbmZ7fHc8KnqqFmLmbjt0gJ5qvfyzH184iLA18XLgpCRZ+40txMQB9a9Iu0E
	lv8Vl3oHcXo31I6GdaUzK8Gom8Zbf5r/YMfoByRlD9wXuB8Z7Tevqm7X7YwyrfIqxYTDQrLjkUm
	Uqps2X/Ot8uSGzH1RP2hVzAPiBxOMcjBE0jokRS4sDSB41mjuzkGmtf6KdZxPPSjiTkUsMn1tm3
	5ipD/DWCOi5XRfXzkvYX4/+sxSzm8os+HGnBX+GT7DyZFGzp/5VcJtqqbabNTAqYTHc3yMbZRax
	rkg2q/04Rd6ITPBtrYr8a8VCBJsbw7rp5cNx0duQzyc2plzs6zT57EzOa67pBRtdsvOrBVfdjtY
	/l7fQ0rDdJBROVvDZBMrWiL2+YM=
X-Received: by 2002:a0c:f099:0:b0:91f:3103:cb59 with SMTP id 6a1803df08f44-91f3103ce56mr130836d6.5.1794576608219;
        Fri, 13 Nov 2026 05:30:08 -0800 (PST)
Received: from [127.0.0.1] ([4.236.94.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db0f58sm20189886d6.39.2026.11.13.05.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:30:06 -0800 (PST)
Message-Id: <pull.2309.v2.git.1794576606249.gitgitgadget@gmail.com>
In-Reply-To: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Nov 2026 13:30:06 +0000
Subject: [PATCH v2] commit: remove padding from struct commit
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

On 64-bit platforms, "struct commit" is 80 bytes, 8 of which are
padding:
 - 4 bytes between .object and .date
 - 4 bytes of tail padding after .index

Reduce memory usage by moving .index into the hole after .object.
On 64-bit platforms this shrinks the struct to 72 bytes and
eliminates the padding, resulting in 10% less memory for every commit
allocated, with no change in behaviour.

On platforms where 8-byte members only need 4-byte alignment (e.g.
i386) both layouts are already free of padding, so the size stays the
same there.

Since the order of the members no longer reflects their importance,
document that only "object" has to come first, and describe "index"
and "date", whose meanings are not obvious from their names.

Measuring peak RSS of "git rev-list --all" over an internal monorepo
with ~4.5 million commits (three runs each):

             peak RSS     time
  before     ~849 MiB   12.8-13.7s
  after      ~817 MiB   12.8-13.0s

The ~32 MiB saved is close to the expected 8 bytes * 4.5M commits
(~34 MiB); running time is unchanged within noise.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    commit: remove padding from struct commit
    
    I stumbled on this while rabbit-holing on an unrelated change to the
    commit walk, by looking at the layout with gdb's "ptype /o".
    
    Changes since v1:
    
     * Document that "object" must be the first member, and that the order
       of the other members is partly chosen for a compact memory layout
       rather than reflecting their importance (Junio).
    
     * Add comments describing "index" and "date" (Junio).
    
    A regression check for the padding (unit test or a scoped -Wpadded) and
    a build-time assertion that "object" comes first are discussed in the v1
    thread; I will send those separately.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2309%2Fspkrka%2Fcommit-index-hole-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2309/spkrka/commit-index-hole-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2309

Range-diff vs v1:

 1:  20de8db00d ! 1:  f8f0dbcf46 commit: remove padding from struct commit
     @@ Commit message
          i386) both layouts are already free of padding, so the size stays the
          same there.
      
     +    Since the order of the members no longer reflects their importance,
     +    document that only "object" has to come first, and describe "index"
     +    and "date", whose meanings are not obvious from their names.
     +
          Measuring peak RSS of "git rev-list --all" over an internal monorepo
          with ~4.5 million commits (three runs each):
      
     @@ Commit message
      
       ## commit.h ##
      @@ commit.h: struct commit_list {
     +  * The size of this struct matters in full repo walk operations like
     +  * 'git clone' or 'git gc'. Consider using commit-slab to attach data
     +  * to a commit instead of adding new fields here.
     ++ *
     ++ * The order of the members is partly chosen to keep the memory layout
     ++ * compact (avoiding alignment padding), and does not necessarily
     ++ * reflect their importance or grouping.
        */
       struct commit {
     ++	/*
     ++	 * Must be the first member, so that a "struct object *" can be
     ++	 * cast to a "struct commit *".
     ++	 */
       	struct object object;
     ++
     ++	/*
     ++	 * Index into the commit-slab arrays: unique per in-core commit,
     ++	 * and only meaningful within the current process.
     ++	 */
      +	unsigned int index;
     ++
     ++	/*
     ++	 * The committer date taken from the commit object, without any
     ++	 * adjustment.
     ++	 */
       	timestamp_t date;
     ++
       	struct commit_list *parents;
       
     + 	/*
      @@ commit.h: struct commit {
       	 * or get_commit_tree_oid().
       	 */


 commit.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index 1061ed791b..d43cb1e46d 100644
--- a/commit.h
+++ b/commit.h
@@ -23,10 +23,30 @@ struct commit_list {
  * The size of this struct matters in full repo walk operations like
  * 'git clone' or 'git gc'. Consider using commit-slab to attach data
  * to a commit instead of adding new fields here.
+ *
+ * The order of the members is partly chosen to keep the memory layout
+ * compact (avoiding alignment padding), and does not necessarily
+ * reflect their importance or grouping.
  */
 struct commit {
+	/*
+	 * Must be the first member, so that a "struct object *" can be
+	 * cast to a "struct commit *".
+	 */
 	struct object object;
+
+	/*
+	 * Index into the commit-slab arrays: unique per in-core commit,
+	 * and only meaningful within the current process.
+	 */
+	unsigned int index;
+
+	/*
+	 * The committer date taken from the commit object, without any
+	 * adjustment.
+	 */
 	timestamp_t date;
+
 	struct commit_list *parents;
 
 	/*
@@ -35,7 +55,6 @@ struct commit {
 	 * or get_commit_tree_oid().
 	 */
 	struct tree *maybe_tree;
-	unsigned int index;
 };
 
 extern int save_commit_buffer;

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
gitgitgadget
