From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ship sample hooks with .sample suffix
Date: Tue, 24 Jun 2008 19:48:18 -0700
Message-ID: <7vod5q8c25.fsf@gitster.siamese.dyndns.org>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
 <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
 <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
 <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
 <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
 <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org>
 <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jun 25 04:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBL4k-0004HM-9w
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 04:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbYFYCsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 22:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYFYCsZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 22:48:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYFYCsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 22:48:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96C611689B;
	Tue, 24 Jun 2008 22:48:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E12F016898; Tue, 24 Jun 2008 22:48:20 -0400 (EDT)
In-Reply-To: <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Tue, 24 Jun 2008 19:09:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2DA53A2A-4261-11DD-95A2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86198>

I'll queue the patch to 'master' and I suspect that this will make 31d6632
(Windows: Change the name of hook scripts to make them not executable.,
2007-11-30) unnecessary.

I've looked at diff between ee1e0a3 (the original "pull" request) and
8fd39ba (after WS fixup on borrowed code and other changes).

They all looked fine except for git.c::main() where do .. while does not
have a { } around the body (which is not required by C language but it
just looked funny).

I am very tempted to pull MinGW series directly to 'master', or at least
to 'next', perhaps after dropping 31d6632.  What's your confidence level
on the series?  I think we should give this series extra priority so that
any potential issues with other series (like dr/ceil) that do pathname
traversal will become more apparent sooner rather than later.
