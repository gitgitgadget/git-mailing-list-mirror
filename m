From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix an unitialized pointer in merge-recursive.c
Date: Thu, 16 Aug 2007 01:30:25 -0700
Message-ID: <7vk5rvkhjy.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550708160100t5aa93430x6cbe83e6e7a61d73@mail.gmail.com>
	<7vsl6jkila.fsf@gitster.siamese.dyndns.org>
	<e5bfff550708160111n66b5ea94k26cf2fecc06fd84c@mail.gmail.com>
	<7vodh7khuo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILakm-0006rH-RX
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbXHPIah (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXHPIag
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:30:36 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbXHPIad (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:30:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BBE6120853;
	Thu, 16 Aug 2007 04:30:51 -0400 (EDT)
In-Reply-To: <7vodh7khuo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 Aug 2007 01:23:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55992>

Junio C Hamano <gitster@pobox.com> writes:

> Third option.  Change the assignment from "mrtree = NULL" to
> "mrtree = mtree".  It is a standard idiom to work around stupid
> gcc warnings.

Oops; it might be obvious but that's "mrtree = mrtree".
