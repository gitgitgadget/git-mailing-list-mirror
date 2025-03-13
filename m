Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CF264FBD
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865111; cv=none; b=D0yV3JgckTYmsJuF7nVKMmWgiVkGJghtkzGWjCh32X56+MF999DbJzIrf0b0vUN8aSZwUyEn1/XU1Qd2WayKyeO+bCGfbp7ZAFJwGRmBTe17gwoHhuZFqfo6614pTgG9LbYfKpmOtSK0jiEIxWHFj4qRWFx1H+WH+pv+vj/Tlp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865111; c=relaxed/simple;
	bh=2N95GN3vaeFXCYTZpnd3VXK7bgGHMa1qB0VekpD0c2w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPnDKOvQounDpLi4uK+xP3aunPAvgejG6nxoP0Z+MLGLXTt07vtImmEjKwn7kyRMAnf4AbZiEFkJWvNZYkBwKXegdTxBiXB46IbTssgk4apvWonJgtDvnEhUZFrlVrJFm9+Q253JEOVET5m/qkgVv0LRg0wKi+9O8WdVLjkWESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MizGfCaz; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MizGfCaz"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5240764f7c1so354435e0c.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741865108; x=1742469908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFk++i5WSIV2Nx7rI1TWn8B6tIocaIwlx9+LgCrT8gY=;
        b=MizGfCaz7leNkdaMC2iB6niz8I2MmBNl0Reqv1M0/gTz17L+G6YIWp+JF3kTeh9vQk
         EtFzbqyGDvijz/0gTQrSQZhXRDM89mJK2KhySKxPGNaIKg1iKnjsUdko979180o6+VYv
         b344tqXcAeb7+6zD4N+7t0og1ew1zhT8NLvHeqHUgK45OjqJuFn8qJyGOGOxzmNE+wOF
         Q8bPwWACf2hlXb7feZk/nIspvxjebynzTLYtWkabdubI/DbK1zOHbXNDNnyzxtGwoSBz
         UQ5/tR21/RApQ9rdW+nW3b5eLDH9TgGQOcLc95Cwy7/Aav7cUbMnz79stmbfwTfLThhi
         YtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865108; x=1742469908;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFk++i5WSIV2Nx7rI1TWn8B6tIocaIwlx9+LgCrT8gY=;
        b=dnExggkm91kcYgMDvuK1vtWPDnrn75PXCbXfal5poWwuOwMcNooaCdiUO+T/aiSoXT
         dscKKBPwMG7AC8TAEDGpNnOvx+MIb2T+DRSIFBrmG/ICRr5EDoY5OZEhdL8TllbT6kW1
         gIfnfwP61eO56kKVBxCWvcqLAcXnv6XBCQPlBwHeB30wYcWaoMVV/h5droNbooyVORL3
         xMNHCRwsh+EDpJBmqrlAPfyAtudIJiqv/unGrY34K2Rpik9kxZw7vcy/iHHbpoXhxFRG
         I5NL3jfvdAs7oLJhvzq2EsS+OIK+VT1oxFLWpAx1kDmwhmK+6ixOTKZiM8XwT7wVN/mL
         UKNg==
X-Gm-Message-State: AOJu0YzpyLgTL6eJFF+v/F7vwqHFELfdukepViz22HstW1x5DnSaMi9X
	yjO2Qw9kGVmHHLKNsYh30M3YMMPBC7I+74TV3phG47w67ZTHtBoiBKxfYioFgs9DOwHhseaC4Ge
	LozSp4609LwrR7to0vUCpBlmjJrtOPVQw
X-Gm-Gg: ASbGncsnqRj4weofmi6l4ANIo8REjEkqOjm9BBdT1LDPO+1RzPCwbg5420u/T54/Xg0
	tiOCghZ+fh++eDz653kIVW3QGbNLCLTODlNfZ+p77sDhPB+VYZIgXmW5oR6pL0BUryDWKB2xQU+
	g5VUJRLT3scQ7COcBjxZD4wdSz4C8=
X-Google-Smtp-Source: AGHT+IHhEUUjXDb0vrb8tjGRGolnkShcmB0oXY3wZA/Sane0Vcoo83akK/2IxLd80x5jPfhr68Z4SAoBXKCV4ffKdGk=
X-Received: by 2002:a05:6122:918:b0:520:3e1c:500f with SMTP id
 71dfb90a1353d-52419948798mr9480262e0c.8.1741865108143; Thu, 13 Mar 2025
 04:25:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 07:25:07 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0x9s8mg.fsf@gitster.g>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com> <xmqqy0x9s8mg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 07:25:07 -0400
X-Gm-Features: AQ5f1Jpfafty01A822OKsYlc9CjpdszaAkzD5lrhklHUaSwbUiR6RiSIQ1cZbwE
Message-ID: <CAOLa=ZTia95Lib6bkz_nWi2BYEteAaOxsrrX9DqLTEz1t02ggA@mail.gmail.com>
Subject: Re: [GSoC PATCH] rm: fix sign comparison warnings
To: Junio C Hamano <gitster@pobox.com>, Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000004a69a0630379339"

