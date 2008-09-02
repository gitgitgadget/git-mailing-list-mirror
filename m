From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Tue, 02 Sep 2008 10:47:47 -0700
Message-ID: <7v4p4ymocc.fsf@gitster.siamese.dyndns.org>
References: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu>
 <7vskskw41j.fsf@gitster.siamese.dyndns.org>
 <quack.20080901T0350.lthzlmsgmx6@roar.cs.berkeley.edu>
 <7vy72bnk5x.fsf_-_@gitster.siamese.dyndns.org>
 <quack.20080902T1039.lthabeqmopo_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaa08-0000Yo-Bf
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 19:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbYIBRsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 13:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYIBRsA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 13:48:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbYIBRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 13:47:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C3F6871B3A;
	Tue,  2 Sep 2008 13:47:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B511D71B39; Tue,  2 Sep 2008 13:47:54 -0400 (EDT)
In-Reply-To: <quack.20080902T1039.lthabeqmopo_-_@roar.cs.berkeley.edu> (Karl
 Chen's message of "Tue, 02 Sep 2008 10:39:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 47457A02-7917-11DD-B5CE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94684>

Karl Chen <quarl@cs.berkeley.edu> writes:

> If anyone actually used the old behavior of ignoring
> diff.autorefreshindex (as an optimization, because the script ran
> update-index --refresh outside a loop), there could be a --quick
> option, or they could use git-diff-files.

No, that actually is a wrong attitude.

If somebody's depending on the behaviour, it is this new behaviour of
doing everything asked without shortcut that needs to become a new
option.

What tempted me to suggest the simpler and potentially slower approach was
my hunch that no sane people depended on the old behaviour.
