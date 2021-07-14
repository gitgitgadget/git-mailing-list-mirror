Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CBDC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258D8613AF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbhGNSWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:22:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56424 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhGNSWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 14:22:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2C8F14BCE0;
        Wed, 14 Jul 2021 14:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=trJr2GwHiCjZcahm5rtbPVe1s7E4OMDR65wQ3X
        TtZ6k=; b=yTn4iUyIkLFA8U16qQPZYl3tUBdWCj7wgmUho16vgYrjvm2p+hMql2
        UjMwPxItp9IgD/C3hEIFPrFx114q8PWq368saFsZ3rn8Sqsyi70MV8e5Mh4841vi
        O8y9HDbqvfNDWsU+8OFWrres1goLau5sGjw6IZ9J40dHDT/psqh4g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9D3314BCDF;
        Wed, 14 Jul 2021 14:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2FF5A14BCDE;
        Wed, 14 Jul 2021 14:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/9] Add commit, tag & push signing via SSH keys
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <390a8f816cda0574cabe49e9f88ae1803142fb51.1626264613.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 11:19:37 -0700
In-Reply-To: <390a8f816cda0574cabe49e9f88ae1803142fb51.1626264613.git.gitgitgadget@gmail.com>
        (Fabian Stelzer via GitGitGadget's message of "Wed, 14 Jul 2021
        12:10:05 +0000")
Message-ID: <xmqqlf68wyfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D48E8C4-E4D0-11EB-A595-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fabian Stelzer <fs@gigacodes.de>
> Subject: [PATCH v3 1/9] Add commit, tag & push signing via SSH keys

If you chose "ssh signing:" as the common prefix for the series, use
it consistently with this step, too.

> Openssh v8.2p1 added some new options to ssh-keygen for signature
> creation and verification. These allow us to use ssh keys for git
> signatures easily.
>
> Start with adding the new signature format, new config options and
> rename some fields for consistency.

OK.

> This feature makes git signing much more accessible to the average user.
> Usually they have a SSH Key for pushing code already. Using it
> for signing commits allows us to verify not only the transport but the
> pushed code as well.

Drop this paragraph or at least tone it down.  It may hold true only
around your immediate circle but it is far from clear and obvious.
I'd expect more people push over https:// than ssh://.

We do not really require a new feature to make much more accessible
for wide average user---making it just a bit more accessible to
folks in your immediate circle is perfectly fine, as long as you are
not harming other people ;-)

> In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
> signing/encryption and ssh keys which i think is quite common

Upcase "I".

> (at least for the email part). This way we can establish the correct
> trust for the SSH Keys without setting up a separate GPG Infrastructure
> (which is still quite painful for users) or implementing x509 signing
> support for git (which lacks good forwarding mechanisms).
> Using ssh agent forwarding makes this feature easily usable in todays
> development environments where code is often checked out in remote VMs / containers.
> In such a setup the keyring & revocationKeyring can be centrally
> generated from the x509 CA information and distributed to the users.

All of the above promises a wonderful new world, but what is left
unclear is with this step alone how much of the new world we already
gain.  When you ask others to read and understand your code, please
give them a bit more hint to guide them what to expect and where you
are taking them next. 

> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 0f66818e0f8..1d7b64fa021 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -527,10 +527,10 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
>  			len = payload.len;
>  			if (check_signature(payload.buf, payload.len, sig.buf,
>  					 sig.len, &sigc) &&
> -				!sigc.gpg_output)
> +				!sigc.output)
>  				strbuf_addstr(&sig, "gpg verification failed.\n");
>  			else
> -				strbuf_addstr(&sig, sigc.gpg_output);
> +				strbuf_addstr(&sig, sigc.output);

These are "rename some fields for consistency" the proposed log
message promised.  Makes sense, as you are taking the sigc structure
away from pgp/gpg dependency.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 127aecfc2b0..3c9a48c8e7e 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -8,6 +8,7 @@
>  #include "tempfile.h"
>  
>  static char *configured_signing_key;
> +const char *ssh_allowed_signers, *ssh_revocation_file;

Very likely these want to be file-scope statics?

