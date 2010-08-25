From: "Todd A. Jacobs" <tjacobs@si2services.com>
Subject: Re: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Wed, 25 Aug 2010 03:20:28 -0400
Message-ID: <AANLkTimebn+p9dcUWQiUPT8WwC-tuPpTM8M+ptq4Q9uc@mail.gmail.com>
References: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
	<20100825041440.GH11619@burratino>
	<AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com>
	<20100825062403.GA15858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 09:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoAHj-0008L5-Lg
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 09:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab0HYHUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 03:20:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45866 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0HYHU3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 03:20:29 -0400
Received: by wyb35 with SMTP id 35so324928wyb.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 00:20:28 -0700 (PDT)
Received: by 10.216.157.81 with SMTP id n59mr6914388wek.84.1282720828683; Wed,
 25 Aug 2010 00:20:28 -0700 (PDT)
Received: by 10.216.229.164 with HTTP; Wed, 25 Aug 2010 00:20:28 -0700 (PDT)
In-Reply-To: <20100825062403.GA15858@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154429>

> As you know, in a distributed development model, history is not
> linear. =A0It is possible to have multiple lines of development by
> people who are not aware of each other:

=46air enough. Thank you for taking the time to explain further. I gues=
s
I still don't understand how both the patch and the tag are both on
the master branch:

    $ git branch --contains v1.7.2.2
    * master

    $ git branch --contains 35039ce
    * master

while still not being exported at v1.7.2.2. Diffing:

    git diff 35039ce v1.7.2.2 -- archive.c

still shows the patch unapplied, but I can't understand why since both
commits are on the same branch. What I'm not seeing is where it's
unapplied, reverted, or otherwise stripped out of the progression
along master. What am I missing here?

Meanwhile, whether it isn't merged in, or because the patch doesn't
work/was reverted/won the lottery/took a vacation, the bottom line is
that the last two releases of git Do The Wrong Thing (tm) with
export-subst strings when called by git-archive.

I'd really like to know (for my own git-knowledge growth) how to
figure out where the patch went, if not up the master tree, but in the
end all I want is the right functionality back. :)
