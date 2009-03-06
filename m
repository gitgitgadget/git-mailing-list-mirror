From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation - More examples for git bisect
Date: Fri, 6 Mar 2009 08:46:24 +0100
Message-ID: <200903060846.25151.chriscool@tuxfamily.org>
References: <1236256574-24764-1-git-send-email-johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 08:48:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfUng-00015o-6r
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 08:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbZCFHrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 02:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZCFHrW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 02:47:22 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:37640 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbZCFHrV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 02:47:21 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 0CCAA4C80D9;
	Fri,  6 Mar 2009 08:47:12 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 19B2A4C8118;
	Fri,  6 Mar 2009 08:47:10 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1236256574-24764-1-git-send-email-johnflux@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112397>

On a second look here are a few nit picks.

=46irst the patch title could be:

"Documentation: More examples for git bisect"

instead of:

"Documentation - More examples for git bisect"

as it would be more consistent with other patches.

Le jeudi 5 mars 2009, John Tapsell a =E9crit :
> Including passing parameters to the programs, and running more
> complicated checks without requiring a seperate shell script.
>
> Signed-off-by: John Tapsell
> ---
>  Documentation/git-bisect.txt |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.=
txt
> index 147ea38..e65c1ca 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -212,7 +212,7 @@ If you have a script that can tell if the current
> source code is good or bad, you can automatically bisect using:
>
>  ------------
> -$ git bisect run my_script
> +$ git bisect run my_script arguments
>  ------------
>
>  Note that the "run" script (`my_script` in the above example) should
> @@ -252,6 +252,13 @@ $ git bisect start HEAD v1.2 --      # HEAD is b=
ad,
> v1.2 is good $ git bisect run make                # "make" builds the=
 app
>  ------------
>
> +* Automatically bisect a test failure between origin and HEAD:
> ++
> +------------
> +$ git bisect start HEAD origin --    # HEAD is bad, origin is good
> +$ git bisect run make test           # "make test" builds and tests
> +------------

Perhaps we should add that the above may not work well if there are som=
e=20
commits that don't build. And that it is fixed in the example below thi=
s=20
one.

>  * Automatically bisect a broken test suite:
>  +
>  ------------
> @@ -291,6 +298,15 @@ It's safer if both "test.sh" and
> "check_test_case.sh" scripts are outside the repo to prevent interact=
ions
> between the bisect, make and test processes and the scripts.
>
> +* Automatically bisect a broken test suite:

The title of the previous example is=20

* Automatically bisect a broken test case:

so if it is the same, then it should perhaps have the same title or per=
haps:

* Automatically bisect a broken test case simplified:

or something like that.

> ++
> +------------
> +$ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
> +$ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
> +------------
> ++
> +Does the same as the previous example, but on a single line.
> +

Thanks,
Christian.
