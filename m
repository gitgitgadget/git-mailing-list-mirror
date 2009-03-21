From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] test-lib: Infrastructure to test and check for
 prerequisites
Date: Sat, 21 Mar 2009 16:16:44 -0700
Message-ID: <7vmybebh5v.fsf@gitster.siamese.dyndns.org>
References: <cover.1237667830.git.j6t@kdbg.org>
 <a7bb394037e1c32d47d0b04da025bdbe2eb78d66.1237667830.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlASK-0006Xw-ML
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbZCUXQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZCUXQw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:16:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCUXQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:16:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E4DEFA349D;
	Sat, 21 Mar 2009 19:16:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EA77CA349C; Sat,
 21 Mar 2009 19:16:46 -0400 (EDT)
In-Reply-To: <a7bb394037e1c32d47d0b04da025bdbe2eb78d66.1237667830.git.j6t@kdbg.org>
 (Johannes Sixt's message of "Sat, 21 Mar 2009 22:26:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B263454-166E-11DE-80E2-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114094>

Johannes Sixt <j6t@kdbg.org> writes:

> Some tests can be run only if a particular prerequisite is available. For
> example, some tests require that an UTF-8 locale is available. Here we
> introduce functions that are used in this way:
>
> 1. Insert code that checks whether the prerequisite is available. If it is,
>    call test_set_prereq with an arbitrary tag name that subsequently can be
>    used to check for the prerequisite:
>
>       case $LANG in
>       *.utf-8)
>             test_set_prereq UTF8
>             ;;
>       esac
>
> 2. In the calls to test_expect_success pass the tag name:
>
>       test_expect_success UTF8 '...description...' '...tests...'
>
> 3. There is an auxiliary predicate that can be used anywhere to test for
>    a prerequisite explicitly:
>
>       if test_have_prereq UTF8
>       then
>             ...code to be skipped if prerequisite is not available...
>       fi
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Very nicely done.  Thanks.
