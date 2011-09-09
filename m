From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Fri, 09 Sep 2011 08:54:42 +0200
Message-ID: <4E69B832.9030503@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net> <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> <7vfwkodq5s.fsf@alter.siamese.dyndns.org> <4E5A5290.4050005@drmicha.warpmail.net> <20110907195611.GD13364@sigill.intra.peff.net> <4E6889DF.7030404@drmicha.warpmail.net> <7vr53qwxtz.fsf@alter.siamese.dyndns.org> <7vmxeewx7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 08:54:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1uzC-0003A2-Ke
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 08:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab1IIGyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 02:54:46 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37774 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756565Ab1IIGyp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 02:54:45 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9ABB02BF9C;
	Fri,  9 Sep 2011 02:54:44 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 09 Sep 2011 02:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nzZMDFcqKeKXjSpELteVzv
	Iq1sk=; b=aQ4vfsn4MAPR52ee+8NKEcgDM+o9STPSlE6V8Oer02EzKNhwEWdF/j
	Al3DRqlmcUY67lmqSzbmQJ9bvWrWE6YCxmEDr0+9d6L5laPd5zPnPjOGZ9u/3N7m
	pgWHu6kxKQt57ChAmxf1hoiRR3RrXB4NJTjfnF/c+jvY1HoicYvnw=
X-Sasl-enc: RdrLc4B/bYO21mswcGmZl905CNbAQR7yMBoRoGsp2Gzv 1315551284
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F3D918E02C4;
	Fri,  9 Sep 2011 02:54:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vmxeewx7f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181029>

Junio C Hamano venit, vidit, dixit 08.09.2011 23:17:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Jeff King venit, vidit, dixit 07.09.2011 21:56:
>>> ...
>>>> It does make me a little nervous about the "'git branch -v'
>>>> automatically means 'git branch --list -v'" patch, though. It closes the
>>>> door in the future to us being more or less verbose about branch
>>>> creation details (and while helpful, it creates a slight inconsistency
>>>> in the interface).
>>
>> Hasn't 'git branch -v' meant listing in verbose mode for a long enough
>> time that changing it now would mean a moderately major regression?
>>
>> At least my copy of v1.7.0 seems to list with "git branch -v".
> 
> Ah, nevermind.
> 
> As the series is already in 'next', here is what I came up with.

I thought you'll rebuild next anyways after 1.7.7, but either way it's
fine. Thanks for holding this series in next long enough to really cook
it (and Jeff for revisiting it), it's much better now, keeping the
(undocumented, but expected) behavior of "git branch -v foo".

> 
> -- >8 --
> From: Michael J Gruber <git@drmicha.warpmail.net>
> Date: Thu, 8 Sep 2011 14:09:50 -0700
> Subject: [PATCH] branch: -v does not automatically imply --list
> 
> "branch -v" without other options or parameters still works in the list
> mode, but that is not because there is "-v" but because there is no
> parameter nor option.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-branch.txt |    6 +++---
>  builtin/branch.c             |    3 +--
>  t/t3203-branch-output.sh     |    8 ++++++--
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 2b8bc84..f46013c 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -21,7 +21,7 @@ DESCRIPTION
>  With no arguments, existing branches are listed and the current branch will
>  be highlighted with an asterisk.  Option `-r` causes the remote-tracking
>  branches to be listed, and option `-a` shows both. This list mode is also
> -activated by the `--list` and `-v` options (see below).
> +activated by the `--list` option (see below).
>  <pattern> restricts the output to matching branches, the pattern is a shell
>  wildcard (i.e., matched using fnmatch(3))
>  Multiple patterns may be given; if any of them matches, the tag is shown.
> @@ -120,10 +120,10 @@ OPTIONS
>  
>  -v::
>  --verbose::
> -	Show sha1 and commit subject line for each head, along with
> +	When in list mode,
> +	show sha1 and commit subject line for each head, along with
>  	relationship to upstream branch (if any). If given twice, print
>  	the name of the upstream branch, as well.
> -	`--list` is implied by all verbosity options.
>  
>  --abbrev=<length>::
>  	Alter the sha1's minimum display length in the output listing.
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 98a420f..099c75c 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -712,8 +712,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
>  			     0);
>  
> -	if (!delete && !rename && !force_create &&
> -	    (argc == 0 || (verbose && argc)))
> +	if (!delete && !rename && !force_create && argc == 0)
>  		list = 1;
>  
>  	if (!!delete + !!rename + !!force_create + !!list > 1)
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index f2b294b..76fe7e0 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -84,12 +84,16 @@ cat >expect <<'EOF'
>  two
>  one
>  EOF
> -test_expect_success 'git branch -v pattern shows branch summaries' '
> -	git branch -v branch* >tmp &&
> +test_expect_success 'git branch --list -v pattern shows branch summaries' '
> +	git branch --list -v branch* >tmp &&
>  	awk "{print \$NF}" <tmp >actual &&
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git branch -v pattern does not show branch summaries' '
> +	test_must_fail git branch -v branch*
> +'
> +
>  cat >expect <<'EOF'
>  * (no branch)
>    branch-one
