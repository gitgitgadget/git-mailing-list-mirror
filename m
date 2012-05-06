From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 06 May 2012 12:26:48 +0200
Message-ID: <vpqehqxmwpj.fsf@bauges.imag.fr>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 12:27:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQygI-0006Tx-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 12:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2EFK1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 06:27:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57881 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab2EFK1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 06:27:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q46AJlMx025938
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2012 12:19:47 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SQyfx-00080s-9g; Sun, 06 May 2012 12:26:49 +0200
In-Reply-To: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 5 May 2012 15:04:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 May 2012 12:19:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q46AJlMx025938
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336904390.12738@Q2p/0letJnkBQAPDiu2X/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197163>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Proposal:
>
> Avoid the terms 'cache' and 'index' in favor of 'stage'.

I completely agree that something needs to be done.

But there are at least two points that were raised during the previous
discussions that need to be taken into account:

* Currenly, "index" and "staging area" are not exactly synonyms. When
  used with "git add" and "git commit" (without -a), the index is the
  staging area for the next commit. But when used by "git merge", the
  index is more a "merging area".

* There is currently a distinction in the meaning of --cached and
  --index. See the end of Documentation/gitcli.txt. I think it is good
  to have this distinction, but I agree that the wording of current
  option name is wrong (i.e. without having read gitcli.txt, I don't
  think anyone could have guessed this distinction). Perhaps something
  like --staged-only/--staged-too?

About the name, an alternative to "stage" was suggested earlier:
"precommit". If we were to rewrite Git from scratch, I'd argue in favor
of this one, which is really easy to understand, especially for
non-native (you really need to know what a "commit" is to use Git, and
then infering the meaning of precommit is easy). But we probably have
already a too long history of changing the name, so introducing yet
another one is perhaps counter-productive. I don't know.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
