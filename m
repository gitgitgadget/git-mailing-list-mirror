From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Status of dumb http transport?
Date: Sun, 30 Jan 2011 08:07:52 -0700
Message-ID: <AANLkTik99NNjNwLbj3-xEvVqiYUENiaREYAeJUC0bwVY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 30 16:08:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjYt3-0001xE-PD
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 16:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986Ab1A3PIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 10:08:16 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62801 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab1A3PIP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 10:08:15 -0500
Received: by bwz15 with SMTP id 15so4572050bwz.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=x2R77ysYCN0mFWgdFTq7H9PIcwZgs4eK+r9xmfSW754=;
        b=LpHYAdiYzznbxakuQqa2gYbyXS99zOt75RsRMggR9jabq6/pvYZg715rMu9tsmwVKX
         FMJwXnhVWob4gIVmDsthdSFshn1xf5je74qGJ85tpSchGhS0bD/x6OoUgd8Dmrgkix8V
         S15yS2KeGwXpOyp7F5dJwdb8By1MG4Qpdlj3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=I1/xyOmTGEhC9eWguO1Cdwsi4DCxm6PwKioPgGBxtqHnNs/oRS9I5GluoQzI0+GtAA
         AQ5x6Ig8Xnso3+QXKpKpETDGrPvT3BIYkhuxhtEBF+cy78OAOvFA2aD1mTlZqSHdhgXg
         hNOn5tn+61w97WJFnBUY76KjBS3ElEp0IX288=
Received: by 10.204.103.132 with SMTP id k4mr4413935bko.28.1296400093076; Sun,
 30 Jan 2011 07:08:13 -0800 (PST)
Received: by 10.204.101.69 with HTTP; Sun, 30 Jan 2011 07:07:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165685>

Hi List!

What is the state of dumb http transport today, for fetching updates?
Is the client code smart enough to fetch indexes and use range
requests? If so, how does that fare for latency?

Background: I am looking at whether yum repositories' data (currently
in sqlite & xml) could benefit from being a git (or very gittish)
database -- with a bit of re-organizing to make it git-efficient of
course.

Not the data that would benefit, but rather, users pulling updates
from fast-moving repos (updates, updates-testing, rawhide...).

One of the constraints is that this has to be http, and work well
across a universe of mirrors (that won't install or configure
software) and the good bad and ugly world of http proxies. Yum can be
taught to use the git proto, but that won't gain widespread use
quickly -- http is and will be the mainstay for a long time.



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
