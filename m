From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 19:45:10 +0100
Message-ID: <80typu1ozt.fsf@tiny.isode.net>
References: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com>
            <AANLkTimsGdv-La_poLpdrvuGChD6_sAD77fcjqKn5PAd@mail.gmail.com>
            <8E0CE121-DB2F-4017-AB46-282562B072FB@aol.com>
            <4BFD680E.8000603@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Walker <PWalker752@aol.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed May 26 20:45:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHLbm-0007Ik-ER
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 20:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934138Ab0EZSpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 14:45:19 -0400
Received: from rufus.isode.com ([62.3.217.251]:47768 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756731Ab0EZSpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 14:45:13 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <S=1sNgBeGYYP@rufus.isode.com>; Wed, 26 May 2010 19:45:10 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 26 May 2010 19:45:11 +0100
X-Hashcash: 1:20:100526:newsletter@dirk.my1.cc::U4LPi2oKs+6JSTxR:0000000000000000000000000000000000000000lyv
X-Hashcash: 1:20:100526:artagnon@gmail.com::zkjJIBmL9Xb8b+LB:00000000000000000000000000000000000000000000g7I
X-Hashcash: 1:20:100526:git@vger.kernel.org::52DiFFeA+uE2Gg+6:0000000000000000000000000000000000000000001nwL
X-Hashcash: 1:20:100526:pwalker752@aol.com::6HkSx62qOsRKSU66:00000000000000000000000000000000000000000004vBf
In-Reply-To: <4BFD680E.8000603@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of
	"Wed, 26 May 2010 20:27:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147818>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

[...]

> I had a similar problem when "make install"ing under AIX. Not with
> NO_CURL but with some other NO_* option. I forgot which.
> This yealded to an empty $(REMOTE_***_ALIASES) macro
> (REMOTE_CURL_ALIASES in your case) which my AIX shell cannot handle.
>
> It reads "for p in; do" which makes it unhappy. I solved my problem
> with the SHELL_PATH environment variable (look at the first few lines
> in the Makefile).
>
> $ SHELL_PATH=3D/bin/bash NO_SOMETHING=3DYesPlease make install
>
> then worked fine for me.

It wouldn't be too horrible to fix the Makefiles, though.  Doing stuff
like this works portably (judging by what some OpenSSL Makefiles do):

	foo=3D"$(REMOTE_CURL_ALIASES)"; for i in $$foo; do \

[...]
