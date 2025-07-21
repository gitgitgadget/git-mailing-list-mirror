Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC52D8DAE
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106968; cv=none; b=NMuRzzYwHaIz7F47fnIo8I6Ujw4IlecN3ggxf04xg+P6J0W544bXGO/2wD3a2DTLZKiJAg9/tvj5SxHYaPechy9AI3H7kggZWUkGAV5TD54FlOGJvPg+eZt5QQEH4KvjgAwKVHp2PFiW6I2ygrCx+YxYpw0/RCLL3XhbSIyfH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106968; c=relaxed/simple;
	bh=i7oAXIx2BGpr67Af1wYtCEDoeoCxG+ZsXMgwQtVGMXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU0IqviFWAc2JNWm82VL/Rdx8B52V0+7omwGE5S4m77f5/WpprESR3dP1w1VcMjj8Kfj72TcLw1mLvOwCFHHBROXC+AUzFZmO417nWPS0NNlqS4a7aImNT4k1HpseK9U8dJlbuY41Ku65b3FFTFKqdJb9pzQt//18BqpMPlLgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQKyWEH5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQKyWEH5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0e0271d82so811544966b.3
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753106964; x=1753711764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLzOxnfFAhJdXQhYpqOYCa0HfyGDBISDpzBviSAaG18=;
        b=jQKyWEH5BSxAxP5Rcj9K0uupKOjj8eNzdV/afZkonNTOnoWwNsuXZCL0N+RGh0s8Vl
         7lcx7YY2TxBUofkinmIKmt+TXCmM0IqWqMglfe4pMnRFk2XVTSwfQ5ex+voWadCGtdxn
         yvVcOc3lpw8WOqMudjSKh3sQtTktwp3C3LWOjnIxOq8TAwR2FgDBFeS8aO/YJZDhZ5Iw
         n5QnWIYGMHV1SxunWSvlYEKA6KGsM8Rw7NmT3sEjPlIocHz9UHbJagsKELTDMoopGf12
         lzSpd85OIiiN1TJ8MqhxiL0iNY4gUJO0ojGPSMtmo5sY/WQxXjK//du6mRRnUugxbYEU
         NhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106964; x=1753711764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLzOxnfFAhJdXQhYpqOYCa0HfyGDBISDpzBviSAaG18=;
        b=faF/hSbaunqOhgBQv8+mfWoY8+j8xBkWGjVqe7hYqdvRlVlYl+3hZKk1ctHC1LkJY2
         ymQoKLHZxBvmh700mbLX5tBdxMPZ1FXXaQivU/gUseHW1/Sjgeq3s2X4VeXWcZsuxqJx
         y0dAWHaUbFAZMrKODpLx+UCPqgkv1cPGY838pcIJa5L149wpUIbfmyMMgUP7UplsJcWo
         ysNofiS6Fa+tvJC2yFlrdrzgjkCWTV0DlA1DQZZn8XRI5VQ8pJ3fF57BA/9PrRk38a+k
         dHiNpYx/sk2KnezS+/asx3Mt5Vq+ChEhGmJ6I+DKBsOHtxcKt5pua0tsFD2u2RoIhsfP
         ywXg==
X-Gm-Message-State: AOJu0YzBbdLChNSB31it/rZYd9lEXwORcAbxsouENmnf45UAeObm8Zhb
	K4VgPtQyKRHmE3L7WVYPELPH/Vbbp4v0mmEmAPhBYm5fRustZPlovXi/wDkhvp36tzrmPlN56C7
	FuPV3MKcUCEEuZKwpKja2P7Ba2P+SUjc=
X-Gm-Gg: ASbGncuMC0gN/X7lEuQC8ymehqu7DWGNx4uh8SFiz8073p3NYsRrW34Q5cgZ+PP1VFF
	h8mBcDoE2s1nuAWvoc3iHsZrjq7owl/yzBV9FSDWTH4aOg/mgrzo0XdnJPpSJmAPK9bACqhWepj
	h+FjCF9tk7mJ8xrtAZ2cAsDLuuBs6tO+pMT3soNaUWzrPFMiMQ3VyleLy1iQ4JEG8VVR/Xz3ZeL
	J5RDUndAQ==
