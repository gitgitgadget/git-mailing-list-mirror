From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] Documentation: Add diff.<driver>.* to config
Date: Mon, 04 Apr 2011 10:54:14 +0200
Message-ID: <4D998736.2080901@drmicha.warpmail.net>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com> <1301840722-24344-1-git-send-email-artagnon@gmail.com> <1301840722-24344-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 10:57:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6fbd-00016M-0h
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 10:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab1DDI5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 04:57:47 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57521 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753362Ab1DDI5q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 04:57:46 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2F70B2063E;
	Mon,  4 Apr 2011 04:57:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 04 Apr 2011 04:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=P8vCTeYOKDWTk/kaT5C4LUUzkaM=; b=SNlcox41iTaSvfhba207P1i8+hFQaNwIx+59mkTJLRgrMd8MTqIEVACTTAYbxNBihawB8BGsDKdj4h+oggcvZugLyrX1MQDafB+eTNM9vX7AEiegJDmIQQcdsNF6Iq9+r+Q0qtIwFKZtM1sUqpZ5P2nOBmgpUIsOCgSplenLwuc=
X-Sasl-enc: Pv8QvZcbB5c13GQmavrLLTyL7p+dWjYSLu+IZCcGaJ/D 1301907465
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4C9DD4013DF;
	Mon,  4 Apr 2011 04:57:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1301840722-24344-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170798>

Ramkumar Ramachandra venit, vidit, dixit 03.04.2011 16:25:
> Although the gitattributes page contains comprehensive information
> about these configuration options, they should be included in the
> config documentation for completeness.  Also, move out the diff.*
> configuration options into a dedicated diff-config.txt.
> 
> Helped-by: Jakub Narebski <jnareb@gmail.com>
> Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/config.txt      |   63 +----------------------------
>  Documentation/diff-config.txt |   91 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/diff-config.txt
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 711072c..cfeef63 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -812,68 +812,7 @@ commit.template::
>  	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
>  	specified user's home directory.
>  
> -diff.autorefreshindex::
> -	When using 'git diff' to compare with work tree
> -	files, do not consider stat-only change as changed.
> -	Instead, silently run `git update-index --refresh` to
> -	update the cached stat information for paths whose
> -	contents in the work tree match the contents in the
> -	index.  This option defaults to true.  Note that this
> -	affects only 'git diff' Porcelain, and not lower level
> -	'diff' commands such as 'git diff-files'.
> -
> -diff.external::
> -	If this config variable is set, diff generation is not
> -	performed using the internal diff machinery, but using the
> -	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
> -	environment variable.  The command is called with parameters
> -	as described under "git Diffs" in linkgit:git[1].  Note: if
> -	you want to use an external diff program only on a subset of
> -	your files, you	might want to use linkgit:gitattributes[5] instead.
> -
> -diff.mnemonicprefix::
> -	If set, 'git diff' uses a prefix pair that is different from the
> -	standard "a/" and "b/" depending on what is being compared.  When
> -	this configuration is in effect, reverse diff output also swaps
> -	the order of the prefixes:
> -`git diff`;;
> -	compares the (i)ndex and the (w)ork tree;
> -`git diff HEAD`;;
> -	 compares a (c)ommit and the (w)ork tree;
> -`git diff --cached`;;
> -	compares a (c)ommit and the (i)ndex;
> -`git diff HEAD:file1 file2`;;
> -	compares an (o)bject and a (w)ork tree entity;
> -`git diff --no-index a b`;;
> -	compares two non-git things (1) and (2).
> -
> -diff.noprefix::
> -	If set, 'git diff' does not show any source or destination prefix.
> -
> -diff.renameLimit::
> -	The number of files to consider when performing the copy/rename
> -	detection; equivalent to the 'git diff' option '-l'.
> -
> -diff.renames::
> -	Tells git to detect renames.  If set to any boolean value, it
> -	will enable basic rename detection.  If set to "copies" or
> -	"copy", it will detect copies, as well.
> -
> -diff.ignoreSubmodules::
> -	Sets the default value of --ignore-submodules. Note that this
> -	affects only 'git diff' Porcelain, and not lower level 'diff'
> -	commands such as 'git diff-files'. 'git checkout' also honors
> -	this setting when reporting uncommitted changes.
> -
> -diff.suppressBlankEmpty::
> -	A boolean to inhibit the standard behavior of printing a space
> -	before each empty output line. Defaults to false.
> -
> -diff.tool::
> -	Controls which diff tool is used.  `diff.tool` overrides
> -	`merge.tool` when used by linkgit:git-difftool[1] and has
> -	the same valid values as `merge.tool` minus "tortoisemerge"
> -	and plus "kompare".
> +include::diff-config.txt[]
>  
>  difftool.<tool>.path::
>  	Override the path for the given tool.  This is useful in case
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> new file mode 100644
> index 0000000..8c1732f
> --- /dev/null
> +++ b/Documentation/diff-config.txt
> @@ -0,0 +1,91 @@
> +diff.autorefreshindex::
> +	When using 'git diff' to compare with work tree
> +	files, do not consider stat-only change as changed.
> +	Instead, silently run `git update-index --refresh` to
> +	update the cached stat information for paths whose
> +	contents in the work tree match the contents in the
> +	index.  This option defaults to true.  Note that this
> +	affects only 'git diff' Porcelain, and not lower level
> +	'diff' commands such as 'git diff-files'.
> +
> +diff.external::
> +	If this config variable is set, diff generation is not
> +	performed using the internal diff machinery, but using the
> +	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
> +	environment variable.  The command is called with parameters
> +	as described under "git Diffs" in linkgit:git[1].  Note: if
> +	you want to use an external diff program only on a subset of
> +	your files, you	might want to use linkgit:gitattributes[5] instead.
> +
> +diff.ignoreSubmodules::
> +	Sets the default value of --ignore-submodules. Note that this
> +	affects only 'git diff' Porcelain, and not lower level 'diff'
> +	commands such as 'git diff-files'. 'git checkout' also honors
> +	this setting when reporting uncommitted changes.
> +
> +diff.mnemonicprefix::
> +	If set, 'git diff' uses a prefix pair that is different from the
> +	standard "a/" and "b/" depending on what is being compared.  When
> +	this configuration is in effect, reverse diff output also swaps
> +	the order of the prefixes:
> +`git diff`;;
> +	compares the (i)ndex and the (w)ork tree;
> +`git diff HEAD`;;
> +	 compares a (c)ommit and the (w)ork tree;
> +`git diff --cached`;;
> +	compares a (c)ommit and the (i)ndex;
> +`git diff HEAD:file1 file2`;;
> +	compares an (o)bject and a (w)ork tree entity;
> +`git diff --no-index a b`;;
> +	compares two non-git things (1) and (2).
> +
> +diff.noprefix::
> +	If set, 'git diff' does not show any source or destination prefix.
> +
> +diff.renameLimit::
> +	The number of files to consider when performing the copy/rename
> +	detection; equivalent to the 'git diff' option '-l'.
> +
> +diff.renames::
> +	Tells git to detect renames.  If set to any boolean value, it
> +	will enable basic rename detection.  If set to "copies" or
> +	"copy", it will detect copies, as well.
> +
> +diff.suppressBlankEmpty::
> +	A boolean to inhibit the standard behavior of printing a space
> +	before each empty output line. Defaults to false.
> +
> +diff.tool::
> +	Controls which diff tool is used.  `diff.tool` overrides
> +	`merge.tool` when used by linkgit:git-difftool[1] and has
> +	the same valid values as `merge.tool` minus "tortoisemerge"
> +	and plus "kompare".

