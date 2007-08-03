From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Help a sed noob
Date: Sat, 04 Aug 2007 01:40:23 +0200
Message-ID: <46B3BCE7.3090509@lsrfire.ath.cx>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH6l1-0004l7-Q0
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956AbXHCXkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Aug 2007 19:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755956AbXHCXkd
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:40:33 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:57670
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755917AbXHCXkc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 19:40:32 -0400
Received: from [10.0.1.201] (p508EF046.dip.t-dialin.net [80.142.240.70])
	by neapel230.server4you.de (Postfix) with ESMTP id EBB598B008;
	Sat,  4 Aug 2007 01:40:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54772>

Nguyen Thai Ngoc Duy schrieb:
> Hi,
>=20
> There is a construct like this in git-parse-remote.sh which makes
> busybox ash unhappy:
>=20
>                 sed -ne '/^URL: */{
>                         s///p
>                         q
>                 }' "$GIT_DIR/remotes/$1"
>=20
> It complains about "no previous regexp" while gnu sed is ok. Can
> anyone explain to me what does "s///p" do? GNU Sed info page says
> nothing about empty regexp. If I replace it with "s/\(.*\)/\1/p" then
> I get "URL: " along with the remote path.
>=20
> By the way, can we use another construct instead? It would be less
> work for me ;-)

You could manually add the previous regular expression, like this:

		sed -ne '/^URL: */{
			s/^URL: *//p
			q
		}' "$GIT_DIR/remotes/$1"

Ren=C3=A9
