From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] Add tests for git hash-object
Date: Fri, 26 Oct 2007 14:00:06 -0700
Message-ID: <7v640ty4kp.fsf@gitster.siamese.dyndns.org>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
	<1193307927-3592-2-git-send-email-aroben@apple.com>
	<1193307927-3592-3-git-send-email-aroben@apple.com>
	<1193307927-3592-4-git-send-email-aroben@apple.com>
	<1193307927-3592-5-git-send-email-aroben@apple.com>
	<1193307927-3592-6-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 23:00:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlWIY-0000gS-SP
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 23:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939AbXJZVAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757450AbXJZVAO
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 17:00:14 -0400
Received: from rune.pobox.com ([208.210.124.79]:52718 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427AbXJZVAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 17:00:12 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 00504150A07;
	Fri, 26 Oct 2007 17:00:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 45C99150A09;
	Fri, 26 Oct 2007 17:00:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62442>

Adam Roben <aroben@apple.com> writes:

> +test_expect_success \
> +    'hash a file' \
> +    "test $hello_sha1 = \$(git hash-object hello)"
> +
> +test_expect_success \
> +    'hash from stdin' \
> +    "test $hello_sha1 = \$(echo '$hello_content' | git hash-object --stdin)"

Needs to make sure no object has been written to the object
database at this point?

> +test_expect_success \
> +    'hash a file and write to database' \
> +    "test $hello_sha1 = \$(git hash-object -w hello)"

... and make sure the objectis written here?

> +test_expect_success \
> +    'hash from stdin and write to database' \
> +    "test $hello_sha1 = \$(echo '$hello_content' | git hash-object -w --stdin)"
> +
> +test_done

... and/or here?
