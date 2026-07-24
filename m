Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BB426D22
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890474; cv=none; b=HJkpXgFEcpax2Y7Wbmuw6Oe+JjfgBVhRlyCNBZMvqcLHVkv98iBw+IkV+Wo8o2DYvUMyT9Z2q/V/sAK0oPFivmF4an57DuFUzLC6KtH3cnCCnyS+iiAiBPt/+iC/Gpzvk6YmampfF1n1cO060sp7fHn4FmSXn8D2idAYBfJcbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890474; c=relaxed/simple;
	bh=pDZZ4ndfGFCyaxhBLY5SYcHuGS8pXnTLa6r1Vpbtvfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otwg+UlYss2MW63tUPnU3WaNt5D+g3xrE0Del0rDNqEcjgLgvtDegZ7R43rWXMdqRqWTVoGtCrWCSf0twW9Ie5tqwpJq3FUuO/7S86SVNq6TJ16MrjFxeo2iImx/u8trBHWCLgyigtmp9pa3arm1qVQNUJ81nmS9DOcAHK3OArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C06UtYtP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C06UtYtP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49553515a8bso3517355e9.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890467; x=1785495267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ZhuFr/UhYQBcs7TEMCnshVPKIH/HMZjwdsmSIVbP8E=;
        b=C06UtYtPDLlr3fE+OnH1NYU/qsaRXW80X3+zLYXIucvQfo+G/B8TM89rRwqVKSUD8W
         6zqH3vcuFDsB/84llezZgRc8FPXs1ICJ9uJHBeMJtsSCC+OBOZXRG9LfO5sYu2butIU9
         OSS3toJCdWsw/JQ5CXFVwdrpZVfdVKHffM5FBTAfKib+5Taco2LqP4iwiqDpOLjNYPuU
         Zs0rnjtG26sPobjLyBeAPZepCLS9uljjArefBaZAV3LFyn9ggTyDbtOo31URya5qvWWe
         IqosndzXGFX7geAtKNfwOPwxs4mVIb6MeIWTfPND1EI7mceYHQ3A/k1Uy7fu1D/DB280
         qgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890467; x=1785495267;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZhuFr/UhYQBcs7TEMCnshVPKIH/HMZjwdsmSIVbP8E=;
        b=eihJXc7OoEFkWbaqKWSN0kgz2LL/GHHgQrgt7mn1yuTHoyDloLdHKv/nHxXfMEoK7o
         qh8N1NBu4uf+ngKNFUXiMvVbCqBJ+JrQeRh5SZzmFzGoTko5pCbtQQOaCYwp7554FTA7
         99bmhFzOfcvshBMZ2MdzaNB0BdhWi7yH3D4Wq+ZEjGmch1PUDIlmhmwsLtirVpaAdT9s
         K7rlM05dmtfTdZynh+aYPnfLMNuKD9uTfGZ3m6iCdu2p2Y6QTLVkDpWCYzuNVRUU9gxL
         yCzIPbg/W8vMSERd8Bf/HNnr+R3mC+C6z0tmOLSvrjLZbgzu+X0c7SPM5xuBpta4G+yV
         3mPg==
X-Gm-Message-State: AOJu0Ywq6mKRlam9ioU8aDj8JWlYJ+oOBpNksg+yaSXtOvQMolXtCEtA
	LFdit5jGK4iknbcoxRvvIW0Iqij1p9YrQb9yjr67Y035TBU285Rlq56mFdjtV/P8
X-Gm-Gg: AR+sD11/nGYkabhkYauHblsJxd6qd9NJvgP5BLO0Ycr+B0kHIlsDr8Agg1+w5iViV4d
	2VV8IMMDElIi67HLStkGUvc6/DZtnHGByP5zK+sTuHcUL+Npc6v3uT+8qUMA+ndOil8qEYqtDHK
	MN4gP9/K2xbvFmT+LjpSRYtVC0Jkc0jYzqFtEefn81VR8Di34KIgST9ZCvEkYEpxHgkdQOjhWMi
	htvYverhLPyNYZ57KhvwgWZtYBEPzLaAGnWkG6gY7bjSP7NHXkUZAtkdZ4JMwOtoILAoxDi3NbD
	yPkMosOGJmcMIX3MjZMCZ4UbUxwIkqMQBl/bAT+P0NkWyM8ZqSO9fxOsGn/fm2A5vY2A5Rqwtpx
	VCYghf2baTSYI0vBPIrIiZ2Xt/a0QsF+rq6L0IZL1grV7N4Oa+0NxbFNcVqVtziEnaC1mN2vbdE
	lrkaU+mduI9OYsaYAcOAtdRMV2L76PfoX0cj8FRLZmF1wGuDY4g4wwQcFQJTUFP7YPNbhtJHJnu
	dSQhmLJD262GldYaMUfcsEqR2JirE30qsqLr9oWyj1+8Mu0oXdzA2hYQ09lerbzH7nG3jG9MQOe
	5RnusSAHXW7AkJUxFyGIvFNV90D3m1rrpa4l
