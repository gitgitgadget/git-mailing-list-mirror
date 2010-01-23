From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 20:00:28 +0100
Message-ID: <201001232000.28896.j6t@kdbg.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <201001231409.30706.j6t@kdbg.org> <201001231448.42721.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 20:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYlEs-0003Xl-7n
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 20:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab0AWTBi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jan 2010 14:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755925Ab0AWTBi
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 14:01:38 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:28550 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751752Ab0AWTBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 14:01:37 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D7637A7EB5;
	Sat, 23 Jan 2010 20:01:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 02B0E19F6D1;
	Sat, 23 Jan 2010 20:00:29 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001231448.42721.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Samstag, 23. Januar 2010, Robin Rosenberg wrote:
> l=F6rdagen den 23 januari 2010 14.09.29 skrev  Johannes Sixt:
> > The function returns either the input unmodified, or it strips also=
 at
> >  least one directory component, except when base is only "/" (or "/=
/" or
> >  "///"...). I said in practice, because on Windows it does not make=
 sense
> >  to invoke git with (literally)
> >
> >    git --git-dir=3D//server/share/repo.git --work-tree=3D/ ...
> >
> > i.e., without a drive prefix before the slash of --work-tree.
>
> Why not? //foo/bar/z is just as valid and useful a path as x:/z.

=46ortunately, make_relative_path() does not have the slightest problem=
=20
with //foo/bar/z, either as value of abs (the path to make relative) or=
 as=20
base (the path to strip from abs).

-- Hannes
