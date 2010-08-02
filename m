From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5 v4] log: parse detached options like git log --grep foo
Date: Mon, 02 Aug 2010 20:55:23 +0200
Message-ID: <vpqtyncdeuc.fsf@bauges.imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
	<1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vvd7tlzfu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 20:57:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og0Ce-0007dv-FS
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab0HBS5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 14:57:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53922 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab0HBS5a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 14:57:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o72IrMch004181
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 20:53:22 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Og0AW-0001fC-3w; Mon, 02 Aug 2010 20:55:24 +0200
In-Reply-To: <7vvd7tlzfu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 02 Aug 2010 10\:03\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Aug 2010 20:53:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o72IrMch004181
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281380006.15589@3YqChif/eN/nUIbbqVFa4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152438>

Junio C Hamano <gitster@pobox.com> writes:

> The patch overall looks good, and this comments illustrates the issue
> rather well.  When the user wants to use "--longopt val" syntax, s/he
> needs to know that "--longopt" will always take a value.  Arguably
> majority of options that can take value will, but like "--stat X,Y" this
> leaves things inconsistent.  Without "--longopt value" patch there won't
> be such an inconsistency, but I think this patch series is lessor of two
> evils.

... especially when parse-option already does this:

git commit --message foo   => works
git gc --prune 'last week' => doesn't

Just like most GNU tools:

grep --regexp foo => works
grep --color auto => doesn't

> Don't you by the way regret the naming of the parsing function by now?
> There is nothing "diff" about it anymore.

Right. I'll rename them to "parse_long_opt".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
