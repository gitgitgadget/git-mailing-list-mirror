Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0D21325A
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938399; cv=none; b=tuia7zov5Ue1Kv5/eLJpX3AsGme9AKgvlhG56aI/wVN4LHzJKFlx+fkGJMNMnMYWTiHJOkDi3VVO0jImFWl/8uvomU8H1/kJwcLAhQmhKHGRyfHh9kuo6yRDrCOnjahvj/LPM9bzdvRZD7SGgdR26s9uyC+8zdGmh0wLxwcVv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938399; c=relaxed/simple;
	bh=xCzrH5MJjsj9GNGp4wpEQuyq5qAiKjl4fabyiYaSkYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB8J2vjMQhktjQ9ILLtkMZKkkH7JNItal2Ytk/Hvyl+XrGXYrebmyO0aRTRLCuOtwjGWI3xHX66NKhDN8a04jdCR9oA+uQC/bAwADO1kU8j3hgFoaApS6MwGu435hnCexH7o1qLRwCkJU9MMURi5OFL3NxvMzge9CqQjh3au1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPDOwcRR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPDOwcRR"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1093288566b.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938394; x=1746543194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY10K7LMxDksBiYULWV5TXKtkymsz/KetoVVfJxvlh0=;
        b=KPDOwcRRYOCceBGlnzjVL7DmF+3WdM0cv8nHbtjd32h6XULk1EMxCThdBXS6fvJeiY
         gje8p1HtL/LGm8+dNwv/udNWxZJc8YJVwWnCR1tMx8ZLhp+T1Ivjtc3MEGq/BtoQgz3b
         OeZsqciNlLcqbtor21V5L1IhVzdDzG9/I87O5RNC25pD/0urXBsc994oKBDD2arB1oKY
         TGh24R+iNJ0+owEbA/0U79+uT+MVhVgjmlXJ5uFEqXB3JQ4hwxYoutfrww2VfJIBiLeq
         yT4eaeIgIGyaMYV3TO/mORm1Mdpx25lzrQbFGAhAPeTBnDxN/+khB0FSI8Dlhki5GUQW
         7zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938394; x=1746543194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY10K7LMxDksBiYULWV5TXKtkymsz/KetoVVfJxvlh0=;
        b=kOX4XaPmzMoRycPII6IosxWmGD81vt55muChY3T0eCQFVj+XRgapmHbF7d/gTVIeG/
         t1mQTdBAGM30N8CUsSYzOLv+jaSDFsi3qnsHcKF3mHObeWk1yIF1zW4418t96TQw7Ayx
         hfaYetd51EHmQxPwuNqwxcUXR8JceRjbV0cnjLatJoC0awIK5evVzerl/OR0s2EwxeSs
         L72Gm1RrEOaz+XcDMw5Q2Utvn8p0wOBVtNjcieeE0QKSEbIoBB2+YF9Cp/n2/xi4ugsM
         CSI2rTzz9bP1K7dcnCaBGjiuAbk82ACyyoJOPrvKXRVMyY4tYeSAezySQMTC7TKYrqC8
         fFow==
X-Gm-Message-State: AOJu0Yxe5wmlqqduS/Vfj30gFAdLUzCmQD1o1pImN/3TDh1/bCN9mM9+
	96ZfEbmDemSi+yVmTBYnGka1c+vfj6dEi14Mz3XOaMFgx8ySWg2VFrbKNQ==
X-Gm-Gg: ASbGnctdpSbl57mQDzCrbRxb/3tWdVG/pQ7hwz3fh6RDwaSUBsVw+TGSWpht+iZndM5
	SKiHxbk141nrhO0oE/Ei6pMn1DwBAdpoXSZKnTq5EGK55HlmGTbvuksGRFHdP/zd8LKK/MvT/p5
	fyYhJBnnBP5j+erYQVkt7BHralm/kGkWzHyYSL6TkrPwslY2Rfp+2hzF2UPOpDfopzXsLyPqpgS
	w/0rbAMl+ZCOhwrXChycopI8C69OasKRkCeV5Y9J0I1vXnxJVIrI7v2lbwJ8szaY0Z1V/3FCXAy
	2iHYdM1lbJSW94X469/kRevJVop59GpX4j/MAv+AZ9c5nsNp7VAUTw13ymbMkrHA4vYf5RHkOW+
	u
X-Google-Smtp-Source: AGHT+IHlbF84Ihi3hVq8ekUOXuqcxGgbYvMCQvUTG0m18zd5zSsMhRprw14G1qYutP8tAaGkO9AQ4A==
X-Received: by 2002:a17:906:4fca:b0:ace:c2ab:a728 with SMTP id a640c23a62f3a-acec8499ea0mr266557766b.9.1745938393497;
        Tue, 29 Apr 2025 07:53:13 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:3f04:7ca0:9d50:3329:cd00:6e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6aed0sm791432666b.135.2025.04.29.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:53:12 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/3] Make the "promisor-remote" capability support more fields
