From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Possibility to read both from ~/.gitconfig and from
 $XDG_CONFIG_HOME/git/config
Date: Wed, 30 May 2012 14:54:46 -0700
Message-ID: <7vr4u1xrkp.fsf@alter.siamese.dyndns.org>
References: <1338400509-26087-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338412775-22840-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble.inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed May 30 23:54:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqqz-0005O3-Pc
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225Ab2E3Vyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 17:54:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757055Ab2E3Vyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:54:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FAE384C9;
	Wed, 30 May 2012 17:54:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lBsry1OkVXRPFUSSyv1AnTxldcw=; b=POMV+R
	7ouDa01Mm+GBe/oXITmT92aBqrgbquy++1U9j3fUwEPzaRw0DHQ77gt0VX8b+2So
	CBi/AZ8Kp2zu6F1lAUiv0CbaStq3Adgduz1dQNFKUbNd3SfcL66ztazukWUQBacX
	Y2HAf4RzmrPJjwaqpf7Jhw99zqoabjF/x3c7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p8nbGR+zFUwAO+Qg+52z8Se/JetSA2dH
	152kX/Smrd+QjT6+bXYrOUkRJuB81Wn5jsBuodJT4hwB65Op+vFXeUmcJXxBvuVg
	1kvcEXUeN8aioJlktlVdMuwLF/f3mnSFqeJbvBRyPBrz5jC17C7ASVK4P3iq5pey
	16obAKh5gNs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45CD084C8;
	Wed, 30 May 2012 17:54:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1F1284C7; Wed, 30 May 2012
 17:54:47 -0400 (EDT)
