From: Ian Zimmerman <itz@buug.org>
Subject: fast-import: multiple processes possible?
Date: Sat, 27 Nov 2010 14:07:45 -0800
Message-ID: <8739qmzaha.fsf@matica.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 27 23:18:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMT5n-0007Mc-Dc
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 23:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab0K0WR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 17:17:57 -0500
Received: from disorder.primate.net ([198.144.194.12]:37319 "EHLO
	disorder.primate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab0K0WR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 17:17:56 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Nov 2010 17:17:56 EST
Received: from matica.localdomain (itz@localhost.localdomain [127.0.0.1])
	by disorder.primate.net (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oARM7jxX028437
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Sat, 27 Nov 2010 14:07:46 -0800
Received: from itz by matica.localdomain with local (Exim 4.72)
	(envelope-from <itz@matica.localdomain>)
	id 1PMSvp-0000u4-F0; Sat, 27 Nov 2010 14:07:45 -0800
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEU6JRqbZVHn5+bt7e3M
 l4Tj4+Pf39/dyMIUIzUDAAACSUlEQVQ4jVWUTY+bMBCGjVRtrlhrtddmKOkdlJ4haynntTLutWLX
 5lolaPn7fWeAbDrHeXjn25g655xiToGIQrtYTXUwCvL/gKgmBZzzQI+gAoAzx5yDKIg/NlCrQlNU
 1Y/SGPemgGgDCPVu1L5Jjg1wZrqY1Z4BQrOCyD83vylE0ZiDgMShuwPz8hAqHT795kmBKjJfHsCO
 Ai05mPnVFNaWa5ImhKWPxPwdfuf7hVy3UAB/C/hhFibZV0XkziqY53ny5YmasCpCiS+9PyvoTujQ
 RG0jGgWz2ATQkIA8xL25KwRUK8i8L6wpnPpn312rIwtIif8AmMKvYKhqXhShE2CcEl/SPRShWmlZ
 sky+aGRRWYFUa/vC99LNF8KdKEhow6Eqe8ZMXL8jbERDpah99xbDKmz3RC0LYCg24MvSds96DKpg
 jS0t2t7b6z0U9iQzX+brPX3mALB9uYJzg1Ftyfeotizc5Cfvrw+A97ogGePkb8vBaYP51aq5HggX
 eqRqBb26kcD5k5xusyp+Y1a2WAAiYYa8gAmzcqpxvm0AqgVMrsT30rikaORBKZgcSi0xQwEvAEGu
 JOcRwJqtvZsoFIxYjZfFyhgRqW1qouNgxnke4ZFXBi4vTULhGGaJhQEaHFBv9QVyoFqTHyYEk8Oy
 53YFhySAxjNuRi9OQWIBeOdxlNsQv9MfBlN1iJgu/iRygrLxXTsIYKqh4DTkd9Q2W9ftmhTaYwxt
 FPDrLY95nj96V36NOVSE30RG8sgh5hvIxdtbZK44DgD/AJtJBv5QdLdkAAAAAElFTkSuQmCC
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162328>


Hi, I have a user question, I hope that's ok.  Actually, the end goal is
development of a fast-import frontend.  The fast-import manpage says
that it is safe to run "any other" git operation concurrently with
fast-import.  It doesn't say if it is possible and safe to run another
copy of fast-import itself.

The reason I'd like to do this is speedup.  With sequential approach my
frontend can only load each core on my system about 50%.  If I could run
multiple imports concurrently I could make it close to 100%, especially
when feeding it blobs (which take most of the time).

Thanks for the advice.

-- 
Ian Zimmerman <itz@buug.org>
gpg public key: 1024D/C6FF61AD 
fingerprint: 66DC D68F 5C1B 4D71 2EE5  BD03 8A00 786C C6FF 61AD
Ham is for reading, not for eating.
