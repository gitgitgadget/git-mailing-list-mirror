From: Daniel Lyubomirov -|- Digitalus Bulgaria <daniel@digitalus.bg>
Subject: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 09:32:21 +0200 (CEST)
Message-ID: <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 09:26:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjmdz-0004j4-F8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 09:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386Ab2F0H01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jun 2012 03:26:27 -0400
Received: from office.digitalus.nl ([141.255.176.196]:47641 "EHLO
	office.digitalus.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab2F0H01 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2012 03:26:27 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2012 03:26:27 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by office.digitalus.nl (Postfix) with ESMTP id 498F9E1442A
	for <git@vger.kernel.org>; Wed, 27 Jun 2012 09:32:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at office.digitalus.nl
Received: from office.digitalus.nl ([127.0.0.1])
	by localhost (office.digitalus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jlD+B8SOOqjW for <git@vger.kernel.org>;
	Wed, 27 Jun 2012 09:32:21 +0200 (CEST)
Received: from office.digitalus.nl (office.digitalus.nl [141.255.176.196])
	by office.digitalus.nl (Postfix) with ESMTP id BC1C5E1442E
	for <git@vger.kernel.org>; Wed, 27 Jun 2012 09:32:21 +0200 (CEST)
In-Reply-To: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
X-Originating-IP: [84.54.174.72]
X-Mailer: Zimbra 7.1.1_GA_3213 (ZimbraWebClient - FF3.0 (Linux)/7.1.1_GA_3196)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200703>

Hi,

=D0=90ccidentally my colleague created a file in the root dir of the gi=
t repo called - (just dash).
As result for every commit having this file, diff , merge, cherry-pick =
maybe others just hang.
I tried to make rebase interactive to edit the commit and remove the fi=
le but that fails too.

system: Fedora Linux 3.4.2-1.fc16.x86_64
git version: 1.7.7.6

How to reproduce the bug:
1. create a file named -
2. add the file in the index and commit
3. try diff with another commit, branch

So far i found following workarounds:
1. You can delete the file. Then the problem stays in the history only =
for the commits that have the file.
2. Use git filter-branch and deleted the file from the history.=20

   git filter-branch --index-filter "git rm -rf --cached --ignore-unmat=
ch -- -" <problem commit>..HEAD

   But this changes the history.


Thanks for your work.

Regards,
Daniel Lyubomirov
