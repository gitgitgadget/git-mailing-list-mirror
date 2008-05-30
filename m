From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-log vs git-rev-list
Date: Fri, 30 May 2008 13:28:18 -0700
Message-ID: <7v7idbk04d.fsf@gitster.siamese.dyndns.org>
References: <20080530165641.GG18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 22:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BE4-0002X0-2d
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYE3U2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYE3U2c
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:28:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbYE3U2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:28:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 51B462483;
	Fri, 30 May 2008 16:28:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A6B7C2482; Fri, 30 May 2008 16:28:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7768712-2E86-11DD-A3D3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83329>

Petr Baudis <pasky@suse.cz> writes:

>   I think that having two commands that by now do essentially the same
> thing, but slightly differently, is rather messy UI. Thus, I'm wondering
> if it would be worthwhile to make rev-list a thin git-log wrapper and
> start phasing it out?

Two answers and a half.

 (1) There are a few things git-log does not do but git-rev-list is
     designed to do.

 (2) They are _already_ thin wrappers to the same core "revision
     traversal" engine, and each of them does what it is meant to do well
     as specified.

 (3) rev-list is an established script interface.  You could enhance it if
     it does not fit your Porcelain needs, but you cannot break it, let
     alone phase it out.  What you can contribute is perhaps to document
     it better so that casual end users do not accidentally try to use
     rev-list as if it is the first class end-user interface and get
     confused.

I do not think there is much to be gained by further refactoring of the
implementations between the two.
