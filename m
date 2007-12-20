From: "Dan McGee" <dpmcgee@gmail.com>
Subject: git commit does not show all added files in subdirectories
Date: Wed, 19 Dec 2007 21:47:57 -0600
Message-ID: <449c10960712191947y3125f782t6ce7ec7b25ded30f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 04:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5COX-0005Iy-OS
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 04:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbXLTDr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 22:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbXLTDr7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 22:47:59 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:37308 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbXLTDr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 22:47:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2880832rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 19:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=INmp/5I72o6/iz9naY2Tn9RmKaN95tndaYw9OfM9sFY=;
        b=eIROkfvIhjBM+Okcfk0wjpKX422w0o1N3uq7ufjZWCYSoqCxFS7R1CYSxg8XfW3k1QUfchbNywFoe6xEP/okLvTcsssiSiru1EDkPHNwWRBzsKdyKBP03CxcZ73gS1KESGEop/QWoezRM9APdnAzruNN5nyEyQkWVydW2mMM9Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cmzYTmhPWL4OJZj55MNNRIXiAOkFVrUCJPbT6eDcB8I8BQ+UYMT48o809v3OBnuKmF6O0gopYaEXnlMpEHDwgUXXEqVvT1TiOtx9bGGja4stmunfNSswz0saSyD8vP/80gEzxnUe/RonUIR3LXhaTncknta94czGG9u7tJ54ZUo=
Received: by 10.141.212.5 with SMTP id o5mr6500642rvq.20.1198122477794;
        Wed, 19 Dec 2007 19:47:57 -0800 (PST)
Received: by 10.141.212.3 with HTTP; Wed, 19 Dec 2007 19:47:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68969>

The output below should help explain this bug better than words can.
This is with version 1.5.4.rc0.

Note that all files were added with git add before the below output begins.

dmcgee@dublin ~/projects/abs
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file: abs
#	new file: etc/abs/abs.conf
#	new file: etc/abs/supfile.community
#	new file: etc/abs/supfile.core
#	new file: etc/abs/supfile.extra
#	new file: etc/abs/supfile.testing
#	new file: etc/abs/supfile.unstable
#

dmcgee@dublin ~/projects/abs
$ git commit -s
Created initial commit 5f5f8d3: Initial creation of abs git repository
 1 files changed, 171 insertions(+), 0 deletions(-)
 create mode 100755 abs
 create mode 040000 etc

I assume that all files should be listed by git commit, but they are
not. I'm willing to look into fixing this if someone could point me in
the right direction.

-Dan
