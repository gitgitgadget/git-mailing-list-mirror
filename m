Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CD52189A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926706; cv=none; b=rUjhLAnkDN7MVH6R268+gj52FLJm/HDyKzzrKKGNh8vMqIyyrXn7k9Z0Hr8xSscdjgthEtQQGbRuFyM/ABYaJyl76NzF5A/fru31j/RxJ9TVAL7DKPmOV0HGLSSZUogFE4YI8UREabg07R434O+6P8KIuXNDt7Q5osNkntvDK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926706; c=relaxed/simple;
	bh=hcW9fflHQ/eoIGF0V5gaZXgK9+CrCd7iMzvOM0BuBsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVH+l1pA7J7YZRlY0uNkPbG/rgZI35w2MXYWTKuif0ybfpaZBSHJS2DqwMdqHmx4ZuNKLh05ISbzUAgwP3fWWMkcEPj4648lks1Vc/9WJuZEctqbd/hFAsg7QWlMHNVZ6ruhSgl650Wt/oxCNMFQyMYe7IF51ZGuOlHXqFjUR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBt0yfbM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBt0yfbM"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so3175487a12.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791926699; x=1792531499; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2IGqyHK7egz/CQJ0ZKbghEJdboBKVlIaJn7e4hUFzU=;
        b=FBt0yfbMUPzWAJJ7yZC38IAVujFM9R7BemnMFb0YsBx8DP70pdxey2xCpiGXp20aFg
         bQuDKSGTi4Vbvhxr1J7bGs50Gcoi08pPqZiAMHB441OFyNEZBljXSYE5TOAQmzi+rLPR
         poIcBhxuoFbeVZOXHlal51aMFskEev+/4gY1RIs5ugwllPH4AIS3j49JHXJe6BaHUpLQ
         ta+IsV3Zs1znqn9JerMfij2CXPqhevyfKBuuAsPVYfxJvUaQYedTSMlik4jQ6Y3aL9EI
         Bdj8oGiXt+w0AOZxOzzx0xOn9HDXK7Joqs1gCYjGn4lQqb0I9K5Y+F3RPbMVs1xz0V5k
         rpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791926699; x=1792531499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z2IGqyHK7egz/CQJ0ZKbghEJdboBKVlIaJn7e4hUFzU=;
        b=0fy2RCV8G/cNop44RofRS24SgScJsLtpMh9JsztMMrHRKnuIOooEH0DWRguYSSvXrv
         jDeHPaDEPBlYZl5YsE73iCgSi30XYEefqetzv0w/H0DYdGYDAxUSF3HABCQV35RCHFi9
         FVDSw+VD5vIL/4y+qv9D+kMka2+XtnFJhmmPXvb6Dcay3ZcJc9SleDawdelGKhtEeYRk
         JoAxJIFkMl7UPA3eqHtPGSwtulSkZt/OotfPyorwAAvTzRYfhkpiqqGvxRF9qRqQC1zM
         8qqdshSGh8JuxNKkQEsYRC+Hk5b4Ph517OmYWSlG30Nxp81Lt7M3UBmJWNqjc6rJ29MX
         4Hyw==
X-Gm-Message-State: AFq9FYJ4M6kBo45xS2L+DY1EQFIY5u/f9mkxs0LKaHqW1+mRcI6p54xS
	7FU235G2XXtTIDII7BnnEEwJ5f1Gsi8srpqTQt4Mm25H2P/F7rTQjVKTolv+NQ==
