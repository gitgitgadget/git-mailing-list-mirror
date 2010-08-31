From: Marcin Cieslak <saper@saper.info>
Subject: Re: [PATCH/RFC 07/17] gettext.c: work around us not using
 setlocale(LC_CTYPE, "")
Date: Tue, 31 Aug 2010 15:37:47 +0000
Message-ID: <alpine.BSF.2.00.1008311534390.12745@x.fncre.vasb>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com> <1283203703-26923-8-git-send-email-avarab@gmail.com> <20100831151800.GG2315@burratino>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1730125533-378104593-1283269068=:12745"
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:38:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSui-0003NP-4k
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757556Ab0HaPiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:38:14 -0400
Received: from k.saper.info ([91.121.151.35]:39320 "EHLO k.saper.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757441Ab0HaPiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:38:13 -0400
Received: from k.saper.info (localhost [127.0.0.1])
	by k.saper.info (8.14.4/8.14.4) with ESMTP id o7VFbmgw012927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Aug 2010 15:37:48 GMT
	(envelope-from saper@saper.info)
Received: from localhost (saper@localhost)
	by k.saper.info (8.14.4/8.14.4/Submit) with ESMTP id o7VFbl9p012924;
	Tue, 31 Aug 2010 15:37:48 GMT
	(envelope-from saper@saper.info)
X-Authentication-Warning: k.saper.info: saper owned process doing -bs
In-Reply-To: <20100831151800.GG2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154915>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1730125533-378104593-1283269068=:12745
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 31 Aug 2010, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>
>> In 107880a I removed our use of setlocale(LC_CTYPE, "") because of a
>> bug in the GNU C Library [1]
>
> Future readers might benefit from a reminder that it is vsnprintf that
> is broken.
>
> Aside, not about this patch: glibc printf can be very convenient for
> translators, because of format strings like "%4$s".  Do other common
> platforms like FreeBSD and Mingw have something similar?

Speaking for FreeBSD:

% svn log -r21674 printf.3 
------------------------------------------------------------------------
r21674 | jkh | 1997-01-14 08:31:39 +0100 (wto) | 8 linii

The following patch to lib/libc/stdio implements positional arguments in
a manner consistent with other implementations.  Its done in a way that
adds only a tiny amount of overhead when positional arguments are not used.
I also have a test program to go with this, but don't know where it belongs
in the tree.

Submitted-By: Bill Fenner <fenner@FreeBSD.ORG>

------------------------------------------------------------------------

Solaris 9 has it, too.

--Marcin
--1730125533-378104593-1283269068=:12745--
