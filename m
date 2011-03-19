From: Ilyes Gouta <ilyes.gouta@gmail.com>
Subject: Question: How to rebase my changes on a new base (ref)?
Date: Sat, 19 Mar 2011 09:50:37 +0100
Message-ID: <AANLkTinnGw-u-snLwTUzry2PRmTUD7oDGjedJLhkJGoh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 09:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0rsV-0002dt-56
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 09:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab1CSIvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 04:51:00 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63290 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab1CSIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 04:50:58 -0400
Received: by vxi39 with SMTP id 39so4171026vxi.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=OFmNeXkqZ65PkxEndmPsswwoZFidTdVlxVBqDpymo1E=;
        b=uai4vC2gerLEA9C5xrUD5EA2HBynDvA18uxbQW2v4xlZuVgX7aChK1DLpvLXB6Bt6z
         LF3KqEsQ94LLNFmGipdL637gkBHbmo8UP0VGVWn9gpXVeMk1Y5yCD5G39tq54aac7HsD
         Aun+A7hFtp62tP90+carG8FYyAaKSiy9/gphA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=EtQM6bJezQ4O34QHSolGIWcmYTQ3ZS4OU2TlyBU6pOsdPYCru0xRorCwYC6mvVlXix
         pDQRTMAgVo5f3R1w9rcszVLBeMr6H7ehd+Z67PkOLjC47rjN/EHtk+Z64msvsmGoSwcf
         uS1MHaEPuxgPNiw1Uif7Vs61/rvel5rahFLcE=
Received: by 10.52.0.37 with SMTP id 5mr2665838vdb.269.1300524657740; Sat, 19
 Mar 2011 01:50:57 -0700 (PDT)
Received: by 10.52.169.163 with HTTP; Sat, 19 Mar 2011 01:50:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169415>

Hi,

I've been tracking a project, via the master branch, customizing
certain aspects and applying my changes into a separate local branch
B. In the mean time, there is this new remote branch
origin/release_2.1, that was created for releasing a certain version.
It happened that I merge entirely that master branch into my local
branch, periodically, in order to get the latest change sets. It also
happens in that projects, that commits from branch C get merged into
the project's origin/master.

I'd like to do the following: Take all the those changes I made
against origin/master, checkout a local branch based on
origin/release_2.1 and apply them on it. This way I can get my
customizations re-based against that particular branch (stream)
instead of origin/master being the parent/upstream.

Is it possible to achieve that? does it involves a kind of git
rebasing (--onto ?). So far, I used exclusively a merge flow to
maintain my private branch B in sync with origin/master and that right
now that code base is more recent than origin/release_2.1.

Here is the structure, in ASCII, of the project: (best viewed with a
proportional font)

origin/master
|
|
|  |  |
|  |  |
|  |  |
+--|--\ (sometimes commits in origin/release_2.1 go into origin/master)
|  |  |
|  |  |
|  |  |
|  |  |
|  |  |
|  +  | (git merge origin/master into my_private_branch)
| /|  |
+  |  |
|  |  |
|  |  |
|  +  | (git merge origin/master into my_private_branch)
| /|  |
+  |  |
|  |  | origin/release_2.1
|  |  /
+--|-/
|  |
|  | my_private_branch (git checkout -b)
|  /
+/
|
|

Regards,

-Ilyes