Date: Tue, 29 Apr 2025 16:52:40 +0200
Message-ID: <20250429145243.992252-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.157.g09af0369a6
In-Reply-To: <20250414160343.2216312-1-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "promisor-remote" capability can only be used to pass the names
and URLs of the promisor remotes from the server to the client. After
that the client can use this information to decide if it accepts the
remotes or not.

It would be nice if the server could pass more fields about its
remotes and if the client could use that additional information to
decide about the remotes by comparing it with its local information
about the remotes.

This patch series implements this by adding the "promisor.sendFields"
on the server side and the "promisor.checkFields" on the client side.

For example, if "promisor.sendFields" is set to "partialCloneFilter",
and the server has the remote "foo" configured like this:

[remote "foo"]
        url = file:///tmp/foo.git
	partialCloneFilter = blob:none

then "name=foo,url=file:///tmp/foo.git,partialCloneFilter=blob:none"
will be sent by the server for this remote.

All the information passed through the "promisor-remote" capability is
still only used to decide if the remotes are accepted or not. The
client doesn't store it and doesn't use it for any other purpose.

The fields that can be passed are limited to "partialCloneFilter" and
"token".

On the technical side, we get rid of 'struct strvec' and we use mostly
'struct string_list' instead, which is more flexible. This matches
some suggestions made when the series that introduced the
"promisor-remote" capability was reviewed.

Right now in this series, the fields names (like "partialCloneFilter"
in the example) that are passed to the client are compared case
sensitively to the local config keys. I think this is a bug and they
should be compared case insensitively, (while values should still be
compared case sensitively). I am planning to fix this in the next
iteration of this series. I am also planning to add more tests then.

Changes since v1
----------------

Thanks to Patrick and Junio for their comments on the v1.

* Patch 1/4 in v1 has been removed. It isn't necessary anymore because
  we limit the possible field names to some harcoded values. So we
  don't need to check if the field names contain only valid
  characters.

* In patch 1/3, the commit message has been improved to explain why we
  use "field" and to tell that they should correspond to config
  variables.

* In patch 1/3, the following improvements have been made to the code:

  - the comment before the definition of 'struct promisor_info' has
    been improved to better describe the fields and their possible
    names

  - free_info_list() has been renamed promisor_info_list_free()

  - field names are now compared case insensitively by setting the
    'cmp' member of 'struct string_list' to 'strcasecmp'

  - a memory leak in promisor_info_vecs() has been fixed and the code
    simplified, as we used to free only a single 'struct
    promisor_info' instance instead of all the instances

  - an assert() has been replaced by a BUG()

  - a BUG() message has been improved

* In patch 2/3, there are a number of general changes:

  - the name of the "promisor.sendExtraFields" config variable has
    been changed to "promisor.sendFields"

  - in general we just talk about "fields" and not "extra fields"

  - only the "partialCloneFilter" and "token" fields are allowed on
    top of the pre-existing "name" and "url" fields

* In patch 2/3, in "Documentation/gitprotocol-v2.adoc", the
  documentation of the "promisor-remote" capability has been improved
  in a few ways:

  - `fld-key` has been renamed `fld-name` to be consistent with
    everywhere else where we talk about field names

  - it's stated that "Clients SHOULD ignore fields they don't
    recognize to allow for future protocol extensions"

* In patch 2/3, the following improvements have been made to the code:

  - a `static const char *allowed_fields[]` is used to store the
    allowed field names in an extensible way

  - a new is_allowed_field() function is introduced and used in
    valid_field() to check if a field name is valid

  - "extra" has been removed from all function and variable names

* In patch 2/3, the tests have been improved to use "token" instead of
  "id" as "token" is among the list of allowed field names.

* In patch 3/3, there are the same general changes as in patch 2/3.

* In patch 3/3, the commit message says that limiting the fields
  allows both server and client have a shared understanding of field
  semantics and usage.

* In patch 3/3, the following improvements have been made to the code:

  - "extra" has been removed from all function and variable names

  - field names are compared case insensitively by setting the 'cmp'
    member of 'struct string_list' to 'strcasecmp'
  
* In patch 3/3, the tests have been improved to use "token" instead of
  "id" as "token" is among the list of allowed field names.

CI tests
--------

Here they are:

https://github.com/chriscool/git/actions/runs/14729278162

They have all passed except the "pedantic(fedora:latest)" one which
failed with the following error:

  t/unit-tests/generate-clar-suites.sh: line 63: awk: command not found

Range diff compared to v1
-------------------------

