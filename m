From: P Baker <me@retrodict.com>
Subject: [PATCH 1/2] Clarify the gitmodules and submodules docs
Date: Wed, 8 Apr 2009 03:04:46 -0400
Message-ID: <526944450904080004r1249d1b8j4a44472d72502b9c@mail.gmail.com>
References: <1239172816-38966-1-git-send-email-pbaker@retrodict.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 09:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRrv-0004yY-F5
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 09:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761442AbZDHHEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 03:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761286AbZDHHEt
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 03:04:49 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:32599 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761175AbZDHHEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 03:04:48 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3434736qwh.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=KT39anfekl8oTPnINSn69IKfsk6e7A+HKduuly+K5qg=;
        b=VRzNA2pu+ZZQ+6tCyBUIwDrYYYbz4pIDhzaMoSC8OsHlrksYw82RItH3OLcmkj5zP3
         tXbMeSSQfozYYUKdevr4GrDhObIKIoAdGS1qp1/VQgQ1wPnbEFqEIhv44WJNBJjWmvF9
         iny5Pl38pcbxXsQxBOGpZRWIbhS4M4pSwy380=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=B8zDgy97NGgelUlFNcYP4TmLRlk6RzIm48x8r8Z8OOlUBPj4aBGgUGI128EZfKmo0Z
         zrH5RacLjOHJCWe0OrnwR4IvSDHywi0J5UvFlti+reO+Y98xzH0+p3u2q5HF/kCEO4D7
         J2lRywIThSC3qA/DDzyRa4ji2n8wC93zbdW3c=
Received: by 10.220.72.200 with SMTP id n8mr1528472vcj.16.1239174286563; Wed, 
	08 Apr 2009 00:04:46 -0700 (PDT)
In-Reply-To: <1239172816-38966-1-git-send-email-pbaker@retrodict.com>
X-Google-Sender-Auth: 0a621aa52afdaa8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116051>

Added some explanation to the docs to clear up some confusing parts of
git-submodules that appeared frequently on the mailing list.

 Signed-off-by: pbaker <pbaker@retrodict.com>
 ---

 As I dug into the reasoning and structure of git-submodule as part of
GSoC preparation, I also ran across frequently asked questions on the
mailing list. From this background, I added some explanation to the
docs to  clear up some confusing parts of git-submodules.

 - pbaker

 Documentation/git-submodule.txt |    9 ++++++---
  Documentation/gitmodules.txt    |    8 +++++++-
  2 files changed, 13 insertions(+), 4 deletions(-)

 diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
 index 3b8df44..1ca8184 100644
 --- a/Documentation/git-submodule.txt
 +++ b/Documentation/git-submodule.txt
 @@ -50,9 +50,12 @@ This command will manage the tree entries and
contents of the
  gitmodules file for you, as well as inspect the status of your
  submodules and update them.
  When adding a new submodule to the tree, the 'add' subcommand
 -is to be used.  However, when pulling a tree containing submodules,
 -these will not be checked out by default;
 -the 'init' and 'update' subcommands will maintain submodules
 +is to be used. This creates a record in the gitmodules file for each
 +submodule. When the file is committed and pulled by others it serves as an
 +in-tree reference for where to obtain the submodule.
 +
 +When pulling a tree containing submodules, these will not be checked out by
 +default; the 'init' and 'update' subcommands will maintain submodules
  checked out and at appropriate revision in your working tree.
  You can briefly inspect the up-to-date status of your submodules
  using the 'status' subcommand and get a detailed overview of the
 diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
 index d1a17e2..8f03310 100644
 --- a/Documentation/gitmodules.txt
 +++ b/Documentation/gitmodules.txt
 @@ -15,7 +15,13 @@ DESCRIPTION

  The `.gitmodules` file, located in the top-level directory of a git
  working tree, is a text file with a syntax matching the requirements
 -of linkgit:git-config[1].
 +of linkgit:git-config[1]. As this file is managed by Git, it tracks the
 +records of a project's submodules. Information stored in this file is used
 +as a hint to prime the authoritative version of the record stored in the
 +project configuration file. User specific record changes (e.g. to account
 +for differences in submodule URLs due to networking situations) should be
 +made to the configuration file, while record changes to be propagated (e.g.
 +due to a relocation of the submodule source) should be made to this file.

  The file contains one subsection per submodule, and the subsection value
  is the name of the submodule. Each submodule section also contains the
 --
 1.6.2.1.316.gedbc2
