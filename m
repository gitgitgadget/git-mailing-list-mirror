From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Let --decorate show HEAD position
Date: Mon, 12 Oct 2009 14:05:33 -0700
Message-ID: <7vk4z0e31e.fsf@alter.siamese.dyndns.org>
References: <200910122206.23044.trast@student.ethz.ch>
 <36861d16d0e21c662430882140893ad9a0b2fb25.1255379242.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDe-0002of-Is
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176AbZJLVGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758174AbZJLVGZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:06:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758154AbZJLVGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:06:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CBC375CFE;
	Mon, 12 Oct 2009 17:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qMrwDEESHvz6XG47c9KS2ImG3so=; b=aneGOm
	fSpLurkBmUWaT6ZX6CMesEer58kk0xzBQA/p17osj3jqafJrRI8MLBrFRXVg3boj
	vG3wuUIRx+vgUZM9Ivceij6uNACzTfLAZNBrPR0hNqiiw0fibfB2vRbd5PVL/sYL
	87Z/41jClA6/S1RyvYVIV693pk0rYtYq5qpIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nUnWLofSJ64DccLs5ZECRvh9SYGiK48h
	RHXv578eUy+nCX2hzkYvo7cwFNJwpA9TQRJPkOXZ9WIm2u5f0gl+3ZHP7apf51wW
	MQsk7hP1tR4kPBSUyRUP7FQXZhXrPUh80vMFPCxWVDVYYVFawE2kZxpRASQzTqBU
	YNTq8Yi28+8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 709B175CFC;
	Mon, 12 Oct 2009 17:05:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE4EF75CF5; Mon, 12 Oct 2009
 17:05:34 -0400 (EDT)
In-Reply-To: <36861d16d0e21c662430882140893ad9a0b2fb25.1255379242.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon\, 12 Oct 2009 22\:34\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FEA69934-B772-11DE-8B95-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130064>

Thomas Rast <trast@student.ethz.ch> writes:

> 'git log --graph --oneline --decorate --all' is a useful way to get a
> general overview of the repository state, similar to 'gitk --all'.
> Let it indicate the position of HEAD by loading that ref too, so that
> the --decorate code can see it.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

I think this makes sense.

I see HEAD is given at the front in the sample output, which I think also
makes sense.  Is it because it is pushed the last?  If so, the same commit
at the tip of branch alpha and beta are decorated with beta and then
alpha, I have to wonder...?

>
> I wrote:
>> Damn, this fails tests and I only just noticed while testing another
>> series.  Sorry for the noise, reroll upcoming...
>
>
>  log-tree.c                             |    1 +
>  t/t4013/diff.log_--decorate=full_--all |    2 +-
>  t/t4013/diff.log_--decorate_--all      |    2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 1618f3c..f7d54f2 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -43,6 +43,7 @@ void load_ref_decorations(int flags)
>  	if (!loaded) {
>  		loaded = 1;
>  		for_each_ref(add_ref_decoration, &flags);
> +		head_ref(add_ref_decoration, &flags);
>  	}
>  }
>  
> diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
> index 903d9d9..d155e0b 100644
> --- a/t/t4013/diff.log_--decorate=full_--all
> +++ b/t/t4013/diff.log_--decorate=full_--all
> @@ -1,5 +1,5 @@
>  $ git log --decorate=full --all
> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (refs/heads/master)
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, refs/heads/master)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
> diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
> index 954210e..fd7c3e6 100644
> --- a/t/t4013/diff.log_--decorate_--all
> +++ b/t/t4013/diff.log_--decorate_--all
> @@ -1,5 +1,5 @@
>  $ git log --decorate --all
> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (master)
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, master)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
> -- 
> 1.6.5.62.g4370d.dirty
