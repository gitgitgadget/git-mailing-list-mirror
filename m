From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Move the file read logic to read_patch_file() in builtin-apply.c
Date: Sun, 09 Dec 2007 10:27:01 -0800
Message-ID: <7v7ijnpvuy.fsf@gitster.siamese.dyndns.org>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197219900-19334-2-git-send-email-mh@glandium.org>
	<1197219900-19334-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:27:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1QsH-0005sC-Kl
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbXLIS1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXLIS1N
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:27:13 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbXLIS1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:27:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ECDD45EE4;
	Sun,  9 Dec 2007 13:27:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9368C5EE3;
	Sun,  9 Dec 2007 13:27:03 -0500 (EST)
In-Reply-To: <1197219900-19334-3-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Sun, 9 Dec 2007 18:04:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67647>

Mike Hommey <mh@glandium.org> writes:

> This will allow to extend the read logic further. We also return a better
> error message than usage() when the given filename can't be opened, and
> avoid whitespace options not being set when reading from stdin with the
> "-" argument as a side effect.

I think this is a good clean-up, but I suspect that apply_patch() should
be further refactored to take strbuf, instead of <fd, filename>
(original) or <filename> (yours).
