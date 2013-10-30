From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] Documentation: put blame/log -L in sticked form
Date: Tue, 29 Oct 2013 18:11:29 -0700
Message-ID: <xmqqvc0fd0la.fsf@gitster.dls.corp.google.com>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<c41aef218951f8b0ec6a20e1dbc39712ad13afce.1383031141.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Oct 30 02:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbKK7-00069j-D4
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 02:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab3J3BLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 21:11:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab3J3BLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 21:11:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CFCA465D7;
	Wed, 30 Oct 2013 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z3BBr11gBxibDOs8d0375IHHjxA=; b=vtBgLo
	BuVLBfdKoQdAgzzbU+KVbbX7zhbQ3CxXcllqNUjRThbwOpcQXUZbQA+eZ4Yv+A4U
	ca610DFCyi0rZCi0fF37HQTKpNrgCz1JO62AuNp8ag/J1TnbJzEOgQs3/FEdXovh
	zrMzbbnFssNP8M+XQ5xUCRcq4S6XiM+MWPhL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XOZQ3L0oiqCaptY3mWpKVZnt+bq/vrV3
	F9UByDJ8CUsYUCNmhPlI0TYAgj8p9LGFp3n+1cVpjwXBO4t5Ss+SYGz5+QhDa98h
	z+x01QochjupdVh4aAGygaimAokAiElERoZ5V1Y8mqJgXYhGvdkpXydXMcRb+crv
	8sb1arj2IWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CD6F465D6;
	Wed, 30 Oct 2013 01:11:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B625D465D5;
	Wed, 30 Oct 2013 01:11:33 +0000 (UTC)
In-Reply-To: <c41aef218951f8b0ec6a20e1dbc39712ad13afce.1383031141.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Tue, 29 Oct 2013 08:20:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3780EF50-4100-11E3-9B23-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236955>

Thomas Rast <tr@thomasrast.ch> writes:

> The next patch will document gitk -L, but gitk does not understand the
> separated form ('gitk -L :foo:bar' results in an error).  Spell
> git-blame and git-log -L, which are supposed to be "the same" option,
> without the spaces to prevent confusion.

I agree that this patch may reduce confusion locally, but if we were
to go in this direction, we should be consistent and enforce "stuck"
form everywhere, not just the options you happened to have passed
thru to gitk, but other options such as "-S <revs-file>", and also
other commands that do not have anything to do with gitk (e.g. "git
commit -C<commit>", not "git commit -C <commit>".  Otherwise you
will give a wrong impression to readers as if they have to remember
which ones need to use the stuck form and which ones do not.

> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---
>  Documentation/blame-options.txt | 8 ++++----
>  Documentation/git-blame.txt     | 8 ++++----
>  Documentation/git-log.txt       | 6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 0cebc4f..28ca95e 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -9,13 +9,13 @@
>  --show-stats::
>  	Include additional statistics at the end of blame output.
>  
> --L <start>,<end>::
> --L :<regex>::
> +-L<start>,<end>::
> +-L:<regex>::
>  	Annotate only the given line range. May be specified multiple times.
>  	Overlapping ranges are allowed.
>  +
> -<start> and <end> are optional. ``-L <start>'' or ``-L <start>,'' spans from
> -<start> to end of file. ``-L ,<end>'' spans from start of file to <end>.
> +<start> and <end> are optional. ``-L<start>'' or ``-L<start>,'' spans from
> +<start> to end of file. ``-L,<end>'' spans from start of file to <end>.
>  +
>  include::line-range-format.txt[]
>  
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index f2c85cc..085dba1 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
> -	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
> +	    [-L<range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
>  	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
>  
>  DESCRIPTION
> @@ -139,12 +139,12 @@ lines 40-60 for file `foo`, you can use the `-L` option like so
>  (they mean the same thing -- both ask for 21 lines starting at
>  line 40):
>  
> -	git blame -L 40,60 foo
> -	git blame -L 40,+21 foo
> +	git blame -L40,60 foo
> +	git blame -L40,+21 foo
>  
>  Also you can use a regular expression to specify the line range:
>  
> -	git blame -L '/^sub hello {/,/^}$/' foo
> +	git blame -L'/^sub hello {/,/^}$/' foo
>  
>  which limits the annotation to the body of the `hello` subroutine.
>  
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 34097ef..87c10fa 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -62,8 +62,8 @@ produced by --stat etc.
>  	Note that only message is considered, if also a diff is shown
>  	its size is not included.
>  
> --L <start>,<end>:<file>::
> --L :<regex>:<file>::
> +-L<start>,<end>:<file>::
> +-L:<regex>:<file>::
>  
>  	Trace the evolution of the line range given by "<start>,<end>"
>  	(or the funcname regex <regex>) within the <file>.  You may
> @@ -152,7 +152,7 @@ EXAMPLES
>  	This makes sense only when following a strict policy of merging all
>  	topic branches when staying on a single integration branch.
>  
> -`git log -L '/int main/',/^}/:main.c`::
> +`git log -L'/int main/',/^}/:main.c`::
>  
>  	Shows how the function `main()` in the file 'main.c' evolved
>  	over time.
