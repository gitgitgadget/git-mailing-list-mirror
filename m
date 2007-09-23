From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sun, 23 Sep 2007 10:59:36 +0200
Message-ID: <85ir61rc3r.fsf@lola.goethe.zz>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
	<20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<20070922035434.GA99140@void.codelabs.ru>
	<7vtzpnf6c9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 10:59:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZNJg-0005B2-Bu
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 10:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbXIWI7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 04:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbXIWI7p
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 04:59:45 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:56324 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309AbXIWI7o (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 04:59:44 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id EAAE71F5232;
	Sun, 23 Sep 2007 10:59:42 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id CE6521145EA;
	Sun, 23 Sep 2007 10:59:42 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id A9DD13226E8;
	Sun, 23 Sep 2007 10:59:38 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4C9F01C1F3DC; Sun, 23 Sep 2007 10:59:36 +0200 (CEST)
In-Reply-To: <7vtzpnf6c9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 22 Sep 2007 01\:32\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4364/Sun Sep 23 01:59:34 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58955>

Junio C Hamano <gitster@pobox.com> writes:

> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>
>> OK, you're right.  Especially if /bin/sh from Solaris and OpenBSD
>> are working and they are not Bash.  But I would not tell that
>> the shell is broken now -- I had not seen the POSIX specification.
>> Does it specifies how the shell should work in this case?
>
> I have always been assuming it to be the case (this construct is
> not my invention but is an old school idiom I just inherited
> from my mentor) and never looked at the spec recently, but I
> re-read it just to make sure.  The answer is yes.

Independent of that: would you mind a patch replacing that idiom with

while : do case xxx) break; esac

instead?  I find breaking out of the condition rather than the body
awkward, and I find a non-matching case statement, POSIX or not, quite
unobvious in the place of a true while condition.

It is a bit too much of cleverness for my taste.  Never mind that the
current FreeBSD shell does not understand it due to being buggy: I
find that this is not very readable to the human reader either without
a double take.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
