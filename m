From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3 1/2] wt-status.*: better advices for git status added
Date: Mon, 28 May 2012 22:23:31 +0200
Message-ID: <vpqobp89hrw.fsf@bauges.imag.fr>
References: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon May 28 22:23:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ6Td-0006XI-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 22:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab2E1UXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 16:23:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54143 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057Ab2E1UXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 16:23:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4SKFEO6007335
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2012 22:15:14 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZ6TU-0007RD-P2; Mon, 28 May 2012 22:23:32 +0200
In-Reply-To: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Mon, 28 May 2012 19:36:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 May 2012 22:15:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4SKFEO6007335
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338840915.97414@+v06R8US3BmwZ3hYoKIpWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198720>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> These messages can be shortened by setting
> the new advice.* config key called advice.statushelp to false.

It may make sense to use the existing advice.statusHint here.

> +	else {
> +		if (!stat(git_path("rebase-apply"), &st)) {

"else { if" is usually spelt "else if", without an additional level of
indentation.

> +			status_printf_ln(s, c, _("You have unmerged paths: fix conflicts and then commit the result."));

I'd even say

You have unmerged paths; fix conflicts and run "git commit"

> +				status_printf_ln(s, c, _("One of the patches is empty or corrupted !"));

No space before !

> +				status_printf_ln(s, c, _("When you have resolved this problem run \"git am --resolved\"."));
> +				status_printf_ln(s, c, _("If you would prefer to skip this patch, instead run \"git am --skip\"."));
> +				status_printf_ln(s, c, _("To restore the original branch and stop patching run \"git am --abort\"."));

You have overly long lines. I already suggested splitting the function
into smaller functions, and the presence of long lines is usually an
indication that the splitting should be done.

Documentation/CodingGuidelines says:

,----
| For C programs:
| 
|  - We use tabs to indent, and interpret tabs as taking up to
|    8 spaces.
| 
|  - We try to keep to at most 80 characters per line.
`----

> +				status_printf_ln(s, c, _("You are currently rebasing%s"),
> +				advice_status_help
> +				? _(": fix conflicts and then run \"git rebase -- continue\".") : ".");

Weird indentation, it feels like 3 different statements.

> +	if(bisect_state) {

Space between if and (.

> +		if (advice_status_help)
> +		status_printf_ln(s, c, _("To get back to the original branch run \"git bisect reset\""));

Broken indentation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
