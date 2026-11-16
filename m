Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829565;
	b=Peg8cM4noLfRX7H4kFqUZfaHs5FMI29bcXya2ElVIKy2nhaZpdiwNwz2qo07bTXxFVAY
	 D4Lkjx/NJHm7OK/YQ1ccaXsNunDRiWAGh/h4CJ+ArFnpzex2C6YSVH73DV6t38WoRfrb7
	 QnVkoc3JCf0b9MWp0pVEuRn7wbSTh1CuIC9hAWRN6mocJguJJRi2heLE64Ej1yWQO/J6L
	 vzN834h8Ks1kcKZe2lKxO+qiTIm1w1P8RHgqdaMOaQEu0gYDfPKAGFyinktFP73mUZV/1
	 L0oez1ypQwAbwvjNsdlR5RlvWhpxp6F3bg3x8UscQauW2/GbjHLwmCSWGJwDWVbo1BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:Date:Cc:To:
	 X-Mailer;
	bh=H5mGfJyOSEvYnR54J5EI1phONYnENVSjAXsfhrfIoSE=;
	b=siw7swBD9dgFfCTWHGUDAcKU2HKeS1lkekW1Ed7QeKOjWoleSYIkpYKAIcNPmcks3RSI
	 5HqoX0X6gENhpEF8J+dGXBjomYJ7NwudlsWqBUu1k0P2O3nyFb8/e4qoiVEHp099UFSY0
	 GWMz/0VvDDFRUl9RtZjS7anKUKkXAE/86oGNxJY/92NXru7qZ/4nvKeKpERkQ2tGmdmJC
	 IlbhT9xmnRQOx4laZYo6FJGjbN/qeIrSEXgtZtGaFeYQRnatj0NV9bNMVpSjgC5DWM+s2
	 ++zLSw4Q9qFhBmhEUIQ+mcHBu6cLY5RJuy54np24vOfQLVd0fvVonblT3lgf6mgoeJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mergify.com;
	spf=pass smtp.mailfrom=mergify.com;
	dkim=pass header.d=mergify.com header.i=@mergify.com header.a=rsa-sha256 header.s=google header.b=tos43I7R;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F3606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 11:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475F3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mergify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mergify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mergify.com header.i=@mergify.com header.a=rsa-sha256 header.s=google header.b=tos43I7R
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e46e449e8so2540965f8f.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mergify.com; s=google; t=1794829563; x=1795434363; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5mGfJyOSEvYnR54J5EI1phONYnENVSjAXsfhrfIoSE=;
        b=tos43I7RMM7fZFQVeWvinu7YPgQIoNHPfLL6GzQyRPGGqgquKHOICQ/tPK2HDYfNKG
         XuR0o2O9bQ2kV7gXrMq97dxTt7uOf45579FcZOoMyg0X9ottspjOgTHeITm60RpWa8QO
         kcSi0UvZDRt0es/u+5Y8oC/YpILhOlzWjY7o51XyL/ijCCkv7IA0YfmW1l2ARyhdz3YF
         f8cYe+S2e+DYGlxmTthDfFB5V6BnRVT7lvRaTSkEug71ufl8Qg59M8/kk28e7pnJc8V5
         q2orNQnlr2ZYgt0xAPvqIj7Y70qEZcW8F4qmMqBqR7AZkIjygEvT0BS51JQPeNf3iLMz
         6uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794829563; x=1795434363;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5mGfJyOSEvYnR54J5EI1phONYnENVSjAXsfhrfIoSE=;
        b=XOB4cIuG4njgWo1v3V5FMuTi6ngBtWedKRZwWje0HENpQ81waShQtL2Ba6q3JIpaGg
         KWwL51relSi9i6ZDxJno90a8+MAbKZb+iwsRxC7ydqi/0ksH5AudHLjG4fpzzzlYEdCE
         Brrv0K/kOvBpDELjDd3cmw6kG10h7AgPGLFds1VVw+1NPLapK0LY0CzioR6Z6apzkB0Q
         ke738Ay2ZEtL7jUJrJQXU+M/Wy5OxsNAzY8lP19qRJjA6SsFqfF5v4kgaFwy6L5ODu5C
         xTNh6Q1vVWbNYmsd7S/GCWtqkHRLv+ROwwzYDgBg9o2z/lhf8laLDXzhIzRF8EsuBl0d
         GxAA==
X-Gm-Message-State: APuU4Z8ByBup5C3s8fMiK5Rp2OfF1Dc9DBDBMnjGetkTDjJa3/YVOB+4
	ZPanwTU0W8YUafiYQ2SFm5XSBCawTAikCRuk5M2NjvmhsC0b/ya7TWbcC5Vr44GXknMvwj6V9+L
	eRKvlf54MwyC+f5I=
