From: Jan Kara <jack@suse.cz>
Subject: Re: git bisect goes wild?
Date: Tue, 24 Feb 2009 20:10:02 +0100
Message-ID: <20090224191002.GF22108@duck.suse.cz>
References: <20090224184414.GE22108@duck.suse.cz> <eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 20:11:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc2gq-0002gS-46
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 20:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbZBXTKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbZBXTKH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 14:10:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:36967 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbZBXTKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 14:10:06 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A87D947794;
	Tue, 24 Feb 2009 20:10:03 +0100 (CET)
Received: from duck.suse.cz (duck.suse.cz [10.20.1.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.suse.cz (Postfix) with ESMTP id 4CF8E62807F;
	Tue, 24 Feb 2009 20:10:03 +0100 (CET)
Received: by duck.suse.cz (Postfix, from userid 10005)
	id CF27A1F1E2F; Tue, 24 Feb 2009 20:10:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111329>

On Tue 24-02-09 13:59:16, Peter Harris wrote:
> 2009/2/24 Jan Kara:
> > =A0Hi,
> >
> > =A0I've been bisecting some change in Linux kernel. The output of
> > "git bisect log" is:
> ...
> > git-bisect bad 419217cb1d0266f62cbea6cdc6b1d1324350bc34
> ...
> > git-bisect good 3e9830dcabdeb3656855ec1b678b6bcf3b50261c
> >
> > =A0But after the last command, I was sent to commit
> > 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b which is far outside the w=
indow
> > between the last good and bad commit.
>=20
> How did you determine that this commit is outside the window?
>=20
> When I run "gitk 3e9830..419217" it shows that commit, as does "git
> log". 9ec76fb appears to be inside the window to me.
  Ho, hum, right. But if I do:
git describe 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b
  I get v2.6.23-rc3-215-g9ec76fb which is a bit strange for bisecting
between 2.6.23 and 2.6.24. Also the kernel gets named 2.6.23-rc3 and ke=
rnel
config options get also to some pre 2.6.23 state. That's what is confus=
ing
me. It seems like the kernel checked out is some old one. I'm not a git
expert so it might be fine but it just seems really strange.

									Honza
--=20
Jan Kara <jack@suse.cz>
SUSE Labs, CR
