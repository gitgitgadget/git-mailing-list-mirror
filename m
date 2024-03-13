Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB31E480
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373145; cv=none; b=E2DxtWZ+6ACtYwfsZHY4v/8kBPZyTg0o3bFmiYPVnTls8xuRSnoKHZdkvksSN1BGEipYHiBCTDZ9QHMZ2PRNm5l89li9ODkwwFA9nFhOjL+Ive2l4SvYVwXhXdp3HvZ/mpwcH9W56jEXJ+FZJ3lMgaHLF0qaseZSUOAnTYiJWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373145; c=relaxed/simple;
	bh=QSsC+69ZyNONWapHARAkpKNh8pITSXDppL3I7g19e6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjMloWn2ALJ/OnwVaDaP0ymUGMrlTIuAejqwOj/z3Yhnl+9ZxkC90oUmr5hHHDT8w/hlWw/5M85mOgRBVAXHI3hAEDtRCIrn/wRUl7IQpigMMifuSQXcVGzbLYEzLdTU8tB/Xb+6cWkXedIuxL0WBlY5hWOMXw1K5fnIDzf4g2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YNMlofqj; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YNMlofqj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F63C1CA5D;
	Wed, 13 Mar 2024 19:39:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QSsC+69ZyNONWapHARAkpKNh8pITSXDppL3I7g
	19e6E=; b=YNMlofqjTFDt5CWjQrHv9Dm5E+7tntaUitySR3+7+Qskrtt0TkOsaL
	rg9stPSMseWTgueBHc8vkDeOtN3i0FChZlIUfFnulCkwfQHlh9h/wRLRK0xtau/x
	bXA9Bc5zJBu8I59qz1DzYZRnDFcEbYQBOa+8tbW3TVnVsymaw80Eg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 487EA1CA5C;
	Wed, 13 Mar 2024 19:39:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7D951CA58;
	Wed, 13 Mar 2024 19:38:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] Teach send-pack & push to --send-up-to-date refs
In-Reply-To: <SA1PR14MB469144B8903909F65493323A8D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	(Christopher Lindee's message of "Tue, 12 Mar 2024 21:55:12 +0000")
References: <SA1PR14MB469144B8903909F65493323A8D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
Date: Wed, 13 Mar 2024 16:38:58 -0700
Message-ID: <xmqqzfv14s8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DDD64236-E192-11EE-8331-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christopher Lindee <christopher.lindee@webpros.com> writes:

> Subject: Re: [PATCH 1/2] Teach send-pack & push to --send-up-to-date refs

cf. Documentation/SubmittingPatches:describe-changes.

Perhaps

	[PATCH 1/2] push: allow pushing a no-op update to refs

or something?

> Provide an option that forces the local Git transport to transmit a local
> ref even when the receiving ref would not change (i.e. the local & remote
> refs point to the same object).  This is not done normally, as no changes
> would take place on the server in a vanilla Git setup.  However, some Git
> servers support push options and those push options decide which branches
> to operate on based on the refs that are transmitted alongside the option.
> This option ensures the refs listed on the command line are always sent.

Flip the order of description to give your observation of the
current behaviour first, your perceived problem in it next, and then
finally your solution.  That way, those who are totally unfamiliar
with the problem area can just read from start to end straight, and
those who know what we do currently can skip and start from your
problem description.

Also, it would be nice if you throw in the issue about missing ref
in the push certificate, which I mentioned in my response to the
cover letter.

>  Documentation/git-push.txt      | 8 +++++++-
>  Documentation/git-send-pack.txt | 7 +++++++
>  builtin/push.c                  | 1 +
>  builtin/send-pack.c             | 4 ++++
>  send-pack.c                     | 2 +-
>  send-pack.h                     | 3 ++-
>  transport-helper.c              | 7 ++++++-
>  transport.c                     | 1 +
>  transport.h                     | 1 +
>  9 files changed, 30 insertions(+), 4 deletions(-)

No tests?

>  'git push' [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>  	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-q | --quiet] [-v | --verbose]
> -	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
> +	   [-u | --set-upstream] [-o <string> | --push-option=<string>] [--send-up-to-date]

I do not know if the new option is a name that is easy to
understand.  I am not great at naming, either but how does
"--force-no-op" sound?

> +	Usually, the command will not send a local ref when the remote ref
> +	already matches, as no change would occur if it did.  This flag

In the context of "push", 'match' is a verb that is used in
different contexts, like "'git push master' finds a ref that matches
'master' and updates refs/heads/master".  You would want to avoid it
when you can.

    Usually the command omits instructing the receiving end to
    update a ref to point at an object, if the target ref points at
    the exact object already, as no change ...

> +	disables that check.  This allows push options to be sent alongside
> +	up-to-date references on the remote.

Aside from options and push certificates, there may be other side
effects from this change.  I am not sure if we want to make sure we
enumerate the benefit all like this.  Perhaps drop "This allows ..."
altogether?

> diff --git a/send-pack.c b/send-pack.c
> index 37f59d4f66..30b0f2f276 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -313,7 +313,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
>  	case REF_STATUS_REJECT_NODELETE:
>  		return CHECK_REF_STATUS_REJECTED;
>  	case REF_STATUS_UPTODATE:
> -		return CHECK_REF_UPTODATE;
> +		return args->send_uptodate ? 0 : CHECK_REF_UPTODATE;
>  
>  	default:
>  	case REF_STATUS_EXPECTING_REPORT:

Given the existing flow of this code, I would prefer to see it
written more like so:

diff --git i/send-pack.c w/send-pack.c
index 37f59d4f66..97d01726bb 100644
--- i/send-pack.c
+++ w/send-pack.c
@@ -313,8 +313,9 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 	case REF_STATUS_REJECT_NODELETE:
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
-		return CHECK_REF_UPTODATE;
-
+		if (!args->send_uptodate)
+			return CHECK_REF_UPTODATE;
+		/* fallthru */
 	default:
 	case REF_STATUS_EXPECTING_REPORT:
 		/* already passed checks on the local side */

to make it clear that the caller gets 0 ("go ahead and do it")
unless it is one of the cases explicitly listed abouve the "default"
label.

> +	int do_nop = flags & TRANSPORT_PUSH_SEND_UPTODATE;

Here we do call it "do_nop", showing that at least to you, "nop" is
a much more fitting word than "uptodate" for what we are trying to
achieve in this topic.  It would give us one piece of good input to
decide what the end-user facing name should be.  In fact it is where
I took inspiration from for "force-noop" I mentioned earlier.

> @@ -1010,7 +1011,11 @@ static int push_refs_with_push(struct transport *transport,
>  			} else
>  				continue;
>  		case REF_STATUS_UPTODATE:
> -			continue;
> +			if (do_nop) {
> +				; /* do nothing */
> +			}
> +			else
> +				continue;

Drop needless braces around a single-statement block.
Alternatively, we could write it like so:

			if (!do_nop)
				continue;
			/* fallthru */

but I think what you wrote, modulo the unnecessary braces, makes the
intent a bit more clear.

>  		default:
>  			; /* do nothing */
>  		}
