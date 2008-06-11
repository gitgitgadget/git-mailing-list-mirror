From: "John Yesberg" <john.yesberg@gmail.com>
Subject: autocrlf and git manual
Date: Wed, 11 Jun 2008 12:53:44 +0100
Message-ID: <1033a22d0806110453h16782758i7318ef4fce434ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 13:54:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Oua-0005jv-OO
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 13:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbYFKLxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 07:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYFKLxu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 07:53:50 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:15895 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYFKLxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 07:53:49 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1893013ywe.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MKlcFYzqUfASJ0aG1KTf2A+/P/GreysZoTD1JDlpPv0=;
        b=xyfOSIGPKdG2kU9cicTsqUeIqs6jDcYvCtKcrD5I9b8a1p8+lBoqKeIAV1K1zxYiSz
         4lW1btlPIueS9+KxU4gGOA8nFdclZi+L6dVJMLgw6ouqbPRn0ugaX6+Ba44YX71hT/hH
         ekn52JwSD10nzABUpgxzPwcgKFrMWz8lV0g5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=tAl3B1MOIRVXiBpvpF2c3lR3QHJ7l8y8ble9tSLfju2EnCa4e7NwccCl+/QtbPDhAR
         Y4PY9S7Y0yDzHU0T9JpOplp0TS9zVpgc3ljncflBNMpd9MlJt+cqda4ehxhMfeqABaP1
         PpyiHB5XcQwYwyOZCu5CpM0Hr8BaBG8QN8/2o=
Received: by 10.150.84.17 with SMTP id h17mr77828ybb.206.1213185224234;
        Wed, 11 Jun 2008 04:53:44 -0700 (PDT)
Received: by 10.151.14.21 with HTTP; Wed, 11 Jun 2008 04:53:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84604>

Hi all. I'm just starting with git. Downloaded the msysgit 1.5.5 for
windows, and tried to work through the manual from
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html.

The first step was to clone an existing repository. I had trouble
because I'm behind a proxy. Is it worth putting a short section in the
manual describing how the proxy should be set? In the Git Bash, I
tried using
$ git config --global http.proxy proxyname:port
but it didn't work. So I tried
$ git config --global http.proxy http://proxyname:port
that didn't work. I tried
$ export http_proxy=http://proxyname:port
and this time it (the clone) did work.

Then, I went on to the second subsection of the manual, How to check
out a different version of the project. The command
$ git checkout -b new v0.2
failed with:
error: Entry 'org.spearce.egit-feature/.settings/org.eclipse.core.runtime.prefs'
not uptodate. Cannot merge.

After some searching, I found roughly what this message means.
Noticing a suggestion elsewhere in the manual advice to try gitk, I
discovered that there were "Local uncommitted changes, not checked
into index" as suggested by the error. But I hadn't made any changes.
I remembered the release notes from the installation procedure warning
me of an autocrlf issue that had changed recently. The diff aspect of
gitk didn't really demonstrate whether this was the issue, but I tried
removing the repository, setting core.autocrlf false, and then cloning
it again. This time, gitk didn't identify any local uncommitted
changes, and creating a new branch worked. Perhaps it would be good if
the manual could help windows newbies out by providing a hint here -
otherwise they're likely to be discouraged away from git.

I didn't see any contact details in the manual or on the web site. I'd
be happy to contribute text if that helps: Is there a markup language?
Who is the editor?

Thanks,

John.
