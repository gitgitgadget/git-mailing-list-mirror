From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 21:03:54 +0100
Message-ID: <vpqhamapal1.fsf@grenoble-inp.fr>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
	<vpq622s9jk1.fsf@grenoble-inp.fr>
	<7v1udfn0tm.fsf@alter.siamese.dyndns.org>
	<CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
	<7v622qhouc.fsf@alter.siamese.dyndns.org>
	<7v1udegy2o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:04:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxNbr-00038F-9X
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 21:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab3AUUE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 15:04:26 -0500
Received: from mx2.imag.fr ([129.88.30.17]:41294 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756137Ab3AUUEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 15:04:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0LK3qVZ019252
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 21:03:52 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TxNb1-00052G-5X; Mon, 21 Jan 2013 21:03:55 +0100
In-Reply-To: <7v1udegy2o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 21 Jan 2013 11:01:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 21 Jan 2013 21:03:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0LK3qVZ019252
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359403434.80173@AtIiXFu6qsYuFqbKSHNkVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214158>

Junio C Hamano <gitster@pobox.com> writes:

> But v1.5.2.5~1 (git-add -u paths... now works from subdirectory,
> 2007-08-16) changed the semantics to limit the operation to the
> working tree.

Not really. It fixed "git add -u path", not plain "git add -u". A quick
test checking out and compiling v1.5.2.5~1^ shows that "git add -u ."
from a subdirectory was adding everything from the root.

My interpretation is that v1.5.2.5~1 fixed an actual bug, without
thinking about what would happen when "git add -u" was called without
path, so the behavior is "what happens to be the most natural to
implement". Indeed, the behavior was actually documented only later, in
v1.5.4.3~3 (Feb 21 00:29:39 2008, Clarified the meaning of git-add -u in
the documentation), the previous doc said only "If no paths are
specified, all tracked files are updated.".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
