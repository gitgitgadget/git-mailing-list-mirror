From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Mon, 12 Oct 2009 14:25:08 +0200
Message-ID: <4AD32024.6020005@drmicha.warpmail.net>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com> <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 14:27:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxJzG-0006Hg-EB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 14:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbZJLM0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 08:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbZJLM0T
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 08:26:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38292 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753943AbZJLM0S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 08:26:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B084A398B;
	Mon, 12 Oct 2009 08:25:17 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 12 Oct 2009 08:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VY10M/Eo5zR1gT9BMVQ8W0JVyag=; b=kZq9N08Q7AjQ2rmv8hTKUa5T+aJifzZ8cVgBoZuW3VovRrX5WjqlKvGH+oE9gN83sBlOR9e1lgnJqUpyYVnVd3bHeBfmDTAFDsIr359zu+StRlg2GZWgn56fU4B2VR6VGfSaoN+FWP7xuqGTDpWA1rfr1JINKJWt03NPm+BiyPU=
X-Sasl-enc: EaYd98g4L4n+IDr8V+Zq2bVLDiBof5sQ8ipjnq0eyTZ5 1255350316
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1334921727;
	Mon, 12 Oct 2009 08:25:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091012 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130006>

Felipe Contreras venit, vidit, dixit 11.10.2009 22:43:
> So that users get to know how to configure git from the get-to with good
> practical example (color.ui = auto) that most people would probably like
> anyway.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/user-manual.txt |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 67ebffa..ff2563a 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -40,6 +40,33 @@ without any explanation.
>  Finally, see <<todo>> for ways that you can help make this manual more
>  complete.
>  
> +[[getting-started]]
> +Getting started
> +=============
> +
> +Git's configuration is distributed among different locations--this manual will
> +only to deal with 'global' (for the user) and 'repository' variables, where
> +'repository' variables take precedence over 'global' ones.

Well, you do talk about "system" below, and that's about it. Also, the
configuration is not really distributed among different locations. Most
newbies interested in a *D*VCS will misunderstand this (as git having
distributed configuration).

Alternative:

Git's default configuration can be changed on a system wide, global (per
user) and local (per repository) level, in the order of increasing
precedence.

> +
> +You would probably want to start setting up something useful:
> +------------------------------------------------
> +$ git config --global color.ui auto
> +------------------------------------------------
> +
> +This will make prettier the output of certain commands such as `git diff`, but
> +that's not important; what is important here is that `color.ui` has been
> +stored in the 'global' configuration.

This will make certain commands such as `git diff` use colors in the
output. What is important here is that the value `auto` for the option
`color.ui` has been stored in the 'global' configuration. Use `--system`
for the system wide configuration; specifying neither `--system` nor
`--global` makes `git config` access the local configuration.

> +
> +View and manually modify the configuration by opening `~/.gitconfig`:

View and manually modify the global configuration by opening
`~/.gitconfig` in your editor or using `git config --global --edit`:

> +------------------------------------------------
> +[color]
> +        ui = auto
> +------------------------------------------------
> +
> +Other locations are `/etc/gitconfig` (system), and `.git/config` (repository).

I don't even think we should talk about locations here, "git config -e"
should be the first user's way to do it.

> +
> +More git configurations will be covered in the rest of the manual, if you want
> +to learn more look at linkgit:git-config[1] for details.

"Configurations" is ambiguous, it can be easily (mis)understood as
"types of configuration" (global, local etc.). Also, the above doesn't
really cover even one option. How about:

This manual covers many configuration options (such as `color.ui.`). For
more details on the `git config` command as well as all configuration
options see linkgit:git-config[1].

>  [[repositories-and-branches]]
>  Repositories and Branches

Cheers,
Michael
