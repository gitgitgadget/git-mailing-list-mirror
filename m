Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6F43A80B
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623382; cv=pass; b=ANlD/4Fj9TLNyKh1s+yIOPUks0paUhkIf2NLWg3rCkf5h6iBjTKyPZZw3rnPHuPebD3jmAee/5v4D9Mu9jqwTih5Uzrta9C1W/ViObe+Hb3DDPT874Upj4bnonmZIfvSGwxgAHnQxXBL5sc1BKQT4SVWXN7lImAJ21rGG+lqChs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623382; c=relaxed/simple;
	bh=n2fxdL4znQgiMUuP9kAXTmS9XPIa3/ify1U23xREBkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEySUNHBcqQSJ8Ala4ghR0pH1tznf9gNFq+lyezI8OA/7BJx52wCSG3Qt+IGPlY7PXBQNtyLxdqAO1wOxd2SiZEZvLVnSCYhJa0WA2j3nAkvbccd9fBM+gkxY63hIwfUFwrfDD1AFsS7neG5iQ3hVpx+3akZ28YbTEPco15wpK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=d6wEpX8e; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="d6wEpX8e"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6768403e9bbso304605d50.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 02:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791623377; cv=none;
        d=google.com; s=arc-20260327;
        b=fM86MV8Bl4++1y/EFUPLk8IddrcrbwxcP1PhgGoOwJLEYYvU+YQnkL0yqv2nIOmffc
         etIPFSBJwk9wCJv84X47wLVx7+qMQ3OdrjVH9xGoLs2oHG42JCaN+aW42Z5eEwLBwrmc
         yz/SFk6KW5hS7jucAuzj8HvaCo7wbJ5zV1+6TsMWIx76P89zM8FJH6z1RtuKNnGeFaIn
         Jtj5iy1dVxdLNW2nQveXfsSHlT+T710SVGgGjGcJrboidNhYoNim6/IYb9cdRAg283g3
         HUM9UaEXTsXvVciQ+I7yopO86j08SZGBdHs5z6w+5J29lzLa96hW+v27/WN+UpnG5GhT
         d4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jA3GO7CEMLtWpWXT2EoWPn+Vcb6NoDyxSfbZ10q0GbM=;
        fh=Vmj8T8FYO4WighmUB9oJUhnXNfCicBlIA0jacrCq2H4=;
        b=kO1S+nGLuQ5dVLnD0KpNKS2R0ITYTf7IUV1HGV5MIjaWy0y8F/0lKnv/djxOL2c4t4
         TgIiJtFRekIXF/Dhx9wpBtaTR6keCHK2vvRcJK2QS6qQedoSpqddTGC0IAbX03RDE9Om
         xuao282fn35W+CD6nWuaOb2WQ1oljV0mINbZQc6F8Yv5OaoHNZpIirSjv0FHgWFyatx+
         QUzaWsrbc8VRQT9msziUnvpO4lK1eBBrFOOg8RViW7jGtSfvfc52fneAjtVSUQlLZFT7
         kCYoQKLE2nWV1Wg934OhpiXlKakcJGFj3V4nsxy49sDGP84I0xIcT+Ff0Ws3ePMeUt9s
         NYMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1791623377; x=1792228177; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jA3GO7CEMLtWpWXT2EoWPn+Vcb6NoDyxSfbZ10q0GbM=;
        b=d6wEpX8eIXf8JAE7PNJYX0NahIvOFmPUK5GLeZSlRisa5GZFt1Yzr9iXutCRvbcmmt
         sGwAglSc9vb2TyKkW/IVzsFfvvETBFBRzWeuPDII14FcgQuiv7JQ1RIOn06F2rQmAcNW
         Jnegqh1fr1sV5xwsrUq/vDhlHhhWy6+OdkDx4GAaP1gqPVockICv+WipZB2k0QQHWptd
         +X8mW1mSsjojuFjQ11KUGe3r7M4UhZAPgTb7kNfxTX5D2fA3J6oHrGhZkr2aWmI4NcNF
         excDHXDv3lFTcuRWRHtpHsb4hqJwLNjNDBddk8cEa80HGrjZRKKK2lmi4J6ZSBGnYXwb
         QoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791623377; x=1792228177;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jA3GO7CEMLtWpWXT2EoWPn+Vcb6NoDyxSfbZ10q0GbM=;
        b=CoqLWnJca2RTgzyhl1hY/m5pZERDPjTJchvLkx3q11ZhuZz9YtrBQ5MBH1/zm3YEn4
         bnP3T4C7Q1cuN0wbqGBCFGUX1/y91hh5Rng++Uf3ywW3TyJ9B594Nae/9mK5/AVa0lwz
         YLv49d9j8HIvzc7s1UJAbg8TLa5qanT2UnoMKpFj1SwIj9Hxt6JLQDLYJpF8SnvhXuU0
         1cnIjDBkNCnw4yAmOxJJ+Y91InoDR+h2HDUFXa9Ut1ZMZSgE2amFXi7giltab3UFtBkU
         vFq34Pj1x1PyE1CdW+/tDh1ZQU3/7y4dkFDA4bm9v/OcuAmLKUnLJkAd/jrqqt+73mSI
         upDg==
