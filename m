From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-log.txt,rev-list-options.txt: -n/--max-count is
 commit limiting
Date: Tue, 08 Mar 2011 11:59:22 -0800
Message-ID: <7vaah5e63p.fsf@alter.siamese.dyndns.org>
References: <4D75E92C.1090506@drmicha.warpmail.net>
 <4c0ad5a9af1d18e59a7e820349a531f220cbf776.1299572814.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px34F-0001jg-4s
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab1CHT7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:59:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab1CHT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:59:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02D06351A;
	Tue,  8 Mar 2011 15:00:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2vYEhW26yHPlCDDwJVizUimc3/Q=; b=nn1GGT
	krV0ytv1GVtDFvGomJBJS32u7pa2ERwqcMVO3EPhO19IeMhsUmTJVuDiuvw0/qzT
	RgxpMrGmR9mAmTR4KMpSgkuprV4Q1auz6YMcY2EjKHEmvVoG/gZUYQx5BMLyc6R/
	ji2upjhPGirXww0RrP6lbKOQURm+p7XUTI2aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VdPNX36kmPx/KexweGRVKsaeCjMJK5Op
	LFswkXBg9HCuq+LojNjjag7JgRtko59OQEJUm5NGTl1HENc6C3e/5HUTJKExlQxC
	by+B3u7YyU6zqfmGKw8uUuRpD7yaZqz61yxkKgdlA1ewtjS8/WUZapBAtFu2ycCK
	pgsiQ6yaqko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C5CE63519;
	Tue,  8 Mar 2011 15:00:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9FAE83517; Tue,  8 Mar 2011
 15:00:50 -0500 (EST)
In-Reply-To: <4c0ad5a9af1d18e59a7e820349a531f220cbf776.1299572814.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 8 Mar 2011 09:31:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6B1283E-49BE-11E0-8A82-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168684>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index ff41784..48c1715 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -25,6 +25,7 @@ OPTIONS
>  
>  -<n>::
>  	Limits the number of commits to show.
> +	Note that this is a commit limiting option, see below.

I wonder if we should be dropping this instead, as it appears later in the
document anyway.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 76add13..adcafa0 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -158,7 +158,8 @@ Commit Limiting
>  
>  Besides specifying a range of commits that should be listed using the
>  special notations explained in the description, additional commit
> -limiting may be applied.
> +limiting may be applied. Note that they are applied before commit
> +ordering and formatting options, such as '--reverse'.

This part is probably a good addition.
