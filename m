From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] git-hash-object: Add --stdin-paths option
Date: Fri, 26 Oct 2007 14:00:47 -0700
Message-ID: <7vy7dpwpz4.fsf@gitster.siamese.dyndns.org>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
	<1193307927-3592-2-git-send-email-aroben@apple.com>
	<1193307927-3592-3-git-send-email-aroben@apple.com>
	<1193307927-3592-4-git-send-email-aroben@apple.com>
	<1193307927-3592-5-git-send-email-aroben@apple.com>
	<1193307927-3592-6-git-send-email-aroben@apple.com>
	<1193307927-3592-7-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 23:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlWIm-0000je-3O
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 23:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbXJZVAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 17:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXJZVAx
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 17:00:53 -0400
Received: from rune.pobox.com ([208.210.124.79]:52746 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbXJZVAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 17:00:52 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 0C4C8150A0A;
	Fri, 26 Oct 2007 17:01:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 80D3814E4CD;
	Fri, 26 Oct 2007 17:01:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62443>

Adam Roben <aroben@apple.com> writes:

> This allows multiple paths to be specified on stdin.

Ok.  List of paths is certainly a good thing to have.

In addition, if you are enhancing cat-file to spew chunked
output out, I suspect that there should be a mode of operation
for hash-object that eats that data format.  IOW, this pipe

	git-cat-file --batch <list-of-sha1 |
        git-hash-object --batch

should be an intuitive no-op, shouldn't it?
