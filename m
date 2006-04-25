From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 20:24:38 +0200
Organization: At home
Message-ID: <e2lpgb$64l$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org> <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org> <e2lmm3$rts$1@sea.gmane.org> <Pine.LNX.4.64.0604251053100.3701@g5.osdl.org> <Pine.LNX.4.64.0604251058490.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Apr 25 20:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSDQ-00023v-3j
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWDYSYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 25 Apr 2006 14:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWDYSYd
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:24:33 -0400
Received: from main.gmane.org ([80.91.229.2]:12192 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932273AbWDYSYc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 14:24:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYSD3-0001z6-7d
	for git@vger.kernel.org; Tue, 25 Apr 2006 20:24:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 20:24:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 20:24:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19162>

Linus Torvalds wrote:

> On Tue, 25 Apr 2006, Linus Torvalds wrote:
>>=20
>> The "track it with pull/push" thing is NOT one such thing, however m=
uch
>> you protest. We already _have_ that thing. It's called a "ref", and =
it's
>> really really easy to create anywhere in .git/refs/, and the tools
>> already know how to use it.

I agree(d) that tracking pull/push with extra commit header fields is n=
ot a
good example.
=20
> Btw, there are other cases for that. For example, "parent" is a
> well-specified thing that actually has very clear and unambiguous mea=
ning.

In single parent case, "parent" means that we modified tree pointed by =
the
parent. Multiple parent case suggests that we combined trees pointed by
parents, most probable by merge. I'd rather we not use parent for anyth=
ing
else.

> And we had a much better proposals (in the sense that it had real
> suggested _meaning_ and semantics) over the last few months for thing=
s
> like sub-projects (trees that point to other commits)

Wasn't it commits pointing to other trees (or to commits)? "bind" field
proposal suggests it. And it could be implemented using 'X-*' "related"
headers in commit.

   related=A0a0e7d36193b96f552073558acf5fcc1f10528917=A0bind=A0linux-2.=
6

vs. proposed

   bind=A0f6a8248420395bc9febd66194252fc9957b0052d=A0linux/

--=20
Jakub Narebski
Warsaw, Poland
