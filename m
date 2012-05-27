From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 2/2] t7512-status-warnings.sh: better advices for git status
Date: Sun, 27 May 2012 14:57:44 +0200
Message-ID: <vpqlikdlr1z.fsf@bauges.imag.fr>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338035905-24166-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sun May 27 14:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYd3K-00029K-QI
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 14:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab2E0M5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 08:57:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42480 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab2E0M5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 08:57:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4RCnW2B010669
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2012 14:49:32 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYd2X-0007gZ-Ea; Sun, 27 May 2012 14:57:45 +0200
In-Reply-To: <1338035905-24166-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Sat, 26 May 2012 14:38:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 27 May 2012 14:49:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4RCnW2B010669
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338727775.64465@kUe3vyqCiBeG6qY7Ip0TIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198588>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

>  t/t7060-wtstatus.sh        |    2 +
>  t/t7512-status-warnings.sh |  280 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 282 insertions(+), 0 deletions(-)

> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index b8cb490..d9a1e18 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -30,6 +30,8 @@ test_expect_success 'Report new path with conflict' '
>  
>  cat >expect <<EOF
>  # On branch side
> +# You have unmerged paths: fix conflicts and then commit the result.
> +#
>  # Unmerged paths:
>  #   (use "git add/rm <file>..." as appropriate to mark resolution)
>  #

Doesn't the test fail after this if you don't modify the code at the
same time? Git's codebase should pass all tests at each commit (if only
to allow "git bisect" to run smoothly), so don't modify tests and code
in different commits. What you can do on the other hand is to introduce
new failing tests (test_expect_failure), and then mark them as success
when you update the code. Or introduce tests that show the current
behavior, and then patch the expected output when you update the code 
(the above patch hunk is a nice way to demonstrate the change introduced
by the code for example).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
