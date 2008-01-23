From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 09:32:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@MIT.EDU>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHjYE-0000zL-2q
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 18:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391AbYAWRdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 12:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758383AbYAWRdd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 12:33:33 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39931 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758368AbYAWRdc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 12:33:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NHWjI1023886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 09:32:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NHWjoF018447;
	Wed, 23 Jan 2008 09:32:45 -0800
In-Reply-To: <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71562>



On Wed, 23 Jan 2008, Kevin Ballard wrote:
>=20
> Well yes, any context in which a string is treated as Unicode instead=
 of an
> opaque sequence of bytes will probably lead to normalization at some =
point
> (e.g. when searching text, I'm going to want M=E4rchen and M=E4rchen =
to be treated
> as the same string).

As pointed out (multiple times), this is only true if the programmer is=
 a=20
moron.

You do not need to - and *should* not - convert to a common normalizati=
on=20
in order to compare to Uncode strings. You should just compare them wit=
h a=20
Unicode-aware comparison routine. It will be faster, and it will avoid=20
corrupting the input.

Sadly, stupid people are much too common.

		Linus
