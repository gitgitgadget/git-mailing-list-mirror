From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 03/19] completion: use __gitdir() in _git_log()
Date: Wed, 9 May 2012 21:01:00 +0200
Message-ID: <20120509190100.GB6958@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-4-git-send-email-szeder@ira.uka.de>
	<7vr4utryd2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 21:02:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSC9B-0006nS-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388Ab2EITB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 15:01:56 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:52450 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab2EITBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 15:01:55 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MK5c9-1STZAv0y4T-001DSa; Wed, 09 May 2012 21:01:00 +0200
Content-Disposition: inline
In-Reply-To: <7vr4utryd2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:FC3m18HAcn+a0OcoGPnS8UOpsEA/3Ifbetl2oCbIkDD
 O+eeFKw8i10f1ouNg+mZsKnm2Z985MUMTIxQ8v2ynG1L0Ibl57
 8GziIiCdJMOGrkJZHAjhTMJ+zfZkmVJ54w7Qup6sGjF2xxJtCt
 lhXtYqUIf2Ptm9ZNmM0cEfGxTjNwCmmM+qNyV3qEiie4vL0NV+
 Gbt/UUyRyBKN+J6oVXjzp0KTCQDhyzx2A0+7RiScvGcfhy/lKR
 GJU1AOYrYIJwKGivt6ih4j6Ff+MV71UOtHMM0ibRJcEiSLQkDU
 j2YoZukBykq2HeIRp7f+YkTUSWxjpsH1MA2NsUz8e73UTW77p7
 MsfgMTHXlTF2WTTq4kI8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197492>

On Wed, May 09, 2012 at 11:41:13AM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > The standard way to find out the path to the repository in the
> > completion script is the __gitdir() helper function, because that
> > handles the repository path given on the command line (i.e. git
> > --git-dir=3D/path/to/repo log --<TAB>).  However, there is one
> > exception: the completion function for 'git log' still uses 'git
> > rev-parse --git-dir' directly, and could offer (or not) the '--merg=
e'
> > option erroneously when the repository is specified on the command
> > line.
>=20
> Here `--merge` is the visible symptom, and the real issue you fixed i=
s
> that it used to be looking into a repository that is different from t=
he
> user is working with, right [*1*]?

Exactly; will add a sentence about it to be more explicit in the
reroll.

Note, however, that this doesn't influence refs completion, because
__git_refs() does use __gitdir(), so it will look into the right
repository.


G=E1bor