X-Google-Smtp-Source: AGHT+IHmFzNk2t3ubjAQCPvMXn+zIeYSAUVITnCBrYmK8dMApSENIJuS56JjIKtxbBvDEy74WHgFmIZitLFjk0Zmqss=
X-Received: by 2002:a17:906:d7c3:b0:ae3:f524:b51 with SMTP id
 a640c23a62f3a-aec4fa44a85mr1763070766b.10.1753106963793; Mon, 21 Jul 2025
 07:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com> <20250625125055.1375596-3-christian.couder@gmail.com>
 <xmqqbjqbsbe0.fsf@gitster.g>
In-Reply-To: <xmqqbjqbsbe0.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 21 Jul 2025 16:09:10 +0200
X-Gm-Features: Ac12FXwFAsaByH6LnIL6weH0GC8Lhyop2HxcvZk4rg5zRynh6Xp_43otNZbxMYI
Message-ID: <CAP8UFD1wYXrEC2VYBHTL7NS1ksSa0oiBgB3Ua=6V1SnP=+RMsQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] promisor-remote: allow a server to advertise more fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > For now the "promisor-remote" protocol capability can only pass "name"
> > and "url" information from a server to a client in the form
> > "name=3D<remote_name>,url=3D<remote_url>".
> >
> > Let's make it possible to pass more information by introducing
>
> Motivation, like "in order to allow the client more efficient
> transfer", "in order to give more control on what can be fetched
> from the server", etc., needs to be given before we say "let's do
> X".  We want to do X not because we can do X; we want to do X as it
> currently seems to us the best way to achieve Y.  What is our Y in
> this case for the proposed feature?

Ok, I have changed it to the following in v6:

   To allow clients to make more informed decisions about which promisor
   remotes they accept, let's make it possible to pass more information
   by introducing a new "promisor.sendFields" configuration variable.

> > a new
> > "promisor.sendFields" configuration variable. This variable should
> > contain a comma or space separated list
>
> By making it easier for casual humans who manually write the
> configuration variable (presumably while testing) and allowing both
> comma and space as separator, this design decision is forcing one
> more rule to worry about for those who are writing the parser for
> the value.  There may be some existing configuration variables with
> such a "leninent" syntax, but I'd rather see us not make the mess
> even worse.

We indeed have a number of configuration variables accepting lists of
items separated by both comma and space. As we cannot fix those easily
for backward compatibility and they still make things a bit simpler
for users, my opinion is that we'd better bite the bullet and make
sure we have a simple and hard-to-misuse standard way to parse such
lists. Then we can allow such comma and space separated lists in many
places, and use this standard way to parse those lists wherever they
are allowed. Users would have a consistent experience when dealing
with different configuration variables.

It also seems to me that parsing such lists is not so difficult right
now. It basically only requires a call to
`string_list_split_in_place()`, followed by a call to
`string_list_remove_empty_items()`. Maybe we could refactor that into
a dedicated (possibly inline) function (maybe called
`string_list_split_config_list()`)
and make sure it is used in all the places where such lists are
accepted.

I would prefer adding that kind of refactoring in the form of a
preparatory patch (or maybe a separate patch altogether) rather than
for example allowing only spaces as separators. For now I have made no
changes in v6 regarding this.

> > of field names that will be
> > looked up in the configuration of the remote on the server to find the
> > values that will be passed to the client.
>
> I know the name "field" was discussed in earlier iterations, but
> these three lines together with "For example" in a later paragraph,
> it hints to me that this mechanism is to choose variable-value pairs
> for which among remotes.<name>.* variables to send after name=3D<name>
> and url=3D<url>; is my understanding correct?  If so, can we clarify
> the paragraphs around here even more so that I do not even have to
> ask this question?

Yeah, it seems to me that there was previously a sentence about what
fields are, but it looks like I removed it by mistake. Anyway, before
the paragraph about what the "promisor.sendFields" configuration
variable contains, I have added the following in v6:

   On the server side, information about a remote `foo` is stored in
   configuration variables named `remote.foo.<variable-name>`. To make
   it clearer and simpler, we use `field` and `field name` like this:

     * `field name` refers to the <variable-name> part of such a
       configuration variable, and

     * `field` refers to both the `field name` and the value of such a
       configuration variable.