X-Gm-Gg: AZFdTZehm2adPChewLs4JDoeeK2GHWA2aQPvC3J1Fp2bYy2Rb3L2egYw3ir+AiIU+w+
	XxMSNGFelXAJTq8AHsNhn2wxXuOVwvbb1JbZccx1PTT9t6OBc7J4gJsMCBjN9yOedNOsHAp8wT9
	cA6A6oRbCA/zqu8UHmsIe47pf2ySEY9+nsX+S8T6SKRgbv90237GCJ9UvB2YzHo7xBvLtfKPwb+
	4dmnL4EdPVk7skPkjRPF5XWWMnwEHXnNdhMW0zpXzyOTMh9QvRMXXM1F8bZO9rYPSx4doWVdIjH
	BetRaD5EXufwZBWh7Hho/mC7Aqd3qvedmTafhud0Spjo482IUpBRLT1iMoygtSJxrH9TyecPZj4
	dvkSMOOuaRm1td5fUasAh4Zae11zigx7AXJkz0vZTGLVPSdo4ykGDaawwt35acqdxrw0y+76uqX
	NipB7cESsgWdqpz5r9J6oYZo2G6riNz3XU9cpVhlRNSIf5FMUncTwEMoUqm8Q1v2XbeA1vIkAWX
	f+EP/jfINARu0ZskXfz3m/xts9zy8PL9ORjzBbZH5YIE8jwYXBJDE/tDw/lMTVaAZ2g8KBxDwLW
	3CRi2h9I6jykuP6yaBRrsaMBziPAHsLA9SGdi2dwnKxJlJhLqk6i
X-Received: by 2002:a05:6000:2007:b0:492:a2cc:f2f4 with SMTP id ffacd0b85a97d-49c72c9be17mr20388690f8f.53.1794829563373;
        Mon, 16 Nov 2026 03:46:03 -0800 (PST)
Received: from smtpclient.apple ([81.56.107.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm36537252f8f.44.2026.11.16.03.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2026 03:46:03 -0800 (PST)
From: =?utf-8?Q?Google_=E2=80=94_Mergify?= <remy.duthu@mergify.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: [BUG] partial clone lazy-fetches a blob it just wrote (bisected to
 5946a564cd)
Message-Id: <69EF6B53-E153-46CC-B7EC-536BEBE8CF52@mergify.com>
Date: Mon, 16 Nov 2026 12:45:52 +0100
Cc: Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3901.200.71.1.16)

Since Git 2.54.0, a cherry-pick in a blob:none partial clone can try to
lazy-fetch a blob that the cherry-pick has just written to the local
object store. The server never had that blob, so the fetch fails and the
command dies:

  Auto-merging dev-tools/go.mod
  Auto-merging go.mod
  Auto-merging testing/go.mod
  [bp fatal: remote error: upload-pack: not our ref =
201d4490be49318c26485d10869070ae44d3e7ef
  fatal: could not fetch 929ed29a43110d65cb7d581c4028e3f183088c3c from =
promisor remote

The commit itself has been written. The failure happens while the commit
summary is printed. 201d4490 is the result of the content merge of
dev-tools/go.mod. It is stored as a loose object in the clone, and
"git cat-file -t" with GIT_NO_LAZY_FETCH=3D1 reports it as a blob after
the failure.

Reproduction (needs network access to github.com, takes a few seconds):

  git init -q repro && cd repro
  git config core.repositoryformatversion 1
  git config user.name t && git config user.email t@example.com
  git remote add origin https://github.com/elastic/fleet-server
  git config remote.origin.promisor true
  git config remote.origin.partialclonefilter blob:none
  git sparse-checkout set --no-cone --stdin </dev/null
  git fetch --quiet --no-tags --depth=3D2 origin \
    +refs/heads/9.4:refs/remotes/origin/9.4 \
    8e9bf0673fe59a12c889b0c087319077c4138103
  git checkout --quiet -b bp origin/9.4
  git cherry-pick -x 8e9bf0673fe59a12c889b0c087319077c4138103

The 9.4 branch moves over time, so the exact object ids may change, but
the shape of the failure should not.

Results:

  - Fails on 2.54.0, 2.55.0, 2.56.0, 2.56.1 and master (7fb6055e67).
  - Succeeds on 2.47.3, 2.48.1, 2.50.1, 2.52.0 and 2.53.0.
  - "git bisect" between v2.53.0 and v2.54.0 names:
      5946a564cd odb/source: make `read_object_info()` function =
pluggable

My reading of that commit: before it, a lookup miss without
OBJECT_INFO_QUICK called odb_reprepare(), which also dropped the loose
object cache. Since then, the second read flushes only the packfile
store. The loose object cache is filled per fan-out directory and is
not updated when an object is written. So once a directory has been
scanned, a loose object written into it afterwards stays invisible to
OBJECT_INFO_QUICK lookups such as the OBJECT_INFO_FOR_PREFETCH check
in the diff prefetch. git then puts that object in the promisor fetch.
In the case above, the base blob of dev-tools/go.mod (2070e6a...) and =
the
merged blob (201d449...) share the "20/" directory, which fits.

To check this, I applied the change below on master. With it, the
reproduction succeeds:

--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ static enum odb_read_status odb_source_files_read_object_info(
 	for (struct odb_files_dir *dir =3D files->dirs; dir; dir =3D =
dir->next) {
-		if (retry)
+		if (retry) {
 			odb_source_prepare(&dir->packed->base, =
ODB_PREPARE_FLUSH_CACHES);
+			odb_source_prepare(&dir->loose->base, =
ODB_PREPARE_FLUSH_CACHES);
+		}

This is a check, not a proposed fix. Updating the loose cache when an
object is written may be the better fix. I'm happy to test patches
against this reproduction.

We run git this way in production (blob:none partial clones,
cherry-pick, merge-tree). This hit cherry-picks in several unrelated
public and private repositories, and on each repository it fails the
same way on every attempt. We have gone back to 2.53 until this is
fixed.

