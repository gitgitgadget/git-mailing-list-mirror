From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git submodule for a local branch?
Date: Tue, 23 Oct 2012 22:57:57 +0200
Message-ID: <508704D5.9020902@web.de>
References: <20121022123714.GL25563@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Oct 23 22:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQlYK-0000bU-2S
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 22:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364Ab2JWU6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 16:58:07 -0400
Received: from mout.web.de ([212.227.17.12]:49561 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964994Ab2JWU6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 16:58:05 -0400
Received: from [192.168.178.41] ([79.193.87.155]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MEmKo-1Tfg3P10Ha-00FUXw; Tue, 23 Oct 2012 22:58:01
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121022123714.GL25563@odin.tremily.us>
X-Provags-ID: V02:K0:a56f2jJUD9rDn2ENAoUIH8Besyjmg3+VrQavzWctFDR
 rVvuy3pWdApt2+FOo85ZqkC7y6sBnNOjvF+wnLKjL7u2ru11FE
 9+7fGVSeWh8wiBZUnkhayPsw8kbhIsL3HWcIyRIdoksJ79/FmS
 Zxtzxn5aq+bKjQ7GrDy9Ke2Y7sNq4LBs0JgGSfGB+v8493r+HV
 0C02eLgJhszuzdoXMVEwg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208249>

Am 22.10.2012 14:37, schrieb W. Trevor King:
> I have a bunch of branches in my repo (a, b, c, =E2=80=A6), and I'd l=
ike to
> check them out into subdirectories of another branch (index).  My
> initial inclination was to use something like
>=20
>   $ git checkout index
>   $ git branch
>     a
>     b
>     c
>   * index
>   $ git submodule add -b a --reference ./ ./ dir-for-a/
>   $ git submodule add -b b --reference ./ ./ dir-for-b/
>   $ git submodule add -b c --reference ./ ./ dir-for-c/
>=20
> but cloning a remote repository (vs. checking out a local branch)
> seems to be baked into the submodule implementation.  Should I be
> thinking about generalizing git-submodule.sh, or am I looking under
> the wrong rock?  My ideal syntax would be something like
>=20
>   $ git submodule add -b c --local dir-for-c/

But then we'd have to be able to have two (or more) work trees using
the same git directory, which current submodule code can't.

> The motivation is that I have website that contains a bunch of
> sub-sites, and the sub-sites share content.  I have per-sub-site
> branches (a, b, c) and want a master branch (index) that aggregates
> them.  Perhaps this is too much to wedge into a single repository?

To me this sounds upside-down. I'd put the three sub-sites into
different repositories and the shared content into a submodule that
all three sub-sites use. At least that is how I do all my content
sharing on the websites I have done ... does that make sense?
