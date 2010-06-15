From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere.txt: Document forget subcommand
Date: Tue, 15 Jun 2010 09:37:47 -0700
Message-ID: <7vr5k86ylg.fsf@alter.siamese.dyndns.org>
References: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
 <ebd2b2b5bb3352c6204f181416a7a521f8c6abf7.1276582759.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:38:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZ9H-0002hl-IB
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab0FOQh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:37:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0FOQh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:37:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D04BA7C8;
	Tue, 15 Jun 2010 12:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E4TCy3WmiR/uKa7FruhgtqtuOL0=; b=DFlAAN
	LG409FFlhhbCYJRhSKq2Rie+MR6U49/xAnWHMaVIn2o2uyDJjxVnApBlo5ZZNg47
	DiuasoxgtOzB6gA1Bqlr3qO044syzzqd0z/aMl/kCOGPWgBXoHlPum4biFjk/lN4
	JRVcS38Yck6WJ2yYDLNC8b0bV+MXfSJWGRBm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s83YEHT7s6skodkP6xZybUTA62ZQ7Gvy
	VrOydESagB11K68eO1+tPAEZeM0i0FNYTqIT3jcQCeW8QsVob45VMk93w2Hag6gx
	Nu/tSegiRpiMYMcpivCxj1Iw61ebqzIrWW3PkG1xkNoj3QZHpqZvhjeXxYKEgAbW
	Or0iavcZ7UE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56397BA7C3;
	Tue, 15 Jun 2010 12:37:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BDF5BA7BB; Tue, 15 Jun
 2010 12:37:49 -0400 (EDT)
In-Reply-To: <ebd2b2b5bb3352c6204f181416a7a521f8c6abf7.1276582759.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\, 15 Jun 2010 08\:21\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58217AD4-789C-11DF-B84B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149202>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> dea4562 (rerere forget path: forget recorded resolution, 2009-12-25)
> introduced the forget subcommand for rerere.
> ...
> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
> index acc220a..a7370d3 100644
> --- a/Documentation/git-rerere.txt
> +++ b/Documentation/git-rerere.txt
> @@ -40,6 +40,10 @@ This resets the metadata used by rerere if a merge resolution is to be
>  aborted.  Calling 'git am [--skip|--abort]' or 'git rebase [--skip|--abort]'
>  will automatically invoke this command.
>  
> +'forget' <pathspec>::
> +
> +This resets the conflict resolutions which rerere has recorded for <pathspec>.
> +

This description is not _incorrect_ per-se, but it does not convey one
important aspect of the subcommand; unlike "clear" and "gc", "forget" only
works in the context of the _current_ conflict resolution, just like
"diff" and "status".

Perhaps s/for <pathspec>/for the current conflict in <pathspec>/ would be
a sufficient improvement?
