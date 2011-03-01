From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Tue, 01 Mar 2011 15:53:13 +0100
Message-ID: <vpqipw2rixy.fsf@bauges.imag.fr>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
	<7vei6t4uwa.fsf@alter.siamese.dyndns.org>
	<AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
	<7vy6512rnb.fsf@alter.siamese.dyndns.org>
	<AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
	<7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?iso-8859-1?Q?G=E1b?= =?iso-8859-1?Q?or?= 
	<szeder@ira.uka.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:54:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuQxf-000347-8k
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 15:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab1CAOx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 09:53:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48308 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab1CAOx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 09:53:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p21ErCo5026939
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 15:53:12 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PuQwr-0000Hm-PE; Tue, 01 Mar 2011 15:53:13 +0100
In-Reply-To: <7vk4gkk5pd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 27 Feb 2011 22:56:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Mar 2011 15:53:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p21ErCo5026939
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299595996.57767@j6sAeANvw/oP1waHmIe0MQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168224>

Junio C Hamano <gitster@pobox.com> writes:

> I already do not like the possibility of potential double deprecation
> myself, one to flip the default and then possibly another to drop the
> support of the traditional behavour, but anything I've seen so far would
> hurt the end users more than that plan.

I think promoting "git add -u ." more than a configuration option would
reduce the pain.

As a user, if I get used to typing "git add -u ." instead of "git add -u", 
I get the current behavior regardless of the version of Git, without a
warning. Later, when all the machines I word on support the tree-wide
"git add -u" (either 1.7.x + some configuration or 1.8.y), I'll use it
as a new feature.

So, a warning like

  warning: the behavior of "git add -u" without pathspec will change in
  Git 1.8.0. To keep the current behavior, use this instead:
  
      git add -u .
  
  + explanations about the config options as already discussed here

would be fine.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
