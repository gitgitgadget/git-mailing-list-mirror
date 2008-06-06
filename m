From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an unknown command
Date: Fri, 6 Jun 2008 16:18:09 +0200
Message-ID: <FFFBD901-955E-472F-BFAC-E11D69934064@wincent.com>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <200806061415.27507.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:24:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4crr-0005np-BC
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbYFFOXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 10:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756039AbYFFOXj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:23:39 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:55713 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbYFFOXi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 10:23:38 -0400
Received: from cuzco.lan (35.pool85-53-24.dynamic.orange.es [85.53.24.35])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m56EIAKg029869
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 6 Jun 2008 10:18:13 -0400
In-Reply-To: <200806061415.27507.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84074>

El 6/6/2008, a las 14:15, Robin Rosenberg escribi=F3:

> torsdagen den 5 juni 2008 08.48.40 skrev Johannes Schindelin:
>>
>> This patch introduces a modified Damerau-Levenshtein algorithm into
>> Git's code base, and uses it with the following penalties to show =20
>> some
>> similar commands when an unknown command was encountered:
>>
>> 	swap =3D 0, insertion =3D 1, substitution =3D 2, deletion =3D 4
>>
>> A typical output would now look like this:
>>
>> 	$ git reabse
>> 	git: 'reabse' is not a git-command. See 'git --help'.
>>
>> 	Did you mean one of these?
>> 		rebase
>> 		merge-base
>> 		rev-parse
>> 		remote
>> 		rerere
>>
> Sorry about my negativity here..
>
> Doesn't this confuse more than it helps? Most people do not need to =20
> know about rerere, rev-parse or merge-base so it is very unlikely =20
> they actually meant those. That might be an issue of tuning than =20
> general principles, but I have my doubts. It won't hint that there =20
> are wildly different variants of rebase, which ctually might be much =
=20
> more important to know than rerere, not will it tell svn users that =20
> git revert isn't even close to svn revert.
>
> Completion or git gui is a much better tool for solving this isssue

All true, but most of those issues would go away if just _one_ guess, =20
the best guess, was shown.

Cheers,
Wincent