--00000000000004a69a0630379339
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Arnav Bhate <bhatearnav@gmail.com> writes:
>
>>  static int get_ours_cache_pos(const char *path, int pos)
>>  {
>> -	int i = -pos - 1;
>> +	/*
>> +	 * This function is only called when pos < 0, so -pos - 1 is
>> +	 * greater than or equal to 0, so it can be safely be stored in
>> +	 * an unsigned int.
>> +	 */
>> +	unsigned int i = -pos - 1;
>
> "Can be safely stored", sure.
>
> But so is "int i" perfectly adequate to hold such a value, no?
>
> This is one of the many instances that demonstrate why the
> "-Wsign-compare" warning is of dubious value, and invites worse code
> than necessary.

I have to agree. I think it would a bit cleaner to actually change the
functions argument type itself. Perhaps, something like:

-- >8 --

diff --git a/builtin/rm.c b/builtin/rm.c
index 12ae086a55..79e47d6e9e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -40,10 +40,8 @@ static struct {
 	} *entry;
 } list;

-static int get_ours_cache_pos(const char *path, int pos)
+static int get_ours_cache_pos(const char *path, unsigned int i)
 {
-	int i = -pos - 1;
-
 	while ((i < the_repository->index->cache_nr) &&
!strcmp(the_repository->index->cache[i]->name, path)) {
 		if (ce_stage(the_repository->index->cache[i]) == 2)
 			return i;
@@ -83,7 +81,7 @@ static void submodules_absorb_gitdir_if_needed(void)

 		pos = index_name_pos(the_repository->index, name, strlen(name));
 		if (pos < 0) {
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(name, -pos - 1);
 			if (pos < 0)
 				continue;
 		}
@@ -131,7 +129,7 @@ static int check_local_mod(struct object_id *head,
int index_only)
 			 * Skip unmerged entries except for populated submodules
 			 * that could lose history when removed.
 			 */
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(name, -pos - 1);
 			if (pos < 0)
 				continue;

>> @@ -58,7 +62,7 @@ static void print_error_files(struct string_list *files_list,
>>  			      int *errs)
>>  {
>>  	if (files_list->nr) {
>> -		int i;
>> +		unsigned int i;
>>  		struct strbuf err_msg = STRBUF_INIT;
>>
>>  		strbuf_addstr(&err_msg, main_msg);
>> @@ -271,6 +275,7 @@ int cmd_rm(int argc,
>>  {
>>  	struct lock_file lock_file = LOCK_INIT;
>>  	int i, ret = 0;
>> +	unsigned int j;
>>  	struct pathspec pathspec;
>>  	char *seen;
>>
>> @@ -314,8 +319,8 @@ int cmd_rm(int argc,
>>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>>  		ensure_full_index(the_repository->index);
>>
>> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
>> -		const struct cache_entry *ce = the_repository->index->cache[i];
>> +	for (j = 0; j < the_repository->index->cache_nr; j++) {
>> +		const struct cache_entry *ce = the_repository->index->cache[j];
>>
>>  		if (!include_sparse &&
>>  		    (ce_skip_worktree(ce) ||

--00000000000004a69a0630379339
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 26c49781e75ee51d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mU3dKSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzUvQy80NnNmcWJ1ejFoR3FKVndmZXFsNTdhTFl4KwpqalVYejREYVZG
aE9DdW9NSjZ1NUYrdUkzZENnbTNDNzNmY21RUGl4RXdyd25laXcrMUExbVhXR2lZSXRpd0hKCkc5
NWxXNVErcmtnaWtFZllMVTZtSDBXckh4QTFsWDQxK05nMms3MXVXbGpVVFh5SXBIQzlodmFYaGNa
cEZrT1gKc1M0WWU4R0JVRkpxT1JxSm1zWnpUWHpNT1laU1E4bzUyUjhiNTk1M3dvZmhDQ0pLbzZP
SjJtam5zN1o1WlYvaAoyeDBCQzd4bmxJYjBtUFc1YS96dy9GZW1mNTNRZ2U1UG9IVkJMbmhpM292
T3M3cUNTMGJ5RVhHbk1JUXdsOWxpCjNrRHhnRTIwODZMV3dwa2w2RWV0WjVoNlpCTk9kMUZGTktD
RDBaRlJ2Z0wrOHkrdkoySjZCTURTUk56dWFqdE0KQ0pPelJaaUlRbnZUY2VRa2Z3K2NtbVFKVFlI
bVJFOEN4UHRleUN2cFdmd3BwMlYwV3krZ0c2MjVFNTROOTdVTgp4RlY2UUowbGx4NWFkdWpyVXZM
REVMU0FZK1I3Y2ZKczVOYjVubGc1WEg5dS9uYWlpaVhEblFsZjJQYit0elY2CmZSejRodDlWODJh
QlZPTGVsQU5FcnlPd2Nrc3U2R0hhTFVCVURxOD0KPXNvalAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000004a69a0630379339--
