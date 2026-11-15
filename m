Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746865;
	b=u/tveK8rtThnFhKt48OYSO2ucJvYuXnIhJBJRi9BHSZ3D4QRwMuBNY3Kd2Szs/Krx3hX
	 b5b2F4Iq7bol+LHlhKrsVXMf8ZP3R0QZdchQBggis9gFhJ5V6d8iH7bBZERtGSGpGIrtN
	 NeWp0a40aCzOGdsjSf+1+W0J5qMDkpw7cLfPMDgkGnWQKWBYp4qVucayb8AFFCWU7M04W
	 DtqDk+LyADrSFO36uEK3PvDghkTW0nep8ogAW8f/DbcgjAC32jCTO/LkZnOPZSOlIDpVw
	 AZvIvUTmrMEp5GSohqS7qok0AGTR2Aa5aruCSNSoC+/ABBC8lozDHVDJgUGKvYVGPLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=q0pBQjs5fK2F9cQzTQZtDWmNCjrk/WGEgTtmok6Y3og=;
	b=wly6OWM2yMJxGYuvq2fCLP3RHBpdin8Lqd3S2NLXo3ElmFAP5cHk3Te/mWUP/Zp3ximJ
	 eRXKx0Vm1k/zhndR91Udoj/QSbzR3aEp5lOkV6CEKzcI9YS71IJaZWGxsusXpsilIcLsk
	 BmmOPjamuj6ck/77O9YFEyk0wM1GjYmirI0XZOTyOUbNLO6KQmp42Qk71plMFtK1fJCC6
	 77ndM8c2EdqCoMkR50M8T00K73w/OgyljKYgnwwYjLuNbs9ge2n55H2VMGYg3F6+5i8Gz
	 cazsK4450hMSWZuVJOrqgJ/cl+87aD7jlpXqE4YbVe5h7TJTJKfEFWkT0PW6xeWuPoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fv27g0J9;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B9606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 12:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F5B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fv27g0J9
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-94959217274so337171085a.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794746863; x=1795351663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q0pBQjs5fK2F9cQzTQZtDWmNCjrk/WGEgTtmok6Y3og=;
        b=Fv27g0J9Q8BHBJ6ljGS823QRgwR6dlpoBqlLFxBj9DrNlwtYjbXPSY4FMPCWZVuV0J
         tyGm4u6wwapkVzhcGEeKxqBx/sAJFxt+er526yoSs/cBqhQJ6E83osP9b/95eqkbta3x
         BN43J+R0NxYeCJZe3FnzXIGalQmF22JVVj4aD+rQC48GuveiCrFvXdOqqtlCwaN2xSJ7
         haptGIlEkrR3q/Yi8rIRRX92pq2FJh4fQC22IYKIhrgkhuLDwmyvlfw0iQnuJ6K+SNjD
         7ESvnlVeB+ZNd5b26uDBGPvsH+Y/wZMMhiEqBZaQDxNnqtQJZtcuVfnJume49wR7SVXn
         hcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794746863; x=1795351663;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0pBQjs5fK2F9cQzTQZtDWmNCjrk/WGEgTtmok6Y3og=;
        b=NaBtqCHo2owFMtXaVJlBDZ24/3T9qZ+CkpJ2egQP8C+ngHOzgSWRx2H6Zz2tnOsfwu
         T3DXK/QA/VeOfnnqwrkE6fNs9JRuKkrycRXeVOClqVKchucQglCwHzTdDaXK6K09wEtf
         Y2EmD1EyuEmFRVWRDfY+zmqE14MDvgqsAtpwooCf0Qe9g2W62ZSATTC0crL8HzUWbufy
         vVq5GTLLuobRp/bJ4e5sqXNRDUfy/V2QYWuNl7kgZS/ez2Tz7mPYUKQgzF5Y9YMC5oAp
         z4dI/FGzaW2fqT4Pc4KhHoWDglK/OdTGPA6HUCkyccUb8+s25JeEZ4uhsiinuGHRP+cs
         TnRw==
X-Gm-Message-State: APuU4Z/j2Y2+kgTusyJCykgOxrRZowZldKskoe26IBLXgPpvP0vJMT2I
	zz0fyCEzrq9HDsDuxTjmhm3kC9NXIbHQskBfZk+1En6CtMoNP3IDoXBC133w3g==
