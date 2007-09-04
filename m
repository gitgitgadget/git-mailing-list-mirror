From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Tue, 4 Sep 2007 23:38:57 +0200
Message-ID: <20070904213857.GA21351@steel.home>
References: <46DDC500.5000606@etek.chalmers.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISg76-00015o-Ie
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXIDVjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 17:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbXIDVjH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:39:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:47855 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXIDVjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 17:39:06 -0400
Received: from tigra.home (Fc916.f.strato-dslnet.de [195.4.201.22])
	by post.webmailer.de (mrclete mo61) (RZmta 12.5)
	with ESMTP id o03be2j84JMifw ; Tue, 4 Sep 2007 23:38:58 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1CEE0277BD;
	Tue,  4 Sep 2007 23:38:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CDE9BBEAC; Tue,  4 Sep 2007 23:38:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46DDC500.5000606@etek.chalmers.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAclPg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57651>

Lukas Sandstr=F6m, Tue, Sep 04, 2007 22:50:08 +0200:
> Hi.
>=20
> This is an attempt to use "The Better String Library"[1] in builtin-m=
ailinfo.c
>=20
> The patch doesn't pass all the tests in the testsuit yet, but I thoug=
ht I'd
> send it out so people can decide if they like how the code looks.

It looks uglier, but what are measurable merits? Object code size,
perfomance hit/improvement, valgrind logs?

> -static int read_one_header_line(char *line, int sz, FILE *in)
> +static int read_one_header_line(struct bStream *in, bstring line)

Every coder has a time in his life when he writes a string library...
and a stream support for it.
