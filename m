From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Speedup scanning for excluded files.
Date: Mon, 29 Oct 2007 15:17:52 -0700
Message-ID: <7v8x5ltvjj.fsf@gitster.siamese.dyndns.org>
References: <200710290845.26727.lars@trolltech.com>
	<20071029080234.GA22826@artemis.corp>
	<200710290959.32538.lars@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Lars Knoll <lars@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:19:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imcwf-00031f-U7
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 23:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbXJ2WSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 18:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbXJ2WSF
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 18:18:05 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:48523 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbXJ2WSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 18:18:03 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 104A52F0;
	Mon, 29 Oct 2007 18:18:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9787090071;
	Mon, 29 Oct 2007 18:18:19 -0400 (EDT)
In-Reply-To: <200710290959.32538.lars@trolltech.com> (Lars Knoll's message of
	"Mon, 29 Oct 2007 10:59:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62628>

Thanks.  This looks obviously correct and tempts me to apply
directly to 'master'.

There are similar logic on the gitattributes side (attr.c) which
might benefit from such an optimization as well.  In the longer
run, we might even want to introduce 'ignored' attribute to the
gitattributes mechanism and make the unified result to supersede
gitignore.