X-Gm-Gg: AYBFou0IASPFA5hjaHS0u+x71RcX4M5SgECDog35vKbpUxK6meT4oGCzF9vMAJiTQ5y
	/QzDit+QRf+kUoGP2J8jHa7eQCB83lBOfHzYdq2ugEd55PsYodxnLXy1o2SeWaJWVYkr1XcKg2v
	7BoYdSQgm9DYbb44e/RM/DbcmVWb/zESIAf+LDDkjrp48QzSwh3wpnVylGRB64R6P/OS4EhDDFD
	5nClCWpj6wkWNh153b5m2KWYGrQY28iUmtvOpfSeiUSIJ1j85Wvdm26yrfAZZmkZBfrNz40o+nR
	CR/2AixUv6ZifYV2U85+L/4Lbnkk7ES+9M84xtkJeft/E81YK71XaB/d+gTdN48J6LLgeqvHLi8
	dyEhMBrY01UdYc9qqKaUBCNlcq5JbzfOIV7V6LA6fATqr6bnaoVCjbh+cZUYhR/QjAH5C0pyBG1
	tE7VxLXDoH9wUnqnhLLDu2OuYUsat04eGiyRPEZK0bZgHtItDkyfEjTHWu3DeQkSgYgAD5cXcj4
	QYYDdKuXWp+jpryA2UQYSzh+VQ=
X-Received: by 2002:a05:6402:20c3:20b0:6b1:827c:af1b with SMTP id 4fb4d7f45d1cf-6b1827cb05fmr8566504a12.13.1791926699184;
        Tue, 13 Oct 2026 14:24:59 -0700 (PDT)
Received: from localhost (84-236-78-156.pool.digikabel.hu. [84.236.78.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203839503sm309299a12.8.2026.10.13.14.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 14:24:58 -0700 (PDT)
Date: Tue, 13 Oct 2026 23:24:41 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@collabora.com>
Subject: Re: Performance regression in `git log --follow`
Message-ID: <as6hmUG5AaL5iLbO@szeder.dev>
References: <as44NVKZA9C9S5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as44NVKZA9C9S5ae@pks.im>

On Tue, Oct 13, 2026 at 03:55:01PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> a user on IRC reported a performance regression in linux.git:
> 
>     $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>     $ git -C linux log --stat --follow -- include/linux/rsc_table.h
> 
> I was able to reproduce the performance regression: while this command
> takes roughly 33 seconds with Git 2.55, it takes almost 8 minutes with
> Git 2.56.
> 
> I've bisected the regression to 304812ed33 (log: improve --follow
> following renames for non-linear history, 2026-06-22). I don't have time
> right now to debug any further, so I decided to just forward the report
> to the mailing list. I've also Cc'd the original author of the above
> commit.

The performance regression is clearly noticable in the git repository,
though the slowdown is not as pronounced as in linux.git:

  Benchmark 1: ./304812ed33^/bin/git --no-pager log --oneline --no-patch --follow v2.56.0 t/valgrind/valgrind.sh
    Time (mean ± σ):      3.275 s ±  0.022 s    [User: 3.157 s, System: 0.116 s]
    Range (min … max):    3.240 s …  3.313 s    10 runs

  Benchmark 2: ./304812ed33/bin/git --no-pager log --oneline --no-patch --follow v2.56.0 t/valgrind/valgrind.sh
    Time (mean ± σ):      8.825 s ±  0.029 s    [User: 8.554 s, System: 0.264 s]
    Range (min … max):    8.769 s …  8.864 s    10 runs

  Summary
    './304812ed33^/bin/git --no-pager log --oneline --no-patch --follow v2.56.0 t/valgrind/valgrind.sh' ran
      2.69 ± 0.02 times faster than './304812ed33/bin/git --no-pager log --oneline --no-patch --follow v2.56.0 t/valgrind/valgrind.sh'

That's 5.5 seconds of runtime difference, and with a bit of trace
performance hack[1] it turns out that most of it is spent in a call to
propagate_follow_pathspec_to_parent() to compare the current commit
with its second...N-th parent:

  $ GIT_TRACE_PERFORMANCE=1 ./304812ed33/bin/git --no-pager log --follow --oneline v2.56.0 t/valgrind/valgrind.sh >/dev/null
  21:59:30.465592 read-cache.c:2364       performance: 0.000626524 s:  read cache .git/index
  21:59:39.246697 log-tree.c:1158         performance: 1.374980154 s:  first parent propagate_follow_pathspec_to_parent()
  21:59:39.247164 log-tree.c:1159         performance: 4.448692273 s:  N-th parents propagate_follow_pathspec_to_parent()
  21:59:39.247192 trace.c:416             performance: 8.799236172 s: git command: ./304812ed33/bin/git --no-pager log --follow --oneline v2.56.0 t/valgrind/valgrind.sh

Interestingly, although line-level log performs its own rename
tracking, it's still notably faster than "--follow" even before this
perf regression (that "-L1,40" means "track the whole file"):

  Benchmark 1: ./304812ed33^/bin/git --no-pager log --oneline --no-patch --follow v2.56.0 t/valgrind/valgrind.sh
    Time (mean ± σ):      3.260 s ±  0.019 s    [User: 3.140 s, System: 0.118 s]
    Range (min … max):    3.219 s …  3.284 s    10 runs

  Benchmark 2: ./304812ed33^/bin/git --no-pager log --oneline --no-patch -L1,40:t/valgrind/valgrind.sh v2.56.0
    Time (mean ± σ):      1.454 s ±  0.014 s    [User: 1.369 s, System: 0.084 s]
    Range (min … max):    1.441 s …  1.481 s    10 runs

  Summary
    './304812ed33^/bin/git --no-pager log --oneline --no-patch -L1,40:t/valgrind/valgrind.sh v2.56.0' ran
      2.24 ± 0.02 times faster than './304812ed33^/bin/git --no-pager log --oneline --no-patch --follow v2.56.0 t/valgrind/valgrind.sh'

The reason for this might be:

  - If line-level log finds that the interesting path is not modified
    between a merge commit and its first parent, then it doesn't
    perform a diff between that merge commit and its second..N-th
    parent.
    "--follow" seems to performs a diff between a merge commit and all
    its parents.

  - Line-level log checks for renames only when the path is not
    present in the parent commit.
    "--follow" seems to always look for renames.


[1] It really is just a hack:

diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..fd4824fd3e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -34,6 +34,7 @@
 #include "wildmatch.h"
 #include "write-or-die.h"
 #include "pager.h"
+#include "trace.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -1144,6 +1145,8 @@ static void free_follow_pathspec_slot(char **slot)
 	FREE_AND_NULL(*slot);
 }
 
