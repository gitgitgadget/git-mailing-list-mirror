From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable
	errors.
Date: Mon, 12 Jan 2009 22:47:29 +0100
Message-ID: <20090112214729.GC24941@chistera.yi.org>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net> <496BB204.2040109@tedpavlic.com> <496BA0E4.2040607@tedpavlic.com> <20090112212544.GA24941@chistera.yi.org> <496BB810.30503@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:50:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUf7-00009G-Vv
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbZALVrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 16:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbZALVrc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:47:32 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1072
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757716AbZALVrb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 16:47:31 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id D9EFE801C078;
	Mon, 12 Jan 2009 22:47:29 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LMUd7-0006qd-2v; Mon, 12 Jan 2009 22:47:29 +0100
Content-Disposition: inline
In-Reply-To: <496BB810.30503@tedpavlic.com>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105393>

* Ted Pavlic [Mon, 12 Jan 2009 16:37:20 -0500]:

>> Because (from a quick look) their completion script never expands a
>> variable which is not known to be set.

> They use $1, $2, etc. In fact, they use $1, $2, and $3 in their _hg, =
=20
> which is their main completion function. Why would those be defined=20
> there?

=46rom http://www.gnu.org/software/bash/manual/bashref.html#Programmabl=
e-Completion:

  When the function or command is invoked, the first argument is the na=
me
  of the command whose arguments are being completed, the second argume=
nt
  is the word being completed, and the third argument is the word
  preceding the word being completed on the current command line.

> In fact, it's $1, $2, $3, and $4 that are causing the problemw ith th=
e =20
> git completions.

They are causing problems in the functions that are called sometimes
with arguments, sometimes without, like __gitdir. If you know that
you'll always be calling a function with $1, you need not use ${1-};
that's what happens in the mercurial completion script AFAICS.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
The surest way to corrupt a youth is to instruct him to hold in higher
esteem those who think alike than those who think differently.
                -- F. Nietzsche
