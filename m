From: Teemu Likonen <tlikonen@iki.fi>
Subject: Plumbing commands (was: Bug report - git show <tagname> together with --pretty=format)
Date: Wed, 08 Apr 2009 22:47:22 +0300
Message-ID: <87myarszat.fsf_-_@iki.fi>
References: <49DC9F07.4090105@gmx.de> <49DCC295.7010908@drmicha.warpmail.net>
	<adf1fd3d0904080937v634c5b69rffa7a737f22a3768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Cornelius <c.r1@gmx.de>, git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 21:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrdli-00038l-AI
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 21:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759400AbZDHTrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758552AbZDHTra
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 15:47:30 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:34036 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbZDHTr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 15:47:29 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 49CA1E6700A0C9B5; Wed, 8 Apr 2009 22:47:23 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Lrdk2-0005c8-7x; Wed, 08 Apr 2009 22:47:22 +0300
In-Reply-To: <adf1fd3d0904080937v634c5b69rffa7a737f22a3768@mail.gmail.com>
 ("Santi =?iso-8859-1?Q?B=E9jar=22's?= message of "Wed\, 8 Apr 2009
 18\:37\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116115>

On 2009-04-08 18:37 (+0200), Santi B=E9jar wrote:

> In addition to what Michael said, you should use the plumbing command=
s
> instead of the porcelain (see man git). They are specifically for use
> with scripts and parse their output. The output from the porcelain
> commands can change.

Hmm, I've been using a command like this in a script:

    date=3D$(git log -1 --pretty=3Dformat:%ai $REV)

Would it be better to change it to

    date=3D$(git rev-list -1 --pretty=3Dformat:%ai $REV | sed -e 1d)

or something else?
