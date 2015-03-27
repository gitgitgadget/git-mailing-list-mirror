From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Change default branch name (server side) while cloning a repository
Date: Fri, 27 Mar 2015 17:40:51 +0100
Message-ID: <vpqmw2ytmuk.fsf@anie.imag.fr>
References: <1427459241861-7627964.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Garbageyard <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:41:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbXJs-0003Oa-EM
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 17:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbbC0QlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2015 12:41:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57961 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbbC0Qk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 12:40:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2RGeoZd022638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Mar 2015 17:40:50 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2RGeplQ017717;
	Fri, 27 Mar 2015 17:40:51 +0100
In-Reply-To: <1427459241861-7627964.post@n2.nabble.com> (Garbageyard's message
	of "Fri, 27 Mar 2015 05:27:21 -0700 (MST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 27 Mar 2015 17:40:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2RGeoZd022638
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1428079251.60478@AuD82pW8GYApD0Vdshz4gA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266377>

Garbageyard <varuag.chhabra@gmail.com> writes:

> If i now clone the repository on my local machine, then the default b=
ranch
> should be pointing to mainline and not master. However, the issue is =
that it
> still points to master. Am I /wrong/ in assuming that changing the en=
try in
> file HEAD for a given repository on Git server will change the defaul=
t
> branch while cloning? If I=E2=80=99m wrong, can anyone please tell me=
 how can I
> enforce this change on the /server/ side correctly?

IIRC, there's a known limitation of the Git protocol which does not
transmit symbolic ref over the network. Only the HEAD's sha1 is
transmitted and the client guesses which branch should be checked out
based on this. But it can guess incorrectly if several branches point t=
o
the same commit.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
