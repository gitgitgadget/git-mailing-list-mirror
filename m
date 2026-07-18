Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF13451B3
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411409; cv=none; b=Qa7E7f4ZnCOoxkRgn7cvbJFYPbdiIfshIpUk5bO7ratNBU4D0iOiNdSdqd9CvteOjl4HM05ep4kEqOwtE1xNiMDK6oy+pDdUB5wNciPU36DClQFX7ZI7CmCxpTVOIoJI9kzM1BNhX+gdcFtZytzWLmjtiEYSEO3kY1yR5QHbz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411409; c=relaxed/simple;
	bh=l26tm/j5YPgivGT2YMy+unaLTE6ZouXLN/I0gF/qgF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4mo+hXDfWnhlthHzXFLHJsz8ufYE0CHcNlTOWR4Blllqfdl5U5yIWV0yQoP4DGcl3IHgLJgutGOqUkQGvuv7bOOZRui7XU1barNHrcouziN/IAOx00Sj7OJGdv6eI+LLEA1+4Na35LvmGB8UU5lo6tJKhTX6VKGSzxPsqEfAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kjr99EWs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjr99EWs"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4953ddae026so28331495e9.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411406; x=1785016206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H6dFdXd2+FSptooHfX6yXyvUOaUTN/tQz8Ss0DplLuw=;
        b=Kjr99EWsN3QzCW3mswSz96P7Ur0c5KqlJo2qDUNDlbihNT/RYh/PayvN6Sjuv7IlZr
         rrfgyYTPz6oc4tkzIgJRy7YoHgHMcUWqYI7cq4WYwciO6yNG4Cc2tzuZafRTdFUV8jhs
         nfNzYI703yWn3VadVEQdobzzlVA2AeRz+EBAVpBPlA8Udc+zKuKesU9qzfK8tauuApzF
         sq+jM5IegxlpCT8VQeMTEanrhMwPQP25sBRvHzJT3JoSied4/Z8A7YyFuITjnBpxWg16
         kTCcpgn0GPCdXD7iE3O3a1cT4OEqJxLl36dNeWmRr9m7KHkeYTJKtRYAXJRiL/nKcwsZ
         2+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411406; x=1785016206;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6dFdXd2+FSptooHfX6yXyvUOaUTN/tQz8Ss0DplLuw=;
        b=FerlJTIfm3bTmhzfOZGudK8KtJ/aaLY0x02qMI/ECiI3DF6k71dTAqa7tL5w6AH6Gk
         1HjIhly9JxrOu62k8Gx92L1Ub4ROI1wTwAUObHvTMDFUKuulGgqbcWqdcKmlpavBXZYb
         E4cvEhAbRu44ShZyKuz714pSuIlwBeVEl2QWA/e8P/6WFXatEpLuG2ptNmBi699Ki8LZ
         r6BbbfkFo4MlBZggNQELLC1pg2wZfmAltjxrh4P/ZDxDghmWopHc8vXtdmb8xgdxrpgx
         o0e0Z2sD6NWfqVTpv+sLGCgVmY85OzHhnUVh5vHDqzYZaflrBwPNtgjyg484HhPF8m7d
         PmjQ==
X-Gm-Message-State: AOJu0YwoDbV8cL18vj/GnOaUsBW5m5XGPEy11roz6Qeh0VBkliGtT2UV
	ESDu7uj8+fNr0UtE1wN8bLyrG/mjR6PKF95epI16xIeLi/CIiJffkeApGhnR5VzR
X-Gm-Gg: AfdE7cmByiZbyL0NQYUPa5c1u//NXRIRpuoi8FLlu+cbzkcyxfAe4WiBuc1+t7bI0j8
	nJRB4z6gT06XzVNtpwWPss02eTKubKw02A8e7ux2AZ1K2dNK5E0a+g0/8c6Fhjp7J9SrMvVbOf2
	nZnySRieMGWLozvYIIkc7SzuqLmdQmznkD+ynnzRV1kQSoWlzgx66O/kHCf4AoCv3SiOaLhRs9n
	oE9tTIhBSmeKFgwj7wOKEdp3CopMEtMj/ZC8EemXnDGBYXQhLhaxMin6tkYExcne5KDEPoBaOOu
	Z7/pKi6jlcnCeCW8Ws6M3bAkp71QqYPdquNwvQUmHVZyF2bpUyJBqMvHiQhx8sYhiuZ+kX9ozx7
	nG9fMwIZMxFJv8fsmEnvvKwliaglKHXMkvvAAwe91wOtVmdHw5ysxifBdeGtVi+/lOa7Ur9oJww
	VNFmaJ5x83eQ/zTVH+axlqwMcKAPeVOxdDfvQ7h6CZ7C5oxHJ+iwSgrdA4QAWZl7N5U+QkkENzo
	C2UzsPjltiPYGp96PLoi24FzedONQ4+wNUoVAZX49DgcUfO87vx+DZppRgl2oTpL/kI0AiuSNmp
	/UMxGAgsw/CctdWt9i5HiZf8dt15FY8z
