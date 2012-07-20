From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANNOUNCE] Sharness - Test library derived from Git
Date: Fri, 20 Jul 2012 13:45:26 +0200
Message-ID: <vpq7gtyr6zt.fsf@bauges.imag.fr>
References: <CAMFa-2hS-5CHQj79KMGwY7_qv6nGiK+9cKeDdihMVmSoxfsesQ@mail.gmail.com>
	<CACBZZX6QZACjkFPEsNgAkKgnkZHDsCOEAm=-9rs=PLiSfgsXBw@mail.gmail.com>
	<CAMFa-2gRWRKgj140i1q9iux=eC6nWxfdUPPhb42xAG1Gr7e4vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Mathias Lafeldt <mathias.lafeldt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 13:46:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsBej-0004hj-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 13:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab2GTLpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jul 2012 07:45:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37091 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab2GTLpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 07:45:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6KBheVc023647
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2012 13:43:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SsBeB-00051a-9D; Fri, 20 Jul 2012 13:45:27 +0200
In-Reply-To: <CAMFa-2gRWRKgj140i1q9iux=eC6nWxfdUPPhb42xAG1Gr7e4vA@mail.gmail.com>
	(Mathias Lafeldt's message of "Fri, 20 Jul 2012 12:18:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Jul 2012 13:43:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6KBheVc023647
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343389421.97541@UCHNqxD6aG9AVQljuETLAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201767>

Mathias Lafeldt <mathias.lafeldt@gmail.com> writes:

> On Tue, Jul 17, 2012 at 8:31 PM, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> Perhaps to avoid duplication we could move to this and keep
>> Git-specific function in some other file.
>
> That would be fantastic! From a technical point of view, it would mak=
e
> a lot of sense to join forces here.

Seems to be a reasonable goal, yes. The test harness in Git keeps
improving, and Sharness is likely to improve also, it would be a pity t=
o
have them diverge and not benefit from each other.

> How do you think would Sharness fit into the Git project? Is adding i=
t
> as an external dependency an option?

It would be nice if the code sharing did not result in extra pain for
users and testers, so "external dependency" in the sense "not included
in git.git and ask the user to install it" is IMHO a bad idea.
Increasing the effort needed to run the testsuite means more people wil=
l
give up before running it :-(.

OTOH, having it leave in a subdirectory (e.g. $git/t/Sharness/), and
synchronize with stg like subtree merge would be nice for the user. We
already have something similar for gitk and git-gui, except that the
synchronization is normally one way (subprojects merged into Git, but
merging back changes that were made in git.git in these subprojects is
more painful).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
