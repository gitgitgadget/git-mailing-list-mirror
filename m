From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] fetch: align new ref summary printout in UTF-8 locales
Date: Mon, 03 Sep 2012 22:01:17 +0200
Message-ID: <50450C8D.7010301@kdbg.org>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com> <7vwr0aewlf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 22:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8cpt-0002FK-6d
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 22:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385Ab2ICUBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Sep 2012 16:01:22 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:29232 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756229Ab2ICUBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 16:01:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 50B0310017;
	Mon,  3 Sep 2012 22:01:19 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0B4A219F3BE;
	Mon,  3 Sep 2012 22:01:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vwr0aewlf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204708>

Am 03.09.2012 21:26, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
>> fetch does printf("%-*s", width, "foo") where "foo" can be an utf-8
>> string, but width is bytes, not letters. This results in misaligned
>> ref summary table.
>=20
> "but width is bytes, not letters" is a misleading statement.
>=20
> Be careful about three different quantities when talking about
> aligning on terminal output with monospaced fonts:
>=20
>  - How many bytes does the string occupy in memory?
>  - How many unicode codepoints are in the string?
>  - How many display columns does the string occupy on terminal?
>=20
> Note that some "letters" (e.g. Han) occupy two display columns, and
> you want to measure the "width" and compensate that for "bytes".
> Letter count do not come into the picture for the purpose of aligning
> the terminal output.

If I'm reading POSIX correctly, printf measures the width in %*s in byt=
es.

-- Hannes
