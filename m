From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Wed, 14 Nov 2007 13:25:13 -0800
Message-ID: <7vprycfrk6.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
	<20071114204732.GE3973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 22:26:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsPk3-00080K-Eg
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 22:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbXKNVZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 16:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758660AbXKNVZ1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 16:25:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47058 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107AbXKNVZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 16:25:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EBE362F2;
	Wed, 14 Nov 2007 16:25:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 78AE695C6A;
	Wed, 14 Nov 2007 16:25:42 -0500 (EST)
In-Reply-To: <20071114204732.GE3973@steel.home> (Alex Riesen's message of
	"Wed, 14 Nov 2007 21:47:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65016>

Alex Riesen <raa.lkml@gmail.com> writes:

> Guido Ostkamp, Wed, Nov 14, 2007 21:31:13 +0100:
>> ...
>> cc: acomp failed for diff-delta.c
>> make: *** [diff-delta.o] Error 2
>>
>> This is because 'struct delta_index' is declared with no size in delta.h 
>> and with size in diff-delta.c which does not fit.
>
> Huh?! Ever heard of forward declaration?

We are not the first people who pass around a pointer to an
opaque struct in the API to hide away the implementation.  It
would be surprising if the Workshop Compiler chokes on this and
not other projects.
