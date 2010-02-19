From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] ? - git log :/text results are strange
Date: Fri, 19 Feb 2010 23:34:52 +0100
Message-ID: <201002192334.52495.trast@student.ethz.ch>
References: <76c5b8581002191350h61d6d8c2jd0245c0963fcc85f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:35:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NibR7-0004Rr-5F
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 23:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab0BSWe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 17:34:56 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:6315 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab0BSWez convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 17:34:55 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 19 Feb
 2010 23:34:52 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 19 Feb
 2010 23:34:53 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <76c5b8581002191350h61d6d8c2jd0245c0963fcc85f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140492>

On Friday 19 February 2010 22:50:39 Eugene Sajine wrote:
> When I=E2=80=99m executing
> $ git log :/fix
>=20
> I expect to see commits with messages starting from word =E2=80=9Cfix=
=E2=80=9D only

You're not putting the puzzle together in the right way.  The chain
goes roughly like this:

* git-log wants to know what its arguments resolve to

  * (the internal equivalent of) git-rev-parse works out that :/fix is
    a525d2a, as it (apparently) is the youngest commit with a message
    starting with 'fix' (see man git-rev-parse)

* git-log feeds a525d2a to the revision walker

  * the revision walker starts outputting commits backwards through
    history, starting from a525d2a

and unsurprisingly, the log you pasted is just 'git log a525d2a'.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
