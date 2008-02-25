From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH v3] builtin-fsck: reports missing parent commits
Date: Mon, 25 Feb 2008 08:16:42 +0100
Message-ID: <20080225071642.GA15761@auto.tuwien.ac.at>
References: <12038867362489-git-send-email-mkoegler@auto.tuwien.ac.at> <7vlk59pwaj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 08:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTXaT-0000Pl-SG
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 08:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbYBYHQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 02:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbYBYHQo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:16:44 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:33428 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYBYHQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:16:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id BCFEF680B59A;
	Mon, 25 Feb 2008 08:16:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0k+-2-ztJDTf; Mon, 25 Feb 2008 08:16:42 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 9F48068018E5; Mon, 25 Feb 2008 08:16:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vlk59pwaj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74997>

On Sun, Feb 24, 2008 at 07:08:52PM -0800, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> As far as I can tell, the new test is not testing the commit
> object we are looking at from the object database.  What it is
> testing is if the code that parsed and prepared the information
> in "struct commit" found the same number of parents an extra
> check we are doing here by hand (if not grafted --- but
> presumably whoever gave the struct commit we are handling here
> would have obtained that information by doing the same parsing),
> or the parsing of the graft file (when grafted --- but
> presumably whoever gave the struct commit we are handling here
> would have obtained that information by calling the same
> llokup_commit_graft()).
>=20
> So I am not sure what problems in the repository objects these
> new checks are designed to catch.
>=20
> This needs a lot of explanation than what's in your commit log
> message.

If we have already parsed a non-commit object and parse_commit_buffer
hits such a sha1 in a parent line, it simply drops it (same for grafts)=
=2E

I hope that you agree with me, that fsck should catch such an error.

As you don't want to tighten parse_commit_buffer, it must be in fsck.

mfg Martin K=F6gler
