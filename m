From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
 16:24:51}'
Date: Tue, 19 Aug 2008 16:57:46 -0700
Message-ID: <7vskt0woat.fsf@gitster.siamese.dyndns.org>
References: <20080819234433.GJ24212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVb6G-0004sw-Nv
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 01:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbYHSX5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 19:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbYHSX5x
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 19:57:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYHSX5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 19:57:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 45B2B54626;
	Tue, 19 Aug 2008 19:57:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A7E9F54624; Tue, 19 Aug 2008 19:57:48 -0400 (EDT)
In-Reply-To: <20080819234433.GJ24212@spearce.org> (Shawn O. Pearce's message
 of "Tue, 19 Aug 2008 16:44:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A1D56234-6E4A-11DD-B978-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92940>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The value 1112911993 was chosen for the limit as it is the commit
> timestamp for e83c516331 "Initial revision of "git" ...". Any
> reflogs in existance should contain timestamps dated later than
> the date Linus first stored Git into itself, as reflogs came about
> quite a bit after that.
>
> Additionally a reflog with 1,112,911,993 record entries is also
> simply not valid.  Such a reflog would require at least 87 TB to
> store just the old and new SHA-1 values.  So our randomly chosen
> upper limit for @{nth} notation is "big enough" that users will
> not run into it by accident.

Hmm, would we want to apply that logic to replace the magic "8-digit" rule
in date.c::match_digit()?
