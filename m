From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: diff support for the Eiffel language?
Date: Mon, 22 Oct 2012 15:35:12 +0200
Message-ID: <50854B90.50807@viscovery.net>
References: <508550E8020000A10000CF36@gwsmtp1.uni-regensburg.de> <CACBZZX4wF8C_9ok+zeTfO70BgZXufvQaJ+8B5EiOAmxvVwr54g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:35:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQIAE-0006wm-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 15:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab2JVNfS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 09:35:18 -0400
Received: from so.liwest.at ([212.33.55.24]:30700 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182Ab2JVNfR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2012 09:35:17 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TQI9x-0001fP-Gm; Mon, 22 Oct 2012 15:35:14 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4363B1660F;
	Mon, 22 Oct 2012 15:35:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CACBZZX4wF8C_9ok+zeTfO70BgZXufvQaJ+8B5EiOAmxvVwr54g@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208183>

Am 10/22/2012 15:06, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Mon, Oct 22, 2012 at 1:58 PM, Ulrich Windl=20
> <Ulrich.Windl@rz.uni-regensburg.de> wrote:
>> However there's one little thing I noticed with "git diff": The
>> conte4xt lines (staring with "@@") show the current function (in Per=
l
>> and C), but they show the current "feature clause" in Eiffel (as
>> opposed to the expected current feature). I wonder how hard it is to
>> fix it (Observed in git 1.7.7 of openSUSE 12.1).
>=20
> See git.git's e90d065 for an example of adding a new diff pattern.

It's not necessary to wait until there is built-in support for a new la=
nguage.

=46or example, for Windows resource files, I have

*.rc    diff=3Dwinres

in .gitattributes or .git/info/attributes and

[diff "winres"]
        xfuncname =3D
"!^(BEGIN|END|FONT|CAPTION|STYLE)\n^[a-zA-Z_][a-zA-Z_0-9]*.*\n^[[:space=
:]]*([[:alnum:]_]+,
*DIALOG.*)"

in .git/config (the xfuncname is all on a single line). The first part
beginning at ! up to \n tells to ignore the specified matches. The othe=
r
parts separated by \n tell the things to put in the hunk header. You ca=
n
have "ignore" parts (with exlamation mark) and "take this" parts (witho=
ut)
in any order that is convenient, as long as the last one is "take this"=
=2E

-- Hannes
