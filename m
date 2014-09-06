From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 0/1] Use absolute paths of lockfiles
Date: Sat,  6 Sep 2014 12:31:28 +0200
Message-ID: <1409999489-25193-1-git-send-email-mhagger@alum.mit.edu>
References: <CACsJy8AJvt3bVj783eyHhiFaMD3Ys6pAsyT7S2TYi2a_ACKcRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 12:31:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQDHZ-0000WD-1l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 12:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbaIFKbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Sep 2014 06:31:45 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54630 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbaIFKbn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 06:31:43 -0400
X-AuditID: 1207440c-f79036d000005e77-01-540ae28f7b15
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B7.3C.24183.F82EA045; Sat,  6 Sep 2014 06:31:43 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s86AVdBT013096
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 06:31:40 -0400
X-Mailer: git-send-email 2.1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqNv/iCvE4O4qTouuK91MFg29V5gt
	nsy9y2xxe8V8ZovuKW8ZLXZPW8Bm0bbzCJMDu8ff9x+YPHbOusvu8fBVF7vHxUvKHo8nnmD1
	+LxJLoAtitsmKbGkLDgzPU/fLoE749n7j0wFczkqbv48y97AeISti5GTQ0LAROLI1rfMELaY
	xIV764HiXBxCApcZJXoP97FAOMeYJJa19bOCVLEJ6Eos6mlmArFFBNQkJrYdAitiFljEJLFk
	cRdQgoNDWMBc4t8eXZAaFgFViem7toPV8wq4SBy83Qq1TU5iw+7/jCC2kECAxLl9u5ghagQl
	Ts58wgIyhllAXWL9PCGQMLOAvETz1tnMExj5ZyGpmoVQNQtJ1QJG5lWMcok5pbm6uYmZOcWp
	ybrFyYl5ealFuoZ6uZkleqkppZsYIWHOs4Px2zqZQ4wCHIxKPLwFDlwhQqyJZcWVuYcYJTmY
	lER5VW4DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwdkwGyvGmJFZWpRblw6SkOViUxHlVl6j7
	CQmkJ5akZqemFqQWwWRlODiUJHjTHgI1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZk
	xIPiMb4YGJEgKR6gvR8egOwtLkjMBYpCtJ5i1OVY1/mtn0mIJS8/L1VKnLcTpEgApCijNA9u
	BSypvWIUB/pYmHcvSBUPMCHCTXoFtIQJaIl5OifIkpJEhJRUA2NoPlNd9f/obafa/blWHt7l
	a1TubZmhX6GqcnPNi2CrA7EfrPpSGYQtN9X8MNpZeVk7fHbbpGsHjv9NceI3OC5t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256584>

This patch applies on top of the patch series that I just sent [1]:

    Lockfile correctness and refactoring, v4

It has the same effect as Duy's [2]

    Keep .lock file paths absolute, v3

except that my patch series obviates the need for his patches 1/3 and
2/3. So only one patch remains, the equivalent of his patch 3/3,
simplified because lockfile::filename is now a strbuf.

So I've shamelessly labeled this "v4" of his patch series and I've
left Duy as the author, because his commit message (which I used
directly) has far more intellectual content than the code change. Duy,
if that's not OK with you, please let me know.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/256564
[2] http://thread.gmane.org/gmane.comp.version-control.git/253817/focus=
=3D254573

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  lockfile.c: store absolute path

 lockfile.c                    | 14 +++++++++++---
 t/t2107-update-index-basic.sh | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

--=20
2.1.0
