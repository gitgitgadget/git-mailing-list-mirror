From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
 unknown command
Date: Sat, 07 Jun 2008 11:08:00 -0700
Message-ID: <7vmylxnmnz.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
 <20080607072721.GA3347@steel.home> <alpine.DEB.1.00.0806071603470.1783@racer>
 <20080607175103.GA5822@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 20:09:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K52qr-00006L-3O
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 20:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761423AbYFGSIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 14:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763017AbYFGSIN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 14:08:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761146AbYFGSIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 14:08:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F91C57DD;
	Sat,  7 Jun 2008 14:08:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 859E357DC; Sat,  7 Jun 2008 14:08:03 -0400 (EDT)
In-Reply-To: <20080607175103.GA5822@steel.home> (Alex Riesen's message of
 "Sat, 7 Jun 2008 19:51:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF7E8DE2-34BC-11DD-9CDD-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84222>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Sat, Jun 07, 2008 17:04:14 +0200:
>> -	for (i = 0; i < main_cmds.cnt; i++) {
>> +	for (i = 0; i < main_cmds.cnt && i < 5; i++) {
>
> I accidentally considered "i" just the index in the global command
> table. Of course it is better :)

That confusion however shows how hacky the approach to clobber the
main_cmds global table by stuffing other things in it and sorting, without
saying "who cares, we will exit after we are done with this processing
anyway".  If this patch were for inclusion, such a comment should be there
immediately before it starts to muck with the command table.
