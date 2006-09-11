From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 22:27:26 -0700
Message-ID: <7vac57nfb5.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
	<17668.2019.732961.855446@cargo.ozlabs.ibm.com>
	<20060911000306.GA28927@spearce.org>
	<7vfyezqlny.fsf@assigned-by-dhcp.cox.net> <ee2cms$o18$1@sea.gmane.org>
	<20060911024434.GA29368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 11 07:26:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMeJi-00056T-FJ
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 07:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWIKF0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 01:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWIKF0m
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 01:26:42 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31192 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964812AbWIKF0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 01:26:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911052640.EYT6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Sep 2006 01:26:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LtSh1V00P1kojtg0000000
	Mon, 11 Sep 2006 01:26:42 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060911024434.GA29368@spearce.org> (Shawn Pearce's message of
	"Sun, 10 Sep 2006 22:44:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26837>

Shawn Pearce <spearce@spearce.org> writes:

> Jakub Narebski <jnareb@gmail.com> wrote:
>> Junio C Hamano wrote:
>> 
>> >  the impact of changing the
>> > one-file-per-ref implementation to something based on a single
>> > simple databasy file (e.g. gdbm, bdb, sqlite, ...)
>> 
>> One of the complaints against Subversion was that it use BerkeleyDB
>> (bdb) backend... but it was before it acquired fsfs interface. Perhaps
>> we could use it too.
>
> I'm against the latest Berkely DB (Sleepy Cat) implementations.
> Every time I've stored data in them or in applications which use
> them I've lost everything.  GNU dbm might not be too bad.  SQL Lite
> is overkill.
>...
> This is probably something that is easily solved by a simple fixed
> record format holding a 20 byte SHA1 (binary) and a fixed width null
> terminated string holding the ref name, with the records sorted
> by ref name.  Its yet another file format with yet another set of
> utilities needed but we pretty much have those (update-ref).

Yup.  That is one reasonable implementation of "single simple
databasy file" I suggested.  Or we could just borrow .git/info/refs
format.
