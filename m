From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 18/19] mingw: handle the missing POSIXPERM prereq in
 t9124
Date: Wed, 27 Jan 2016 10:20:53 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601271010270.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de> <4c38596ae3fdcc5906dba49521084fe2b1a6888d.1453818790.git.johannes.schindelin@gmx.de> <xmqqfuxkatdl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:21:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOMHm-0006UM-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbcA0JVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 04:21:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:62080 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbcA0JVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 04:21:00 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M4WuC-1aA0Dq3Buu-00yhz6; Wed, 27 Jan 2016 10:20:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqfuxkatdl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:vwhrXmcjSCdwnIdI4tHJwFZaUbNdP99MCUQIe7tEFw5VLKtDiPG
 liO64EDbXHQjygph9pFG6KIZMRprNQKFgHbx4SAhCmGuKuNt2GX+zr3GIznjoTkAy2wUVFV
 vcfF3TWMXtNGsS8UCzD8dM5J4yuyu0KopHlfS0rw4D6nU3veYfBVf0obxq+d7xD7ef30Z7y
 8JMmenHp6CqpTj8k/qq1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8w7kfNqOdzc=:LzMoRc6rC28HDoohCGsrHN
 iKNr23Fy/92QkTIEShbIa8zKiPTAb7KNwx0mX3L6W9qw94zrKiFV5HTYjKuaA7JzyUcrCtQRN
 /RR9ToGfGX+NUz0AAk4pJ/ffmKzauWqaWX7ue5PTh7bZp6H0hdC+E5WSCefpvFB6KgatcNRhA
 nS4B8Z0nqvNqxpArvmjX+VWVkSXeCUUySABJecJV24YcTiClKxwwfLx86RlceHDkBef7OfAAV
 B2VoWDQFjqwqODXLNDsW5NHzw0Uo4xZawVeC3d58mk1Q+e1VbBAxa0wO/LPna+fw7EXUWjEKa
 UszQLHVigc/XTQgUMWJ6xJ6Ig0/aToACm0xgtGBNLmuuJGHpxWPl2g9+NS2Ck0BMk+nK4ezPj
 7TPkEWFs87sMHIGQ/kU8KmaDAzg5JAIkd9o705cyrXcwrRghsVcT/MTLyO+5e09QLlSzp+0uK
 tL05xliwK/zfKefmBotpz1Qt5yhoNC51jH66lTJqtky98EkeXB6uVl7Eh7tfZKwiavqaPcsXn
 NzZSgVCEw6T61rRhR3pym5i2Cj7OzaFzwD45jG2eexHIyCVVjYRohYv3p2US/dJZJjZQSHsk1
 u6vyubQUD38cWWnYPPez1e3c/1KvZy+O8jx2F7WPXYYcF1XNr4QxUMoXVeb2X1+LmS8RUCgI2
 91P0n13iV++STGnCtMJuOhNaLL9mYFXAhS+HAv+E0tBVLRShBmL2aFr+dU/1xT+GYo5qX+SoJ
 tNFveBo2PO/k3VoGSWbzrN/7mMnPvh1nP6zgvsVtKCEhobplMFIRWtZm1GoRI7RiYVHgxYHO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284901>

Hi Junio,

On Tue, 26 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > On Windows, the permission system works completely differently than
> > expected by some of the tests. So let's make sure that we do not test
> > POSIX functionality on Windows.
> >
> > This lets t9124-git-svn-dcommit-auto-props.sh pass in Git for Windows'
> > SDK.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t9124-git-svn-dcommit-auto-props.sh | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
> > index aa841e1..2be0805 100755
> > --- a/t/t9124-git-svn-dcommit-auto-props.sh
> > +++ b/t/t9124-git-svn-dcommit-auto-props.sh
> > @@ -34,8 +34,7 @@ test_expect_success 'enable auto-props config' '
> >  '
> >  
> >  test_expect_success 'add files matching auto-props' '
> > -	echo "#!$SHELL_PATH" >exec1.sh &&
> > -	chmod +x exec1.sh &&
> > +	printf "" | write_script exec1.sh &&
> 
> That looks like a useless use of printf.  Why not
> 
> 	write_script exec1.sh </dev/null &&

Good point! I changed it, also in t9100.

> >  	echo "hello" >hello.txt &&
> >  	echo bar >bar &&
> >  	git add exec1.sh hello.txt bar &&
> > @@ -48,8 +47,7 @@ test_expect_success 'disable auto-props config' '
> >  '
> >  
> >  test_expect_success 'add files matching disabled auto-props' '
> > -	echo "#$SHELL_PATH" >exec2.sh &&
> > -	chmod +x exec2.sh &&
> > +	printf "" | write_script exec2.sh &&
> >  	echo "world" >world.txt &&
> >  	echo zot >zot &&
> >  	git add exec2.sh world.txt zot &&
> > @@ -65,7 +63,10 @@ test_expect_success 'check resulting svn repository' '
> >  	cd svnrepo &&
> >  
> >  	# Check properties from first commit.
> > -	test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*" &&
> > +	if test_have_prereq POSIXPERM
> > +	then
> > +		test -z "$(svn_cmd propget svn:executable exec1.sh)"
> 
> Why this change?
> 
> 		test "x$(svn_cmd propget svn:executable exec1.sh)" = "x*" &&
> 
> means "propget command gives a literal string that consists of a
> single asterisk".

Oh wow... I blame it on lack of sleep. Would you believe that I totally
overlooked the asterisk, in both cases? Wow.

Sorry for the mess, cleaned it up locally and will resubmit as soon as the
tests passed on both Windows & Linux, and as soon as I figure out how to
change my charset to something else than unknown.

My apologies,
Dscho

P.S.: Would you believe that the reason the tests passed on Linux was that
I forgot to install Subversion? ;-)
