From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 09:41:42 -0700
Message-ID: <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 
	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> 
	<AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> 
	<4C4DB9AC.9000306@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 18:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdQkq-0000LB-4f
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 18:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab0GZQmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 12:42:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34880 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753184Ab0GZQmJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 12:42:09 -0400
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com [209.85.161.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o6QGg774002509
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 09:42:08 -0700
Received: by gxk23 with SMTP id 23so898467gxk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 09:42:02 -0700 (PDT)
Received: by 10.151.6.5 with SMTP id j5mr8985829ybi.235.1280162522207; Mon, 26 
	Jul 2010 09:42:02 -0700 (PDT)
Received: by 10.151.142.21 with HTTP; Mon, 26 Jul 2010 09:41:42 -0700 (PDT)
In-Reply-To: <4C4DB9AC.9000306@xiplink.com>
X-Spam-Status: No, hits=-2.954 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151857>

On Mon, Jul 26, 2010 at 9:37 AM, Marc Branchaud <marcnarc@xiplink.com> =
wrote:
>
> I think I should mention one aspect of what we're doing, which is tha=
t a lot
> of our submodules are based on external code, and that we occasionall=
y need
> to modify or customize some of that code. =A0So it's quite nice for u=
s to
> maintain private git mirrors of the external repos, with our own priv=
ate
> branches that contain our modifications. =A0Although we want to get m=
uch of our
> changes incorporated into the upstream code bases, upstream release c=
ycles
> are rarely in sync with ours.

THIS.

This is why I always thought that submodules absolutely have to be
commits, not trees. It's why the git submodule data structures are
done the way they are. Anything that makes the submodule just a tree
is fundamentally broken, I think.

That said, I'm not competent to comment on the actual user interface
issues. I can well believe that git-subtree has a nicer interface.

             Linus
