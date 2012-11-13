From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 15/13] compat/fnmatch: fix off-by-one character class's
 length check
Date: Tue, 13 Nov 2012 19:07:26 +0100
Message-ID: <50A28C5E.3090508@kdbg.org>
References: <5096D76F.5090907@kdbg.org> <1352628837-5784-1-git-send-email-pclouds@gmail.com> <1352628837-5784-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKti-0002Et-G6
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab2KMSH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 13:07:28 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:62181 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab2KMSH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:07:28 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DE92910011;
	Tue, 13 Nov 2012 19:07:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9808919F30E;
	Tue, 13 Nov 2012 19:07:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <1352628837-5784-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209650>

Am 11.11.2012 11:13, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> -			if (c1 =3D=3D CHAR_CLASS_MAX_LENGTH)
> +			if (c1 > CHAR_CLASS_MAX_LENGTH)

Nice catch! With this one and 14/13, all tests in t3070 pass on Windows=
=2E

-- Hannes
