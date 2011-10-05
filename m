From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Wed, 05 Oct 2011 10:08:07 +0200
Message-ID: <vpqd3ebn9nc.fsf@bauges.imag.fr>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 10:08:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBMWb-0004TS-Er
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 10:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009Ab1JEIIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 04:08:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54518 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757979Ab1JEIIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 04:08:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p9585jSa000949
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Oct 2011 10:05:45 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RBMWO-0001kZ-0H; Wed, 05 Oct 2011 10:08:08 +0200
In-Reply-To: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 5 Oct
 2011 18:18:05 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 05 Oct 2011 10:05:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9585jSa000949
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318406746.85152@zq5DaCa0jalUCioIK+NXSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182835>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This series adds --exclude that uses .gitignore mechanism remove
> commits whose changes that are _entirely_ excluded.

I'd see this --exclude as the opposite of specifying files, i.e. in a
repository containing directories A, B and C,

git log --exclude=3DB

would be the same as

git log A C

If I understand correctly, it's not the case with your implementation
because

> Because it uses .gitignore mechanism, beware that these patterns do
> not behave exactly like pathspecs

and because "git log --stat A C" (or --patch) will show the diff only
for A and C for commits touching all directories.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