> What do we call the third-level of a variable name in the
> configuration file?  The description on the "--regexp" option in
> "git config --help" hints one:
>
>     With `get`, interpret the name as a regular expression. Regular
>     expression matching is currently case-sensitive and done against
>     a canonicalized version of the key in which section and variable
>     names are lowercased, but subsection names are not.
>
> So a for remote.origin.partialCloneFilter, "remote" is the section
> name, "origin" is the subsection name, and "partialCloneFilter" is
> the variable name.

Yeah, I thought that "variable name" could be confusing, so I prefered
to use another word, "field", to talk about this.

> Armed with that knowledge, perhaps something like:
>
>     <<the motivation comes here, and then ...>> In order to give
>     additional information to the client, the server side can set a
>     new 'promisor.sendAdditionalVariables' configuration variable,
>     whose value is a comma separated list of variable names.
>
>     The values of the configuration variables specified by this
>     variable for the given remote [*] are sent as comma separated
>     list of variable=3D<value>, after name=3D<name>,url=3D<url> in the
>     promisor-remote capability.
>
>     [*] Concatenating each of these variable names listed as the
>     value of promisor.sendAdditionalVariables after remote.<name>.
>     results in the configuration variables exposed to the client.

I'd rather avoid talking about "variable name" other than to explain
what "field name" and "field" are. I think it would be too confusing,
especially if the name of the new config options are still
"promisor.sendFields" and "promisor.checkFields".

> to replace all of the above, and then it ...
>
> > Only a set of predefined fields are allowed. The only fields in this
> > set are "partialCloneFilter" and "token". The "partialCloneFilter"
> > field specifies the filter definition used by the promisor remote,
> > and the "token" field can provide an authentication credential for
> > accessing it.
>
> ... is a good thing to describe that we have these two supported.
>
> And this one ...
>
> > For example, if "promisor.sendFields" is set to "partialCloneFilter",
> > and the server has the "remote.<name>.partialCloneFilter" config
> > variable set to a value for a remote, then that value will be passed
> > in the form "partialCloneFilter=3D<value>" after the "name" and "url"
> > fields.
>
> ... has already been covered.  My main point is that we should
> clarify what a 'field' is and how it relates to the variables in the
> configuration file of which side (the server, not the client) a lot
> earlier than we say "these two are the only ones that are
> supported".  Before understanding what a field is, "only these two
> are valid" does not give readers much useful information.

Yeah, I hope that the definitions I have added are good enough.

> > diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitproto=
col-v2.adoc
> > index 9a57005d77..0583fafa09 100644
> > --- a/Documentation/gitprotocol-v2.adoc
> > +++ b/Documentation/gitprotocol-v2.adoc
> > @@ -785,33 +785,59 @@ retrieving the header from a bundle at the indica=
ted URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > -promisor-remote=3D<pr-infos>
> > +promisor-remote=3D<pr-info>
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >  The server may advertise some promisor remotes it is using or knows
> >  about to a client which may want to use them as its promisor remotes,
> > +instead of this repository. In this case <pr-info> should be of the
> >  form:
> >
> > +     pr-info =3D pr-fields | pr-info ";" pr-info
> >
> > +     pr-fields =3D field-name "=3D" field-value | pr-fields "," pr-fie=
lds
>
> Typically a name is at most a few words (concatenated with some
> punctuation), and url would probably be a few hundred bytes at most?
> can we afford to cram even more var=3Dvalue on the same line?

We are adding only 2 relatively short optional "var=3Dvalue" per remote,
so a few hundred bytes at most per remote. This means the whole
advertisement for one remote is at most around 500 bytes. As the max
pkt-line size is around 16^4, so 65536, this still allows for more
than 130 remotes to be advertised which should be enough for now.

> The syntax allows you to send more than one name/url pair on the
> same promisor-remote.  Length aside, does this pr-fields mechanism
> give the values of these fields for multiple remotes?
>
> Suppose you want to advertise promisor-remote "A" and "B", and your
> sendFields says "token".  What does your promisor-remote=3D<pr-info> look
> like in such a case?
>
>     name=3DA,url=3Dhttps://git.git/A,token=3Dfoo;name=3DB,url=3Dhttps://g=
it.git/B,token=3Dbar

Yes, it should look like this, and each "field-name" should appear at most =
once.

> Do we explicitly say that the set of var=3Dval on promisor-remote are
> grouped into distinct sets with ';' and each set talks about only
> one remote?  I.e.
>
>     name=3DA,name=3DB,url=3Dhttps://git.git/A,url=3Dhttps://git.git/B,tok=
en=3Dfoo,token=3Dbar
>
> may be syntactically allowed in the above BNF, but it needs _some_
> rule to match which URL and which token go with which name.

