From: "Wink Saville" <wink@saville.com>
Subject: Setting up remote repository --bare
Date: Sun, 26 Aug 2007 22:03:12 -0700
Message-ID: <d4cf37a60708262203j1cdd6e88u82f65f7a435c5dc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 07:03:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPWlN-00012B-AF
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 07:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXH0FDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 01:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbXH0FDP
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 01:03:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:29841 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbXH0FDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 01:03:14 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1928818wah
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 22:03:13 -0700 (PDT)
Received: by 10.114.14.1 with SMTP id 1mr495634wan.1188190993032;
        Sun, 26 Aug 2007 22:03:13 -0700 (PDT)
Received: by 10.114.149.15 with HTTP; Sun, 26 Aug 2007 22:03:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56761>

It seems that the "--bare" option has been removed, I now using 1.5.2.5.
This makes the documentation in
http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html
incorrect. I was able to manually create a bare directory using the following:

$ git-init --shared
$ git-config core.bare true
$ mv .git/* .
$ rmdir .git
$ git-fetch ~/git-repos/my-repo master:master

Things seem to be working I can pull and push to the repo after using:

$ git-daemon --enable=receive-pack --reuseaddr
--base-path=/home/wink/git-repos \
--export-all --verbose

But this seems arduous, I suspect I'm missing something.

Cheers,

Wink Saville
