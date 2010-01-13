From: Jon Seymour <jon.seymour@gmail.com>
Subject: discussion: an option to fail git fetch if a pulled branch tip is not 
	a fast forward of the existing remote tip?
Date: Wed, 13 Jan 2010 22:54:44 +1100
Message-ID: <2cfc40321001130354w626ec0fat7abdfaff9771c29f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 12:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV1oJ-0005qK-GD
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 12:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab0AMLyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 06:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192Ab0AMLyq
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 06:54:46 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:33221 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab0AMLyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 06:54:46 -0500
Received: by pzk1 with SMTP id 1so7130382pzk.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 03:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=7i8rvGZV6AXELpAorjo5aHE41t/NYoEBV9RlKXMWGS8=;
        b=rufC/u8LHtbG1hJU2/j3EnaUe6JV40OoPBjbHkd4HV40ZTgeDervyAx6AHp24Oiq2e
         QRWSrFb24fBM7nayKJX+qC04rcLMb5ln5ldbYXDBfRjxN+p05dj+y+IVfAN0xFEu80Z3
         5ajqUX/X1OYTMyqa1VtteJD+vKBgTqluJUv7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=BoEd2nuTlKoPlzXCGjlc4MyKsTU4LVhLHQNKM0GF13kKsfPTcEL7IwLdHiWNnekLjk
         HrTyw55+tzDBkYEyDOKnMllAMarjcUFUsyIDgIgIx2IIiRTVNOda5bhHjH/b7cq3dSYG
         SH5ljrnxbiOCeinIu52JyKqAAkeGZX1p9OWu4=
Received: by 10.114.188.31 with SMTP id l31mr6065537waf.201.1263383684373; 
	Wed, 13 Jan 2010 03:54:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136811>

I spent a little while this afternoon debugging an issue where an
upstream publisher had backtracked and published a branch tip which
was not a descendant of a previously published (and fetched) branch
tip. The net result was that the backtracked changes were preserved in
the downstream branch once the 2nd tip was pulled.

Now clearly the upstream developer should not have backtracked. That
said, it would have been nice if I could have easily configured my
porcelain to detect the backtracking condition. An option on git fetch
that implemented something similar to the git push check would have
made this easy to achieve.

Has any consideration been given to such an option? Is there a
well-known alternative pattern for detecting this case?

jon.
