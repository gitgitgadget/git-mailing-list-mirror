From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log -g --reverse horribly insane
Date: Sun, 19 Aug 2007 02:09:52 -0700
Message-ID: <7v8x87dh5r.fsf@gitster.siamese.dyndns.org>
References: <20070819085624.GU27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 11:10:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMgnY-0002r9-1O
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 11:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbXHSJKE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXHSJKB
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 05:10:01 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbXHSJKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 05:10:01 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 58418124225;
	Sun, 19 Aug 2007 05:10:17 -0400 (EDT)
In-Reply-To: <20070819085624.GU27913@spearce.org> (Shawn O. Pearce's message
	of "Sun, 19 Aug 2007 04:56:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56126>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> OK, I'm just too tired to find this on my own right now.  I'll try
> again later after I get some sleep, but maybe someone with a
> different sleeping pattern than me will find and fix this before
> I arise...
>
>   git log -g --reverse --pretty=oneline

I would have to say that "-g" support was hacked into the normal
revision traversal machinery in such a way to minimize the
amount of changes, without refactoring the two completely
different traversal machineries separate to make the resulting
code maintainable.  Ideal refactoring would require quite a lot
of changes, unfortunately.  I would say it probably would make
sense to make the two options incompatible for now.
