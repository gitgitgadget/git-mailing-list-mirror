From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last break point?
Date: Mon, 31 Oct 2011 02:14:01 -0700 (PDT)
Message-ID: <m3obwx4j7s.fsf@localhost.localdomain>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
	<CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mail List <git@vger.kernel.org>
To: netroby <hufeng1987@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 10:14:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKnwa-0004d4-3g
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 10:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303Ab1JaJOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Oct 2011 05:14:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56936 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab1JaJOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 05:14:05 -0400
Received: by faan17 with SMTP id n17so5313343faa.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=7FtLTzrPsCYtLrMWRdSzbxO3BkYzaKLJwaoLcMgzR5Q=;
        b=HD680oL+vTDB3L6fCmJZr35qITUgnlnBoZ+3WIcGQ4+h353337GeAvEVFO7NeZDhKz
         fXMTSwze/wNqe3BzJEolESS3l/yJX/5uKGBp0+uQuBqDWZhWEHgMvABwTk8NFFyQKT86
         /Hqdkd0EW8MY9uFssKObot77CDcksjogBgFzc=
Received: by 10.223.58.146 with SMTP id g18mr28176281fah.13.1320052443278;
        Mon, 31 Oct 2011 02:14:03 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id l26sm24313243fad.17.2011.10.31.02.14.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 02:14:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9V9DcKK024281;
	Mon, 31 Oct 2011 10:13:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9V9DSZJ024278;
	Mon, 31 Oct 2011 10:13:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184498>

netroby <hufeng1987@gmail.com> writes:

> Is it possible to let git clone continue last break point.
> when we git clone very large project from the web,=A0 we may face som=
e
> interupt, then we must clone it from zero .
>=20
> it is bad feeling for low=A0 connection=A0 speed users.
>=20
> please help us out.
>=20
> we need git clone continue last break point

Resuming "git clone" is not currently possible in Git, and it would be
difficult to add such feature to Git; there were several attempts and
neither succeeded.

What you can do is generate a starter bundle out of your repository
(using "git bundle"), and serve this file via HTTP / FTP / BitTorrent,
i.e. some resumable transport.  Then you "git clone <bundle file>",
fix up configuration, and fetch the rest since bundle creation.

Though this is possible only if it is your project... or can ask
project administrator to provide bundle.

--=20
Jakub Nar=EAbski
