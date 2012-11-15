From: Patrick Lehner <lehner.patrick@gmx.de>
Subject: `git mv` has ambiguous error message for non-existing target
Date: Thu, 15 Nov 2012 19:54:56 +0100
Message-ID: <50A53A80.4080203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 19:55:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ4ap-00089t-KU
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 19:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768706Ab2KOSzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 13:55:00 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:38396 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1423636Ab2KOSy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 13:54:59 -0500
Received: (qmail invoked by alias); 15 Nov 2012 18:54:57 -0000
Received: from 188-194-118-2-dynip.superkabel.de (EHLO [192.168.1.110]) [188.194.118.2]
  by mail.gmx.net (mp072) with SMTP; 15 Nov 2012 19:54:57 +0100
X-Authenticated: #36416844
X-Provags-ID: V01U2FsdGVkX1/K0zFvFEHKE4S9LqyAEDi31J7G/cMqzyZLEGiWrC
	n9YGXA5Cp2Hrz+
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209839>

Hey guys,

as was brought up on #github today, the "git mv" command has a bit of a 
little-helping output message when the target directory (or any 
intermediate directories) dont exist.

To reproduce:
- cd into a git repo
- assuming "filea.txt" is an existing file in the CWD, and "dirb" is 
neither a file nor a directory in the CWD, use the command "git mv 
filea.txt dirb/filea.txt"
- this will produce an error message like `fatal: renaming 'filea.sh' 
failed: No such file or directory`

It does not mention that the problem is, in fact, the target directory 
not existing. This seems to be mostly a problem for users unfamiliar 
with bash/*nix console commands. Although it is documented that git mv 
will not create intermediate folders (which is fine, because neither 
does mv), the error message might lead to believe a problem exists with 
the source file.

Expanding the error message to "No such file or directory: 'dirb/' " 
would probably clear this up.

Best regards and thanks to anyone who could improve this,
Patrick
