X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: reexporting git repository via git-daemon
Date: Sun, 10 Dec 2006 18:28:38 +0100
Organization: SelfOrganizing
Message-ID: <200612101828.38165.arekm@maven.pl>
References: <200612082212.09682.arekm@maven.pl> <200612101822.09385.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 17:28:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612101822.09385.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-Authenticated-Id: arekm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33905>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtSTr-0004jq-Vp for gcvg-git@gmane.org; Sun, 10 Dec
 2006 18:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762266AbWLJR2t convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 12:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762277AbWLJR2t
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 12:28:49 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:55684 "EHLO
 outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762266AbWLJR2s convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 12:28:48 -0500
Received: from [83.11.40.170] (helo=[192.168.0.64]) by tekla.agnat.pl with
 esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256) (Exim 4.63) (envelope-from
 <arekm@maven.pl>) id 1GtSTg-0004Ni-Vs; Sun, 10 Dec 2006 18:28:41 +0100
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

On Sunday 10 December 2006 18:22, Robin Rosenberg wrote:
> fredag 08 december 2006 22:12 skrev Arkadiusz Miskiewicz:
> > Hi,
> >
> > I have weird problem wit git (1.4.4.2).
> >
> >  git --bare clone git://git.kernel.org/pub/scm/git/git.git
> > fetches everything correctly;
>
> You proably ment git clone --bare git://git.kernel.org/pub/scm/git/gi=
t.git

Tested - result is the same, git-damon strace:
[pid  6686] write(1, "00408419a453dc088b25b63ab1746d3d7e679caf686d=20
refs/tags/v1.4.1.1\n", 64) =3D 64
[pid  6686] write(2, "fatal: ", 7)      =3D 7
[pid  6686] write(2, "corrupted pack=20
file ./objects/pack/pack-bc830a5d1c2efa3b727ef9af8faba13c3e719395.pack"=
, 85)=20
=3D 85
[pid  6686] write(2, "\n", 1)           =3D 1


> Maybe git shouldn't accept useless (in this case) options.
Options handling in git* is a nightmare. It accepts non-existant option=
s. You=20
never know if the option is fine, missplaced or ignored :/

> -- robin

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
