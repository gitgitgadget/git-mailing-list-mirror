From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] submodule update: consistently document the '--checkout'
 option
Date: Fri, 28 Feb 2014 22:41:11 +0000
Message-ID: <53111087.1000909@web.de>
References: <20140225110316.GU11566@login.drsnuggles.stderr.nl>	<530FB5C4.8080400@web.de> <xmqqbnxqudbf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 23:41:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJW7T-0000Ca-Qx
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 23:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbaB1WlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 17:41:22 -0500
Received: from mout.web.de ([212.227.15.4]:53882 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbaB1WlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 17:41:20 -0500
Received: from [192.168.1.102] ([213.143.48.60]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MhDgb-1WWUhQ2C4v-00MOav for <git@vger.kernel.org>;
 Fri, 28 Feb 2014 23:41:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqbnxqudbf.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:YbpuR29FbqSK5gJoHqbjskht8gu9+TLK5fYJDKspMipx4HDu0wX
 FGqCn4h/uele2KtrndE8JDIbmBscHme7D2LQNGJSlCqm8S+zkIdE13mcKN03/EAQgMjo68x
 5LlOG12O31mpG4177x5iaux5BnwGNdPsBYC5oUskpD/yeynJhd+5QZ6tu3MN0F1huSOcOr+
 8K4slQy1tc8/bv4FT2Niw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243024>

Commit 322bb6e12f (add update 'none' flag to disable update of submodule
by default) added the '--checkout' option to "git submodule update" but
forgot to explicitly document it in synopsis, usage string and man page
(It is only mentioned implicitly in the man page). In 23d25e48 (submodule:
explicit local branch creation in module_clone) the synopsis of the man
page was updated, but the "OPTIONS" section of the man page and the usage
string of the git-submodule script still do not mention the '--checkout'
option.

Fix that by documenting this option in usage string and the "OPTIONS"
section of man page too. While at it group the update-mode options into
a single set in the usage string.

Reported-by: Matthijs Kooijman <matthijs@stdin.nl>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 28.02.2014 21:39, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Good point. What about this?
>>
>>
>>  Documentation/git-submodule.txt | 13 +++++++++++--
>>  git-submodule.sh                |  2 +-
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index bfef8a0..9054217 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -15,8 +15,8 @@ SYNOPSIS
>>  'git submodule' [--quiet] init [--] [<path>...]
>>  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
>> -	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
>> -	      [--merge] [--recursive] [--] [<path>...]
>> +	      [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>]
>> +	      [--depth <depth>] [--recursive] [--] [<path>...]
> 
> This has already been done by 23d25e48 (submodule: explicit local
> branch creation in module_clone, 2014-01-26).  That commit also adds
> some text to the description of 'update' subcommand, but not a
> separate entry for '--checkout' mode.

Thanks, I missed that one.

> Does the result of applying this patch except for this particular
> hunk still make sense as a whole?  It appears to me that it does,
> but just to double check...

Yes, it still makes sense. But I updated the commit message to
also mention 23d25e48.


 Documentation/git-submodule.txt | 9 +++++++++
 git-submodule.sh                | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 21cb59a..dab817d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -315,6 +315,15 @@ the submodule itself.
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.

+--checkout::
+	This option is only valid for the update command.
+	Checkout the commit recorded in the superproject on a detached HEAD
+	in the submodule. This is the default behavior, the main use of
+	this option is to override `submodule.$name.update` when set to
+	`merge`, `rebase` or `none`.
+	If the key `submodule.$name.update` is either not explicitly set or
+	set to `checkout`, this option is implicit.
+
 --merge::
 	This option is only valid for the update command.
 	Merge the commit recorded in the superproject into the current branch
diff --git a/git-submodule.sh b/git-submodule.sh
index a33f68d..6135cfa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
-- 
1.8.3.1
