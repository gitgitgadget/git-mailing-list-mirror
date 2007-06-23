From: "Marco Costalba" <mcostalba@gmail.com>
Subject: qgit: Annotate hundreds of files at terrific speed ;-)
Date: Sat, 23 Jun 2007 18:35:11 +0200
Message-ID: <e5bfff550706230935m5363a6dava9dbd62a56a1b685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 18:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I28Zv-0002F5-OE
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 18:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbXFWQfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbXFWQfN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 12:35:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:30334 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbXFWQfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 12:35:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1157073wah
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 09:35:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j6RtJzt4Wlcp6G2Rq+7BCeKB2O/yMu2sY6B/D/Q/jaJA7WfLAnLp5YPmV+fY8x9MY1fb+t1gprzv6nlFPzhMsrD476QtkOYlRtS2X4YaiT3RWE0MS/j83+gBEgcl5DA+AXTRyPgN8Ep+u+Eviz+fOlAuJba5jNAWu8d0FW4eWEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gLH+dZhBIv8FRLRPUk9/g0vqV3atUqmvLvt4pr1NmN6W0Be7t6sspgd/rIWGtk/qNh3KT54WA4ggoTqaN8hrDss9fvcbN9jyt0GjhT/5Yt8s6tNmYmoeBdknIcECZVIf/id5j8+M9sMLaLmS+CqGIt1BOdsV19N8YN+Opo5NuIY=
Received: by 10.114.181.1 with SMTP id d1mr3949009waf.1182616511643;
        Sat, 23 Jun 2007 09:35:11 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sat, 23 Jun 2007 09:35:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50743>

- pull from git://git.kernel.org/pub/scm/qgit/qgit4.git

- compile + install

- run qgit on the git repo

- select the 900 pounds gorilla called 'Makefile' from tree view ('t'
key shortcut)

- double click on it so to start file viewer and annotation

- say wahooo!

You get _all_ the hundreds (more then 800) of revisions of this
monster history annotated in the time it takes *other* ;-) tools to
annotate just one of them.



Ok. Come back to earth. I've just pushed some patches to use 'git log'
instead of 'git rev-list' as interface with git.

By using git-log with '-p' option it is possible to get a file history
_and_ corresponding diff in one pass instead of the double step
git-rev-list + git-diff-tree. Speed up it's huge.

But there are other gains:

- qgit can now be run with any command line argument known to 'git log'

- when Linus patch 'git log --follow' will be accepted by Junio the
following of file renames will come automatically


Unfortunately there are issues too:

- git-log lacks currently a --stdin option needed to pass a long list
of sha's, something that a tool sometime wants to do.

- because of the previous issue a StGIT repo under with a long list of
unapplied patches may break 'git log' loading.

- probably 'git log --follow' will come semi-automatically because an
incompatibility with '--parents' option, as pointed out by Linus,
needs a workaround. The latter is currently used to handle the grafts.


Marco