X-Received: by 2002:a05:600c:5493:b0:493:f80c:5455 with SMTP id 5b1f17b1804b1-4954a3d0cb1mr87473425e9.5.1784411405713;
        Sat, 18 Jul 2026 14:50:05 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:05 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 00/13] cat-file: add remote-object-info to batch-command
Date: Sat, 18 Jul 2026 23:49:49 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260608-ps-eric-work-rebase-b73ae84ba671
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Eric Ju's
(eric.peijian@gmail.com) and Calvin Wan's (calvinwan@google.com) patch
series [1] and [2] respectively.

Sometimes it is beneficial to retrieve information about an object
without having to download it completely. The server logic for
retrieving size has already been implemented and merged in a2ba162cda
(object-info: support for retrieving object info, 2021-04-20) [3].
This patch series implements the client option for it.

Eric's series adds the remote-object-info command to cat-file
--batch-command. This command allows the client to make an object-info
command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info
capability, cat-file --batch-command will die.
If a user attempts to use remote-object-info with protocol v1, cat-file
--batch-command will die.

Currently, only the size (%(objectsize)) is supported end to end in this
implementation. The type (%(objecttype)) is known by the client's
allow-list and request path but is not supported on the server side
nor the response parsing. A follow up series will add full end-to-end
support for %(objecttype).

The default format for remote-object-info is set to "%(objectname)
%(objectsize)". Once %(objecttype) is supported, the default format will
be unified accordingly.

If the batch command format includes unsupported fields such as
%(objecttype), %(objectsize:disk), or %(deltabase), the command will
return empty strings for each unsupported field.

This series completes Eric's work mainly with the refactor of the
validation of the placeholders with an allow-list that filters what the
client asks with what the server is capable of providing, following Jeff
King's idea [4].

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29660677279

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/

Changes in v20:
- Moved the prep patch that fixes hash_algo's type to be before
  write_fetch_command_and_capabilities() being moved to 'connect.c'
- Reverted git-cat-file.adoc documentation comments about CAVEATS
- Fixed style for EXPAND_DATA_INIT
- Added more context for comman line die()

---
Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Eric Ju (3):
      cat-file: declare loop counter inside for()
      t1006: extract helper functions into new 'lib-cat-file.sh'
      cat-file: add remote-object-info to batch-command

Pablo Sabater (7):
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: drop the static advertise_sid variable
      fetch-pack: use unsigned int for hash_algo variable
      fetch-pack: move write_fetch_command_and_capabilities() to connect.c
      connect: make write_fetch_command_and_capabilities() more generic
      protocol-caps: check object existence regardless of the attributes requested
      cat-file: make remote-object-info allow-list adapt to the server

 Documentation/git-cat-file.adoc        |  24 +-
 Documentation/gitprotocol-v2.adoc      |  21 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 222 +++++++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    | 156 +++++++
 fetch-object-info.h                    |  25 ++
 fetch-pack.c                           |  58 +--
 meson.build                            |   1 +
 object-file.c                          |  10 +
 odb.h                                  |   9 +
 protocol-caps.c                        |  45 +-
 serve.c                                |   5 +-
 t/lib-cat-file.sh                      |  16 +
 t/meson.build                          |   1 +
 t/t1006-cat-file.sh                    |  15 +-
 t/t1017-cat-file-remote-object-info.sh | 747 +++++++++++++++++++++++++++++++++
 t/t5701-git-serve.sh                   |  63 +++
 transport-helper.c                     |  12 +-
 transport-internal.h                   |   8 +
 transport.c                            |  44 ++
 transport.h                            |   9 +
 23 files changed, 1442 insertions(+), 92 deletions(-)

