From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Sun, 02 Dec 2007 18:19:23 -0800
Message-ID: <7vhcj0seok.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Anatol Pomozov" <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz0uT-0007gK-F9
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXLCCTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXLCCT3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:19:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60688 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbXLCCT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:19:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A52452F2;
	Sun,  2 Dec 2007 21:19:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FA619C1F5;
	Sun,  2 Dec 2007 21:19:48 -0500 (EST)
In-Reply-To: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
	(Anatol Pomozov's message of "Sun, 2 Dec 2007 16:52:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66845>

"Anatol Pomozov" <anatol.pomozov@gmail.com> writes:

> I just start learning git and I found a bug (but sorry if the
> functionality I am trying to blame as a bug not actually bug and it
> was made by intention)

I think it is rather a sloppy error checking than a bug.  It should be
throwing a stone back at you when you feed it a full path, or converting
it back to work tree relative path before using.
