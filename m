From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] Help doc: Include --guide option description
Date: Sun, 03 Mar 2013 15:39:06 -0800
Message-ID: <7vd2vgyrxh.fsf@alter.siamese.dyndns.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
 <1362342072-1412-6-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIVI-0001Nh-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab3CCXjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:39:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712Ab3CCXjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 18:39:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0E70B689;
	Sun,  3 Mar 2013 18:39:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lgTD4d0yuMjKTQgByOEuiH3ZHFU=; b=cer0+cCzUrlkXshDv6hF
	amgTkBJkFix1j/d2XpR/d5/xgx8+42z3Pr9b2kZM8Itu9n6a2NLLg173PYu59khU
	yvWm+vEk36KFM9V5O3ddJNqglCy1b1FUiG/m0EC5qqpYrfy7/L+PghnAbzQlzy0f
	HMkWvxj+bmiE4rh0W985z/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MlOJO6MCIUpg5iOffmmZnEsXV+WHDz+W9NDfLfEuRpNtg9
	g2TM1661cOIFv5q7ZPeeYaTHg14qcsBPIPqJObaD8DSG09RpWev2v7iBD3OciMDX
	A+ltyyF2f8b35GrLpn/sifIgn9mF/9Jq/Ymd6nbDbyrc7lzqv+j+qFW3Y1AnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C65FEB688;
	Sun,  3 Mar 2013 18:39:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE3A2B686; Sun,  3 Mar 2013
 18:39:12 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DB9A478-845B-11E2-9651-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217371>

Philip Oakley <philipoakley@iee.org> writes:

> Note that the ability to display an individual guide was
> always possible. Include this in the update.
>
> Also tell readers how git(1) can be accessed, especially for
> Git for Windows users who do not have the 'man' command.
> Likewise include a commentary on how to access this page (Catch 22).
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/git-help.txt | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index e07b6dc..498a94e 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -8,31 +8,45 @@ git-help - Display help information about Git
>  SYNOPSIS
>  --------
>  [verse]
> -'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
> +'git help' [-a|--all] [-g|--guide]
> +	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
>  
>  DESCRIPTION
>  -----------
>  
> -With no options and no COMMAND given, the synopsis of the 'git'
> +With no options and no COMMAND|GUIDE given, the synopsis of the 'git'

Please avoid BNF in the prose meant for human consumption unless
necessary.  I think you can just say " or " here.

>  command and a list of the most commonly used Git commands are printed
>  on the standard output.
>
>  If the option '--all' or '-a' is given, then all available commands are
>  printed on the standard output.
>  
> -If a Git subcommand is named, a manual page for that subcommand is brought
> -up. The 'man' program is used by default for this purpose, but this
> -can be overridden by other options or configuration variables.
> +If the option '--guide' or '-g' is given then, a list of the useful
> +Git guides is also printed on the standard output.

s/given then,/given, then/ or just s/ then// make it easier to
follow?  I personally would vote for doing s/given, then/given, /
for the previous paragraph on "--all" as well.

> -Note that `git --help ...` is identical to `git help ...` because the
> +If a Git subcommand, or a Git guide, is given, a manual page for that

"If the name of a command or a guide is given" without "Git/git"
would be much easier to read, especially when the first paragraph
talks about "COMMAND or GUIDE".  I also think s/command/subcommand/
in the synopsis and in the first paragraph may be good for consistency
with this part.

> +subcommand is brought up. The 'man' program is used by default for this
> +purpose, but this can be overridden by other options or configuration
> +variables.
> +
> +Note that 'git --help ...' is identical to 'git help ...' because the
>  former is internally converted into the latter.
>  
> +To display the linkgit:git[1] man page use 'git help git'.

s/man page use/man page, use/;

> +
> +This page can be displayed with 'git help help' or 'git help --help'
> +
>  OPTIONS
>  -------
>  -a::
>  --all::
>  	Prints all the available commands on the standard output. This
> -	option supersedes any other option.
> +	option overides any given command or guide name.
> +
> +-g::
> +--guides::
> +	Prints a list of useful guides on the standard output. This
> +	option overides any given command or guide name.

Thanks. Overall this round looks a lot more manageable than the
previous one.
