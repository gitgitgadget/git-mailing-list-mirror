From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 22:45:05 +0900
Message-ID: <87k5qgrxcu.fsf@catnip.gol.com>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
	<ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
	<86ejgowl5g.fsf@lola.quinscape.zz>
	<20070924080134.GA9112@artemis.corp>
	<20070924080436.GB9112@artemis.corp>
	<Pine.LNX.4.64.0709241128460.28395@racer.site>
	<87ps08s3zt.fsf@catnip.gol.com>
	<20070924113556.GI8111@void.codelabs.ru>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZoFL-0004Yb-Gd
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 15:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826AbXIXNpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 09:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756415AbXIXNpE
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 09:45:04 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:42070 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbXIXNpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 09:45:03 -0400
Received: from 203-216-103-127.dsl.gol.ne.jp ([203.216.103.127] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IZoF2-0003kh-7m; Mon, 24 Sep 2007 22:44:52 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id C71C82F41; Mon, 24 Sep 2007 22:45:05 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <20070924113556.GI8111@void.codelabs.ru> (Eygene Ryabinkin's message of "Mon\, 24 Sep 2007 15\:35\:56 +0400")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59047>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>> The comment "... holds only for a shell where [ is a builtin" doesn't
>> make any sense to me
>
> The 'while case ...' construct does not invoke any external commands.
> The 'while test ...' too, but only when 'test' is builtin.  When
> 'test' is the external binary you get one additional fork/exec per
> each cycle.

In practice that's not an issue though -- every reasonable shell has
test as a builtin these days, so the "works when test is not a builtin"
criteria is really important only for robustness.

> I believe that this trick comes from the old days where people were
> generally much more eager to save CPU cycles than now ;))

Yes.  I still occasionally find myself using "case" where if+test might
be more natural, but I think it's basically an anachronism these days,
and causes more harm by reducing readability than good.

-Miles
-- 
The car has become... an article of dress without which we feel uncertain,
unclad, and incomplete.  [Marshall McLuhan, Understanding Media, 1964]
