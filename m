From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email.perl: expand filename of aliasesfile
Date: Wed, 28 Sep 2011 15:42:01 +0200
Message-ID: <vpqwrcspyvq.fsf@bauges.imag.fr>
References: <20110928131307.GB12586@laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 15:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uOs-0006As-4p
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 15:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab1I1NmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 09:42:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46740 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab1I1NmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 09:42:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8SDdmUD028783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2011 15:39:49 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8uOf-0000Wk-Ez; Wed, 28 Sep 2011 15:42:01 +0200
In-Reply-To: <20110928131307.GB12586@laptop> (Cord Seele's message of "Wed, 28
	Sep 2011 15:13:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Sep 2011 15:39:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8SDdmUD028783
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317821991.32694@NJOgcWvn6gdQkikjnYhVnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182312>

Cord Seele <cowose@googlemail.com> writes:

> -		open my $fh, '<', $file or die "opening $file: $!\n";
> +		open my $fh, '<', glob($file) or die "opening $file: $!\n";

That'd be cleaner to use

git config --path sendemail.aliasesfile

to let Git do the right expansion, in a way consistant with other places
of Git.

In practice, that would imply adding %config_path_settings like the
existing %config_bool_settings, and add config_path to Git.pm (again,
similarly to config_bool).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
