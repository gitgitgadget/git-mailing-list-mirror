From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Wed, 01 Dec 2010 14:13:35 -0500
Message-ID: <1291230820.11917.25.camel@drew-northup.unet.maine.edu>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Wed Dec 01 20:14:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNs7r-0002Lr-SU
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab0LATNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:13:55 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:50945 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab0LATNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:13:54 -0500
Received: from [130.111.39.151] (drew-northup.unet.maine.edu [130.111.39.151])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oB1JDkWV007018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Dec 2010 14:13:46 -0500
In-Reply-To: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oB1JDkWV007018
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291835627.55394@mWi3FqQI7TN5HQKJelJQkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162575>


On Wed, 2010-12-01 at 20:14 +0200, jari.aalto@cante.net wrote:
> From: Jari Aalto <jari.aalto@cante.net>
> 
> In order to easily read paragraphs, use same notation and do not mixed
> both ^ and ~N. This helps digesting the information more easier as the
> tokens stay the same (dcumentation uniformity).
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-reset.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index fd72976..b679c99 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -129,7 +129,7 @@ Undo a commit and redo::
>  +
>  ------------
>  $ git commit ...
> -$ git reset --soft HEAD^      <1>
> +$ git reset --soft HEAD~1     <1>
>  $ edit                        <2>
>  $ git commit -a -c ORIG_HEAD  <3>
>  ------------
> @@ -166,7 +166,7 @@ $ git commit ...
>  $ git reset --hard HEAD~3   <1>
>  ------------
>  +
> -<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
> +<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
>  and you do not want to ever see them again.  Do *not* do this if
>  you have already given these commits to somebody else.  (See the
>  "RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1] for
> @@ -237,7 +237,7 @@ $ git checkout master
>  $ fix fix fix
>  $ git commit ;# commit with real log
>  $ git checkout feature
> -$ git reset --soft HEAD^ ;# go back to WIP state  <2>
> +$ git reset --soft HEAD~1 ;# go back to WIP state <2>
>  $ git reset                                       <3>
>  ------------
>  +

I have to disagree here. Part of the task of good documentation is to
show not just what any one user may prefer (unless it is an accepted
standard, such as an RFC) but also what is possible. Removing the non
"~" examples is actually a disservice to the documentation reader in a
great many cases. What makes more sense in this case is to refer at some
point to the documentation which describes the allowed reference
formats. This makes it clear that:
(1) There are several allowed reference formats, and these are examples
using them;
(2) These, over here, are descriptions of the allowed reference formats.

Also, strictly speaking, each separate operation example is a
"paragraph" inside of a subsection and "EXAMPLES" is the containing
section. If you look at it this way it is already reasonably internally
consistent.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