>  static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
>  
>  struct gpg_format {
> @@ -35,6 +36,14 @@ static const char *x509_sigs[] = {
>  	NULL
>  };
>  
> +static const char *ssh_verify_args[] = {
> +	NULL
> +};

A blank line is missing from here.

> +static const char *ssh_sigs[] = {
> +	"-----BEGIN SSH SIGNATURE-----",
> +	NULL
> +};
> +
>  static struct gpg_format gpg_format[] = {
>  	{ .name = "openpgp", .program = "gpg",
>  	  .verify_args = openpgp_verify_args,
> @@ -44,6 +53,9 @@ static struct gpg_format gpg_format[] = {
>  	  .verify_args = x509_verify_args,
>  	  .sigs = x509_sigs
>  	},
> +	{ .name = "ssh", .program = "ssh-keygen",
> +	  .verify_args = ssh_verify_args,
> +	  .sigs = ssh_sigs },
>  };
>  
>  static struct gpg_format *use_format = &gpg_format[0];
> @@ -72,7 +84,7 @@ static struct gpg_format *get_format_by_sig(const char *sig)
>  void signature_check_clear(struct signature_check *sigc)
>  {
>  	FREE_AND_NULL(sigc->payload);
> -	FREE_AND_NULL(sigc->gpg_output);
> +	FREE_AND_NULL(sigc->output);
>  	FREE_AND_NULL(sigc->gpg_status);
>  	FREE_AND_NULL(sigc->signer);
>  	FREE_AND_NULL(sigc->key);
> @@ -257,16 +269,15 @@ error:
>  	FREE_AND_NULL(sigc->key);
>  }
>  
> -static int verify_signed_buffer(const char *payload, size_t payload_size,
> -				const char *signature, size_t signature_size,
> -				struct strbuf *gpg_output,
> -				struct strbuf *gpg_status)
> +static int verify_gpg_signature(struct signature_check *sigc, struct gpg_format *fmt,
> +	const char *payload, size_t payload_size,
> +	const char *signature, size_t signature_size)
>  {

What is this hunk about?  The more generic name "verify-signed-buffer"
is rescinded and gets replaced by a more GPG/PGP specific helper?

You'd need to help readers a bit more by explaining in the proposed
log message that you shifted the boundary of responsibility between
check_signature() and verify_signed_buffer()---it used to be that
the latter inspected the signed payload to see if it a valid GPG/PGP
signature before doing GPG specific validation, but you want to make
the former responsible for calling get_format_by_sig(), so that you
can dispatch a totally new backend that sits next to this GPG
specific one.

>  	struct child_process gpg = CHILD_PROCESS_INIT;
> -	struct gpg_format *fmt;
>  	struct tempfile *temp;
>  	int ret;
> -	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf gpg_out = STRBUF_INIT;
> +	struct strbuf gpg_err = STRBUF_INIT;
>  
>  	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
>  	if (!temp)
> @@ -279,29 +290,28 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>  		return -1;
>  	}
>  
> -	fmt = get_format_by_sig(signature);
> -	if (!fmt)
> -		BUG("bad signature '%s'", signature);
> -
>  	strvec_push(&gpg.args, fmt->program);
>  	strvec_pushv(&gpg.args, fmt->verify_args);
>  	strvec_pushl(&gpg.args,
> -		     "--status-fd=1",
> -		     "--verify", temp->filename.buf, "-",
> -		     NULL);
> -
> -	if (!gpg_status)
> -		gpg_status = &buf;
> +			"--status-fd=1",
> +			"--verify", temp->filename.buf, "-",
> +			NULL);

What is going on around here?  Ahh, an unnecessary indentation
change is fooling the diff and made the patch unreadable.  Sigh...

>  	sigchain_push(SIGPIPE, SIG_IGN);
> -	ret = pipe_command(&gpg, payload, payload_size,
> -			   gpg_status, 0, gpg_output, 0);
> +	ret = pipe_command(&gpg, payload, payload_size, &gpg_out, 0,
> +				&gpg_err, 0);

What is this change about?  Is it another unnecessary indentation
change?  Please make sure you keep distraction to your readers to
the minimum.

> @@ -309,35 +319,36 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>  int check_signature(const char *payload, size_t plen, const char *signature,
>  	size_t slen, struct signature_check *sigc)
>  {
> -	struct strbuf gpg_output = STRBUF_INIT;
> -	struct strbuf gpg_status = STRBUF_INIT;
> +	struct gpg_format *fmt;
>  	int status;
>  
>  	sigc->result = 'N';
>  	sigc->trust_level = -1;
>  
> -	status = verify_signed_buffer(payload, plen, signature, slen,
> -				      &gpg_output, &gpg_status);
> -	if (status && !gpg_output.len)
> -		goto out;
> -	sigc->payload = xmemdupz(payload, plen);
> -	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
> -	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
> -	parse_gpg_output(sigc);
> +	fmt = get_format_by_sig(signature);
> +	if (!fmt) {
> +		error(_("bad/incompatible signature '%s'"), signature);
> +		return -1;
> +	}
> +
> +	if (!strcmp(fmt->name, "ssh")) {
> +		status = verify_ssh_signature(sigc, fmt, payload, plen, signature, slen);
> +	} else {
> +		status = verify_gpg_signature(sigc, fmt, payload, plen, signature, slen);
> +	}

OK, so get_format_by_sig() now is used to dispatch to the right
backend.  Which sort of makes sense, but ...

 * "ssh" is the newcomer; it has no right to come before the
   battle-tested existing one.

 * If we are dispatching via "fmt" variable, we should add
   fmt->verify() method to each of these formats, so that we don't
   have to switch based on the name.

IOW, this part should just be

	fmt = get_format_by_sig(signature);
	if (!fmt)
		return error(_("...bad signature..."));
	fmt->verify_signature(sigc, fmt, payload, plen, signature, slen);

> +	if (status && !sigc->output)
> +		return !!status;
> +
>  	status |= sigc->result != 'G';
>  	status |= sigc->trust_level < configured_min_trust_level;

By the way, there is no verify_ssh_signature() function defined at
this step [1/9], so this won't compile from the source at all.
Please make sure that each step builds and passes tests.

If I were doing this patch, I probably would NOT do anything related
to "ssh" in this step.  Probably just doing

 - rename gpg_* variables to generic names in codepaths that _will_
   become generic in future steps (like "check_signature()"
   function);

 - introduce verify_signature member to the fmt struct;

 - hoist get_format_by_sig()'s callsite to check_signature() from
   its callee.

would be sufficient amount of work for the first step.  Call that a
preliminary refactoring and clean-up.

And then in the second and subsequent steps, you may start adding
additional code to support ssh signing, including the new instance
of fmt that has verify_ssh_signature() as its verify_signature
method, etc.

Introducing ssh_allowed_signers and ssh_revocation_file at this step
is way premature.  Nobody uses them in this step, the code that uses
them is already referenced but missing (hence the code does not
build), so they are only there to frustrate readers wondering what
they are for and how they will be used.

Thanks.