1:  fe49a861b9 < -:  ---------- config: move is_config_key_char() to "config.h"
2:  6ebff6d784 ! 1:  d4e12afbc1 promisor-remote: refactor to get rid of 'struct strvec'
    @@ Commit message
         stores the field names, like "name" and "url", in the 'string' member
         of its items, and the field values in the 'util' member of its items.
     
    +    Except for "name", each "<field_name>/<field_value>" pair should
    +    correspond to a "remote.<name>.<field_name>" config variable set to
    +    <field_value> where "<name>" is a promisor remote name.
    +
    +    Previously in Git, the part after the last dot in a configuration
    +    variable key, for example "c" for "a.b.c", was called the "variable
    +    name part" of a configuration key. It would be very confusing to use
    +    "variable name part" or some similar terms in the context of the
    +    'promisor-remote' protocol though, so let's forget about it, and just
    +    use "field", "field name" and "field value" instead.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## promisor-remote.c ##
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     -			       struct strvec *names,
     -			       struct strvec *urls)
     +/*
    -+ * Linked list for promisor remotes.
    ++ * Linked list for promisor remotes involved in the "promisor-remote"
    ++ * protocol capability.
    ++ *
    ++ * 'fields' contains a defined set of field name/value pairs for
    ++ * each promisor remote. Field names are stored in the 'string'
    ++ * member, and values in the 'util' member.
    ++ *
    ++ * Currently supported field names:
    ++ * - "name": The name of the promisor remote.
    ++ * - "url": The URL of the promisor remote.
    ++ *
    ++ * Except for "name", each "<field_name>/<field_value>" pair should
    ++ * correspond to a "remote.<name>.<field_name>" config variable set to
    ++ * <field_value> where "<name>" is a promisor remote name.
     + *
     + * 'fields' should not be sorted, as we will rely on the order we put
     + * things into it. So, for example, 'string_list_append()' should be
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +	struct string_list fields;
     +};
     +
    -+static void free_info_list(struct promisor_info *p)
    ++static void promisor_info_list_free(struct promisor_info *p)
     +{
     +	struct promisor_info *next;
     +
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
     +			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
     +
     +			string_list_init_dup(&new_info->fields);
    ++			new_info->fields.cmp = strcasecmp;
     +
     +			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
     +			string_list_append(&new_info->fields, "url")->util = (char *)url;
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
     -	struct strvec names = STRVEC_INIT;
     -	struct strvec urls = STRVEC_INIT;
     +	struct promisor_info *info_list;
    -+	struct promisor_info *r, *p;
    ++	struct promisor_info *r;
      
      	git_config_get_bool("promisor.advertise", &advertise_promisors);
      
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      
     -	for (size_t i = 0; i < names.nr; i++) {
     -		if (i)
    -+	for (p = NULL, r = info_list; r; p = r, r = r->next) {
    ++	for (r = info_list; r; r = r->next) {
     +		struct string_list_item *item;
     +		int first = 1;
     +
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      
     -	strvec_clear(&names);
     -	strvec_clear(&urls);
    -+	free_info_list(p);
    ++	promisor_info_list_free(info_list);
      
      	return strbuf_detach(&sb, NULL);
      }
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
     -			return i;
     -	return nicks->nr;
     +	for (; p; p = p->next) {
    -+		assert(!strcmp(p->fields.items[0].string, "name"));
    ++		if (strcmp(p->fields.items[0].string, "name"))
    ++			BUG("First field of promisor info should be 'name', but was '%s'.",
    ++			    p->fields.items[0].string);
     +		if (!strcmp(p->fields.items[0].util, nick))
     +			return p;
     +	}
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
     -	if (!strcmp(urls->v[i], remote_url))
     +	if (strcmp(p->fields.items[1].string, "url"))
    -+		BUG("Bad info_list for remote '%s'", remote_name);
    ++		BUG("Bad info_list for remote '%s'.\n"
    ++		    "Second field of promisor info should be 'url', but was '%s'.",
    ++		    remote_name, p->fields.items[1].string);
     +
     +	local_url = p->fields.items[1].util;
     +
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      
     -	strvec_clear(&names);
     -	strvec_clear(&urls);
    -+	free_info_list(info_list);
    ++	promisor_info_list_free(info_list);
      	strbuf_list_free(remotes);
      }
      
3:  f8b875d1a7 ! 2:  d6d4f99768 promisor-remote: allow a server to advertise extra fields
    @@ Metadata
     Author: Christian Couder <chriscool@tuxfamily.org>
     
      ## Commit message ##
    -    promisor-remote: allow a server to advertise extra fields
    +    promisor-remote: allow a server to advertise more fields
     
         For now the "promisor-remote" protocol capability can only pass "name"
         and "url" information from a server to a client in the form
         "name=<remote_name>,url=<remote_url>".
     
         Let's make it possible to pass more information by introducing a new
    -    "promisor.sendExtraFields" configuration variable. This variable
    -    should contain a comma or space separated list of fields that will be
    -    looked up in the configuration of the remote on the server to find the
    -    values that will be passed to the client.
    +    "promisor.sendFields" configuration variable. This variable should
    +    contain a comma or space separated list of fields that will be looked
    +    up in the configuration of the remote on the server to find the values
    +    that will be passed to the client.
     
    -    For example if "promisor.sendExtraFields" is set to "partialCloneFilter",
    +    Only a set of predefined fields are allowed. The only fields in this
    +    set are "partialCloneFilter" and "token".
    +
    +    For example if "promisor.sendFields" is set to "partialCloneFilter",
         and the server has the "remote.<name>.partialCloneFilter" config
         variable set to a value for a remote, then that value will be passed
         in the form "partialCloneFilter=<value>" after the "name" and "url"
         fields.
     
    -    A following commit will allow the client to use the extra information
    -    to decide if it accepts the remote or not. For now the client doesn't
    -    do anything with the extra information it receives.
    +    A following commit will allow the client to use the information to
    +    decide if it accepts the remote or not. For now the client doesn't do
    +    anything with the additional information it receives.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ Documentation/config/promisor.adoc: promisor.advertise::
      	"false", which means the "promisor-remote" capability is not
      	advertised.
      
    -+promisor.sendExtraFields::
    ++promisor.sendFields::
     +	A comma or space separated list of additional remote related
     +	fields that a server will send while advertising its promisor
     +	remotes using the "promisor-remote" capability, see
    -+	linkgit:gitprotocol-v2[5]. When a field named "bar" is part of
    -+	this list and a corresponding "remote.foo.bar" config variable
    -+	is set on the server to a non empty value, for example "baz",
    -+	then the field and its value, so "bar=baz", will be sent when
    -+	advertising the promisor remote "foo". This list has no effect
    -+	unless the "promisor.advertise" config variable, see above, is
    -+	set to "true", and if that's the case, then whatever this list
    -+	contains, the "name" and "url" fields are advertised anyway
    -+	and contain the remote name and URL respectively, so there is
    -+	no need to add "name" or "url" to this list.
    ++	linkgit:gitprotocol-v2[5]. Currently, only the
    ++	"partialCloneFilter" and "token" fields are supported. The
    ++	"partialCloneFilter" field contains the partial clone filter
    ++	used for the remote, and the "token" field contains an
    ++	authentication token for the remote.
    +++
    ++When a field is part of this list and a corresponding
    ++"remote.foo.<field>" config variable is set on the server to a
    ++non-empty value, then the field and its value will be sent when
    ++advertising the promisor remote "foo". This list has no effect unless
    ++the "promisor.advertise" config variable is set to "true", and the
    ++"name" and "url" fields are always advertised regardless of this
    ++setting.
     +
      promisor.acceptFromServer::
      	If set to "all", a client will accept all the promisor remotes
    @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the in
     +	pr-info = pr-fields | pr-info ";" pr-info
      
     -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
    -+	pr-fields = fld-key "=" fld-value | pr-fields "," pr-fields
    ++	pr-fields = fld-name "=" fld-value | pr-fields "," pr-fields
      
     -where `pr-name` is the urlencoded name of a promisor remote, and
     -`pr-url` the urlencoded URL of that promisor remote.
    -+where all the `fld-key` and `fld-value` in a given `pr-fields` are
    -+field keys and values related to a single promisor remote.
    ++where all the `fld-name` and `fld-value` in a given `pr-fields` are
    ++field names and values related to a single promisor remote.
      
     -In this case, if the client decides to use one or more promisor
     -remotes the server advertised, it can reply with
     -"promisor-remote=<pr-names>" where <pr-names> should be of the form:
    -+The server MUST advertise at least the "name" and "url" field keys
    ++The server MUST advertise at least the "name" and "url" field names
     +along with the associated field values, which are the name of a valid
     +remote and its URL, in each `pr-fields`.
      
     -	pr-names = pr-name | pr-names ";" pr-name
    -+`fld-key` MUST start with an alphabetic character and contain only
    -+alphanumeric or '-' characters, and `fld-value` MUST be urlencoded.
    ++The server MAY advertise the following optional fields:
    ++
    ++- "partialCloneFilter": Filter used for partial clone, corresponding
    ++  to the "remote.<name>.partialCloneFilter" config setting.
    ++- "token": Authentication token for the remote, corresponding
    ++  to the "remote.<name>.token" config setting.
    ++
    ++No other fields are defined by the protocol at this time. Clients SHOULD
    ++ignore fields they don't recognize to allow for future protocol extensions.
    ++
    ++For now, the client can only use information transmitted through these
    ++fields to decide if it accepts the advertised promisor remote. In the
    ++future that information might be used for other purposes though.
    ++
    ++Field values MUST be urlencoded.
     +
     +If the client decides to use one or more promisor remotes the server
     +advertised, it can reply with "promisor-remote=<pr-names>" where
    @@ Documentation/gitprotocol-v2.adoc: In this case, or if the client doesn't want t
     -The "promisor.advertise" and "promisor.acceptFromServer" configuration
     -options can be used on the server and client side to control what they
     -advertise or accept respectively. See the documentation of these
    --configuration options for more information.
    -+On the server side, the "promisor.advertise" and
    -+"promisor.sendExtraFields" configuration options can be used to
    -+control what it advertises. On the client side, the
    -+"promisor.acceptFromServer" configuration option can be used to
    -+control what it accepts. See the documentation of these configuration
    -+options for more information.
    ++On the server side, the "promisor.advertise" and "promisor.sendFields"
    ++configuration options can be used to control what it advertises. On
    ++the client side, the "promisor.acceptFromServer" configuration option
    ++can be used to control what it accepts. See the documentation of these
    + configuration options for more information.
      
      Note that in the future it would be nice if the "promisor-remote"
    - protocol capability could be used by the server, when responding to
     
      ## promisor-remote.c ##
     @@ promisor-remote.c: static int allow_unsanitized(char ch)
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
      }
      
     +/*
    -+ * A valid extra field "foo" should correspond to a
    -+ * "remote.<name>.foo" config variable, so, like config variables
    -+ * keys, it should start with an alphabetic character and otherwise
    -+ * each character should satisfy is_config_key_char().
    ++ * List of field names allowed to be used in the "promisor-remote"
    ++ * protocol capability. Each field should correspond to a configurable
    ++ * property of a remote that can be relevant for the client.
    ++ */
    ++static const char *allowed_fields[] = {
    ++	"partialCloneFilter", /* Filter used for partial clone */
    ++	"token",              /* Authentication token for the remote */
    ++	NULL
    ++};
    ++
    ++/*
    ++ * Check if 'field' is in the list of allowed field names for the
    ++ * "promisor-remote" protocol capability.
     + */
    -+static int valid_extra_field(struct string_list_item *item, void *cb_data)
    ++static int is_allowed_field(const char *field)
    ++{
    ++	const char **p;
    ++
    ++	for (p = allowed_fields; *p; p++)
    ++		if (!strcasecmp(*p, field))
    ++			return 1;
    ++	return 0;
    ++}
    ++
    ++static int valid_field(struct string_list_item *item, void *cb_data)
     +{
     +	const char *field = item->string;
     +	const char *config_key = (const char *)cb_data;
     +
    -+	for (size_t i = 0; field[i]; i++)
    -+		if (i ? !is_config_key_char(field[i]) : !isalpha(field[i])) {
    -+			warning(_("invalid field '%s' in '%s' config"), field, config_key);
    -+			return 0;
    -+		}
    ++	if (!is_allowed_field(field)) {
    ++		warning(_("unsupported field '%s' in '%s' config"), field, config_key);
    ++		return 0;
    ++	}
     +	return 1;
     +}
     +
     +static char *fields_from_config(struct string_list *fields_list, const char *config_key)
     +{
    -+	char *extras = NULL;
    ++	char *fields = NULL;
     +
    -+	if (!git_config_get_string(config_key, &extras) && *extras) {
    -+		string_list_split_in_place(fields_list, extras, ", ", -1);
    -+		filter_string_list(fields_list, 0, valid_extra_field, (void *)config_key);
    ++	if (!git_config_get_string(config_key, &fields) && *fields) {
    ++		string_list_split_in_place(fields_list, fields, ", ", -1);
    ++		filter_string_list(fields_list, 0, valid_field, (void *)config_key);
     +	}
     +
    -+	return extras;
    ++	return fields;
     +}
     +
    -+static struct string_list *extra_fields_sent(void)
    ++static struct string_list *fields_sent(void)
     +{
     +	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
     +	static int initialized = 0;
     +
     +	if (!initialized) {
    -+		fields_from_config(&fields_list, "promisor.sendExtraFields");
    ++		fields_list.cmp = strcasecmp;
    ++		fields_from_config(&fields_list, "promisor.sendFields");
     +		initialized = 1;
     +	}
     +
     +	return &fields_list;
     +}
     +
    -+static void append_extra_fields(struct string_list *fields,
    -+				struct string_list *extra_fields,
    -+				const char *name)
    ++static void append_fields(struct string_list *fields,
    ++			  struct string_list *field_names,
    ++			  const char *name)
     +{
     +	struct string_list_item *item;
     +
    -+	for_each_string_list_item(item, extra_fields) {
    ++	for_each_string_list_item(item, field_names) {
     +		char *key = xstrfmt("remote.%s.%s", name, item->string);
     +		const char *val;
     +		if (!git_config_get_string_tmp(key, &val) && *val)
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +}
     +
      /*
    -  * Linked list for promisor remotes.
    +  * Linked list for promisor remotes involved in the "promisor-remote"
    +  * protocol capability.
    +@@ promisor-remote.c: static int allow_unsanitized(char ch)
    +  * member, and values in the 'util' member.
    +  *
    +  * Currently supported field names:
    +- * - "name": The name of the promisor remote.
    +- * - "url": The URL of the promisor remote.
    ++ * - "name": The name of the promisor remote,
    ++ * - "url": The URL of the promisor remote,
    ++ * - the fields in 'allowed_fields[]' above.
       *
    -@@ promisor-remote.c: static void free_info_list(struct promisor_info *p)
    +  * Except for "name", each "<field_name>/<field_value>" pair should
    +  * correspond to a "remote.<name>.<field_name>" config variable set to
    +@@ promisor-remote.c: static void promisor_info_list_free(struct promisor_info *p)
       * remotes. For each promisor remote, some of its fields, starting
       * with "name" and "url", are put in the 'fields' string_list.
       */
     -static struct promisor_info *promisor_info_list(struct repository *repo)
     +static struct promisor_info *promisor_info_list(struct repository *repo,
    -+						struct string_list *extra_fields)
    ++						struct string_list *field_names)
      {
      	struct promisor_info *infos = NULL;
      	struct promisor_info **last_info = &infos;
    @@ promisor-remote.c: static struct promisor_info *promisor_info_list(struct reposi
      			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
      			string_list_append(&new_info->fields, "url")->util = (char *)url;
      
    -+			if (extra_fields)
    -+				append_extra_fields(&new_info->fields, extra_fields, r->name);
    ++			if (field_names)
    ++				append_fields(&new_info->fields, field_names, r->name);
     +
      			*last_info = new_info;
      			last_info = &new_info->next;
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
      		return NULL;
      
     -	info_list = promisor_info_list(repo);
    -+	info_list = promisor_info_list(repo, extra_fields_sent());
    ++	info_list = promisor_info_list(repo, fields_sent());
      
      	if (!info_list)
      		return NULL;
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
      	check_missing_objects server 1 "$oid"
      '
      
    -+test_expect_success "clone with promisor.sendExtraFields" '
    ++test_expect_success "clone with promisor.sendFields" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	git -C server remote add otherLop "https://invalid.invalid"  &&
    -+	git -C server config remote.otherLop.id "fooBar" &&
    ++	git -C server config remote.otherLop.token "fooBar" &&
     +	git -C server config remote.otherLop.stuff "baz" &&
     +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
     +	test_when_finished "git -C server remote remove otherLop" &&
    -+	git -C server config promisor.sendExtraFields "id, partialCloneFilter" &&
    -+	test_when_finished "git -C server config unset promisor.sendExtraFields" &&
    ++	git -C server config promisor.sendFields "token, partialCloneFilter" &&
    ++	test_when_finished "git -C server config unset promisor.sendFields" &&
     +	test_when_finished "rm trace" &&
     +
     +	# Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
     +		-c promisor.acceptfromserver=All \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
    -+	# Check that extra fields are properly transmitted
    ++	# Check that fields are properly transmitted
     +	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
     +	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
    -+	PR2="name=otherLop,url=https://invalid.invalid,id=fooBar,partialCloneFilter=blob:limit=10k" &&
    ++	PR2="name=otherLop,url=https://invalid.invalid,token=fooBar,partialCloneFilter=blob:limit=10k" &&
     +	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
     +	test_grep "clone> promisor-remote=lop;otherLop" trace &&
     +
4:  d3b09c1afe ! 3:  09af0369a6 promisor-remote: allow a client to check extra fields
    @@ Metadata
     Author: Christian Couder <chriscool@tuxfamily.org>
     
      ## Commit message ##
    -    promisor-remote: allow a client to check extra fields
    +    promisor-remote: allow a client to check fields
     
    -    A previous commit allowed a server to pass extra fields through the
    -    "promisor-remote" protocol capability after the "name" and "url"
    -    fields.
    +    A previous commit allowed a server to pass additional fields through
    +    the "promisor-remote" protocol capability after the "name" and "url"
    +    fields, specifically the "partialCloneFilter" and "token" fields.
     
    -    Let's make it possible for a client to check if these extra fields
    -    match what it expects before accepting a promisor remote.
    +    Let's make it possible for a client to check if these fields match
    +    what it expects before accepting a promisor remote.
     
    -    We allow this by introducing a new "promisor.checkExtraFields"
    -    configuration variable. It should contain a comma or space
    -    separated list of fields that will be checked.
    +    We allow this by introducing a new "promisor.checkFields"
    +    configuration variable. It should contain a comma or space separated
    +    list of fields that will be checked.
    +
    +    By limiting the protocol to specific well-defined fields, we ensure
    +    both server and client have a shared understanding of field
    +    semantics and usage.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
      	to "fetch" and "clone" requests from the client. Name and URL
      	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
     +
    -+promisor.checkExtraFields::
    ++promisor.checkFields::
     +	A comma or space separated list of additional remote related
     +	fields that a client will check before accepting a promisor
    -+	remote. When a field named "bar" is part of this list and a
    -+	corresponding "remote.foo.bar" config variable is set for
    -+	locally for remote "foo", then the value of the
    -+	"remote.foo.bar" config variable will be checked against the
    -+	value of the "bar" field passed by the server through the
    -+	"promisor-remote" capability for the remote "foo". The remote
    -+	"foo" will be rejected if the values don't match. The fields
    -+	should be passed by the server through the "promisor-remote"
    -+	capability by using the `promisor.sendExtraFields` config
    -+	variable, see above. The extra fields will be checked only if
    -+	the `promisor.acceptFromServer` config variable, see above, is
    -+	not set to "None". If is set to "None", this config variable
    -+	will have no effect. See linkgit:gitprotocol-v2[5].
    ++	remote. Currently, only the "partialCloneFilter" and "token"
    ++	fields are supported.
    +++
    ++When a field is part of this list and a corresponding
    ++"remote.foo.<field>" config variable is set locally for remote "foo",
    ++then the value of this config variable will be checked against the
    ++value of the same field passed by the server for the remote "foo". The
    ++remote "foo" will be rejected if the values don't match.
    +++
    ++For the "partialCloneFilter" field, this allows the client to ensure
    ++that the server's filter matches what it expects locally, preventing
    ++inconsistencies in filtering behavior. For the "token" field, this can
    ++be used to verify that authentication credentials match expected
    ++values.
    +++
    ++The fields should be passed by the server through the
    ++"promisor-remote" capability by using the `promisor.sendFields` config
    ++variable. The fields will be checked only if the
    ++`promisor.acceptFromServer` config variable is not set to "None".  If
    ++set to "None", this config variable will have no effect.  See
    ++linkgit:gitprotocol-v2[5].
     
      ## promisor-remote.c ##
    -@@ promisor-remote.c: static struct string_list *extra_fields_sent(void)
    +@@ promisor-remote.c: static struct string_list *fields_sent(void)
      	return &fields_list;
      }
      
    -+static struct string_list *extra_fields_checked(void)
    ++static struct string_list *fields_checked(void)
     +{
     +	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
     +	static int initialized = 0;
     +
     +	if (!initialized) {
    -+		fields_from_config(&fields_list, "promisor.checkExtraFields");
    ++		fields_list.cmp = strcasecmp;
    ++		fields_from_config(&fields_list, "promisor.checkFields");
     +		initialized = 1;
     +	}
     +
     +	return &fields_list;
     +}
     +
    - static void append_extra_fields(struct string_list *fields,
    - 				struct string_list *extra_fields,
    - 				const char *name)
    + static void append_fields(struct string_list *fields,
    + 			  struct string_list *field_names,
    + 			  const char *name)
     @@ promisor-remote.c: enum accept_promisor {
      	ACCEPT_ALL
      };
      
    -+static int check_extra_field_one(struct string_list_item *item_value,
    -+				 struct promisor_info *p)
    ++static int check_field_one(struct string_list_item *item_value,
    ++			   struct promisor_info *p)
     +{
     +	struct string_list_item *item;
     +
    @@ promisor-remote.c: enum accept_promisor {
     +}
     +
     +
    -+static int check_extra_field(struct string_list_item *item_value,
    -+			     struct promisor_info *p, int in_list)
    ++static int check_field(struct string_list_item *item_value,
    ++		       struct promisor_info *p, int in_list)
     +{
     +	if (!in_list)
    -+		return check_extra_field_one(item_value, p);
    ++		return check_field_one(item_value, p);
     +
     +	for (; p; p = p->next)
    -+		if (check_extra_field_one(item_value, p))
    ++		if (check_field_one(item_value, p))
     +			return 1;
     +
     +	return 0;
     +}
     +
    -+static int check_all_extra_fields(struct string_list* extra_values,
    -+				  struct promisor_info *p,
    -+				  int in_list)
    ++static int check_all_fields(struct string_list* values,
    ++			    struct promisor_info *p,
    ++			    int in_list)
     +{
    -+	struct string_list* fields_checked = extra_fields_checked();
    ++	struct string_list* fields = fields_checked();
     +	struct string_list_item *item_checked;
     +
    -+	string_list_sort(extra_values);
    ++	string_list_sort(values);
     +
    -+	for_each_string_list_item(item_checked, fields_checked) {
    ++	for_each_string_list_item(item_checked, fields) {
     +		struct string_list_item *item_value;
     +
    -+		item_value = string_list_lookup(extra_values, item_checked->string);
    ++		item_value = string_list_lookup(values, item_checked->string);
     +		if (!item_value)
     +			return 0;
    -+		if (!check_extra_field(item_value, p, in_list))
    ++		if (!check_field(item_value, p, in_list))
     +			return 0;
     +	}
     +
    @@ promisor-remote.c: enum accept_promisor {
     -				const char *remote_name, const char *remote_url,
     +				const char *remote_name,
     +				const char *remote_url,
    -+				struct string_list* extras,
    ++				struct string_list* values,
      				struct promisor_info *info_list)
      {
      	struct promisor_info *p;
    @@ promisor-remote.c: enum accept_promisor {
      
      	if (accept == ACCEPT_ALL)
     -		return 1;
    -+		return check_all_extra_fields(extras, info_list, 1);
    ++		return check_all_fields(values, info_list, 1);
      
      	p = remote_nick_find(info_list, remote_name);
      
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
      	if (accept == ACCEPT_KNOWN_NAME)
     -		return 1;
    -+		return check_all_extra_fields(extras, p, 0);
    ++		return check_all_fields(values, p, 0);
      
      	if (accept != ACCEPT_KNOWN_URL)
      		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
      	if (!strcmp(local_url, remote_url))
     -		return 1;
    -+		return check_all_extra_fields(extras, p, 0);
    ++		return check_all_fields(values, p, 0);
      
      	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
      		remote_name, local_url, remote_url);
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      		const char *remote_url = NULL;
      		char *decoded_name = NULL;
      		char *decoded_url = NULL;
    -+		struct string_list extras = STRING_LIST_INIT_NODUP;
    ++		struct string_list field_values = STRING_LIST_INIT_NODUP;
    ++
    ++		field_values.cmp = strcasecmp;
      
      		strbuf_strip_suffix(remotes[i], ";");
      		elems = strbuf_split(remotes[i], ',');
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     +			p = strchr(elems[j]->buf, '=');
     +			if (p) {
     +				*p = '\0';
    -+				string_list_append(&extras, elems[j]->buf)->util = p + 1;
    ++				string_list_append(&field_values, elems[j]->buf)->util = p + 1;
     +			} else {
     +				warning(_("invalid element '%s' from remote info"),
     +					elems[j]->buf);
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     -			strvec_push(accepted, decoded_name);
     +		if (decoded_name) {
     +			if (!info_list)
    -+				info_list = promisor_info_list(repo, extra_fields_checked());
    ++				info_list = promisor_info_list(repo, fields_checked());
     +
     +			if (should_accept_remote(accept, decoded_name, decoded_url,
    -+						 &extras, info_list))
    ++						 &field_values, info_list))
     +				strvec_push(accepted, decoded_name);
     +		}
      
    -+		string_list_clear(&extras, 0);
    ++		string_list_clear(&field_values, 0);
      		strbuf_list_free(elems);
      		free(decoded_name);
      		free(decoded_url);
     
      ## t/t5710-promisor-remote-capability.sh ##
    -@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.sendExtraFields" '
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.sendFields" '
      	check_missing_objects server 1 "$oid"
      '
      
    -+test_expect_success "clone with promisor.checkExtraFields" '
    ++test_expect_success "clone with promisor.checkFields" '
     +	git -C server config promisor.advertise true &&
     +	test_when_finished "rm -rf client" &&
     +
     +	git -C server remote add otherLop "https://invalid.invalid"  &&
    -+	git -C server config remote.otherLop.id "fooBar" &&
    ++	git -C server config remote.otherLop.token "fooBar" &&
     +	git -C server config remote.otherLop.stuff "baz" &&
     +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
     +	test_when_finished "git -C server remote remove otherLop" &&
    -+	git -C server config promisor.sendExtraFields "id, partialCloneFilter" &&
    -+	test_when_finished "git -C server config unset promisor.sendExtraFields" &&
    ++	git -C server config promisor.sendFields "token, partialCloneFilter" &&
    ++	test_when_finished "git -C server config unset promisor.sendFields" &&
     +	test_when_finished "rm trace" &&
     +
     +	# Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
     +		-c remote.lop.url="file://$(pwd)/lop" \
     +		-c remote.lop.partialCloneFilter="blob:none" \
     +		-c promisor.acceptfromserver=All \
    -+		-c promisor.checkExtraFields=partialCloneFilter \
    ++		-c promisor.checkFields=partialcloneFilter \
     +		--no-local --filter="blob:limit=5k" server client &&
     +
    -+	# Check that extra fields are properly transmitted
    ++	# Check that fields are properly transmitted
     +	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
     +	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
    -+	PR2="name=otherLop,url=https://invalid.invalid,id=fooBar,partialCloneFilter=blob:limit=10k" &&
    ++	PR2="name=otherLop,url=https://invalid.invalid,token=fooBar,partialCloneFilter=blob:limit=10k" &&
     +	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
     +	test_grep "clone> promisor-remote=lop" trace &&
     +	test_grep ! "clone> promisor-remote=lop;otherLop" trace &&


Christian Couder (3):
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise more fields
  promisor-remote: allow a client to check fields

 Documentation/config/promisor.adoc    |  43 ++++
 Documentation/gitprotocol-v2.adoc     |  52 ++--
 promisor-remote.c                     | 328 ++++++++++++++++++++++----
 t/t5710-promisor-remote-capability.sh |  67 ++++++
 4 files changed, 425 insertions(+), 65 deletions(-)

-- 
2.49.0.157.g09af0369a6

