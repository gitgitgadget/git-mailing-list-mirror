From: Jim Cromie <jim.cromie@gmail.com>
Subject: skipping commits via commit-msg contents
Date: Mon, 12 Jul 2010 12:21:20 -0600
Message-ID: <AANLkTikYcODU96J-cVYCIad1yrd5zGklVj2OV4UT2PxC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 12 20:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYNdD-0007fR-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab0GLSVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:21:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47627 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0GLSVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:21:24 -0400
Received: by ewy23 with SMTP id 23so903961ewy.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ekRY81IFre49BwGY5cUPBLRvgTbkixc3eheWiwAFrp8=;
        b=nZeD+S4b81oKwXVQtkeEEj2B0eTSbuIt0PJ6fiVzcrPemUCyJnyQQRKF/L1zcIcg86
         +LgiuCHn122Y+MSPbaqzP0atK1aN+3Z+oZ5grKmj3LgpDmVTF6oqloANJleHBZ9vPdWN
         GZfJvAbulby3E8W/FH4MIn4RrUmvxwwK9/IQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VmkLD4vcfkwSyScW1P5KzSkfh5UaLs1o1NYY3b28Nw7deH/gHv78QAZwdGxhTb8HQB
         zFvn5lrph/VoCYnIZmM9QPvbKySlr/24Yb6eqYw8HdlMZhdrmcPr6nn1fQUbJ266TOvw
         DrW96cbdXyKWtAkC9e1vUE79Y8lm5/wuYPPjo=
Received: by 10.213.22.18 with SMTP id l18mr559241ebb.85.1278958880771; Mon, 
	12 Jul 2010 11:21:20 -0700 (PDT)
Received: by 10.14.45.79 with HTTP; Mon, 12 Jul 2010 11:21:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150834>

sometimes its desirable to commit incomplete work separately,
for example a struct change thats intended to get compiler to report
where changes are needed.

if git bisect were to recognize  --skip-bisect  in the subject line
(or in commit-message somewhere, say top or bottom),
then bisection could proceed silently past such commits.

This would also allow rebasing a patchset to markup crappy commits
which need further work.

worth having ?
