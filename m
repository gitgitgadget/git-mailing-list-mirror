From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] t1300: fix the new --show-origin tests on Windows
Date: Wed, 23 Mar 2016 11:42:19 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603230923030.4690@virtualbox>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <a43d6d1f46a90eea9083f329ad0dfb17915c38a1.1458668543.git.johannes.schindelin@gmx.de> <xmqq37riidow.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:42:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigFS-0006sH-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbcCWKmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:42:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:50528 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbcCWKmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:42:40 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Ldspr-1a0VbQ12J9-00j0rD; Wed, 23 Mar 2016 11:42:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq37riidow.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UiRpRgSsj6nHjyIK7BgZ+pGgUH/T9cqHR10AGEHNUmbXl/8imAb
 AzxyK0+8qZG/4gy/QN60XN4Yl8W1V3dPmbH9SDcxIkaH9PmjAhorkyeLn4DaGuF5MRVEJ9G
 4oY0FzbHkf4zpo5Pnu4KNxPo42oTzRRS2z6nTJVuucMHdE6u+xvQwQhc7X/K0/j5KIsOiCE
 QEbaE5HYCUDhIR+5cnB3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vBUMkWyZcTY=:+aeNbLWg3l1B9rWOCqwa6w
 /fx6wiby1GiZv8BK50wV5MhYsfaHh8e+1siijY9jkbCAuTfPUDff1WDQ0Ax03SnH4AGTXSu0Y
 vjtJZlwchDq4MoQc8ludoLtSkksc3KfjaOmWg60hat3gcPCI89zcf5CbHUQYUeGAeYCIjLIjk
 V814LCBjfDzWkrL+g1W5DykYVXeNRCIiErZ+06CGAXAYRbECTdad2/FhV1QEngaWIx+HrxIxY
 WuHHItlrI8EJXQIRpeF/MeiMbIceqWPOAauRYG6s0omZrEa04UZggv4MJUqkYqXpjRGOi5ez/
 5CgPi3wXo88E1uoz7ChI84AkQMX0PksjhCkZKSrD72vJ8+bo8/CZFfiaPYIcqzVlZAr59k06j
 cNGp5RgmZMrIAmE8pTzG5rmdJ8m3SXaUrINlBq0vEFOjm7ivmQamotIDB5AidSEstdreweYCi
 jjb+ckQRtIs0aANJ2VCGWfZMiDVBZQh03Ls+ZjnmC6ozCR2Ky6BuNq+tDeADgq2ZzhWNZihjU
 yWSZTnQjhOnKjP8UxMKrOaw4lYvqUkVjeCB3EIiMDwSKpgQbux0LWJMMKUTHo2S4pWMbAJRMF
 nLQ4FekIXAEiTMZvdGtZ4n0Bh94SNWjEbxG8ut2k2OQxZd6tAoqqLWetBNttmkTYUV8AwMpkb
 mqqVBCYeEqyEwMOO5Ek/xm4JS3tcWjuTo3QByw+KTJk6kJW+I28ueVVpVy6A1a2HfX39rP0CA
 WfYM+8Ej947Tx52hGbbf+xTx55DAYr+u+0gXdghes+uRSSJAPCwVB1jvxbJBqoLJcJ5XTVQ1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289638>

Hi Junio,

On Tue, 22 Mar 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > On Windows, we have that funny situation where the test script can refer
> > to POSIX paths because it runs in a shell that uses a POSIX emulation
> > layer ("MSYS2 runtime"). Yet, git.exe does *not* understand POSIX paths
> > at all but only pure Windows paths.
> >
> > So let's just convert the POSIX paths to Windows paths before passing
> > them on to Git, using `pwd` (which is already modified on Windows to
> > output Windows paths).
> >
> > While fixing the new tests on Windows, we also have to exclude the tests
> > that want to write a file with a name that is illegal on Windows
> > (unfortunately, there is more than one test trying to make use of that
> > file).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t1300-repo-config.sh | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > index 0236fe2..18eb769 100755
> > --- a/t/t1300-repo-config.sh
> > +++ b/t/t1300-repo-config.sh
> > @@ -1232,6 +1232,15 @@ test_expect_success 'set up --show-origin tests' '
> >  	EOF
> >  '
> >  
> > +if test_have_prereq MINGW
> > +then
> > +	# convert to Windows paths
> > +	HOME="$(pwd)"
> 
> We override HOME in t/test-lib.sh; shouldn't this be done there?

We override it with $PWD.

Remember, on Windows we have this funny situation where the shell,
Perl, and the Unix tools used in scripting, know about POSIX paths, but
little else. Most notably git.exe does *not* understand them [*1*].

The difference between $PWD and $(pwd) is, you guessed it, POSIX path vs
Windows path, respectively. And since *some* of our tests verify
shell/Perl scripts' correct behavior, we *want* $HOME to be a POSIX path,
at least some of the time.

> > +	INCLUDE_DIR="$HOME/include"
> 
> I am puzzled. 'set up --show-origin tests' do say INCLUDE_DIR is
> "$HOME/include" already, so why is this needed?
> 
> > +	export HOME INCLUDE_DIR
> 
> Existing tests use $INCLUDE_DIR (and $HOME) as shell variables just
> fine without exporting.  Why do these need to be exported only on
> MINGW?

Habit. The export is actually not needed at all, you are totally correct.

> > +	git config -f .gitconfig include.path "$INCLUDE_DIR/absolute.include"
> > +fi
> 
> Perhaps if you adjust HOME before 'set up --show-origin tests' test,
> most (or all) of the above become unnecessary?

It did not even occur to me, thanks for that suggestion. It works
perfectly. Will send out v2 in a moment.

Ciao,
Dscho

Footnote [*1*]: we do have this hack, system_path(), that can turn "POSIX
paths" into Windows paths. However, it actually turns paths relative to
the prefix (as in "/usr/") into Windows paths, and the prefix is
determined at runtime, from the location of git.exe. When the test suite
runs, the location of git.exe is most definitely *not* related to any
sensible prefix, therefore we simply cannot expect git.exe to handle POSIX
paths correctly in the test suite.
