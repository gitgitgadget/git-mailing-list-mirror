From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sun, 23 Sep 2007 21:33:44 +0200
Message-ID: <853ax5mb1j.fsf@lola.goethe.zz>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
	<20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<20070922035434.GA99140@void.codelabs.ru>
	<7vtzpnf6c9.fsf@gitster.siamese.dyndns.org>
	<85ir61rc3r.fsf@lola.goethe.zz>
	<7vy7excho4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 21:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZXDH-00073h-OI
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbXIWTdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbXIWTdu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:33:50 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:33111 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375AbXIWTdt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 15:33:49 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 864F928167E;
	Sun, 23 Sep 2007 21:33:47 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 6FDC3100C1;
	Sun, 23 Sep 2007 21:33:47 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 43E812BB5A5;
	Sun, 23 Sep 2007 21:33:47 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BF63F1C1F3DC; Sun, 23 Sep 2007 21:33:44 +0200 (CEST)
In-Reply-To: <7vy7excho4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 23 Sep 2007 12\:20\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4369/Sun Sep 23 16:16:26 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58982>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Independent of that: would you mind a patch replacing that idiom with
>>
>> while : do case xxx) break; esac
>>
>> instead?  I find breaking out of the condition rather than the body
>> awkward,...
>
> I do not have any problem with your approach at all.

Too bad sh does... I need to write

while :; do case xxx) break; esac

instead which is slightly uglier concerning visual aesthetics.

> But on one condition, however.  If it is done correctly with
> double semi-colons before "esac" ;-)

My feeling about this is that double semi-colons before "esac" are
redundant and similarly ugly as ";" before "end" in Pascal.  However,
looking at the existing git scripts it would seem that the redundant
style is ubiquitous anyway, so it would be inconsistent to do this
differently just within the idiom.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
