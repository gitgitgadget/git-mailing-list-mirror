From: Kelly Dean <kellydeanch@yahoo.com>
Subject: Does content provenance matter?
Date: Sat, 5 May 2012 13:49:16 -0700 (PDT)
Message-ID: <1336250956.54413.YahooMailClassic@web121505.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 22:56:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQm1q-0006wn-N9
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 22:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982Ab2EEUzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 16:55:55 -0400
Received: from nm14-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.38]:45740 "HELO
	nm14-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750961Ab2EEUzy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 16:55:54 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 May 2012 16:55:54 EDT
Received: from [98.138.90.56] by nm14.bullet.mail.ne1.yahoo.com with NNFMP; 05 May 2012 20:49:16 -0000
Received: from [98.138.89.160] by tm9.bullet.mail.ne1.yahoo.com with NNFMP; 05 May 2012 20:49:16 -0000
Received: from [127.0.0.1] by omp1016.mail.ne1.yahoo.com with NNFMP; 05 May 2012 20:49:16 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 957708.59706.bm@omp1016.mail.ne1.yahoo.com
Received: (qmail 58750 invoked by uid 60001); 5 May 2012 20:49:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1336250956; bh=z/1CaXW5PE2KnHrqRpKGckpnT+yPg3AoNo5NtbazEDI=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type; b=Jv4a6MxdkKD1hLkjzSjsyt7JUyJMIlVSgViTMYvirMuGGrr5wsUjUd/jMmwJUJchfuNdxIcWEZ/z9RRaBX3ZJ82RjlBBurcdJ5PPFCVzeTz1XuoRi0yFDFJizW/dFMQL3erVJY6mbUIYsL7hNMHmAKKIF7+o4ujlvP0UnKcoqrE=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type;
  b=dnqt9tUOR/xxMz0fsL25OQM8BwesbBH2QcPj2keE17BCB4iqzRJcaM70/kwi0qVehX38U2QI1kEzjX/bopWsreRtkOffDNuoau1BwtQqIcrcRuBP+ZDMLq1gYbJKofJsQwiI1icE2dNnNHVpmobrASsD1emlDzGhPfARZdEdrmE=;
X-YMail-OSG: RhkFcIoVM1mZ5nlRHyoG3yevJ2yRojDIIlZdi4fl8I9Tg4G
 KmdVGS54QUEvC5wun6dtZdeNsdXMPWSuBR5IAk.bcAWyimGes2wHRsw17jgY
 TJYngp4jtmugPxPHHMCrw6_mlGgAdbLwIA6KwNg6KL9OF6BKjJVMTeV17WAu
 Awnkhs8HesbjkcQBGXcpm1pj87ig23eD8D0yD7WUab1Ux4Mh_FJCVAEyEbjN
 me.G43wotvK2NM.VsmWxDMTd4uiBacm2Xh1l6AV_EKh5YRo2JFKITL5N27F7
 3.X2vm8VfINFQtbqpaF0LAp60LVTOFW.sxnnuRQ7ouUAf7C_s3xX1X39wrpU
 2GmPPaRG4Smi4X_LSPEwA0FA3ksFyxjGMrUMaEpRvMtTnkCODgV4KFgwigia
 j4vqsvA--
Received: from [109.163.233.205] by web121505.mail.ne1.yahoo.com via HTTP; Sat, 05 May 2012 13:49:16 PDT
X-Mailer: YahooMailClassic/15.0.6 YahooMailWebService/0.8.117.340979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197136>

Suppose you make dirs B and C, copy file X into B and C, insert "foo" somewhere into B/X and the same place into C/X, and commit. Now, you copy "foo" from B/X into the same place in the original X, and commit again. Git doesn't record the information about whether "foo" was copied from B or C, and this is intentional, on the theory that just content, not provenance, is what matters.
Suppose instead, you branch master to new branches B and C, insert "foo" into B/X, commit, insert "foo" into C/X, and commit. Now, you merge B back into master. Git records that master contains "foo" because B contained it rather than because C contained it, on the theory that not only content, but also provenance, matters.
Does provenance actually matter, or not? The reason git doesn't record it in the first case isn't simply that your editor didn't store that information (and the editor didn't store it because it isn't customary to store it, and there's no standard way to store it); even if the editor were to store the information (e.g. as metadata for X; details not relevant) and a patch to git were submitted for it to record this metadata, the git maintainers would presumably reject this patch, on the basis that it violates git's design specification which says that provenance doesn't matter. For the same reason, git intentionally doesn't distinguish the cases of renaming a file or directory vs. deleting it and creating a new one with the same content, as has already been thoroughly debated.
The basic question is, if provenance doesn't matter, then why does a git commit record its parent(s)? Why not omit this information, and figure it out at search time (by looking at all commits with older timestamps), the same as you're supposed to figure out renames at search time and figure out the movement of lines within/among files at search time (by looking at all files in the parent commit(s))? (If speed is an issue, then use an index, but this doesn't require putting such derivative information in the commit record.)
