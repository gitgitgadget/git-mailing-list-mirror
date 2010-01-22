From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Fri, 22 Jan 2010 08:03:47 +0100
Message-ID: <vpq7hrapqng.fsf@bauges.imag.fr>
References: <718290.769818367-sendEmail@darysmbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "David Rydh" <dary@math.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Jan 22 08:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYDbV-0003e0-ST
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 08:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab0AVHGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 02:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729Ab0AVHGo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 02:06:44 -0500
Received: from imag.imag.fr ([129.88.30.1]:46351 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688Ab0AVHGo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 02:06:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o0M73ljI022338
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:03:47 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NYDYZ-0004Zo-FV; Fri, 22 Jan 2010 08:03:47 +0100
In-Reply-To: <718290.769818367-sendEmail@darysmbp> (David Rydh's message of "Thu\, 21 Jan 2010 12\:39\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 22 Jan 2010 08:03:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137743>

"David Rydh" <dary@math.berkeley.edu> writes:

>  		if (!is_absolute_path(given_config_file) && prefix)
> -			config_exclusive_filename = prefix_filename(prefix,
> +			config_exclusive_filename = xstrdup(prefix_filename(prefix,
>  								    strlen(prefix),
> -								    argv[2]);
> +									argv[2]));

Broken indentation on the last two lines.

Other than that, you use strdup without free-ing the result. Probably
not so serious, but it may be cleaner to actually call free, or to
explain why you don't (in commit message).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
