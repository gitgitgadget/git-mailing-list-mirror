From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Bugfix: grep: Do not colorize output when -O is set
Date: Tue, 06 Jul 2010 22:19:03 +0200
Message-ID: <4C338FB7.8060005@lsrfire.ath.cx>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com> <4C2E1185.1040406@lsrfire.ath.cx> <20100706193845.GA7438@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nazri Ramliy <ayiehere@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 22:19:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWEbt-0007iU-Kp
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 22:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab0GFUTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 16:19:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:59776 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab0GFUTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 16:19:11 -0400
Received: from [10.0.1.101] (p57B7D7E9.dip.t-dialin.net [87.183.215.233])
	by india601.server4you.de (Postfix) with ESMTPSA id D8B9C2F80F0;
	Tue,  6 Jul 2010 22:19:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
In-Reply-To: <20100706193845.GA7438@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150408>

Am 06.07.2010 21:38, schrieb Jonathan Nieder:
> Hi,
>=20
> Ren=C3=A9 Scharfe wrote:
>=20
>> Hmm, but with --open-files-in-pager without argument or -Oless colou=
rs
>> may be handled correctly and desirable.
>=20
> Sorry I missed this before.  Is there really a pager that will accept
> \e[36m as a command-line argument and do something reasonable with it=
?

I was missing that -O enforces -l, and that it makes the pager open all
files directly from the worktree, one by one.  Somehow I assumed that i=
t
would pipe something like the output of "grep -h -C inf" to the pager,
colour marks and all -- similar to what is done without -O, except that
it would start a new pager for each file.

I think the "pager" part of the long option name confused me, but that'=
s
a weak excuse.  Just ignore me, your original patch was fine.

[snip]
> Probably a better solution is to recommend -C option, possibly
> implementing -C infinity so people don=E2=80=99t have to use -C 10000=
00.

Hmm, that could be useful, also with -A and -B.

Ren=C3=A9
