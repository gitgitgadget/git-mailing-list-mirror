From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Wed, 18 Nov 2009 01:42:28 +0100
Message-ID: <m2bpj03bpn.fsf@igel.home>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
	<20091117073426.GB4007@coredump.intra.peff.net>
	<20091117074930.GB11636@glandium.org> <m2lji43l20.fsf@igel.home>
	<7v8we4er0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Karl Chen <quarl@quarl.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAYdB-0005dN-0f
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbZKRAm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 19:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZKRAm3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:42:29 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:34220 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbZKRAm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 19:42:28 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 9394A1C1545E;
	Wed, 18 Nov 2009 01:42:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 68E9F9028E;
	Wed, 18 Nov 2009 01:42:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id ixogURKyWY2A; Wed, 18 Nov 2009 01:42:28 +0100 (CET)
Received: from igel.home (DSL01.83.171.175.126.ip-pool.NEFkom.net [83.171.175.126])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 18 Nov 2009 01:42:28 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 7C1E9CA28F; Wed, 18 Nov 2009 01:42:28 +0100 (CET)
X-Yow: I'm in ATLANTIC CITY riding in a comfortable ROLLING CHAIR...
In-Reply-To: <7v8we4er0t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 17 Nov 2009 14:16:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133120>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Mike Hommey <mh@glandium.org> writes:
>>
>>> On Tue, Nov 17, 2009 at 02:34:26AM -0500, Jeff King wrote:
>>>> Maybe:
>>>> 
>>>>   A leading path component of "~user" is expanded to the home directory
>>>>   of "user"; "~" is expanded to the home directory of the user running
>>>>   git.
>>>> 
>>>> would be more clear?
>>>
>>> Add "real" before "user running git" and you have my vote. Or maybe
>>> using the effective user would be better, and the patch should use
>>> geteuid() instead of getuid(), I don't know. ident.c uses getuid(), but
>>> I'm wondering if that's what it should use (although it doesn't seem to
>>> have been a problem to anyone)
>>
>> "~" should just expand to the value of $HOME, like in the shell,
>> independent of the real home directory of the real or effective user.
>
> How should this interact with installations that run gitosis/gitlite that
> use shared account, giving user identity via the ssh key?

Sorry, I don't know enough about such an installation to be able to
answer that.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
