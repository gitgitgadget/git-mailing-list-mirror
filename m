Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E68221DA8
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237663; cv=none; b=jlXKdsGdumc5TecHJB2ABtR1P09XTAnUnl0MM0tpBCMdB5U5ZfPPZb9O0P+NbZTpC+vvSSPhLc78uxTYccDKfmEO9ImHj1TEdTxoo0l8FEthDzuIPlpkOk5GehD9JgNbleid0E6RJP8A9P5cTQX36NWl/40VXPcKAhai9K/zTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237663; c=relaxed/simple;
	bh=Gqo7/xX/eCZF87ChJExToKohynJ+OjgeWaMFMnimOyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNau/uMFNl7tANHvnx8gOExmTYSSb3JlB+Q7WRXalY4RgHRn12fX5YnqPoq5jfv2gPw4Naj6piYneDhqUr4iO8U/5CciuVBenT8PjwroIhPN1lJfS8wudNF9C5D4rGX6JkjUUVnb8hP5CwaBr08D26xmU3vVOhwLve36r5rPuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAK7E50c; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAK7E50c"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so4329209a12.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747237660; x=1747842460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdVghsJNkNuRJ3BLdCOMycrklMirpXXwXaE+tBC/z/A=;
        b=MAK7E50cfsFygwyOuSS2DIRzoAYoxOoW6E5BBVjTtrafexoM4b4XbmMbfsqB2SFMlW
         a2nTrdl86hmumzEWQ8OIjKfaiB7Nt/G5Tpe7ldjthnLAG5e8R3cdZsBL7puNwyKAfYU6
         E/N7IfGyXFqZ7RaVmR7IqvM9o3jmXJ9Dx0QThq/2ILfc7/Wk1fjEKfVXzx9p4sb4yJR7
         E0rgY+2WQJ6lpsW54ghbxU4DPssqgkstv/0r2HAE7l0uFSX10yko30Ont1GUHgO4v+Gu
         Et1ruIwyOg9Tls9hDvutp3u46fxNIfY+ScwTnoQPkB3Zx2DUJ6zC5YLQKflqanRJpvuo
         xVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237660; x=1747842460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdVghsJNkNuRJ3BLdCOMycrklMirpXXwXaE+tBC/z/A=;
        b=AQbbgVa3Ml753YFD2N1/RXB7yumJKWYJXASKm6V8P9W6RTFoyvSWPCKsHUpZSXj0rc
         lIQij/oKYYVeDPPVbk5PpvY61fX49C6LkDFjHnIEY9cC4XpyxF97+FUu+RNCk9WZKWJ5
         sDZaNPbMo3hYOTgZnbtEsP4Cwx+7csEaEwm+uwOTPQd96OxRMlYKvvmQSdGinwR/d4oB
         4bixxrwij98IEsWV0xDjIzKt86Pb7iRvPr4+i4CgOgNBG+BieEBwy+tuCNw21btCSduB
         mrVHtR2bMEnzCBRk90h6nb8nCKSmLZyeDPohTwnxpfc1kOnZLuUv28Oa9U5LqRUxiZ1/
         I33g==
X-Gm-Message-State: AOJu0YzaUHx8ipbmSebAibYJCvOAfztsq8YK+28+I963yOt9vJavePIo
	wRVFMfZkzNI+zfg90JNXUVvnNMJ4XVxzvouLrLmkCDfzKtHMJrLHU0A5lg==
X-Gm-Gg: ASbGnctmhiM+cIh7cMeoqnt0fz401vFwOHAX4X2pDX77qLNDK3JDvtT2IgOHIA63ISl
	y3t+6PC2EWme0q/6TlmjtD3ADYb2WV0hjWqq8zHjPm3E4z2aDJZCJ3LXGZNd6ipEppGBDQos3OW
	umzgRjFIhYX7A40gkX6GKT1ndR66eTzX3Q3AXMqc8CMHx+kVENjIxC1WsGKRAcHWIJrKzqIBYqT
	47h3YDUKVp7okT/9AXwgXm3BrkmAxYnYQ2LBynz4/GjtpRlOEt2EVtyzfZ6f79eVXrNgQLUsYTD
	w0WSoCLClisKZ6ZgOxEMuFryuSDaQPcU7tKzFYw6egewHRc=
X-Google-Smtp-Source: AGHT+IE548LDAE30M07a1EAImLQLAq7YUyLIcMc3ZozjoYX7iFg+999ASC+YdqlcOArM9lUC33lnEQ==
X-Received: by 2002:a17:902:ea06:b0:223:2aab:462c with SMTP id d9443c01a7336-231981353b1mr50355615ad.15.1747237660025;
        Wed, 14 May 2025 08:47:40 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc8271cd9sm100256585ad.111.2025.05.14.08.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:47:39 -0700 (PDT)
Date: Wed, 14 May 2025 23:48:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/3] align the behavior when opening "packed-refs"
Message-ID: <aCS7O8tNekg_u9Wp@ArchLinux>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCMnrwkoJ2WyqGZT@ArchLinux>

Hi All:

