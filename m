From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Merge non-first refs that match first refspec
Date: Fri, 28 Sep 2007 14:23:45 -0700
Message-ID: <7vps02o55q.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
	<20070928041509.GU3099@spearce.org>
	<Pine.LNX.4.64.0709280026240.5926@iabervon.org>
	<7vve9vp1zw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 23:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbNJY-0000s0-Fr
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 23:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbXI1VXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 17:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbXI1VXx
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 17:23:53 -0400
Received: from rune.pobox.com ([208.210.124.79]:42227 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbXI1VXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 17:23:52 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6C1D313DB5A;
	Fri, 28 Sep 2007 17:24:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B23A013DAF4;
	Fri, 28 Sep 2007 17:24:09 -0400 (EDT)
In-Reply-To: <7vve9vp1zw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 28 Sep 2007 02:34:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59421>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> Beats me; Junio, what's your test case?
>
> I can paste tomorrow (it is a clone of git.git at work).  I do
> not use .git/config but .git/remotes/origin and explicit four
> separate Pull: lines and going over http.

Here are the files.  Note that I use traditional layout and
always have 'master' checked out when I initiate 'git pull'.

: xyzzy git.git/master; cat .git/config
[core]
	logallrefupdates = true

[diff]
	color = auto

[showbranch]
	default = --topo-order
	default = master
	default = next
	default = pu

[alias]
	co = checkout
: xyzzy git.git/master; cat .git/remotes origin
URL: http://repo.or.cz/r/alt-git.git/
Pull: master:origin
Pull: next:next
Pull: +pu:pu
Pull: maint:maint
Pull: todo:todo
: xyzzy git.git/master; git pull
Warning: No merge candidate found because value of config option
         "branch.master.merge" does not match any remote branch
         fetched.
No changes.
: xyzzy git.git/master; git version
git version 1.5.3.2.1060.gaf79f
: xyzzy git.git/master; exit