That one would make more sense right before the diftool.* options.

> +
> +diff.<driver>.command::
> +	Defines the command that implements the custom diff driver.
> +	See linkgit:gitattributes[5] for details.

Why not:

The custom diff driver command.

> +
> +diff.<driver>.xfuncname::
> +	Defines the regular expression that the custom diff driver
> +	should use to recognize the hunk header.  A built-in pattern
> +	may also be used.  See linkgit:gitattributes[5] for details.

The regular...

> +
> +diff.<driver>.binary::
> +	Set this option to true to make the custom diff driver treat
> +	files as binary.  See linkgit:gitattributes[5] for details.

This has nothing to do with the diff driver's operation. It is about how
git treats the result (the output from the diff driver):

Set to true if git should treat the output of the custom diff driver as
binary.

> +
> +diff.<driver>.textconv::
> +	Defines the command that the custom diff driver should call to
> +	generate the text-converted version of a binary file.  The
> +	result of the conversion is used to generate a human-readable
> +	diff.  See linkgit:gitattributes[5] for details.

No, please! You don't need a custom diff driver for textconv.

The command which git should call to...

> +
> +diff.<driver>.wordregex::
> +	Defines the regular expression that the custom diff driver
> +	should use to split words in a line.  See
> +	linkgit:gitattributes[5] for details.
> +
> +diff.<driver>.cachetextconv::
> +	Set this option to true to make the custom diff driver cache
> +	the text conversion outputs.  See linkgit:gitattributes[5] for
> +	details.

Again, both are independent of a custom diff driver. Maybe even <driver>
is misleading here, I dunno. By "custom diff driver", I mean the thing
you specify with "diff.<whatever>.command", and this is orthogonal
(unrelated, can be combined with) textconc etc.

Michael
