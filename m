From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 20:58:49 +0100
Message-ID: <56521E79.4080709@kdbg.org>
References: <1448208133-29430-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, max@max630.net
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 20:59:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0anN-0007hA-A1
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 20:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbbKVT6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2015 14:58:54 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:15344 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbbKVT6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2015 14:58:53 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p3j9Q4Jl6z5tl9;
	Sun, 22 Nov 2015 20:58:50 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id CE2BD29D7;
	Sun, 22 Nov 2015 20:58:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1448208133-29430-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281568>

Am 22.11.2015 um 17:02 schrieb Edmundo Carmona Antoranz:
> Will also affect annotate
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>   Documentation/blame-options.txt |  7 +++++++
>   Documentation/git-blame.txt     |  9 ++++++++-
>   builtin/blame.c                 | 25 +++++++++++++++++++++++--
>   3 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 760eab7..43f4f08 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -69,6 +69,13 @@ include::line-range-format.txt[]
>   	iso format is used. For supported values, see the discussion
>   	of the --date option at linkgit:git-log[1].
>
> +--[no-]progress::
> +	Progress status is reported on the standard error stream
> +	by default when it is attached to a terminal. This flag
> +	enables progress reporting even if not attached to a
> +	terminal.
> +
> +
>   -M|<num>|::
>   	Detect moved or copied lines within a file. When a commit
>   	moves or copies a block of lines (e.g. the original file
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index e6e947c..2e63397 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>   [verse]
>   'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
>   	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
> -	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
> +	    [--[no-]progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
> +	    [--] <file>

You add the option to to the synopsis of git-blame.txt, but not to 
git-annotate.txt.

>
>   DESCRIPTION
>   -----------
> @@ -88,6 +89,12 @@ include::blame-options.txt[]
>   	abbreviated object name, use <n>+1 digits. Note that 1 column
>   	is used for a caret to mark the boundary commit.
>
> +--[no-]progress::
> +	Progress status is reported on the standard error stream
> +	by default when it is attached to a terminal. This flag
> +	enables progress reporting even if not attached to a
> +	terminal.
> +

Any particular reason you add this text twice? As can be seen on the 
hunk header, git-blame.txt includes blame-options.txt.

-- Hannes
