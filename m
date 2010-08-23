From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Mon, 23 Aug 2010 11:37:07 +0200
Message-ID: <vpqd3t9656k.fsf@bauges.imag.fr>
References: <4C6A1C5B.4030304@workspacewhiz.com>
	<7viq39avay.fsf@alter.siamese.dyndns.org>
	<20100818233900.GA27531@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 23 11:40:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnTWH-0004vL-R2
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 11:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab0HWJkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 05:40:40 -0400
Received: from imag.imag.fr ([129.88.30.1]:63026 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab0HWJkj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 05:40:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7N9b71T023637
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Aug 2010 11:37:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OnTSl-0005AI-LM; Mon, 23 Aug 2010 11:37:07 +0200
In-Reply-To: <20100818233900.GA27531@localhost> (Clemens Buchacher's message of "Thu\, 19 Aug 2010 01\:39\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 23 Aug 2010 11:37:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154214>

Clemens Buchacher <drizzd@aon.at> writes:

> By default, checkout and fast-forward merge will overwrite ignored
> files. Make this behavior configurable.

Just mentionning an alternative, or complementary approach:

Instead of overwritting completely a .gitignore-d file, Git could
rename it, and warn the user kindly. For example:

$ git merge
...
Warning: existing ignored file 'foo' renamed to 'foo~'

(in case foo~ already exists, it's possible to use numbered backups
just like "mv --backup=existing" does for example)


That could complement your patch if core.overwriteignored is a
multiple-choice option instead of a Boolean:

- "overwrite" => current behavior
- "refuse" => your proposal
- "rename" => my proposal

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
