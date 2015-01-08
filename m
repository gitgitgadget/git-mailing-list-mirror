From: Minty <mintywalker@gmail.com>
Subject: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Thu, 8 Jan 2015 12:43:32 +0000
Message-ID: <CANBgh6jyvbquuAwpWuuG4mJ3uZgajchcsJnttn4tN+LNE6EK+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 13:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9CRB-0002wD-78
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 13:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbbAHMnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2015 07:43:37 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:65330 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbbAHMnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2015 07:43:35 -0500
Received: by mail-qa0-f47.google.com with SMTP id f12so2007881qad.6
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 04:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=aoeRdMUDhD7gHDHtbWvtYewCYp3+E5B/rgDWb9zrb5Y=;
        b=Qubp4zDMNkgDID1cc8QXAqroaeCtXqHONvuiysETAT83z3TE59CUOl0vHS6RLUiw8z
         +LzlkJsZnOhf46NMuEDvZLD/ucMzUA5qYi3uC80E8RHyiuBPxfKE/qfX7cyoYv6jsBSt
         /unNjs+7iPbsPhK5DIpnUT/f/ak55YPbluv7hVL9VdF266ikZl18KychZJcxk87EV/45
         vhwEkXbUzh+t73uZJsL754bi1fnaAIi2Gri2ZFzTMVtxy7PhB2P2QGXFnXC5LIb390aD
         cIl0h1X4qu0MaR4MIp+iPzUuSA0D/JY8cwuPpWZJ0R40Jv1IO4vb3XGqjOkzZg2oX4vr
         /DUQ==
X-Received: by 10.140.84.239 with SMTP id l102mr14037636qgd.25.1420721012556;
 Thu, 08 Jan 2015 04:43:32 -0800 (PST)
Received: by 10.229.90.197 with HTTP; Thu, 8 Jan 2015 04:43:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262194>

I appear to have hit a bug (or have data that the code fails on) while
importing an SVN repo to git.

I'm wondering if there is anything I can do to help find / fix the
cause, given I appear to have a fail-case.

Sadly I can't supply the SVN repo as the code is private.

What I did:

git svn clone https://www.example.com/dshfkjhfsjhsdkjfhsdf/nameofrepo

What I'm running:

MacOS Yosemite 10.10.1 (14B25)

=C2=A7 git --version
git version 2.2.1

Built via MacPorts using: sudo port install git +svn

and updated today to the latest available.

The process was running for a few minutes and does appear to have
imported a lot.  The last few lines of output, including the error
(with paths/names anonymised)

r869 =3D 9823c89bbdfa9d51aeb0a16c539049ae96nd5d62 (refs/remotes/git-svn=
)
    D    path/to/stuff/Example1.java
    D    path/to/stuff/Example2.java
W: -empty_dir: path/to/stuff/Example1.java
W: -empty_dir: path/to/stuff/Example2.java
r870 =3D b1f06434b0b2f37a11be2ee5dfc6175bjs348545 (refs/remotes/git-svn=
)
write .git/Git_svn_hash_BmjclS: Bad file descriptor
 at /opt/local/lib/perl5/vendor_perl/5.16.3/darwin-thread-multi-2level/=
SVN/Ra.pm
line 623.

Any advice / pointers would be welcome -- I'd be happy to run any
tests & I'm reasonably comfortable coding in Perl so happy to poke
around where I can.

I've been using git for year (thanks! it rocks) and hoping I can avoid
having to (re)learn too much about SVN.
