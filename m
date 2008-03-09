From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remotes order in "git remote update"
Date: Sun, 09 Mar 2008 03:38:26 -0700
Message-ID: <7vbq5op4gt.fsf@gitster.siamese.dyndns.org>
References: <2008-03-09-11-22-34+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sun Mar 09 11:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYIwP-0002I1-1i
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYCIKii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 06:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbYCIKii
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 06:38:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYCIKii (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 06:38:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6035C2263;
	Sun,  9 Mar 2008 06:38:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DBF862262; Sun,  9 Mar 2008 06:38:33 -0400 (EDT)
In-Reply-To: <2008-03-09-11-22-34+trackit+sam@rfc1149.net> (Samuel Tardieu's
 message of "Sun, 09 Mar 2008 11:22:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76648>

Samuel Tardieu <sam@rfc1149.net> writes:

> It looks like remote repositories are ordered alphabetically by their
> local names when doing a "git remote update".

Yeah, it is an unfortunate consequence of the Perl implementation that
uses a hash to record remote and then try to give a stable ordering by
sorting keys.  The command originally was never intended for working on
more than one remote, but addition of "remote update" could have been done
to follow the order in the configuration.

I think the reimplementaiton in 'next' that will hopefully be in 1.5.5
will keep the list of remotes in the order read from the config.


