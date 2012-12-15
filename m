From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: Proposal: create meaningful aliases for git reset's
 hard/soft/mixed
Date: Sat, 15 Dec 2012 19:57:57 +0100 (CET)
Message-ID: <alpine.LNX.2.01.1212151955330.14667@nerf07.vanv.qr>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com> <7vlir6brjw.fsf@alter.siamese.dyndns.org> <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com> <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
 <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com> <CABURp0pmnsgE1ywW-W2+QFNci=3Lm=JKj9Y3U8zjh8+Cg_NA6Q@mail.gmail.com> <CAGK7Mr7+_n4opf=uQARxA7iSUMFNn9GCFGD5TrhCgarwGhEySA@mail.gmail.com> <CABURp0rho3KvzHRNXj9EA9C2OnbTc_dcmiBiW6JZ-VHu4g2m0Q@mail.gmail.com>
 <7v391v5rgb.fsf@alter.siamese.dyndns.org> <7vhaqb4bvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Phil Hord <phil.hord@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjwwD-00087I-Us
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab2LOS6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:58:00 -0500
Received: from ares07.inai.de ([5.9.24.206]:34736 "EHLO ares07.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab2LOS57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:57:59 -0500
Received: by ares07.inai.de (Postfix, from userid 25121)
	id 126F496A1090; Sat, 15 Dec 2012 19:57:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ares07.inai.de (Postfix) with ESMTP id E1BB696A108F;
	Sat, 15 Dec 2012 19:57:57 +0100 (CET)
In-Reply-To: <7vhaqb4bvb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211559>


On Wednesday 2012-10-03 21:03, Junio C Hamano wrote:
>
>I said that "git reset --keep" started out as an ugly workaround for
>the lack of "git checkout -B $current_branch".  Now we have it, so
>we can afford to make "reset --keep" less prominently advertised in
>our tool set.  As I already said back then, "reset --soft" also has
>outlived its usefulness when "commit --amend" came, so that leaves
>only these modes of "reset":

Soft is still useful, partway. Consider patch splitting (where easily
possible):

 $ git add foo.c bar.c
 $ git commit -m foo,bar
 [other commits]
 $ git rebase -i FOOBARCOMMIT^
 [mark foo,bar for edit]
 $ git reset --soft HEAD^
 $ git reset bar.c
 $ git commit -m foo
 $ git add bar.c
 $ git commit -m bar
 $ git rebase --continue
