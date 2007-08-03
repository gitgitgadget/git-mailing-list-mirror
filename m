From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 02:24:38 +0200
Message-ID: <85wswdwjll.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
	<7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 02:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkyJ-0002iv-6T
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 02:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbXHCAYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 20:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbXHCAYr
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 20:24:47 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:39835 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750723AbXHCAYr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 20:24:47 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 07BF231EEE0;
	Fri,  3 Aug 2007 02:24:46 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id EA27A346AC1;
	Fri,  3 Aug 2007 02:24:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id C7D5835E5A8;
	Fri,  3 Aug 2007 02:24:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 90E3D1C4F931; Fri,  3 Aug 2007 02:24:38 +0200 (CEST)
In-Reply-To: <7vk5sdscfr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 17\:12\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54655>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> However, there is a line we need to draw when bending bacwards for
>>> compatibility, and I think a system that does not have a working
>>> command substitution $( ... )  is on the other side of that line.
>>
>> Not an issue.  But apparently, ${parameter#word} is for Solaris.  I'd
>> still like to get confirmation that it is indeed /bin/sh, but if it
>> is, the current code is not good for Solaris.
>
> I happen to feel ${parameter#word} is more esoteric than $(cmd).
> If a system does not even do the latter, then avoiding the
> former to help such a system is a futile effort.

The situation is that we currently don't avoid the former.  Robert
said that he had prepared a patch that would do so.

It would make sense to either encourage him to present his patch
(though we probably don't know for sure that there are indeed shells
for which the former works worse than the latter), or permit further
use of ${parameter#word} where it makes things more readable.

But "only a little bit of ${parameter#word}, please" seems pointless.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
