From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 19:57:24 +0100
Message-ID: <5294EF14.7000204@web.de>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com> <5294BB97.7010707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Nick Townsend <nick.townsend@mac.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 26 19:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlNpD-0000Vb-Ct
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 19:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab3KZS51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 13:57:27 -0500
Received: from mout.web.de ([212.227.17.11]:53647 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab3KZS50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 13:57:26 -0500
Received: from [192.168.178.41] ([91.3.171.107]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MKa2F-1Vl6J80p0x-0021tp for <git@vger.kernel.org>;
 Tue, 26 Nov 2013 19:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <5294BB97.7010707@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:PUJWg7shWyxDKrUw8rmDD8c/cP74HApZK5Z0TvmiTmrL7szMeci
 iuzc2iFw4LZJc/Pi+NJw1gADIXlKtAku1M6gbmthwrKYLPU0KLzh2OdkHS/kQlj6Ag1rVZA
 eISiI3OKVD5gPkneugDXXTeM7gUJn8UCN21X5BOhf8zP9BRFfXDQh6BhAnFSZ8wezXoB/PR
 01E+M2NSBK3Y7ydzU/gFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238388>

Am 26.11.2013 16:17, schrieb Ren=E9 Scharfe:
> Am 26.11.2013 01:04, schrieb Nick Townsend:
>> diff --git a/Documentation/git-archive.txt b/Documentation/git-archi=
ve.txt
>> index b97aaab..b4df735 100644
>> --- a/Documentation/git-archive.txt
>> +++ b/Documentation/git-archive.txt
>> @@ -11,6 +11,7 @@ SYNOPSIS
>>  [verse]
>>  'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<=
extra>]
>>  	      [-o <file> | --output=3D<file>] [--worktree-attributes]
>> +	      [--recursive|--recurse-submodules]
>=20
> I'd expect git archive --recurse to add subdirectories and their
> contents, which it does right now, and --no-recurse to only archive t=
he
> specified objects, which is not implemented.  IAW: I wouldn't normall=
y
> associate an option with that name with submodules.  Would
> --recurse-submodules alone suffice?

It should. All new code recursing into submodules should not use
--recursive but always --recurse-submodules, as --recursive means
different things for different commands (the only exception being
"git submodule", as --recursive is obvious here, and "git clone"
for backward compatibility reasons).

But I really like what these patches are aiming at.
