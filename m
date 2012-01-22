From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Checkout tag?
Date: Sun, 22 Jan 2012 03:30:34 -0800 (PST)
Message-ID: <m3ipk4dlfy.fsf@localhost.localdomain>
References: <1327226753653-7213023.post@n2.nabble.com>
	<20120122101116.GA31022@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org
To: =?utf-8?b?TWFnbnVzIELDpGNr?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 12:30:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RovdD-00007s-62
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 12:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab2AVLai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jan 2012 06:30:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63148 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab2AVLah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2012 06:30:37 -0500
Received: by eaac11 with SMTP id c11so954115eaa.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 03:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=xXcUThqIBnaRvX4WPLC46YPgTnrA8l5PYeuLc598N28=;
        b=D2/qQny9F6Wi8x72BtjDQtj/19ri/f5v8lYzJr41FbpH8H1ZUCMhvUujpwesB6ImdJ
         8kzIR2yCOmLHN1YVz5MoSNwW8wD+FubHYt1dXpgTXoIYxE6y5oFBdTnafWgVz+/LAhgJ
         X0utyzGWr1RjqfWS4cGcuTv5VHZZpVjKZJYo8=
Received: by 10.213.23.1 with SMTP id p1mr936092ebb.0.1327231836021;
        Sun, 22 Jan 2012 03:30:36 -0800 (PST)
Received: from localhost.localdomain (abvt44.neoplus.adsl.tpnet.pl. [83.8.217.44])
        by mx.google.com with ESMTPS id y12sm38483936eeb.11.2012.01.22.03.30.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jan 2012 03:30:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0MBUGcf014134;
	Sun, 22 Jan 2012 12:30:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0MBTrS1014118;
	Sun, 22 Jan 2012 12:29:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120122101116.GA31022@jpl.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188962>

Magnus B=C3=A4ck <magnus.back@sonyericsson.com> writes:
> On Sunday, January 22, 2012 at 11:05 CET,
>      Abscissa <bus_nabble_git@semitwist.com> wrote:
>=20
> > I've managed to figure out you switch branches with the checkout
> > command, like this:
> >=20
> >   $ git checkout branch_name
> >=20
> > Does that work for tags as well? The docs don't seem clear on that.
> > If not, how do you get the working copy to be a specific tag?
>=20
> Yes, "git checkout" works for branches, tags, commit SHA-1s, and
> anything else that can be resolved to a SHA-1 identifying what to
> check out. [...]

Note however that because you can generate new commits only on top of
local branches (refs/heads/*), if you check out something other than
local branch, e.g.:

  $ git checkout v1.7.8
  $ git checkout origin/next
  $ git checkout HEAD^

you would be after such checkout in unnamed anonymous branch which
contents corresponds to what you checked out.  This state is called
'detached HEAD', and shows e.g. in "git branch output as

  $ git branch
  * (no branch)
  master
  ...

On the other hand if you don't want to checkout tag to explore it, but
set contents of working area to the state it was in given tag, you can
use

  $ git checkout v1.7.8 -- .

HTH


P.S. Instead of Nabble you can use GMane interface, or just use email
(you don't have ot be subscribed to git@vger.kernel.org to post, and
it is custom here to send replies also to author(s)).

--=20
Jakub Narebski
