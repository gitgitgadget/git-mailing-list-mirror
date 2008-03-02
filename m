From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git reset --abort not restoring the right commit
 under some conditions
Date: Sat, 01 Mar 2008 18:27:36 -0800
Message-ID: <7vmyphx3l3.fsf@gitster.siamese.dyndns.org>
References: <7vod9y4xcn.fsf@gitster.siamese.dyndns.org>
 <1204367534-28204-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 03:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVdwP-0003BO-8M
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 03:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbYCBC1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 21:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbYCBC1v
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 21:27:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbYCBC1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 21:27:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8AEF02E29;
	Sat,  1 Mar 2008 21:27:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E5E802E26; Sat,  1 Mar 2008 21:27:43 -0500 (EST)
In-Reply-To: <1204367534-28204-1-git-send-email-mh@glandium.org> (Mike
 Hommey's message of "Sat, 1 Mar 2008 11:32:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75715>

Mike Hommey <mh@glandium.org> writes:

> Previously, --abort would end by git resetting to ORIG_HEAD, but some
> commands, such as git reset --hard (which happened in git rebase --skip,
> but could just as well be typed by the user), modify ORIG_HEAD.
>
> Just use the orig-head we store in $dotest instead.

What happens if we are not using $dotest but .dotest?
