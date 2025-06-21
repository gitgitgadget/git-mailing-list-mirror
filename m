Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05D79D2
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750471965; cv=none; b=nPic70DYEqN12jj/AR/BBCLF+eLLgcG9vORhwxI1civ0x5puV77JcIFJOB9RJsjq9/cO8TJyA+CaVLwwjPsxsgkQ7bk5U4VEmwTGy4etGKRBXBjdBOxDcgObrPCeRYif2xHgEY3kNUnVOSh4Dd1+Kiuo+Wb6M8kJva6fwcAAhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750471965; c=relaxed/simple;
	bh=1JWHApLYBivE5xkR1q6OpovJ41/u8ezZxHjlOPdC5/w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WxBBDHv1CVgtnj237fKhxI++H+F9wyWrNIUAKSG6QaHaetQ0U6UA3Hv4EjjqfEwIMbtuflQ00RKRHx0ecoKYr0GNUcMX1pNjQrPF6dR+qFJNsJ2A1gg1HfgLXYDfsoIaZiSm5guxpp7ZxhYv869qWMbn53GI+IhwWq+1RIqycbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnakS0bd; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnakS0bd"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-747fba9f962so1883426b3a.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 19:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750471963; x=1751076763; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48WIUjhGyql2W+s+hXmfZPDpea+jJXMfNHp1EkMv1kI=;
        b=AnakS0bdPaTYz0EI2XJlBZ6GoW9kxTigSoSFYTrmUNLFSJ9DI70o0uBMdDLIVx/Fpz
         8nR/Gxw1khITdHvqU9VR0awAow4Ze/2PBKQFlY8PQ+xm5bqdbFIuPswXCp4Dox9UmWSH
         R6FZ1Q+cN5jJT1r13ku+geBwUpV+3dPLMmxEIBJ1/wVoUkpB7qb24aXHwrt4D8ivqE1I
         /2nz07zn4zfg0aqs8UbRqZ3P7yIN0U1nwOEM1FyGqGfxFWF4ikRpTpXu7j66qXljcnmm
         /3pPZRx7hF6I9fuOIqlDz6k95nXyGtVW70npnO4BZSLtcdBGn1bq9fTcOeUo1MYACb0j
         belg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750471963; x=1751076763;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48WIUjhGyql2W+s+hXmfZPDpea+jJXMfNHp1EkMv1kI=;
        b=WUMtCsjZNJz16KVTMIiQPEve1oC0FuEavBouTbdxgEWkVPxznMsUgfxv3zcguX5PZv
         O/k55aekuWqROGnIjFAspDW1MyCJb82yQXR2PJmsU0lK4FlJvUTxvyV867SOYvRE4UM2
         wyugBG0uAaNMw3KqGG6V3NdYP09hKJCZRdLCt5HumQjOvNnXAoQ6IOGRZxsaEM2G3Vy5
         sqI8QHjm8D549Taui7wfLMQo+5tqPWg8+3wAKcCrD85LOgU/z6vLY8QeFOc2UE9lCdoP
         M4izwntUuW/2Jvz80tFY5XeEoV5xxvAwCqNJBSGU7G/V0fFPKb9roTlh1hdS2gtbWWZu
         nKTw==
X-Forwarded-Encrypted: i=1; AJvYcCUqDI+hLTBY1yu30+xLQh1/3gfL48d5WsogxQBt6pQWWO4nWFmXAKBCnhmVf5SJyb5Vxpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tqMIQVUAX/RPzVxgIwAuf+jMVS8QLRWCRS1xJVZQWNHJHKqK
	KqT8E0h665ONXBHTnjh2dI4EQsIpaKkfYEfkXLVsZcBra/UARirg/bNpSoFfJKrmH662DQ==
