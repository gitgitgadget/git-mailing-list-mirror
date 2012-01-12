From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] diff --no-index: support more than one file pair
Date: Thu, 12 Jan 2012 19:26:27 +0100
Message-ID: <vpq8vlc93qk.fsf@bauges.imag.fr>
References: <1326359371-13528-1-git-send-email-pclouds@gmail.com>
	<vpq39bll1ua.fsf@bauges.imag.fr>
	<CACsJy8BvA_o1+xrOx4hYhmwNWpsRnh5+mftb471h3yFW2b6vhA@mail.gmail.com>
	<vpqmx9te08z.fsf@bauges.imag.fr>
	<CACsJy8B460CwtACV+o0wnwqi1On_oEavLfDAL8f=w6kyfktKcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:26:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPMB-0002Qp-Tp
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 19:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2ALS0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 13:26:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38103 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988Ab2ALS0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 13:26:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0CIOvNk017860
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Jan 2012 19:24:57 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RlPM3-0005xS-JO; Thu, 12 Jan 2012 19:26:27 +0100
In-Reply-To: <CACsJy8B460CwtACV+o0wnwqi1On_oEavLfDAL8f=w6kyfktKcQ@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Fri, 13 Jan 2012 00:40:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 12 Jan 2012 19:24:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0CIOvNk017860
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1326997499.39276@qC+l9iTsaW69JIMFVIy9XA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188466>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>> =A0- hell, i might even benefit from git copy/modify detection
>>
>> I don't see how, if you specify explicitely the pairs (old, new). Yo=
u
>> may have such benefit if you let the command-line express "here's a
>> bunch of old files, and a bunch of new ones", but not with your prop=
osed
>> syntax.
>
> That's what git gives to diff machinery: a set of file pairs, and the
> diff machinery has to figure out copy/modify pairs, shuffling them up
> if necessary. I simply cut of tree traversal part out and feed file
> pairs directly to diff machinery.

If you want to benefit from copy detection, you cannot hardcode the fac=
t
that you have as many source and destination files. And even to benefit
from rename detection, I find the user interface really weird. If I
provide files in pairs, I really don't expect Git to shuffle them like

git diff --no-index A1 B1 A2 B2
--- A1
+++ B2
=2E.
--- A2
+++ B1
=2E.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