+static uint64_t t_first = 0, t_nth = 0;
+
 void release_follow_pathspec_slab(struct rev_info *opt)
 {
 	if (!opt->follow_pathspec_slab)
@@ -1151,6 +1154,9 @@ void release_follow_pathspec_slab(struct rev_info *opt)
 	deep_clear_follow_pathspec_slab(opt->follow_pathspec_slab,
 					free_follow_pathspec_slot);
 	FREE_AND_NULL(opt->follow_pathspec_slab);
+
+	trace_performance(t_first, "first parent propagate_follow_pathspec_to_parent()");
+	trace_performance(t_nth, "N-th parents propagate_follow_pathspec_to_parent()");
 }
 
 /* Compute a path to follow in parent, if there is one */
@@ -1304,9 +1310,18 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		struct commit_list *parents = get_saved_parents(opt, commit);
 		if (parents && parents->next) {
 			struct commit_list *p;
-			for (p = parents; p; p = p->next)
+			for (p = parents; p; p = p->next) {
+				if (p == parents)
+					t_first -= getnanotime();
+				else
+					t_nth -= getnanotime();
 				propagate_follow_pathspec_to_parent(opt, commit,
 								    p->item);
+				if (p == parents)
+					t_first += getnanotime();
+				else
+					t_nth += getnanotime();
+			}
 		} else if (parents) {
 			remember_follow_pathspec(opt, parents->item,
 				pathspec_single_path(&opt->diffopt.pathspec));
