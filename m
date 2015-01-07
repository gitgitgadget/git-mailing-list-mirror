From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] support for --no-relative and diff.relative
Date: Wed, 07 Jan 2015 10:09:22 -0800
Message-ID: <xmqqiogijwdp.fsf@gitster.dls.corp.google.com>
References: <548B7967.3060201@shysecurity.com>
	<54972C29.7060801@shysecurity.com> <54A2E744.8010508@shysecurity.com>
	<54A2FDC8.5010504@shysecurity.com> <54AC0B2B.90107@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: kelson@shysecurity.com
X-From: git-owner@vger.kernel.org Wed Jan 07 19:15:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8v7q-0000jN-M8
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 19:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbbAGSO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 13:14:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753573AbbAGSO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 13:14:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A9CC2B35C;
	Wed,  7 Jan 2015 13:14:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kC3HfiSWhcWvI4joR/vH0vlur6g=; b=HLkop0v4LeM+oc0sEmAH
	EtCMgAP9BKbPmfecU6JiXHQm+dVsFfeI+Zrm+SCftURaTeXgytq3fWIpoyeInfod
	5rb7KDLo3PSPhSNAZ3pO8duOGxXozk1/Ev5Lu/wxGtB4FWO+IJ5i8dfz8PAu7woW
	lrBxmcX+/XyBFkVP6KftYdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=as1dDxYCVk7NFfjGIy7dUseI+X5jmfLLYrcPUBB5SzqaiQ
	tEoF2407jIUTJaxwYt+tIr1IPIKvM/VdYY/HjuIpPvxV30kB1uL4wVOPRQehhdxS
	ABrQ0gVCb83OK3CFFfRA9p+rhs4W5IR/IcBnl+wsNxb6T8NLAkbxBMxj34qJY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 810FC2B35B;
	Wed,  7 Jan 2015 13:14:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92EE22B1EC;
	Wed,  7 Jan 2015 13:09:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F39144E-9698-11E4-AC84-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262141>

kelson@shysecurity.com writes:

> Content-Type: text/plain; charset=utf-8; format=flowed

Please.  No format=flawed.  Really.

> Subject: Re: [PATCH 1/2] support for --no-relative and diff.relative

"diff: teach --no-relative to override earlier --relative" or
something.  Saying the affeced area upfront, terminated with a colon
':', will make it easier to spot in "git shortlog" output later.

Also this step is not about --no-relative and diff.relative but is
only about --no-relative option.

> added --no-relative option for git-diff (code, documentation, and tests)

"Add --no-relative option..."; we write in imperative, as if we are
giving an order to the project secretary to "make the code do/be so".

> --no-relative overrides --relative causing a return to standard behavior

OK (modulo missing full-stop).

>
> Signed-off-by: Brandon Phillips <kelson@shysecurity.com>

Please also have

	From: Brandon Phillips <kelson@shysecurity.com>

as the first line of the body of your e-mail message, if you are
letting your MUA only give your e-mail address without name.
Alternatively, please ask/configure your MUA to put your name as
well as your address on From: header of the e-mail (which is
preferrable).

> diff --git a/diff.c b/diff.c
> index d1bd534..7bceba8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3695,6 +3695,8 @@ int diff_opt_parse(struct diff_options *options,
> const char **av, int ac)

Line-wrapped.

>  		DIFF_OPT_SET(options, RELATIVE_NAME);
>  		options->prefix = arg;
>  	}
> +	else if (!strcmp(arg, "--no-relative"))
> +		DIFF_OPT_CLR(options, RELATIVE_NAME);
>

When "--relative" is given, options->prefix is set to something as
we can see above.

The --relative option is described as optionally taking <path> in
the doc:

 --relative[=<path>]::
        When run from a subdirectory of the project, it can be
        told to exclude changes outside the directory and show
        pathnames relative to it with this option.  When you are
        not in a subdirectory (e.g. in a bare repository), you
        can name which subdirectory to make the output relative
        to by giving a <path> as an argument.

Doesn't "--no-relative" codepath have to undo the effect of that
assignment to options->prefix?

For example, after applying this patch, shouldn't

	$ cd t
	$ git show --relative=Documentation --no-relative --relative

work the same way as

	$ cd t
	$ git show --relative

i.e. limiting its output to the changes in the 't/' directory and
not to the changes in the 'Documentation/' directory?

Patch 2/2 also seems to share similar line-wrapping breakages that
make it unappliable, but more importantly, the configuration that is
supposed to correspond to --relative option only parses a boolean.
Is that the right design, or should it also be able to substitute a
command line `--relative=<path>` with an argument?

The last was a half-way rhetorical question and my answer is that
boolean-only is the best you could do, because we cannot do the
usual "bool or string" trick when "string" can be arbitrary.  In
other words, "diff.relative=true" could mean "limit to the current
subdirectory" aka "--relative" or it could mean "limit to true/
subdirectory" aka "--relative=true", and there is no good way to
disambiguate between the two [*1*].

So I can agree with the design decision but only after spending 6
lines to think about it.  For the end-users, this design decision
needs to be explained and spelled out in the documentation.  Saying
"equivalent to `--relative`" is not sufficient, because the way
`--relative` option itself is described elsewhere.  The option
appears as `--relative[=<path>]` (see above), so some people _will_
read "equivalent to `--relative`" to mean "Setting diff.relative=t
should be equivalent to --relative=t", which is not what actually
happens.


[Footnote]

*1* Actually, you could declare that "diff.relative=true/" means the
    'true/' directory while "diff.relative=true" means the boolean
    'true' aka 'diff --relative', but I think it is too confusing.
    Let's not make it worse by going that route.
