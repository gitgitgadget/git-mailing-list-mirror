From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Trivial fix: Display a more friendly message with git-shell.
Date: Mon, 21 Sep 2009 08:17:26 +0200
Message-ID: <4AB71A76.5010509@viscovery.net>
References: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 08:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpcDX-0001uK-MU
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 08:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZIUGR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 02:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbZIUGR0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 02:17:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14475 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbZIUGRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 02:17:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MpcDG-00085F-UO; Mon, 21 Sep 2009 08:17:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B76FF6D9; Mon, 21 Sep 2009 08:17:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128864>

Thiago Farina schrieb:
> +static const char shell_usage[] = "git shell -c <command> <argument>";
> +
>  static int do_generic_cmd(const char *me, char *arg)
>  {
>  	const char *my_argv[4];
> @@ -74,7 +76,7 @@ int main(int argc, char **argv)
>  	 * where "cmd" is a very limited subset of git commands.
>  	 */
>  	else if (argc != 3 || strcmp(argv[1], "-c"))
> -		die("What do you think I am? A shell?");
> +		usage(shell_usage);

I don't think this is an improvement.

git-shell has a very limited use: It is to be used as the login-shell of
accounts where the admin will allow ssh access, but only to git repositories.

Every other use of git-shell is an error, and the current error message
says exactly that, although in a very 31337 way (and, BTW, /me likes it :-)

If an naive user runs git-shell from the command line, then your new
message will not be helpful because git-shell will accept only a very
restricted set of commands.

-- Hannes
