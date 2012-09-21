From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Fri, 21 Sep 2012 09:23:16 +0200
Message-ID: <505C15E4.7060108@alum.mit.edu>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org> <1348170383-15751-1-git-send-email-git@adamspiers.org> <1348170383-15751-15-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 09:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TExaE-0000ZV-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 09:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab2IUHXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 03:23:21 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:65510 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753783Ab2IUHXU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2012 03:23:20 -0400
X-AuditID: 12074411-b7fa36d0000008cc-c8-505c15e725d8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 39.06.02252.7E51C505; Fri, 21 Sep 2012 03:23:19 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8L7NG2R019168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Sep 2012 03:23:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1348170383-15751-15-git-send-email-git@adamspiers.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqPtcNCbAoHGNsMXPaRMZLbqudDNZ
	NPReYbbonvKW0eJHSw+zA6vH8iWLWDx2zrrL7vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGf0//jFWrBMreLqo+0sDYybZbsYOTkkBEwkNv7sZIOwxSQu3FsPZHNxCAlcZpSY0LCR
	FcI5ziTRfOIEK0gVr4C2xJ9H55lBbBYBVYndGx6A2WwCuhKLepqZQGxRgRCJGZcnM0PUC0qc
	nPmEBcQWEVCRuPd5CdhQZoGdjBJXds1kBEkIC9hJ7J6+GGrbEkaJ5x0nwTo4BVwk/m+dC1TE
	AdShLrF+nhBImFlAXmL72znMExgFZiHZMQuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz
	8lKLdE31cjNL9FJTSjcxQoJccAfjjJNyhxgFOBiVeHgvWUQHCLEmlhVX5h5ilORgUhLlbRaI
	CRDiS8pPqcxILM6ILyrNSS0+xCjBwawkwvsoBqicNyWxsiq1KB8mJc3BoiTOy7dE3U9IID2x
	JDU7NbUgtQgmK8PBoSTB+1cEaKhgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFbj
	i4HRCpLiAdqbDtLOW1yQmAsUhWg9xajLsfbuggeMQix5+XmpUuK8z0CKBECKMkrz4FbAUtor
	RnGgj4V5X4JU8QDTIdykV0BLmICWvLkeBbKkJBEhJdXAOPUZR0FzM1OK1/4ndz0Zaw7m1Pwv
	lJ3uq9l2NyZ0SeMy2+XTbcKjW32fLv7iblOZeP7wTPbYmQfPbvuqvzSjT27axIdX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206112>

On 09/20/2012 09:46 PM, Adam Spiers wrote:
> This works in a similar manner to git-check-attr.  Some code
> was reused from add.c by refactoring out into pathspec.c.
> 
> Thanks to Jeff King and Junio C Hamano for the idea:
> http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=108815
> 
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  .gitignore                             |   1 +
>  Documentation/git-check-ignore.txt     |  85 +++++
>  Documentation/gitignore.txt            |   6 +-
>  Makefile                               |   1 +
>  builtin.h                              |   1 +
>  builtin/check-ignore.c                 | 167 ++++++++++
>  command-list.txt                       |   1 +
>  contrib/completion/git-completion.bash |   1 +
>  git.c                                  |   1 +
>  t/t0007-ignores.sh                     | 587 +++++++++++++++++++++++++++++++++
>  t/t9902-completion.sh                  |  24 +-
>  11 files changed, 861 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/git-check-ignore.txt
>  create mode 100644 builtin/check-ignore.c
>  create mode 100755 t/t0007-ignores.sh
> 
> diff --git a/.gitignore b/.gitignore
> index a188a82..11cd975 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -22,6 +22,7 @@
>  /git-bundle
>  /git-cat-file
>  /git-check-attr
> +/git-check-ignore
>  /git-check-ref-format
>  /git-checkout
>  /git-checkout-index
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> new file mode 100644
> index 0000000..2de4e17
> --- /dev/null
> +++ b/Documentation/git-check-ignore.txt
> @@ -0,0 +1,85 @@
> +git-check-ignore(1)
> +=================
> +
> +NAME
> +----
> +git-check-ignore - Debug gitignore / exclude files
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git check-ignore' [options] pathname...
> +'git check-ignore' [options] --stdin < <list-of-paths>
> +
> +DESCRIPTION
> +-----------
> +
> +For each pathname given via the command-line or from a file via
> +`--stdin`, this command will list the first exclude pattern found (if
> +any) which explicitly excludes or includes that pathname.  Note that
> +within any given exclude file, later patterns take precedence over
> +earlier ones, so any matching pattern which this command outputs may
> +not be the one you would immediately expect.

Can I tell from the output of "git check-ignore" whether a file is
really ignored?  The way I read the paragraph above, the output doesn't
necessarily show the pattern that determines whether a file is *really*
ignored.  That makes it sound like the ignore status of the file might
be different than what I would infer from the output.  If I am
misunderstanding the situation, then perhaps the explanation in the
above paragraph can be improved.

On the other hand, if my understanding is correct, then why did you
choose this (seemingly strange) policy?  It would seem more useful
either to output the pattern that has the definitive effect on the
file's status, or to output all patterns that match the file.

> +OPTIONS
> +-------
> +-q, --quiet::
> +	Don't output anything, just set exit status.  This is only
> +	valid with a single pathname.
> +
> +-v, --verbose::
> +	Also output details about the matching pattern (if any)
> +	for each given pathname.
> +
> +--stdin::
> +	Read file names from stdin instead of from the command-line.
> +
> +-z::
> +	The output format is modified to be machine-parseable (see
> +	below).  If `--stdin` is also given, input paths are separated
> +	with a NUL character instead of a linefeed character.
> +
> +OUTPUT
> +------
> +
> +By default, any of the given pathnames which match an ignore pattern
> +will be output, one per line.  If no pattern matches a given path,
> +nothing will be output for that path; this means that path will not be
> +ignored.
> +
> +If `--verbose` is specified, the output is a series of lines of the form:
> +
> +<source> <COLON> <linenum> <COLON> <pattern> <HT> <pathname>
> +
> +<pathname> is the path of a file being queried, <pattern> is the
> +matching pattern, <source> is the pattern's source file, and <linenum>
> +is the line number of the pattern within that source.  If the pattern
> +contained a `!` prefix or `/` suffix, it will be preserved in the
> +output.  <source> will be an absolute path when referring to the file
> +configured by `core.excludesfile`, or relative to the repository root
> +when referring to `.git/info/exclude` or a per-directory exclude file.
> +
> +If `-z` is specified, the output is a series of lines of the form:
> +
> +EXIT STATUS
> +-----------
> [...]

I think you forgot to finish the thought about "If -z is specified".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
