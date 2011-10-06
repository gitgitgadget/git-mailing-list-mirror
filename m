From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git Bug report
Date: Thu, 06 Oct 2011 18:26:12 +0200
Message-ID: <vpq1uuq13yz.fsf@bauges.imag.fr>
References: <1317763443.17036.15.camel@skyplex> <20111005072235.GA12600@kolya>
	<7vlisz8jur.fsf@alter.siamese.dyndns.org>
	<20111006003318.GA9015@goldbirke>
	<7vobxv3q49.fsf@alter.siamese.dyndns.org>
	<20111006010940.GR2208@goldbirke>
	<CABURp0qCsKG2oOxLw4BfU8UM=9V+pigd69ZK=TZVwetBPqjuiA@mail.gmail.com>
	<7vy5wy145q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Hord <phil.hord@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:26:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqmK-0007Ny-62
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144Ab1JFQ0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:26:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46735 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935867Ab1JFQ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:26:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p96GNaBd023444
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Oct 2011 18:23:36 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RBqlx-0003cV-1J; Thu, 06 Oct 2011 18:26:13 +0200
In-Reply-To: <7vy5wy145q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Oct 2011 09:22:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Oct 2011 18:23:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p96GNaBd023444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318523017.51657@tqttE2BT2WM10ahJNtHQkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182970>

Junio C Hamano <gitster@pobox.com> writes:

>  If we cannot tell if it is or is not
> a GIT_DIR, we should error out---the reason we cannot tell most likely is
> because we cannot read it, and such a file, if it is not a GIT_DIR, cannot
> be tracked in the real GIT_DIR at a higher level, and if it is a GIT_DIR,
> we cannot use it to record updates or inspect existing history.

Plus, the user may have removed the permission on the .git directory by
mistake, and it would be very surprising behavior if git ran without
complaining using a higher level GIT_DIR (i.e. a more or less arbitrary
repo as far as the user is concerned ...)

> How's that sound as a guideline?

Sounds reasonable, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