In-Reply-To: <1338412775-22840-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 (Huynh Khoi Nguyen NGUYEN's message of "Wed, 30 May 2012 23:19:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12F00E46-AAA2-11E1-8695-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198841>

Huynh Khoi Nguyen NGUYEN  <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
writes:

> From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
>
> Git will read both in $XDG_CONFIG_HOME/git/config and in ~/.gitconfig in this order:
> .git/config > ~/.gitconfig > $XDG_CONFIG_HOME/git/config > /etc/gitconfig
> If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/config will be used.

Is it just me who finds the above three lines extremely unreadable?

Also can you give this patch a bit more sensible title?
"Possibility to" does not tell us much---anything is possible if you
change code after all.

I see the patch does not touch the writing codepath, which is
probably a good thing, but the log message should explicitly state
that.

> @@ -194,7 +194,7 @@ See also <<FILES>>.
>  FILES
>  -----
>  
> -If not set explicitly with '--file', there are three files where
> +If not set explicitly with '--file', there are four files where
>  'git config' will search for configuration options:
>  
>  $GIT_DIR/config::
> @@ -204,6 +204,9 @@ $GIT_DIR/config::
>  	User-specific configuration file. Also called "global"
>  	configuration file.
>  
> +$XDG_CONFIG_HOME/git/config::
> +	Second user-specific configuration file. ~/.gitconfig has priority.
> +

I am not sure in what way $HOME/.gitconfig has "priority".

Your proposed log message says that You read from $HOME/.gitconfig
and then from $XDG_CONFIG_HOME/git/config, which means that any
single-valued variable set in $HOME/.gitconfig will be overwritten
by whatever is in $XDG_CONFIG_HOME/git/config, no?  That sounds like
you are giving priority to the latter to me.

And for multi-valued variables, settings from both files are read,
so there isn't much inherent priority between the two, except for
variables for which the definition order matters, of course.

If you read only from $HOME/.gitconfig if exists, and read from
$XDG_CONFIG_HOME/git/config only when $HOME/.gitconfig does not,
then you are giving $HOME/.gitconfig a priority, but that is not
what the patch is doing as far as I can tell.

> diff --git a/builtin/config.c b/builtin/config.c
> index 33c8820..38dba4f 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -161,7 +161,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
>  static int get_value(const char *key_, const char *regex_)
>  {
>  	int ret = -1;
> -	char *global = NULL, *repo_config = NULL;
> +	char *gitconfig_global = NULL, *xdg_global = NULL, *repo_config = NULL;
>  	const char *system_wide = NULL, *local;
>  	struct config_include_data inc = CONFIG_INCLUDE_INIT;
>  	config_fn_t fn;
> @@ -171,8 +171,15 @@ static int get_value(const char *key_, const char *regex_)
>  	if (!local) {
>  		const char *home = getenv("HOME");
>  		local = repo_config = git_pathdup("config");
> -		if (home)
> -			global = xstrdup(mkpath("%s/.gitconfig", home));
> +		if (home) {
> +			const char *xdg_config_home = getenv("XDG_CONFIG_HOME");
> +			if (xdg_config_home)

This is logically wrong; even when you fail to read $HOME, you may
be able to read $XDG_CONFIG_HOME, no?  It shouldn't be nested inside
"if (home)" at all, methinks.

It would be more like

	global = xdg_global = NULL;
        if (HOME exists?)
        	global = $HOME/.gitconfig
	if (XDG_CONFIG_HOME exists?)
        	xdg_global = $XDG_CONFIG_HOME/git/config
	else if (HOME exists?)
        	xdg_global = $HOME/.config/git/config

no?

> @@ -381,7 +393,25 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  	if (use_global_config) {
>  		char *home = getenv("HOME");
>  		if (home) {
> -			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
> +			char *user_config;
> +			const char *gitconfig_path = mkpath("%s/.gitconfig", home);
> +			const char *xdg_config_path = NULL;
> +			const char *xdg_config_home = NULL;
> +
> +			xdg_config_home = getenv("XDG_CONFIG_HOME");
> +			if (xdg_config_home)
> +				xdg_config_path = mkpath("%s/git/config", xdg_config_home);
> +			else
> +				xdg_config_path = mkpath("%s/.config/git/config", home);
> +
> +			if (access(gitconfig_path, R_OK) && !access(xdg_config_path, R_OK) &&
> +			    (actions == ACTION_LIST ||
> +			     actions == ACTION_GET_COLOR ||
> +			     actions == ACTION_GET_COLORBOOL))
> +				user_config = xstrdup(xdg_config_path);
> +			else
> +				user_config = xstrdup(gitconfig_path);
> +
>  			given_config_file = user_config;
>  		} else {
>  			die("$HOME not set");

Exactly the same comment applies here.

You seem to always write to $HOME/.gitconfig, so missing $HOME may
be an error if the action is to store, but if you are reading and if
$XDG_CONFIG_HOME is set, you do not have to have $HOME set, no?
Even when there is $HOME, if there is no $HOME/.gitconfig file, you
wouldn't want to give an error, so missing $HOME environment should
be treated pretty much the same way as missing $HOME/.gitconfig file
for the purpose of reading, no?

> diff --git a/config.c b/config.c
> index 71ef171..53557dc 100644
> --- a/config.c
> +++ b/config.c
> @@ -939,10 +939,23 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  
>  	home = getenv("HOME");
>  	if (home) {
> -		char buf[PATH_MAX];
> -		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
> -		if (!access(user_config, R_OK)) {
> -			ret += git_config_from_file(fn, user_config, data);
> +		const char *gitconfig_path = xstrdup(mkpath("%s/.gitconfig", home));
> +		const char *xdg_config_path = NULL;
> +		const char *xdg_config_home = NULL;
> +
> +		xdg_config_home = getenv("XDG_CONFIG_HOME");
> +		if (xdg_config_home)
> +			xdg_config_path = xstrdup(mkpath("%s/git/config", xdg_config_home));
> +		else
> +			xdg_config_path = xstrdup(mkpath("%s/.config/git/config", home));

Exactly the same comment applies here, too.

The original that read from $HOME/.gitconfig was simple enough so
having three copies of getenv("HOME") was perfectly fine, but as you
are introduce this much complexity to to decide which two files to
read from, the code added this patch needs to be refactored and
three copies of the same logic need to be consolidated, I would have
to say.
