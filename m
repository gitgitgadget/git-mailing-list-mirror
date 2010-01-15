From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add push --set-upstream
Date: Fri, 15 Jan 2010 18:03:24 +0100
Message-ID: <vpqy6jzuwpv.fsf@bauges.imag.fr>
References: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:03:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVpaE-0001R6-PL
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 18:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207Ab0AORDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 12:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754993Ab0AORDe
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 12:03:34 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48762 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481Ab0AORDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 12:03:33 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0FH2vc8002781
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 15 Jan 2010 18:02:57 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NVpa0-0003YP-BF; Fri, 15 Jan 2010 18:03:24 +0100
In-Reply-To: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi> (Ilari Liusvaara's message of "Fri\, 15 Jan 2010 18\:36\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 15 Jan 2010 18:02:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0FH2vc8002781
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264179778.91393@wtZdfxC5I8yD3UMh0i5CTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137083>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> +
> +-u::
> +--set-upstream::
> +	For every branch that is up to date or successfully pushed, add
> +	upstream (tracking) reference for argument-less git pull.

Not just argument-less git pull. git status is also impacted for
example. Actually, we already have documentation for it in git-branch
(--track option), and git-config (branch.<name>.merge configuration
variable), so you should add a pointer to one of them.

How about

--set-upstream::
	For every branch that is up to date or successfully pushed, add
	upstream (tracking) reference, used by argument-less
	linkgit:git-pull[1] and other commands. For more information,
	see 'branch.<name>.merge' in linkgit:git-config[1].

?

> +		OPT_BIT('u', "set-upstream", &flags, "Set upstream for git pull", TRANSPORT_PUSH_SET_UPSTREAM),

I'd be in favor of --track for the option name. Not that it's the best
name ever, but this is really doing the same job as branch --track and
checkout --track, so it should have the same name.

Or the --track option of branch and checkout should be renamed as
--set-upstream, but that seems a lot of trouble for little benefit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