Range-diff versus v19:

 1:  6df5bcb3bc =  1:  31b02f10b5 transport-helper: fix memory leak of helper on disconnect
 2:  141d85a76f =  2:  7d62e0586f cat-file: declare loop counter inside for()
 3:  87457a1fe3 =  3:  082d593fb7 t1006: extract helper functions into new 'lib-cat-file.sh'
 4:  c26d378931 =  4:  8646b9d7cf fetch-pack: drop the static advertise_sid variable
 -:  ---------- >  5:  5531a3c399 fetch-pack: use unsigned int for hash_algo variable
 5:  ee16e17228 !  6:  92b4122642 fetch-pack: move write_fetch_command_and_capabilities() to connect.c
    @@ connect.c: int server_supports(const char *feature)
     +	}
     +
     +	if (server_feature_v2("object-format", &hash_name)) {
    -+		int hash_algo = hash_algo_by_name(hash_name);
    ++		const unsigned int hash_algo = hash_algo_by_name(hash_name);
     +		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
     +			die(_("mismatched algorithms: client %s; server %s"),
     +			    the_hash_algo->name, hash_name);
    @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
     -	}
     -
     -	if (server_feature_v2("object-format", &hash_name)) {
    --		int hash_algo = hash_algo_by_name(hash_name);
    +-		const unsigned int hash_algo = hash_algo_by_name(hash_name);
     -		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
     -			die(_("mismatched algorithms: client %s; server %s"),
     -			    the_hash_algo->name, hash_name);
 6:  bb915f57ad <  -:  ---------- connect: use unsigned int for hash_algo_by_name() calls
 7:  b3b06b0cae =  7:  b954a5994a connect: make write_fetch_command_and_capabilities() more generic
 8:  79a87c7011 =  8:  627242a7a1 fetch-pack: move fetch initialization
 9:  37c3f93975 =  9:  0578594733 protocol-caps: check object existence regardless of the attributes requested
10:  c5062ecaf2 = 10:  816bfa9162 serve: advertise object-info feature
11:  22d72168bc = 11:  2323f45cb2 transport: add client support for object-info
12:  2cf3b24a35 ! 12:  a39975766b cat-file: add remote-object-info to batch-command
    @@ Documentation/git-cat-file.adoc: one per line, and print information based on th
      You can specify the information shown for each object by using a custom
      `<format>`. The `<format>` is copied literally to stdout for each
     @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
    - 	reports).
    -
    - `objectsize:disk`::
    --	The size, in bytes, that the object takes up on disk. See the
    --	note about on-disk sizes in the `CAVEATS` section below.
    -+	The size, in bytes, that the object takes up on disk.
    -
      `deltabase`::
      	If the object is stored as a delta on-disk, this expands to the
      	full hex representation of the delta base object name.
     -	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
    --	below.
    -+	Otherwise, expands to the null OID (all zeroes).
    ++	Otherwise, expands to the null OID (all zeroes). See `CAVEATS` section
    + 	below.

      `rest`::
    - 	If this atom is used in the output string, input lines are split
     @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
      	after that first run of whitespace (i.e., the "rest" of the
      	line) are output in place of the `%(rest)` atom.
    @@ builtin/cat-file.c: struct expand_data {
     +	 */
     +	unsigned is_remote:1;
     +};
    ++
     +#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
     +
     +static const char *remote_object_info_atoms[] = {
    @@ builtin/cat-file.c: static void parse_cmd_mailmap(struct batch_options *opt UNUS
     +	line_to_split = xstrdup(line);
     +	count = split_cmdline(line_to_split, &argv);
     +	if (count < 0)
    -+		die(_("remote-object-info: %s"), split_cmdline_strerror(count));
    ++		die(_("remote-object-info: failed to parse command line: %s"),
    ++		    split_cmdline_strerror(count));
     +	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
     +		die(_("remote-object-info supports at most %d objects"),
     +		    MAX_ALLOWED_OBJ_LIMIT);
13:  ebdfc22fb7 ! 13:  70a11d2aea cat-file: make remote-object-info allow-list adapt to the server
    @@ builtin/cat-file.c: struct expand_data {
      	 */
      	unsigned is_remote:1;
     -};
    +-
     -#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }

     -static const char *remote_object_info_atoms[] = {
     -	"objectname",
     -	"objectsize",
    ++	/*
    ++	 * List of atoms (i.e. "objectsize") that the server supports. Built
    ++	 * from the server's object-info advertised capabilities.
    ++	 */
     +	struct string_list remote_allowed_atoms;
      };
    -+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, \
    -+			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }

    ++#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, \
    ++			    .type = OBJ_BAD, \
    ++			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
    ++
      static int is_atom(const char *atom, const char *s, int slen)
      {
    + 	int alen = strlen(atom);
     @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, const char *atom, int len,
      		       struct expand_data *data)
      {
    @@ builtin/cat-file.c: static int expand_atom(struct strbuf *sb, const char *atom,
     -			if (is_atom(remote_object_info_atoms[i], atom, len))
     +		size_t i;
     +		for (i = 0; i < data->remote_allowed_atoms.nr; i++)
    -+			if (is_atom(data->remote_allowed_atoms.items[i].string, atom, len))
    ++			if (is_atom(data->remote_allowed_atoms.items[i].string,
    ++				    atom, len))
      				break;
     -
     -		/*

---
base-commit: 44de1520f08d1dfebc3ab2d9f644208eaa5ac925
