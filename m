From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] bash completion: Support "divergence from
 upstream" warnings in __git_ps1
Date: Sun, 13 Jun 2010 20:13:04 -0700
Message-ID: <7v7hm2e27z.fsf@alter.siamese.dyndns.org>
References: <cover.1276336602.git.trast@student.ethz.ch>
 <93842467ca22405712cab23a9b3920c106df0f17.1276336602.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 14 05:13:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO078-0008HN-Ti
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 05:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab0FNDN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 23:13:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab0FNDNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 23:13:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28895BB99D;
	Sun, 13 Jun 2010 23:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ibRj0CB8BadesVd41ZzE4zzwQo=; b=ak7wb1
	sEdHBcy+7Lxbry27cjbTXMjQ9gatsE2TJ1ZViqNtBPJxnSgJGjk6AneUFItCdEwJ
	h8ZpU9C9PqWcoUf0KfL04Zfxd0qv7+b1kuJqxDbO+WNnIzHSeUk7VfRRdczJPTuc
	vK+dss71s9b8NdizKOjcR1kRGzfLsoCqJmE70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e/9UmLOISLcYNvs+jpkWCHtKLvJ9wo16
	oCwnbJo+suD/3JyvzQGCEe5bgPUUBiSA6l2edxLnBxDOWJqWmlpPIRthE+VsPHXL
	1XjXWoqOhmBZ/6K5njaH3wsvQm65iKjZZrqN9djHiKSJ5N+tsRbl8dF5Icxfj9IN
	Y5gwaITWRy0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73BFABB985;
	Sun, 13 Jun 2010 23:13:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E044BB97F; Sun, 13 Jun
 2010 23:13:06 -0400 (EDT)
In-Reply-To: <93842467ca22405712cab23a9b3920c106df0f17.1276336602.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 12 Jun 2010 11\:59\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5DC0E94-7762-11DF-9AF6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149064>

Thomas Rast <trast@student.ethz.ch> writes:

> +#       If you would like to see the difference between HEAD and its upstream,
> +#       set GIT_PS1_SHOWUPSTREAM to one of the following:
> +#           git          use @{upstream}
> +#           svn          attempt to DWIM svn upstream for normal and --stdlayout
> +#           ref <ref>    unconditionally use <ref>
> +#           eval <code>  evaluate <code> which should print the commit to use

This looks somewhat overengineered, although "git" and "svn" are probably
useful in real life.  I especially wonder if a fixed <ref> is useful at
all.  Wouldn't the choice of "other" branch always depend on the current
branch?