There is already the following:

"where all the `field-name` and `field-value` in a given `pr-fields`
are field names and values related to a single promisor remote."

This disallows having fields related to different promisor remotes
grouped together by ';'.

> Do we
> also need to say that within a single ';' separated group, a variable
> can only appear once?  IOW, this is invalid?
>
>     name=3DA,url=3Dhttps://git.git/A,token=3Dfoo,token=3Dbar

This should be invalid, but it wasn't explicitly said that it is
invalid. In v6 though I have added "A given `field-name` MUST NOT
appear more than once in given `pr-fields`."

> > +where all the `field-name` and `field-value` in a given `pr-fields`
> > +are field names and values related to a single promisor remote.
> >
> > +The server MUST advertise at least the "name" and "url" field names
> > +along with the associated field values, which are the name of a valid
> > +remote and its URL, in each `pr-fields`. The "name" and "url" fields
> > +MUST appear first in each pr-fields, in that order.
>
> With
>
>     pr-fields =3D pr-fields "," pr-fields
>
> the rule in the last sentence does not make sense.  You'd need a
> distinct BNF non-terminal to name the one you want the rule to apply
> to.  Perhaps something like
>
>         pr-info =3D pr-one-remote-info | pr-info ';' pr-one-remote-info
>         pr-one-remote-info =3D pr-fields
>         pr-fields =3D pr-field | pr-fields ',' pr-field
>         pr-field =3D variable '=3D' value

I think the following, which I have put in v6, should be enough but
maybe I am missing something:

    pr-info =3D pr-fields | pr-info ";" pr-fields
    pr-fields =3D pr-field | pr-fields "," pr-field
    pr-field =3D field-name "=3D" field-value

Also in the 'object-info' section of the same file, "attrs =3D attr |
attrs SP attrs" has the same problem and might want to be changed to
"attrs =3D attr | attrs SP attr".

> Then you can safely say 'name' and 'url', must be the first two that
> appear in each pr-one-remote-info.

It seems to me that this sentence which is already in the doc should be eno=
ugh:

"The "name" and "url" fields MUST appear first in each pr-fields, in
that order."

> > +After these mandatory fields, the server MAY advertise the following
> > +optional fields in any order:
> > +
> > +- "partialCloneFilter": The filter specification used by the remote.
> > +Clients can use this to determine if the remote's filtering strategy
> > +is compatible with their needs (e.g., checking if both use "blob:none"=
).
> > +It corresponds to the "remote.<name>.partialCloneFilter" config settin=
g.
> > +
> > +- "token": An authentication token that clients can use when
> > +connecting to the remote. It corresponds to the "remote.<name>.token"
> > +config setting.
> > +
> > +No other fields are defined by the protocol at this time. Clients MUST
> > +ignore fields they don't recognize to allow for future protocol
> > +extensions.
>
> This forces us to never add support for a field that MUST be
> understood for the protocol to operate correctly.  Is it sensible?

The protocol for now allows clients to only reply with the names of
the promisor remote they accept. Clients can also set
"promisor.acceptFromServer" to "All". This means that servers should
not trust anyway that the client understood any specific field they
sent based on the client's reply.

If the server controls the promisor remotes it advertises, it can send
for example a token in the "token" field and then use other means than
this protocol to make sure that the client understood the token (and
maybe other fields) when the client actually accesses the promisor
remote.

If a client wants to make sure that the server passed a specific field
with a specific value, they can list this field's name in their
"promisor.checkFields" configuration variable which is introduced in
patch 4/5 and have their corresponding config option set to the
specific value.

> Just like the index file format defines optional extensions that can
> be ignored (implication of which is that you MUST die if you do not
> understand any non-optional ones), shouldn't we have some mechanism
> to tell "if you do not understand this, do not use the remote, or
> your repository will be broken in a horrible way"?
>
> I dunno.

If we want to make sure that clients don't access some remotes unless
they understand something, we'd better rely at least partially on
another mechanism because clients can already be configured to access
any remote. They don't need this protocol to be able to access a
remote.

In fact the information transmitted by the server is not used to
access the remote. It's only used to decide if the remote is accepted.
So the remote has to be already configured to access the remote.

Thanks.