X-Received: by 2002:a05:600c:5490:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-49573cbf852mr74351105e9.3.1784890466813;
        Fri, 24 Jul 2026 03:54:26 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:26 -0700 (PDT)
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
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 00/13] cat-file: add remote-object-info to batch-command
Date: Fri, 24 Jul 2026 12:54:11 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
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

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/30086202054

[1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
[2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
[4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/

Changes in v21:
- Dropped unnecessary change in git-cat-file.adoc
- Fixed EXPAND_DATA_INIT macro formating
- typo and blank line before WARNING:

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

 Documentation/git-cat-file.adoc        |  23 +-
 Documentation/gitprotocol-v2.adoc      |  21 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 224 +++++++++-
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
 23 files changed, 1444 insertions(+), 91 deletions(-)

Range-diff versus v20:

 1:  ddc6386af3 =  1:  6c868e0e29 transport-helper: fix memory leak of helper on disconnect
 2:  24e0c07dde =  2:  40579c0095 cat-file: declare loop counter inside for()
 3:  08882a9ddd =  3:  b70d1f91c4 t1006: extract helper functions into new 'lib-cat-file.sh'
 4:  0925c208c1 =  4:  5c5050d541 fetch-pack: drop the static advertise_sid variable
 5:  f130092dd9 =  5:  29c321ad3e fetch-pack: use unsigned int for hash_algo variable
 6:  37326255e9 =  6:  bdcd407a22 fetch-pack: move write_fetch_command_and_capabilities() to connect.c
 7:  069b9d4def =  7:  970d59e2cf connect: make write_fetch_command_and_capabilities() more generic
 8:  4225d3087c =  8:  86c64d10d7 fetch-pack: move fetch initialization
 9:  af3b2bb293 =  9:  7007808819 protocol-caps: check object existence regardless of the attributes requested
10:  99df8374df = 10:  2f5acaa540 serve: advertise object-info feature
11:  380bca2a43 = 11:  abb9306254 transport: add client support for object-info
12:  eb48e94f6f ! 12:  36fe34a596 cat-file: add remote-object-info to batch-command
    @@ Documentation/git-cat-file.adoc: one per line, and print information based on th
      `contents` command followed by an object prints contents in the same way
     -`--batch` would.
     +`--batch` would. The `remote-object-info` command followed by a remote and
    -+objects IDs prints object info from the remote without downloading the objects.
    ++object IDs prints object info from the remote without downloading the objects.

      You can specify the information shown for each object by using a custom
      `<format>`. The `<format>` is copied literally to stdout for each
    -@@ Documentation/git-cat-file.adoc: newline. The available atoms are:
    - `deltabase`::
    - 	If the object is stored as a delta on-disk, this expands to the
    - 	full hex representation of the delta base object name.
    --	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
    -+	Otherwise, expands to the null OID (all zeroes). See `CAVEATS` section
    - 	below.
    -
    - `rest`::
     @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
      	after that first run of whitespace (i.e., the "rest" of the
      	line) are output in place of the `%(rest)` atom.
    @@ Documentation/git-cat-file.adoc: newline. The available atoms are:
      If no format is specified, the default format is `%(objectname)
     -%(objecttype) %(objectsize)`.
     +%(objecttype) %(objectsize)`, except for `remote-object-info` commands which
    -+use `%(objectname) %(objectsize)` because "%(objecttype)" is not supported yet.
    ++use `%(objectname) %(objectsize)` because `%(objecttype)` is not supported yet.
    ++
     +WARNING: When "%(objecttype)" is supported, the default format WILL be unified,
     +so DO NOT RELY on the current default format to stay the same!!!

    @@ builtin/cat-file.c: static const struct parse_cmd {
      static void batch_objects_command(struct batch_options *opt,

      ## object-file.c ##
    -@@ object-file.c: struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
    +@@ object-file.c: int odb_transaction_files_begin(struct odb_source *source,

    - 	return &transaction->base;
    + 	return 0;
      }
     +
     +void free_object_info_contents(struct object_info *object_info)
13:  75b1c61c67 ! 13:  71e19e8d27 cat-file: make remote-object-info allow-list adapt to the server
    @@ builtin/cat-file.c: struct expand_data {
     +	struct string_list remote_allowed_atoms;
      };

    -+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, \
    -+			    .type = OBJ_BAD, \
    -+			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
    ++#define EXPAND_DATA_INIT  {  \
    ++	.mode = S_IFINVALID, \
    ++	.type = OBJ_BAD,     \
    ++	.remote_allowed_atoms = STRING_LIST_INIT_NODUP, \
    ++}
     +
      static int is_atom(const char *atom, const char *s, int slen)
      {

---
base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
change-id: 20260608-ps-eric-work-rebase-b73ae84ba671
