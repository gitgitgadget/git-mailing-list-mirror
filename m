From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
 everything up-to-date
Date: Wed, 20 Aug 2008 15:46:25 -0700
Message-ID: <7v4p5fnw3i.fsf@gitster.siamese.dyndns.org>
References: <1219263969579-736663.post@n2.nabble.com>
 <8585F10E-C33C-481E-B044-A7125F3316F2@web.de>
 <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com>
 <7vbpznpeup.fsf@gitster.siamese.dyndns.org>
 <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com>
 <alpine.LNX.1.00.0808201808400.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>,
	ir0s <imirene@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVwT4-0005Ey-Cd
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbYHTWqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbYHTWqh
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:46:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbYHTWqg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:46:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A78656543;
	Wed, 20 Aug 2008 18:46:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6BE9256541; Wed, 20 Aug 2008 18:46:28 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808201808400.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 20 Aug 2008 18:25:03 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7096B7A-6F09-11DD-A737-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93070>

Daniel Barkalow <barkalow@iabervon.org> writes:

> That is actually to say that fetch should do it (pull calls fetch for that 
> part), and I agree with that, assuming you've actually got that fetch 
> config, of course.

Hmm, traditionally, an explicit refspec on the command line that does not
store overrides the configured ones that do store, and I've been using it
as a feature when I run test fetches.  If I do not like fetched result, I
can tell the other guy to fix his history and I do not have to contaminate
the history my tracking ref points at.  IOW, I use my tracking refs not
just "this is where the guy is", but "this is the last good one I fetched
from that guy".

I could be persuaded to use reflog (e.g. "git diff his@{1}..his") and
manual tagging (i.e. "git tag -f last-good-his his") myself, but this is
"I'd _tolerate_ such a change myself", certainly not "I am happy with that
change and I'd help you guys advocate it and try convincing others who
shared my expectations to switch to reglog and manual tagging."
