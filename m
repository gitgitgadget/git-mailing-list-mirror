From: jpinheiro <7jpinheiro@gmail.com>
Subject: Behavior of git rm
Date: Wed, 3 Apr 2013 07:50:24 -0700 (PDT)
Message-ID: <1365000624535-7581485.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 03 16:51:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNP1f-0004Do-RE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 16:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343Ab3DCOu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 10:50:28 -0400
Received: from sam.nabble.com ([216.139.236.26]:41787 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762456Ab3DCOuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 10:50:25 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <7jpinheiro@gmail.com>)
	id 1UNP16-0004Al-Mj
	for git@vger.kernel.org; Wed, 03 Apr 2013 07:50:24 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219940>

Hi all,

We are students from Universidade do Minho in Portugal, and we are using git
in project as a case study.
While experimenting with git we found an unexpected behavior with git rm.
Here is a trace of the unexpected behavior:

$ git init
$ mkdir D
$ echo "Hi" > D/F
$ git add D/F
$ rm -r D
$ echo "Hey" > D
$ git rm D/F
warning: 'D/F': Not a directory
rm 'D/F'
fatal: git rm: 'D/F': Not a directory


If the file D created with last echo did not exist or was named differently
then no error would occur as expected. For example:

$ git init
$ mkdir D
$ echo "Hi" > D/F
$ git add D/F
$ rm -r D
$ echo "Hey" > F
$ git rm D/F

This works as expected, and the only difference is the name of the file of
the last echo.
Is this the expected behavior of git rm?




--
View this message in context: http://git.661346.n2.nabble.com/Behavior-of-git-rm-tp7581485.html
Sent from the git mailing list archive at Nabble.com.
