From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: fix subtree merge
Date: Sat, 30 Aug 2008 10:55:24 -0700
Message-ID: <7vabeuie0j.fsf@gitster.siamese.dyndns.org>
References: <1220110929-6803-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 19:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUgg-0006o2-On
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYH3Rzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbYH3Rzb
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:55:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYH3Rza (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:55:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 20A415AE4C;
	Sat, 30 Aug 2008 13:55:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 842D05AE4B; Sat, 30 Aug 2008 13:55:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5A41234-76BC-11DD-8203-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94396>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Mon, Aug 25, 2008 at 04:25:57PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> It also takes care of subtree merge, output buffering, verbosity, and
>> rename limits - these were global variables till now in
>> merge-recursive.c.
>
> Actually subtree_merge was not used from the struct merge_options, here
> is the fix.

This makes me wonder why we didn't see any breakages in the existing
tests.
