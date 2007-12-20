From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: git-svn: pulling from local mirror but committing via svn+ssh
Date: Thu, 20 Dec 2007 11:21:52 -0500
Message-ID: <8bd0f97a0712200821j778c12a9g9d42bf02482d953c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 17:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5OA6-0006i2-TT
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 17:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647AbXLTQVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 11:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760732AbXLTQVz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 11:21:55 -0500
Received: from hs-out-0708.google.com ([64.233.178.251]:1470 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758647AbXLTQVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 11:21:54 -0500
Received: by hs-out-2122.google.com with SMTP id 54so3375555hsz.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=OX3V+JLcDbL7NUY7db2w2q9N/joeWrqYNiwMHTB4DEA=;
        b=uvw8xInd8cLp9XAtzfpz8Qj39tMFAH9Wjq3WMv094izaygynk5+d75SJEm9Ynj5OTN6zId/bSe8/98UtHn6pnGgz3ORk3HuO9YLiUq57uc2SftNwH3WlAwKV91ovJVWP61Ei6GUFvJJVCfvZxICuOzWwyQoIQyV2wFml8/xkq8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dduVsbilh/TuTrtqMmrWW82hrtRVophbiT4hr5N4nqvMkThYZqOVoC47y/Yd7AwKgdmzp7UJbzC9IH3EtUZyBJYgcmn23VRYMdGQ4cUyqsV3MVQrtCiDNvQvKn11H9KS34rQI7l6GWrTGKiH8B+Zv51uXlCpBZqpTDoEDHeKw3I=
Received: by 10.142.115.10 with SMTP id n10mr128913wfc.95.1198167712741;
        Thu, 20 Dec 2007 08:21:52 -0800 (PST)
Received: by 10.142.165.7 with HTTP; Thu, 20 Dec 2007 08:21:52 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69008>

i have local (fast) mirrors of the svn trees i use, so i normally keep
everything pointing at those.  when i need to commit, i use `svn
switch --relocate ...` to flip to the svn+ssh master, and then flop
back to the local mirror.  it actually works out nicely.

my reading of git-svn(1) seems to indicate that git-svn cant really
handle switching of repository URLs on the fly ?
http://www.kernel.org/pub/software/scm/git/docs/git-svn.html

i tried tweaking my .git/config and changing the url to my svn+ssh,
but it seems any modification in the URL just causes errors ...
vapier@G5[ppc] git $ git-svn dcommit
Use of uninitialized value in concatenation (.) or string at
/usr/bin/git-svn line 384.
Committing to  ...
Unable to determine upstream SVN information from HEAD history

guess i'll have to bite the bullet and just clone the svn+ssh repo :/

(i'm using 1.5.3.7 over here)
-mike
