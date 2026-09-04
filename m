Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807984AD7D5
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537332; cv=pass; b=rvQPhGcWqDeagK4F2c7t5FWKKrVyFk/6BKddG6FtZUVJ5x/VxhyQHdkBXpEuETNApB34VFMAG26Gniq18ryieP4vYM0x56+RCrFpAUJsidTU+AIc0dGrHeYh5sajVPgf6g6MUrZMH8ECdGisAZVfrwhjD95lCsPuhpPDcAYkkMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537332; c=relaxed/simple;
	bh=yoOxyanI/alKtbcunuZtrlv+6/PGhyYmM6D3nmFvtvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov1TQL2kda1HIVpVhox9U3rKq4EW1zMHJYCmBZDgiiJcj4PPj21I3K5Hgr8tK0+lI7E3myp5T92JiLcbzZn6BECsZRRwtG6xM4HCdjjvV3SOWjm+6sDQl+oNkbPmCMLLO4LcKW0gC5mK+UCjNuNVwH+FBnbSV9UisPhMErvzVpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=Cm6PE7kN; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="Cm6PE7kN"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-865bdc6ed72so23332197b3.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788537327; cv=none;
        d=google.com; s=arc-20260327;
        b=VdgeARvXL50MdIDLhzRHi7Ii3KysBWcID1ODoECeMwxu+jvdTP2eaGcPlDCynHcO2O
         2+O3MFKgzCJb+hbHfeBoiomoIRu4+5qxg6+mGpiK+5XvjgHQl3NrCXwwYrEQtHdO74O1
         JevZ5tjygSZmAKXGDGt4PK8LbKlOQbAJBtw8zFocGCMiVYi5tbmG+WsA7EOnQT3kem4E
         usjKij1QU6v2pDK0AWr5qWjKPsp9zMMFQ1KImbyfBytAIbPsb7tWiy6Vpb6SGJKd/nwL
         Xfe0A/y1Al7SpseD58XIv5JX+6VRMiRJ1G/OiEVTlFW6F2m0nba34MS4hcY2uMSgiWiB
         AAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lBWhP2f/Aj7gtq0CLZNAGlOquy7DdYI/ru8IWEB/gUg=;
        fh=L+y2dfwDMulZmZCFk4k3/O8QKR2U484UXi0epagv7jU=;
        b=PhiWcGJmEpZzwl2EAmm4cu0FlyXhkIMQVU5HrQobQruiVmkISBOzptY67cX2NFbJio
         Un0MM+luGNJVFl74G7JIqFsgULNoOp4UWEYUg36fKBMtYUX008cat+V66+UoxFR1PwRw
         P1eBPNi8ICDABYMUjoK5A4JgUXTFvDqI47WtDW8M8ZvIbrPZ9MhYQDdJdqSSUMbsqpWk
         cL5NvkpD1KUfGNKRbNii+TRQI3dxD/dpinYtQ2bA3ggwWv9AiIV5dWPq3adzS+uzNehf
         seOBWXeYnkwwGyiE7eMi20ZkPW1tfu99fV2ki4UIzZG8y8fNbrxvS5WU80BqERyMfx2S
         9b0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788537327; x=1789142127; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBWhP2f/Aj7gtq0CLZNAGlOquy7DdYI/ru8IWEB/gUg=;
        b=Cm6PE7kNcSSQWj4xZyMbfTJYEtBSBwal5guDq21iqI25Oq7TN0IHuChhk/yS0wjiCX
         A4Vv61IJBF4hgGojwRKcJcXKZEZyNAW34zi8to99WY1pqcND8OX3lAvWBDUH/5iJpP03
         agOB54FNelSpNPDv7WK2lo5c8t4R6TwlDrZeyo2sMtxp20X+C7lpqYMSwmxRd/geQ3Os
         l1w+LryGn+oQi0EN1I5UL3lFeLHMTLiqv9/1R4W2Act5SK0DXJvMtxd+8+GjP26wrrfS
         +gTPByjDzt5NDDOTEPPdI3YbrFGrCvrkh1T6AHigdseOuy9EJskOqNLSYaWdVTV9sYnI
         fnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537327; x=1789142127;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lBWhP2f/Aj7gtq0CLZNAGlOquy7DdYI/ru8IWEB/gUg=;
        b=lss2dHEmY5mUFjUJ2PK5vwr9RNPILSjnPj7KKjP4/0mg59bNWYtKQde3r3oJxCPL4a
         IPK0NUk0EKW19SXKYdhpI4PDVa5u9O3T7WEkTyn2UTDSUuiJPV6mbxLBP865BLQvvQnG
         IcIAcL37mBYwxxfzY9CgZwy3h8gBXKI2QcdH7S9g045ocpqwGy0EzNdWiFhXitb/rL0o
         zIJYlIyxSktWJqv75wZrDNIHp9zI1H70T/bfgldfJ3f6PgfBpksuqLdBmdO5Z0JZEmbD
         HsGPbxOVXMBWO07/soDfHk0IH9KuaH2FcHoUJO1+UhxKtkh6yfrzcOHnJEAoBH/O2PjS
         sS+A==