X-Gm-Gg: AYBFou1CoxQZhR6w/tH1xvFVPkHIi8h8zsSc2NxS1uihH07XKzDv+1rckjvlMzwPpks
	MA71/L1bBSMUK0tRW7heWgYrVxdC9nn72HMdBW/WSup2oDFKwqFkRO7AkMhy79RybhmjKBQD1GK
	LRNvD/pLvFseKg0aL2F3Y2Xaq+Pe30k+rLjoO4rGcfLQAEWAWGqINqxtx5D+vPXHspgYYXWIBh2
	zysG/0aveK/mciVEEb8AxcmX450QNsf9cRwADXFFxWWYoZdcDK9qIedMrKzY8Unpv23RFeYWHRt
	AN4wZkUo2wmP12uvn1Kstk1oi6RLVtvNMruAz3gkkZZJatq/urlgS/I5OlM89wAjk3CgNAzrOAV
	+wzT6f8oWXiTa9+wVfo1hheyo8U8dCaPkdnnmGR9dcEsXtkD59anXiH0p8IINW9FbN9GA9gGwMo
	6OZ9yido3adQ0zKaNBfKV81ihwwi9WXxRWfQMPWKwDDTubuU6IzC1NBFmX1JNkxBhM34S6n8MtY
	CGn/aB9q+wCp/Y0LmJtqwq30TTQt8JJrSBtNJmjSALBsVrhcOleN/lZINOqCnXPPS97/3FsI/yZ
	JNG56MEXEAakWJO04bxrHVrQlo+92waWJw==
X-Received: by 2002:a05:620a:6f01:b0:943:faab:a149 with SMTP id af79cd13be357-9494bc4081dmr1161047485a.63.1794746863391;
        Sun, 15 Nov 2026 04:47:43 -0800 (PST)
Received: from [127.0.0.1] ([48.217.227.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9497dc91f48sm7844185a.42.2026.11.15.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 04:47:42 -0800 (PST)
Message-Id: <pull.2309.v3.git.1794746862501.gitgitgadget@gmail.com>
In-Reply-To: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Nov 2026 12:47:42 +0000
Subject: [PATCH v3] commit: remove padding from struct commit
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

Since the order of the members no longer reflects their logical
grouping or importance, document that only "object" has to come
first, and describe "index" and "date", whose meanings are not
obvious from their names.

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
    
    Changes since v2:
    
     * Swap the direction in the comment on "object": a "struct commit *"
       can be cast to a "struct object *" (Junio, Stolee).
    
     * Say "committer date of this commit" instead of "taken from the commit
       object", since it may also come from the commit-graph (Stolee).
    
     * Shorten the comment on "index" (Junio).
    
     * Mention logical grouping in the commit message as well (Junio).
    
    Changes since v1:
    
     * Document that "object" must be the first member, and that the order
       of the other members is partly chosen for a compact memory layout
       rather than reflecting their importance (Junio).
    
     * Add comments describing "index" and "date" (Junio).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2309%2Fspkrka%2Fcommit-index-hole-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2309/spkrka/commit-index-hole-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2309

Range-diff vs v2:

 1:  f8f0dbcf46 ! 1:  a579563389 commit: remove padding from struct commit
     @@ Commit message
          i386) both layouts are already free of padding, so the size stays the
          same there.
      
     -    Since the order of the members no longer reflects their importance,
     -    document that only "object" has to come first, and describe "index"
     -    and "date", whose meanings are not obvious from their names.
     +    Since the order of the members no longer reflects their logical
     +    grouping or importance, document that only "object" has to come
     +    first, and describe "index" and "date", whose meanings are not
     +    obvious from their names.
      
          Measuring peak RSS of "git rev-list --all" over an internal monorepo
          with ~4.5 million commits (three runs each):
     @@ commit.h: struct commit_list {
        */
       struct commit {
      +	/*
     -+	 * Must be the first member, so that a "struct object *" can be
     -+	 * cast to a "struct commit *".
     ++	 * Must be the first member, so that a "struct commit *" can be
     ++	 * cast to a "struct object *".
      +	 */
       	struct object object;
      +
     -+	/*
     -+	 * Index into the commit-slab arrays: unique per in-core commit,
     -+	 * and only meaningful within the current process.
     -+	 */
     ++	/* Index into the commit-slab arrays, unique per in-core commit. */
      +	unsigned int index;
      +
     -+	/*
     -+	 * The committer date taken from the commit object, without any
     -+	 * adjustment.
     -+	 */
     ++	/* The committer date of this commit, without any adjustment. */
       	timestamp_t date;
      +
       	struct commit_list *parents;


 commit.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index 1061ed791b..1bff712c85 100644
--- a/commit.h
+++ b/commit.h
@@ -23,10 +23,24 @@ struct commit_list {
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
+	 * Must be the first member, so that a "struct commit *" can be
+	 * cast to a "struct object *".
+	 */
 	struct object object;
+
+	/* Index into the commit-slab arrays, unique per in-core commit. */
+	unsigned int index;
+
+	/* The committer date of this commit, without any adjustment. */
 	timestamp_t date;
+
 	struct commit_list *parents;
 
 	/*
@@ -35,7 +49,6 @@ struct commit {
 	 * or get_commit_tree_oid().
 	 */
 	struct tree *maybe_tree;
-	unsigned int index;
 };
 
 extern int save_commit_buffer;

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
gitgitgadget
