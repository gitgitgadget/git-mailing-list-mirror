From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.5.3.5 error over NFS (pack data corruption)
Date: Tue, 13 Nov 2007 17:32:06 -0800
Message-ID: <7vfxz9pq7d.fsf@gitster.siamese.dyndns.org>
References: <18228.32091.865519.312011@lisa.zopyra.com>
	<20071109232106.GA3435@steel.home>
	<18232.29603.856766.275854@lisa.zopyra.com>
	<20071112233309.GI2918@steel.home>
	<18233.47472.890658.729250@lisa.zopyra.com>
	<20071113214802.GH3268@steel.home>
	<18234.14781.55429.671459@lisa.zopyra.com>
	<20071114000218.GL3268@steel.home>
	<alpine.LFD.0.9999.0711132027430.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is77M-0001Ge-2J
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbXKNBcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbXKNBcU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:32:20 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57116 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbXKNBcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:32:19 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F07082EF;
	Tue, 13 Nov 2007 20:32:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E04295784;
	Tue, 13 Nov 2007 20:32:35 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711132027430.21255@xanadu.home> (Nicolas
	Pitre's message of "Tue, 13 Nov 2007 20:28:59 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64941>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 14 Nov 2007, Alex Riesen wrote:
> ...
>> oh, you should be looking for usage.c, the function report (it is
>> called by default die handler). The old code used to fputs("fatal:"),
>> the new just vfprintf's everything, so the write should look like:
>> 
>>     write(2, "fatal: cannot pread pack file: No such "...
>
> This is not included in 1.5.3.5 though.

True; although I did not think it was risky at all, I did not
think that was serious enough change.
