From: Nico Williams <nico@cryptonector.com>
Subject: Re: Git messes up =?iso-8859-1?Q?'=F8?= =?iso-8859-1?Q?'?= character
Date: Tue, 20 Jan 2015 16:18:06 -0600
Message-ID: <20150120221802.GJ2350@localhost>
References: <54BEB08D.9090905@tronnes.org>
 <54BEB585.2030902@web.de>
 <54BEB7ED.2050103@tronnes.org>
 <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
 <54BEC75C.3090207@tronnes.org>
 <CACBZZX5f0ciqmJizYxe+UvKL-g9iDZTca52=9xZP4_qiuEaO3Q@mail.gmail.com>
 <54BECAE0.70309@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <notro@tronnes.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:18:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDh7p-0001Bg-TA
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 23:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbATWSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 17:18:13 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:47892 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbbATWSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2015 17:18:13 -0500
Received: from homiemail-a112.g.dreamhost.com (sub4.mail.dreamhost.com [69.163.253.135])
	by hapkido.dreamhost.com (Postfix) with ESMTP id C9C2990479
	for <git@vger.kernel.org>; Tue, 20 Jan 2015 14:18:12 -0800 (PST)
Received: from homiemail-a112.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a112.g.dreamhost.com (Postfix) with ESMTP id 5195A200EDEAD;
	Tue, 20 Jan 2015 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to:content-transfer-encoding; s=
	cryptonector.com; bh=1ut7ne/jcTwMgkW4sG116Y4SBDs=; b=vS321fB9YDv
	+TdsXjfp+8zK97QGWsBwXo1z7gN3QtCpYwOFjOKN8EVtHEByJnLefASSZL1Ycc4n
	NXh1IOlsWX5+Vb0oUQU7pniM91A3hNksnUcmBU+io0ortOpGT2szl3w4RHZWX3Fb
	064x4p/1b7+53K1Lo6AGLKm65xNUpcag=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a112.g.dreamhost.com (Postfix) with ESMTPA id E81F2200EDEAA;
	Tue, 20 Jan 2015 14:18:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54BECAE0.70309@tronnes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262700>

On Tue, Jan 20, 2015 at 10:38:40PM +0100, Noralf Tr=F8nnes wrote:
> Yes:
> $ echo Noralf Tr=F8nnes | xxd
> 0000000: 4e6f 7261 6c66 2054 72f8 6e6e 6573 0a    Noralf Tr.nnes.
>=20
> Is there a command I can run that shows that I'm using ISO-8859-1 ?
> I need something to google with, my previous search only gave locale
> stuff, which seems fine.

The locale(1) command tells you what your locale is set to, but it
doesn't say anything about your input method -- it only tells you what
your shell and commands started from it expect for input and what they
should produce for output.

The input method will generally be part of your windowing environment,
for which you'll have to search how to check/configure your OS
(sometimes it can be set on a per-window basis, sometimes it's a global
setting).

Even if the windowing environment is set to UTF-8, your terminal
emulator might be set to ISO-8859-something, so check the terminal
emulator (e.g., rxvt, Terminator, GNOME Terminal, PuTTY, ...).

=46inally, check what stty(1) says (e.g., on Linux it should show that
iutf8 is enabled) (this is mostly so that when you backspace in cooked
mode the line discipline knows how many bytes to drop from the buffer).

Nico
--=20
