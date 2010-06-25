From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] git-rev-parse.txt: Document ":path" specifier
Date: Fri, 25 Jun 2010 17:25:53 +0200
Message-ID: <vpqvd97rv5q.fsf@bauges.imag.fr>
References: <7vvd98b1jh.fsf@alter.siamese.dyndns.org>
	<633f42d1967049780d66cf72552b22ae17bbbead.1277476258.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 25 17:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSAna-0001nw-6U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 17:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab0FYP0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 11:26:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47864 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab0FYP0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 11:26:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5PFHMIw008844
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Jun 2010 17:17:22 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OSAmv-0006T3-Im; Fri, 25 Jun 2010 17:25:53 +0200
In-Reply-To: <633f42d1967049780d66cf72552b22ae17bbbead.1277476258.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 25 Jun 2010 16\:32\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jun 2010 17:17:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5PFHMIw008844
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1278083846.78342@iHg0tDA5ISLN8w5Yetckgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149692>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The empty treeish in ":path" means "index". Document this.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-rev-parse.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 8db600f..f964de4 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -290,8 +290,9 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
>    followed by something else than '!' is reserved for now.
>  
>  * A suffix ':' followed by a path; this names the blob or tree
> -  at the given path in the tree-ish object named by the part
> -  before the colon.
> +  at the given path in the tree-ish object named by the ref
> +  before the colon. An empty ref before ':' denotes the content
> +  recorded in the index at the given path.

Actually, what you're adding is precisely what was already documented
right below:

>  * A colon, optionally followed by a stage number (0 to 3) and a
>    colon, followed by a path; this names a blob object in the
     index at the given path.  Missing stage number (and the colon
     that follows it) names a stage 0 entry. During a merge, stage
     1 is the common ancestor, stage 2 is the target branch's version
     (typically the current branch), and stage 3 is the version from
     the branch being merged.

Probably it's not obvious enough and your patch is worth it, but then
it would be less confusing if you added "(see next item)." at the end
of your sentence.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
