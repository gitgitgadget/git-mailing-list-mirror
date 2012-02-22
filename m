From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: remote set-* <name> and <branch>
Date: Wed, 22 Feb 2012 01:17:37 +0100
Message-ID: <20120222001737.GB2228@goldbirke>
References: <CAKHWUkZjQYnf=LwS_RC-E_7gV73AzbWjxs33E5-FL25s6_qX4g@mail.gmail.com>
	<1329861274-21418-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Philip =?iso-8859-1?Q?J=E4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:17:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzzu0-0005bI-So
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab2BVARi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 19:17:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:50848 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab2BVARi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:17:38 -0500
Received: from localhost6.localdomain6 (p5B130361.dip0.t-ipconnect.de [91.19.3.97])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M4xAo-1SNqGf3UEQ-00yfqR; Wed, 22 Feb 2012 01:17:36 +0100
Content-Disposition: inline
In-Reply-To: <1329861274-21418-1-git-send-email-philip@foolip.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:xvKHt+bncVGkvWqVje7E6Is7aswD9yHqORf4yht3HJk
 f4WPyRfpjH6Lc6+JR9BQWegdL+dZXSx7WzL8f3cDUOHH9uwGNg
 f8QXEmuJbIWcbUEDwLz4+hDMqaIMAnNIOZWZG2V9XtE8iBmi6N
 3xfIgJlg5AynM4IpyGzcTuvjnLl1CBPlg44vlgzdU9u4JKON7J
 yINQB+yJPqLfKLtcEFgZ43DMUGX6wfBmE5m7ebCJEf1cAl+Ukn
 JhkZXJyrMJvBjB/3mqS9KxGJVB/YVmn5uP6+5GF6zTPW0LB3jw
 eR+GCqiesG5LIkZyB4aJ4o8XXSuYxLFnVqqxNHM9g9a6a/d8EI
 +yw7wIdXSmgg1FFlFjT4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191202>

Hi,


On Tue, Feb 21, 2012 at 10:54:34PM +0100, Philip J=E4genstedt wrote:
> Complete <name> only for set-url. For set-branches and
> set-head, complete <name> and <branch> over the network,
> like e.g. git pull already does.
>=20
> The style used for incrementing and decrementing variables was fairly
> inconsistenty and was normalized to use ++x, or ((++x)) in contexts
> where the former would otherwise be interpreted as a command. This is=
 a
> bash-ism, but for obvious reasons this script is already bash-specifi=
c.
>=20
> Finally, remove out-of-date documentation for how to submit patches a=
nd
> (silently) defer to Documentation/SubmittingPatches like all other co=
de.
>=20
> Signed-off-by: Philip J=E4genstedt <philip@foolip.org>
> ---
>  contrib/completion/git-completion.bash |   42 +++++++++++++---------=
---------
>  1 files changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 1505cff..9dac084 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -60,18 +60,6 @@
>  #       per-repository basis by setting the bash.showUpstream config
>  #       variable.
>  #
> -#
> -# To submit patches:
> -#
> -#    *) Read Documentation/SubmittingPatches

Um, well...  Did you actually read it?  I mean the part that talks
about making separate commits for logically separate changes? ;)
You clearly squashed three separate changes into a single patch.

Your proposed changes to __git_complete_remote_or_refspec() and
__git_remote() make sense, modulo the increment/decrement part.  I
don't have strong preference either way, but please submit those
changes in separate patches.  Otherwise if ever bisect points to this
commit during a hunt for a 'git remote' completion bug, we'll need to
think about whether the increment style change or the functional
change is causing the trouble.


Thanks,
G=E1bor

=20
