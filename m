From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: interaction between --graph and --simplify-by-decoration
Date: Fri, 31 Jul 2009 13:11:00 +0200
Message-ID: <adf1fd3d0907310411j401b4e89r5f1dfc2b0d3b7ff4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWq16-0001TR-Fo
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbZGaLLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 07:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbZGaLLD
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:11:03 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62879 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbZGaLLC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 07:11:02 -0400
Received: by ewy10 with SMTP id 10so1418924ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 04:11:01 -0700 (PDT)
Received: by 10.216.22.78 with SMTP id s56mr475332wes.100.1249038660881; Fri, 
	31 Jul 2009 04:11:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124541>

Hello,

  I've found that in some cases the --graph and
--simplify-by-decoration don't work well together. If you do this in
the git.git repository:

$ git log --graph --simplify-by-decoration --oneline v1.6.3.3
* cff4231 (tag: v1.6.3.3) GIT 1.6.3.3
* 6c7f58d (tag: v1.6.3.2) GIT 1.6.3.2
* 4774780 (tag: v1.6.3.1) GIT 1.6.3.1
* f01f109 (tag: v1.6.3) GIT 1.6.3
*   3536ae3 Sync with GIT 1.6.2.5
|\
| * a48f5d7 (tag: v1.6.2.5) GIT 1.6.2.5
| *   00f97c7 Merge branch 'maint-1.6.1' into maint
| |\
| | * bab39ed (tag: v1.6.1.4) GIT 1.6.1.4
* | | 503f464 (tag: v1.6.3-rc4) GIT 1.6.3-rc4
* | | 95110d7 (tag: v1.6.3-rc3) t4202: fix typo
* | | f29ac4f (tag: v1.6.3-rc2) GIT 1.6.3-rc2
 / /
| | *   66996ec Sync with 1.6.2.4
| | |\
| |_|/
|/| |
* | | 1f9b620 (tag: v1.6.2.4) GIT 1.6.2.4
| | * 77b96d6 (tag: v1.6.3-rc1) Update draft release notes to 1.6.3
| | * c965c02 (tag: v1.6.3-rc0) GIT 1.6.3-rc0
| |/
|/|

you can see that f29ac4f looks like it does not have any parents while
the correct parent is 66996ec which seems to have no children. But if
you omit the --oneline you can see that there are a lot of "root"-like
commits (f01f109, a48f5d7, f29ac4f,...).

gitk gets it right, and I've test also the first commit with both
flags and it happens the same.

Thanks,
Santi
