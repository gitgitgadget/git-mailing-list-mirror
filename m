From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] rebase: move cleanup code to exit_rebase()
Date: Wed, 17 Feb 2016 15:03:51 +0100
Message-ID: <vpqk2m3juwo.fsf@anie.imag.fr>
References: <vpqio1nsk0q.fsf@anie.imag.fr>
	<1455716201-29784-1-git-send-email-pclouds@gmail.com>
	<1455716201-29784-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sbeller@google.com, peff@peff.net,
	christian.couder@gmail.com, Johannes.Schindelin@gmx.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 15:04:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW2i9-000607-BO
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 15:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423190AbcBQOEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 09:04:05 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35975 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423147AbcBQOED (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 09:04:03 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1HE3oZb010524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 17 Feb 2016 15:03:50 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1HE3pdQ029111;
	Wed, 17 Feb 2016 15:03:51 +0100
In-Reply-To: <1455716201-29784-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 17
 Feb 2016 20:36:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Feb 2016 15:03:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1HE3oZb010524
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456322635.59541@s5HCIP7Nqft3LGQU7RQCYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286503>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

This patch could use a little bit more verbose commit message IMHO. At
this point it's not completely clear why you need to move this code to
git--rebase-lib.sh.

My understanding is that you want to have this code in the lib.h file t=
o
allow the toplevel to "exec" the helpers which does not allow the
toplevel to do the cleanup afterwards. Hence you need exit_rebase in th=
e
lib to call it from each helper.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