As discussed in [1], we need to use mmap mechanism to open large
"packed_refs" file to save the memory usage. This patch mainly does the
following things:

1: Fix an issue that we would report an error when the "packed-refs"
file is empty, which does not align with the runtime behavior.
2-4: Extract some logic from the existing code and then use these
created helper functions to let fsck code to use mmap necessarily

[1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net

Really thank Peff and Patrick to suggest me to do above change.

---

Change in v2:

1. Update the commit message of [PATCH 1/4]. And use redirection to
create an empty file instead of using `touch`.
2. Don't use if for the refactored function in [PATCH 3/4] and then
update the commit message to align with the new function name.
3. Enhance the commit message of [PATCH 4/4].

---

Change in v3:

1. Drop the patch which creates a new function
"munmap_temporary_snapshot". As discussed, there is no need to munmap
the file during fsck.
2. Allocate snapshot variable in the stack instead of heap.
3. Fix rebase issue, remove unneeded code to check the file size
explicitly.

---

Change in v4:

1. Report the "emptyPackedRefsFile(INFO)" to the user when the
"packed-refs" is empty instead of ONLY skipping checking the content and
update the shell script and commit message.
2. Apply Peff's advice to make [PATCH v3 2/3] more clear.

---

Change in v5:

1. Improve the commit message in the first patch to be more clear:
    1. Talk about the current behavior, what error we would report if
       "packed-refs" is empty.
    2. To align with the runtime behavior, we should skip checking the
       content of "packed-refs".
    3. Why do we need to report to the user when the "packed-refs" is
       empty
2. Fix grammar issue in the last patch.

Thanks,
Jialuo

shejialuo (3):
  packed-backend: fsck should warn when "packed-refs" file is empty
  packed-backend: extract snapshot allocation in `load_contents`
  packed-backend: mmap large "packed-refs" file during fsck

 Documentation/fsck-msgids.adoc |  6 +++
 fsck.h                         |  1 +
 refs/packed-backend.c          | 73 ++++++++++++++++++++--------------
 t/t0602-reffiles-fsck.sh       | 17 ++++++++
 4 files changed, 67 insertions(+), 30 deletions(-)

Range-diff against v4:
1:  75636c9c85 ! 1:  3487692a03 packed-backend: fsck should warn when "packed-refs" file is empty
    @@ Metadata
      ## Commit message ##
         packed-backend: fsck should warn when "packed-refs" file is empty
     
    -    During fsck, an empty "packed-refs" gives an error; this is unwarranted.
    -    The runtime code paths would accept an empty "packed-refs" file, such as
    -    "create_snapshot" would simply return the "snapshot" without checking
    -    the content of "packed-refs".
    +    We assume the "packed-refs" won't be empty and instead has at least one
    +    line in it (even when there are no refs packed, there is the file header
    +    line). Because there is no terminating LF in the empty file, we will
    +    report "packedRefEntryNotTerminated(ERROR)" to the user.
     
    -    And we should also skip checking the content of "packed-refs" when it is
    -    empty during fsck. However, we should think about whether we need to
    -    report something to the users in this case.
    +    However, the runtime code paths would accept an empty "packed-refs"
    +    file, for example, "create_snapshot" would simply return the "snapshot"
    +    without checking the content of "packed-refs". So, we should skip
    +    checking the content of "packed-refs" when it is empty during fsck.
     
         After 694b7a1999 (repack_without_ref(): write peeled refs in the
         rewritten file, 2013-04-22), we would always write a header into the
    -    "packed-refs" file where we would never create empty file since then.
    -    Because we only create empty "packed-refs" in the very early versions,
    -    we may tighten this rule in the future. In order to notify the users
    -    about this, we should at least report an warning to the users.
    +    "packed-refs" file. So, versions of Git that are not too ancient never
    +    write such an empty "packed-refs" file.
     
    -    But we need to consider the fsck message type carefully, it is not
    -    appropriate that we use "FSCK_ERROR". This is because we would
    -    definitely break the compatibility. Let's create a "FSCK_INFO" message
    -    id EMPTY_PACKED_REFS_FILE" to indicate that "packed-refs" is empty.
    +    As an empty file often indicates a sign of a filesystem-level issue, the
    +    way we want to resolve this inconsistency is not make everybody totally
    +    silent but notice and report the anomaly.
    +
    +    Let's create a "FSCK_INFO" message id "EMPTY_PACKED_REFS_FILE" to report
    +    to the users that "packed-refs" is empty.
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
2:  1a5893379d = 2:  0d050849bc packed-backend: extract snapshot allocation in `load_contents`
3:  31e272db7e ! 3:  fe5ffec8fb packed-backend: mmap large "packed-refs" file during fsck
    @@ Commit message
         current codebase.
     
         As we have introduced the helper function "allocate_snapshot_buffer", we
    -    could simple use this function to use mmap mechanism.
    +    can simply use this function to use mmap mechanism.
     
         Suggested-by: Jeff King <peff@peff.net>
         Suggested-by: Patrick Steinhardt <ps@pks.im>
-- 
2.49.0

