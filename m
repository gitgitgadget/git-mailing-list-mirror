From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update Documentation/git-config to reflect --local
 option.
Date: Thu, 03 May 2012 16:25:59 -0700
Message-ID: <7vr4v0deyg.fsf@alter.siamese.dyndns.org>
References: <1754870.q6d2rgDqBT@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davidbarr@google.com,
	florian.achleitner.2.6.31@gmail.com, jrnieder@gmail.com
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 01:26:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ5PW-00083T-Lu
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 01:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758977Ab2ECX0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 19:26:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64844 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756403Ab2ECX0C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 19:26:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3BFB783A;
	Thu,  3 May 2012 19:26:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y8yMVpBLdsFNpxz0Kbr58sNxQ7A=; b=aHCeuw
	bSXGUgt/OiRMQgK36OuABGoYeNeaiVd1ulF8O1dCJAU4nUEcFT647XdpIiUWRRAe
	S9voZw1Bdf/n5R67/qY9YwME/RgveA3mlr31QI398M2nIbZmB2gIClLOa3IVOtQ1
	kCpsTewvXdQ5t9M96Xl6/M4vKf5XVOtRCS68c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzJRX5da+LL2OHogceFg6LBKLlmM0WAu
	07p2rod7A3dHDkUjEkqm37fiEqg2cpuOHRKY1UPF4QtbGVxhzmhS8JPM7BRpThe0
	xKP7bOb2L2aiw6qE6tmAlfSRsmABJm2HQ4oT2EA3kWAdtPB9tD+0u3x9BmCLqjx0
	R+f2OZWrsZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF9A7839;
	Thu,  3 May 2012 19:26:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40C1A782E; Thu,  3 May 2012
 19:26:01 -0400 (EDT)
In-Reply-To: <1754870.q6d2rgDqBT@flobuntu> (Florian Achleitner's message of
 "Fri, 04 May 2012 00:44:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 584ADEC0-9577-11E1-B943-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196978>

Florian Achleitner <florian.achleitner2.6.31@gmail.com> writes:

> Describe config file selection in git-config.
> While the usage message of git-config shows --local,
> the documentation page did not contain anything about that.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
> This was pointed out in http://thread.gmane.org/gmane.comp.version-
> control.git/196326

Hrm, does the updated text explain the usefulness of the option clearly
enough?

Peff> Original motivation is here:
Peff> http://thread.gmane.org/gmane.comp.version-control.git/152524

> +The file-option can be one of '--system', '--global', '--local', or '--file'
>  which specify where the values will be read from or written to.
>  The default is to assume the config file of the current repository,
> +.git/config unless defined otherwise with GIT_DIR and GIT_CONFIG.
> +For read commands like '--get' the default is to search local, global, and
> +system config files (in this order) for the requested value and stop after
> +the first finding.

It may be just me, but I find the untouched "The default is to assume"
line somewhat out of place after this update.  When reading, without any
of the options, we read all three places and consolidate them (stopping
after the first file that has the definition is a funny exception that
"--get" does; in general the internals read all of them so "--get-all"
output is a better way to understand what you wrote in your configuration
files), and when writing, without any of the options, we write to the
current configuration file.

The paragraph should first be restructured to describe read and write
cases separately, and then '--local' should be described, perhaps like
this?

	When reading, the values are read from the system, global and
	repository local configuration files by default, and options
	'--system', '--global', '--local' and '--file <filename>' can be
	used to tell the command to read from only that location.

	When writing, the new value is written to the repository local
	configuration file by default, and options '--system', '--global',
	'--file <filename>' can be used to tell the command to write to
	that location (you can say '--local' but that is the default).