X-Gm-Gg: ASbGncs5V4lp/0XtU9IZHKONORLEze8StrneGYBOGZFTnfhjBnV1O6S4yqfHdyi+8zR
	mJMrQf/HnFioCy7svtPoJNgLSSWOQvF+QAkmyTMBSFcqFMuaJYzqQ8BO09drcpuC5xgn4nV15jr
	FQS4FYodlGNz2AoIen16+PuVnTiafwiW6KW1zVlbGJnq14kPKhTM9ZDJlPKiPS4g8ootCtlgT6s
	dW1HmqV+1IJdcG987knA851uBipKkM7VyGMO1ENFDldcvgaR27CdP1S8ZNMeh0w9lpKCir6YiWA
	qi86viIvwbnaRWxAkOR9nXMV4mL7dXBzLnJ75yCcxsHBT8xrsqBhBL6oAtATNM81NSmggxuYa2R
	/oiCPcFiqnXOgCthBXpFDwtc8wDW83CMUDhiLHGdPRkwf0K0+nhM5HZkLgnDmZf2i
X-Google-Smtp-Source: AGHT+IGXkBQfz3jDmt6dpG/1/SusujTKkac1n3eG6k/8X4m5s463v+vICpxMtMEnA3Fdf7+G4RY1jQ==
X-Received: by 2002:a05:6a00:2289:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-7490f474fb8mr7195556b3a.4.1750471963250;
        Fri, 20 Jun 2025 19:12:43 -0700 (PDT)
Received: from smtpclient.apple (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118eebdsm2324226a12.6.2025.06.20.19.12.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jun 2025 19:12:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 1/7] remote: remove branch->merge_name and fix
 branch_release()
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqecve0yvz.fsf@gitster.g>
Date: Sat, 21 Jun 2025 10:12:28 +0800
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 git@vger.kernel.org,
 Jacob Keller <jacob.keller@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA42712D-C127-4142-9424-2A512F9488CB@gmail.com>
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
 <20250618-jk-submodule-helper-use-url-v3-1-7c60f2679271@gmail.com>
 <xmqqecve0yvz.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
>> This end result is cleaner, and avoids duplicating the merge names
>> twice.
>>=20
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> Link: [1] =
https://lore.kernel.org/git/20250617-jk-submodule-helper-use-url-v2-1-04cb=
b003177d@gmail.com/
>> ---
>> remote.h       |  4 ++--
>> branch.c       |  4 ++--
>> builtin/pull.c |  2 +-
>> remote.c       | 42 +++++++++++++++++++++++++++---------------
>> 4 files changed, 32 insertions(+), 20 deletions(-)
>=20
> This unfortunately makes t5582 segfault.

I used Clang's Address Sanitizer and found that the segmentation fault
was caused by the following two null pointer dereferences.

=3D=3D501602=3D=3DHint: address points to the zero page.
    #0 0x72be47ec6ce1 in strcmp =
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptor=
s.inc:465
    #1 0x5d7e2f246b11 in do_fetch builtin/fetch.c:1732

=3D=3D501614=3D=3DHint: address points to the zero page.
    #0 0x7b9812ac6ce1 in strcmp =
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptor=
s.inc:465
    #1 0x64e39a76cdc1 in get_ref_map builtin/fetch.c:555

I believe this is because we didn't update the corresponding
branch_has_merge_config() function. In the previous implementation,
if branch->remote_name was a null pointer, branch_has_merge_config()
would return false. However, PATCH[v3 1/7] broke this convention.

The solution could be:
  - Replace !!branch->merge with branch->set_merge in =
branch_has_merge_config().
  - Replace free(branch->merge) with FREE_AND_NULL(branch->merge) in =
merge_release()
    to prevent double free.

I test my solution locally by just running t5582 and it passed.

---
diff --git a/remote.c b/remote.c
index dff76e4626..ee95126f3f 100644
--- a/remote.c
+++ b/remote.c
@@ -259,7 +259,7 @@ static void merge_clear(struct branch *branch)
                refspec_item_clear(branch->merge[i]);
                free(branch->merge[i]);
        }
-       free(branch->merge);
+       FREE_AND_NULL(branch->merge);
        branch->merge_nr =3D 0;
 }
=20
@@ -1788,7 +1788,7 @@ struct branch *branch_get(const char *name)
=20
 int branch_has_merge_config(struct branch *branch)
 {
-       return branch && !!branch->merge;
+       return branch && branch->set_merge;
 }
=20
 int branch_merge_matches(struct branch *branch,
---

