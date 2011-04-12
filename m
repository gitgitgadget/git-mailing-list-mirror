From: Kent Leonard <kleonard@accurev.com>
Subject: Possible bug with multiple mv's and diff output
Date: Tue, 12 Apr 2011 13:58:49 -0400
Message-ID: <BANLkTin2FpQQ1qEZ41VArsRYZre9=U6SKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 19:59:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9hs3-0001xv-M6
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 19:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab1DLR7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 13:59:18 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41141 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755340Ab1DLR7S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 13:59:18 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]) (using TLSv1) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTaSS2XfUeJX0F5sqiZxZX/Vj45CSG+PY@postini.com; Tue, 12 Apr 2011 10:59:17 PDT
Received: by mail-iy0-f170.google.com with SMTP id 12so13179918iyb.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 10:58:49 -0700 (PDT)
Received: by 10.43.61.197 with SMTP id wx5mr9784069icb.286.1302631129037; Tue,
 12 Apr 2011 10:58:49 -0700 (PDT)
Received: by 10.231.207.81 with HTTP; Tue, 12 Apr 2011 10:58:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171406>

Hi all,

When I do this in repo with files a and b:
  git mv b c
  git mv a b
  git commit -m shuffle
  git diff --summary master^ master

I get output:
  delete mode 100644 a
  create mode 100644 c
Which does not indicate that the contents of b changed.

  git diff --summary --find-copies --find-renames master^ master
gives output
  delete mode 100644 a
  copy b => c (100%)
which also doesn't show that b changed.

"git diff --raw" shows more complete information.

I am misunderstanding what should happen, or is this incorrect?

Thanks,
Kent Leonard
