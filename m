From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] builtin-help: make it possible to exclude some
 commands in list_commands()
Date: Tue, 29 Jul 2008 12:46:59 -0700
Message-ID: <7vabg0eamk.fsf@gitster.siamese.dyndns.org>
References: <cover.1217344802.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217344803.git.vmiklos@frugalware.org> <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217344803.git.vmiklos@frugalware.org> <5ad105819efb1c905bd01db3d08eb3422d283b3b.1217344803.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNvBD-0005tA-W7
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYG2TrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYG2TrI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:47:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYG2TrG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:47:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7DF842803;
	Tue, 29 Jul 2008 15:47:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3FB4442802; Tue, 29 Jul 2008 15:47:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1ECE5ACA-5DA7-11DD-9023-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90674>

Miklos Vajna <vmiklos@frugalware.org> writes:

> The supposed method is to build a list of commands to be excluded using
> add_cmdname(), then pass the list as the new exclude parameter. If no
> exclude is needed, NULL should be used.

You require that exclude is a sorted list; this should be documented
somewhere to avoid future misuses.

There is no need for adding extra qsort() anywhere in the patchset because
the only user you are adding is in the next patch that sends a subset of
the commands in main_cmds in the order they are found in the list, and
main_cmds is already sorted.
