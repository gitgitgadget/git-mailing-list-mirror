From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 21:57:27 +0100
Message-ID: <80f140cdddc016f9b4608d79f1bc3722@212.159.54.234>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com> <201004142110.36453.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29eR-0004fI-Q5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756695Ab0DNU5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 16:57:30 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:33228 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756655Ab0DNU5a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 16:57:30 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 00DC3819C3DD;
	Wed, 14 Apr 2010 21:57:21 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 766A320CFB5;
	Wed, 14 Apr 2010 21:57:28 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WaVwQBekBJZW; Wed, 14 Apr 2010 21:57:28 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B8D5020CFAE;
	Wed, 14 Apr 2010 21:57:27 +0100 (BST)
In-Reply-To: <201004142110.36453.jnareb@gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144915>

On Wed, 14 Apr 2010 21:10:35 +0200, Jakub Narebski <jnareb@gmail.com>
wrote:
> On Mon, 12 April 2010, Sverre Rabbelier wrote:
>>=20
>> On Mon, Apr 12, 2010 at 01:21, Julian Phillips
>> <julian@quantumfyre.co.uk> wrote:
>> > Probably the biggest change from v1 is an expanded aim. =C2=A0Now =
the
>> > output library
>> > is aimed at controlling _all_ plubming output. =C2=A0This series i=
ncludes
a
>> > patch for
>> > ls-tree that has all it's output going through the library, and a
>> > patch for
>> > status that has all the --porcelain output going through the libra=
ry.
>>=20
>> I like where this is going, a lot, especially since we don't have to
>> convert everything in one go, but we can do it as desired, similar t=
o
>> optparsification. I still think more commands than just these two
>> should be converted to validate the design though, perhaps something
>> like 'git blame', or 'git for-each-ref'?
>=20
> I don't think it is needed for either command.

I think that the ability to say that all plumbing output is available i=
n a
variety of standard outputs is potentially useful.  In particular the
ability to be able to parse the output of all plumbing commands directl=
y
into whatever native language the high-level tool is in using an alread=
y
existing standard parser makes life easier for those writing the tool.

> 'git blame' has --porcelain and --incremental output, which is
line-based
> and pretty much self-describing (with "header-name value" syntax for
most
> of it), and well documented.  JSON output would only add unnecessary
> chatter and different quoting rules.

That depends really.  If you are writing something to parse the output,
and you already have a JSON parser available then it's the current outp=
ut
that has different quoting rules. ;)

Anyway, I have already converted blame to use the library for both
--porcelain and --incremental output, so it'll be in the next version o=
f
the patch series.  So you can try before you buy ...

> 'git for-each-ref' has both --format=3D<format> to allow to get data =
what
> one needs, and in the format one wants (with e.g. %00 to reresent NUL=
),
> and [--shell|--perl|--python|--tcl] for placeholders in <format> to b=
e
> quoted as string literals suitable for specified host language.=20
Although
> I am not sure if this option, meant to produce scriptlets, is used th=
at
> much/ note that there is not support for --json quoting, nor --xml=20
> escaping.

--=20
Julian
