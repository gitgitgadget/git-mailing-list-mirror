From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix usage of git-init and git-init-db documentation
Date: Tue, 24 May 2011 08:58:04 -0700
Message-ID: <7voc2s850z.fsf@alter.siamese.dyndns.org>
References: <1306248113-19948-1-git-send-email-pegon.marc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Pegon <pegon.marc@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 17:58:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOtzu-0006ho-82
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 17:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab1EXP6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 11:58:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953Ab1EXP6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 11:58:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1F22538B;
	Tue, 24 May 2011 12:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OeWkNHTusNiJeTq6l/4FdRmJpwQ=; b=r7gxHa
	I/3F7bdEmaU+25JMGZzK7r1iArtveFMxI3RU43rIZpHWFC4xgDs2Jl6DIX1efjhp
	vZpsQkWY7XmJCe1/+oCW6/R62TUD0DCBvvlq2hai5fO0fEwpqx6g+PSamven4Pgn
	NmeRTz3EN4woQViWme58FJ3itE8/CboyRDhs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y39df7P/Jx4wv99RqsOhXZB7ty72uZnK
	UFeqvsd6dv6xRBT2zpJLaEzQXyjQ5BFDOM07gnsxyFatGi043nJ6My2YEHaoa1P6
	0bvYluC54x9hEKaRqL4c4G+fouUU5s8uTA6EbQUPsqHrQ9/MKIau1FLRlIByh3kk
	UpwbIwvl4QA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9CC6538A;
	Tue, 24 May 2011 12:00:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C1AEB5389; Tue, 24 May 2011
 12:00:14 -0400 (EDT)
In-Reply-To: <1306248113-19948-1-git-send-email-pegon.marc@gmail.com> (Marc
 Pegon's message of "Tue, 24 May 2011 16:41:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB4E7010-861E-11E0-A20D-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174322>

Marc Pegon <pegon.marc@gmail.com> writes:

> These were not updated in commit b57fb80a7d7 (init, clone: support --separate-git-dir for .git file)

Too long a line?

I think "Fix usage" on the title can be clarified a lot to make the entry
for this commit in the "shortlog" output meaningful.

> Signed-off-by: Marc Pegon <pegon.marc@gmail.com>
> ---
> ...
>  SYNOPSIS
>  --------
> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--shared[=<permissions>]]
> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]
> +	  [--separate-git-dir|-L <git dir>]
> +	  [--shared[=<permissions>]] [directory]

This is wrong, isn't it?  It looks as if you can give "--separate-git-dir"
(without anything else), or you can give "-L <dir>".

By the way, the change seems to have slipped in while I wasn't paying too
much attention, but who came up with this silly capital 'L'?  As it hasn't
been advertised in the documentation (lucky us), it probably is not too
late to remove it.