X-Forwarded-Encrypted: i=1; AKwUvBzMjwFo+mGm3VDTYZUrO/FyYgGPGY3VA7dk66pjedbo8mCRWI4reRuLwV5EC7AqhMpzZ7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQxVLy9fFDXmxAHelqq7sjfRxsM2nfFwQHxJagkWnUEWJ5zfqS
	Y+nFlvxUAUwzSL3oPRwmcXQvXpA9p2rslD2ZifEv8uqpcTToEUNNXGuMUBWS8rYMpiG7oKpO/Fo
	7Q6xDOKvBjgcpY1dWeJDDuEbMPmVSt+CLaFnkdZujpw==
X-Gm-Gg: AYBFou1mH9ArNAcOBhjdjq0EblJ+RHVTua7n65Qs9hXLGB2rjd+WdLPnFnz3jA5ytp4
	s0IAmfHmTcZeofLMgXUg6pdsEk3wNupWF7Tzz/LDfPCMcc5uXZTovd5W0TZy0n8u6wI17/n5ozP
	8SGh9ZPFVcj0vKtj/MKDol1ISDJWf1RxIKMOUmEd4eRh3Ji/w/8eHUBfql7soZa2C4J0B3ZANnB
	2Qbm1Ine4uUkr4bWUG0+Ik55zJ3u3Jsry+mlTRL9LUgd21jqf4JzLPQezIztmZr8loqvLMvy3pJ
	t1hiT6atS6UNbZm8M/7LuViUG1vgukEn71dTzXj8PhSK4NmU3H6QuWkkSp+wjVZOdE7f2WNS0dE
	18R+Rx4+QSJ+OuL7l02LexfKHpxmhrpGXZ5MiPmhmCwxB9A==
X-Received: by 2002:a05:690e:1444:b0:676:863f:8ed2 with SMTP id
 956f58d0204a3-67936a20094mr1705344d50.58.1791623377249; Sat, 10 Oct 2026
 02:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com> <2ef141410a1508477976f9e57cec05f1a7603264.1790939492.git.gitgitgadget@gmail.com>
 <asiugInq7YTj4Qbe@pks.im>
In-Reply-To: <asiugInq7YTj4Qbe@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Sat, 10 Oct 2026 11:09:25 +0200
X-Gm-Features: AclHuK8uNfW2nZjojZtrNNNuq91vJ8LHQkLZZAwHDFHCiGNUA3fAJ89eap6AFuY
Message-ID: <CAA0xjtrna99gE6U14JZbYMXSb8rjE5eay5ug8+v6-j1vBS4f3g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] rerere: add "gc --skip-locked" for auto maintenance
To: ps@pks.im
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 09/10/2026 11:06, Patrick Steinhardt wrote:
> And this reads quite awkward, too. How about:

I'll take your message as it is, thanks. I'd only add a last
paragraph on why the flag is hidden:

  Only auto-maintenance needs that flag, so hide it, like the
  "--skip-foreground-tasks" flag that `git maintenance run` passes to
  `git gc`.

> This comment is basically a layering violation, as you now assume who
> passes `RERERE_NOWAIT`. It's a generic mechanism though, so I'd just
> drop that part.

Right, I'll drop it.

> It's a tiny bit fishy that we return an error in the case where we have
> been asked to skip locking and we indeed weren't able to acquire the
> lock. To me it doesn't really indicate an error, as it matches the
> intent of the caller. But I guess that's debatable.

setup_rerere() already returns -1 when rerere is disabled, and every
caller takes that as nothing to do rather than as an error. So I'd
keep the -1 and say so in the comment on RERERE_NOWAIT.

> "free" is a bit unusual for a term for a lock.

That's the comment I'd change anyway, so it would read:

  /* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */

> Given that these flags are new now, and given that none of the other
> flags apply to `rerere_gc`, shouldn't we instead have a separate list of
> flags specific to this function?

Yes, I'll add enum rerere_gc_flags as you wrote it, and have
rerere_gc() pass RERERE_NOWAIT to setup_rerere() for it.

> You verify that --skip-locked skips when locked, but you don't verify
> that it doesn't skip when unlocked.

The second half of that test does: it removes the lock, runs
"git rerere gc --skip-locked" again and checks that the preimage is
gone. That's easy to miss, so I'll make it a test of its own.

Thanks,
Thomas
