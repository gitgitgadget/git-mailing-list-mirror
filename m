From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink (Putty's ssh)
Date: Fri, 04 Jul 2008 02:18:36 -0700
Message-ID: <7vod5euhw3.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
 <1214987532-23640-5-git-send-email-prohaska@zib.de>
 <1214987532-23640-6-git-send-email-prohaska@zib.de>
 <200807022104.20146.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: prohaska@zib.de, msysGit <msysgit@googlegroups.com>,
	git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>
To: johannes.sixt@telecom.at
X-From: git-owner@vger.kernel.org Fri Jul 04 11:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhSK-0000dP-9Q
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890AbYGDJSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 05:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757856AbYGDJSx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 05:18:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757706AbYGDJSw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 05:18:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5271014D6B;
	Fri,  4 Jul 2008 05:18:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 97CC714D69; Fri,  4 Jul 2008 05:18:44 -0400 (EDT)
In-Reply-To: <200807022104.20146.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Wed, 2 Jul 2008 21:04:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 375F6036-49AA-11DD-96B5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <johannes.sixt@telecom.at> writes:

> What about installing a wrapper script, plinkssh, that does this:
>
> #!/bin/bash
>
> if test "$1" = -p; then
> 	port="-P $2"
> 	shift; shift
> fi
>
> exec plink $port "$@"
>
> and require plink users to set GIT_SSH=plinkssh?

That's quite a nice solution with absolute minimum impact.
