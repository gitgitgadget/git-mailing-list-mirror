From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 20:21:42 +0900
Message-ID: <87ps08s3zt.fsf@catnip.gol.com>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
	<ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
	<86ejgowl5g.fsf@lola.quinscape.zz>
	<20070924080134.GA9112@artemis.corp>
	<20070924080436.GB9112@artemis.corp>
	<Pine.LNX.4.64.0709241128460.28395@racer.site>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 13:21:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZm0X-0007ye-Q2
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 13:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbXIXLVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 07:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbXIXLVj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 07:21:39 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:56749 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbXIXLVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 07:21:38 -0400
Received: from 203-216-103-127.dsl.gol.ne.jp ([203.216.103.127] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IZm0L-0000dU-D2; Mon, 24 Sep 2007 20:21:33 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id C9E8C2F41; Mon, 24 Sep 2007 20:21:43 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <Pine.LNX.4.64.0709241128460.28395@racer.site> (Johannes Schindelin's message of "Mon\, 24 Sep 2007 11\:33\:00 +0100 \(BST\)")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59040>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >   $# != 0 would yield sth like (strcmp(sprintf("%d", argc), "0"))
>> >   $# -ne 0 would yield sth like (argc != atoi("0")).
>> 
>>   Of course this holds only for shell where test/[ is a builtin, which
>> is the at least the case for zsh, bash, and dash (but not posh).
>
> The reason we used "case" is that this has always been a builtin (has to 
> be, because it changes workflow).
>
> Therefore I am somewhat uneasy that the patch went in so easily, 
> especially given a message that flies in the face of our endeavours to 
> make git less dependent on any given shell (as long as it is not broken to 
> begin with).

The comment "... holds only for a shell where [ is a builtin" doesn't
make any sense to me though:  "-ne" is a standard operator even if "["
isn't a builtin.  It's useful if you are testing numbers in potentially
non-canonical form, e.g., with leading zeroes or something, and AFAIK is
quite portable.

-Miles
-- 
Everywhere is walking distance if you have the time.  -- Steven Wright
