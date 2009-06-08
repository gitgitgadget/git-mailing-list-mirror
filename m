From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] add a test for git-send-email for non-threaded mails
Date: Mon, 08 Jun 2009 00:00:44 -0700
Message-ID: <7vd49f8b1f.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-5-git-send-email-markus.heidelberg@web.de>
	<200906080842.00357.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Jun 08 09:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDYqn-0000Gb-3L
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 09:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbZFHHAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 03:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbZFHHAo
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 03:00:44 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56329 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZFHHAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 03:00:43 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608070045.YAXY17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Mon, 8 Jun 2009 03:00:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1K0k1c00D4aMwMQ04K0lnr; Mon, 08 Jun 2009 03:00:45 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=f0elGUVxMZEA:10 a=TBlpmPEDYsQA:10
 a=Jkve4GVq4QWiPLraAiUA:9 a=RynI8F7koONsQFIlbvGRw8MwbokA:4 a=5KVauyKsRKMA:10
X-CM-Score: 0.00
In-Reply-To: <200906080842.00357.markus.heidelberg@web.de> (Markus Heidelberg's message of "Mon\, 8 Jun 2009 08\:41\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121040>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>
> Differences to v1:
> * dump stdout into a file and grep this
> * use "test_must_fail grep" instead of "!git send-email"
>   I'm not sure about this. When should test_must_fail be used and when
>   is !command OK?

Thanks.

Generally, we protect "git" (i.e. what we write ourselves) with test_must_fail
so that we can catch stupid segfaulting crash we introduce ourselves
(unlike "! git foo", "test_must_fail git foo" says "oh, no, it did not
correctly fail" if git segfaults).  We do not expect "grep" to segfault
(iow we are not testing "grep"), so it is customary to say "! grep".
