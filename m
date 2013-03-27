From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Consistent call style to gpg settings
Date: Wed, 27 Mar 2013 09:17:54 -0700
Message-ID: <7vehf0olzh.fsf@alter.siamese.dyndns.org>
References: <8C726954D36902459248B0627BF2E66F45D70C3E55@AUSP01VMBX10.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>,
	Jacob Sarvis <jsarvis@openspan.com>
To: Hans Brigman <hbrigman@openspan.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKt3R-0005ks-2F
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3C0QR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:17:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab3C0QR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:17:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57294A78A;
	Wed, 27 Mar 2013 12:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NSszfNahADElVA6/Hxso7Zqlu2w=; b=DyyY0b
	3nm00s89lbthiEAIKXcNAdO67rMyHe2I80Sb+XItY+c7dBKlIumqmgLvvDP4JR3j
	9WvL2+zmhI7v7uvOUw23crLpzgxmDCiJ/blXPtqOxGitTK+2tPONekEPT+E1Drqr
	W11B07SqTDdkZtyongYpiIdzfYF2kn29kzBa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSB3e5GQs+x7jjtnKSdafZTLdsG0Yj+o
	kl4EE6H2viR9DWKViFIN7MsOPMYh8mVoxxm8wOMzBaqhkpYhgLUiH4RqNEnnhMZM
	mFJ3cPuqocV8WgC7RYn1dN+nf53NcUebbvWEXIUirqW4YKexLUQjm46O22FUEBTO
	0N4B0H3G2Q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B663A789;
	Wed, 27 Mar 2013 12:17:56 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB0F0A788; Wed, 27 Mar 2013
 12:17:55 -0400 (EDT)
In-Reply-To: <8C726954D36902459248B0627BF2E66F45D70C3E55@AUSP01VMBX10.collaborationhost.net> (Hans Brigman's message of "Wed, 27 Mar 2013 10:15:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1FE10E0-96F9-11E2-8FCD-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219267>

Hans Brigman <hbrigman@openspan.com> writes:

> From: Jacob Sarvis <jsarvis@openspan.com>
>
> config: Consistent call style to gpg settings
>
> Calling style for passing settings to git_gpg_config is inconsistent
> between commit-tree, commit, merge, tag, and verify-tag.
>
> Consolidate style of calling git_gpg_config.
>
> Signed-off-by: Hans Brigman <hbrigman@openspan.com>

Exactly the same comments as the review for the other patch apply here.

> ---
> builtin/commit-tree.c |  5 ++---
> builtin/commit.c      |  6 ++----
> builtin/merge.c       | 12 ++++--------
> builtin/tag.c         |  5 ++---
> builtin/verify-tag.c  |  5 ++---
> 5 files changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index eac901a..45e0152 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -28,9 +28,8 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
>  static int commit_tree_config(const char *var, const char *value, void *cb)
> {
> -              int status = git_gpg_config(var, value, NULL);
> -              if (status)
> -                              return status;
> +             if (git_gpg_config(var, value, cb) < 0)
> +                             return -1;
>                return git_default_config(var, value, cb);
> }

Earlier, we always returned what the underlying helper returned, but
in this version, we ignore error return values from git_gpg_config()
but honor error return values from git_default_config().

This is making things worse, no?