X-Forwarded-Encrypted: i=1; AKwUvByWMASaRImnEPzz3hqX2eOanjO95P9wzXSbxd5tn+HdWEkfy2ZmKv2yK7Tzy3+OT2Rfa7o=@vger.kernel.org
X-Gm-Message-State: AFuF++m863KDrMjIj6w0ELgO/pFYEYJDMaq+IUYogMmnP704m/wP+4lE
	Cbw36XVMY1zxqvC8J/P/6rY0t68s5FeW01B57Iwl1ZQDTWGbiA1Qo/9qU3uNmtECd7lvfxeV4n/
	aAVZOaZoPBT3oBLHQXL71Ho26tc2++5LhRWlUA92NQw==
X-Gm-Gg: AYBFou376Zjy2fbZc7dzCjdFrJ26pl7sOsRt4qPOkdjbOpfPjxxPxGXWKCA2KTcTN6X
	AEqrRXQv4leNPGoZC1tjHrbu7ZDlHlND37DTjzGbaw+/FmNXXVr+fffq7Ux0hzssuBzPuC9UT11
	MYhNX7crfEa5ezKGS2MLdW51SKaVI+lB2jafcpjW8M6oZWNyWo0+mVyA4FXpQjQG4q6bcRn+qEn
	d/L5r7vl/8xp8rzLEC7ouaRLUqMhK2UQtojOYr06XnPxHMPo0K/LttHClgZftg/f1pMlkwwzXgC
	et7xPH269AW1CDJx3fXJR84tjKJmZdQUZOmrLYiNma2H2mOa6F9ozJ/LeJr3U4VZ/rWRdId/h5M
	OfcA=
X-Received: by 2002:a05:690c:4029:b0:873:5bd1:98d0 with SMTP id
 00721157ae682-8735bd1a2e7mr7472637b3.66.1788537327010; Fri, 04 Sep 2026
 08:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com> <5e613735-60e2-429d-a5bb-1a4f03578604@gmail.com>
In-Reply-To: <5e613735-60e2-429d-a5bb-1a4f03578604@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Fri, 4 Sep 2026 17:55:15 +0200
X-Gm-Features: AcwNN1VVmkhs_Pyl29xqYZzot9_z6JyEPUIQn6zjfe8UPU5TyxwU71LI6kumO7w
Message-ID: <CAA0xjtrkjaOC_+jhN=Vjm9e0T+iqAZeeMKx-ymVaQcLA37bm-w@mail.gmail.com>
Subject: Re: [PATCH v2] rerere: keep a background gc from killing a rebase
To: phillip.wood@dunelm.org.uk
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On 04/09/2026 16:21, Phillip Wood wrote:
> With Patricks patches that's no-longer true I think. I think a better
> motivation, as the cache is per-repository, rather than per-worktree, is
> concurrent writers running in different worktrees.

MERGE_RR is per worktree, though, and so is its lock:

    $ git -C linked rev-parse --git-path MERGE_RR
    /path/to/main/.git/worktrees/linked/MERGE_RR

so writers in different worktrees never meet on it. What they share is
rr-cache, which a gc in one worktree prunes under its own worktree's
lock only. That is a gap of its own, and not one this patch closes.

What remains after Patrick's series is any "git rerere gc" that runs
while a command records a conflict, from "git gc", from a maintenance
run, or from auto maintenance once enough entries are stale. The v3
message says it that way.

> Overall, this commit message is rather long and it would be helpful if
> you could distill it to remove unnecessary and unrelated details.

Done, it is a quarter of the size now.

> Why do those commands fail rather than wait?

They wait like everything else, and once the time is up they fail
instead of going on without rerere, which is all they are for. That
way a stale lock gets the usual advice to remove it. The config text
said otherwise, fixed.

> It might be worth adding a check above here that BUG()s out if the
> caller passes an incompatible set of flags.

Added, for RERERE_NOWAIT with RERERE_LOCK_OR_DIE and for
RERERE_READONLY with either.

> A background job that the user did not explicitly start printing to the
> terminal is rather confusing as it is likely to get mixed in with the
> output of whatever is running in the foreground.

The detached maintenance run has no terminal: daemonize() closes the
standard descriptors and reopens them on /dev/null, so the gc's
warning goes nowhere when it loses the lock. Where it cannot detach,
on Windows, it runs in the foreground of the commit that started it
and there is no race to lose. The warning the user does see is the
foreground command's own, when it gives up waiting.

Thanks,
Thomas
