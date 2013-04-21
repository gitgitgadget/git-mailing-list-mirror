From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 00:26:05 -0700
Message-ID: <7vd2towdiq.fsf@alter.siamese.dyndns.org>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:26:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTof9-0004Fz-22
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab3DUH0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:26:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab3DUH0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:26:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5F521405F;
	Sun, 21 Apr 2013 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5UpntdGxlDMuWbHf8RP25cNLobQ=; b=BBl2X1
	5zDXQ/Q/EAHF+EtvkTFqnQf0GqRsU2rq+xuYFQjnprq6A+oldUJNNinWIXVM6FYd
	FCM10phfhMkrpxXj++giTMBPfW7ZpWwfaRwD2RsrZ3zUuYLqcRfrXu2vG6NK5dbs
	LdbCP+wpjLiEjGameM6Pg8bCzfXWXG4xGBemg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p47eRFu5DJVLFLt8BftDnhw+rHfWxT0a
	xj9qC5imrgr5W1YBOIvr/+G2LuckvMaRa7aATx3vc/Xhe7MoCHFwVlSKz2PtvUXT
	970FuV1yrnBCpbQsITpucZhh80Bpz2MkqUQVNWi0nRQweTPlVQ5TKV+8opJlFdP6
	cIzJsyIrLdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9D591405E;
	Sun, 21 Apr 2013 07:26:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D3401405C;
	Sun, 21 Apr 2013 07:26:07 +0000 (UTC)
In-Reply-To: <20130420140051.GB29454@ruderich.org> (Simon Ruderich's message
	of "Sat, 20 Apr 2013 16:00:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB7BA022-AA54-11E2-9491-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221904>

Simon Ruderich <simon@ruderich.org> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 104579d..cd35ec7 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -24,6 +24,10 @@ ifndef::git-format-patch[]
>  --patch::
>  	Generate patch (see section on generating patches).
>  	{git-diff? This is the default.}
> +ifdef::git-log[]
> +	Changes introduced in merge commits are not displayed. Use `-c`,
> +	`--cc` or `-m` to include them.
> +endif::git-log[]

It probably is a better change to drop "Use `-c`..." and refer to
the "Diff formatting" section.

And then add '-p' and the fact that by default it will not show
pairwise diff for merge commits to the "Diff Formatting" section.
That is where -c/--cc/-m are already described.
