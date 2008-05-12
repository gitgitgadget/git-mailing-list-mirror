From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Mon, 12 May 2008 12:17:26 -0700
Message-ID: <7vve1jxrg9.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
 <alpine.DEB.1.00.0805060954470.30431@racer>
 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
 <alpine.DEB.1.00.0805071223450.30431@racer>
 <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
 <20080508103436.GB3300@mithlond.arda.local>
 <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com>
 <46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com>
 <7vod7c6c24.fsf@gitster.siamese.dyndns.org>
 <46dff0320805120931u7609a5a2x5433d78e35a62c48@mail.gmail.com>
 <m34p934afu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ping Yin" <pkufranky@gmail.com>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 21:18:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdXX-0001qY-PI
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 21:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYELTRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 15:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbYELTRh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 15:17:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbYELTRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 15:17:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D19258A1;
	Mon, 12 May 2008 15:17:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 98AFE581E; Mon, 12 May 2008 15:17:28 -0400 (EDT)
In-Reply-To: <m34p934afu.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 12 May 2008 11:57:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13481268-2058-11DD-9D0E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81912>

Jakub Narebski <jnareb@gmail.com> writes:

>> To achieve the best, we have to find the pairs of lines (one minus and
>> one plus for each pair) which most match each other, and then do the
>> word diff for each pair.
>
> Wouldn't be enough to treat run of plus/minus lines as a single block,
> tokenize, do token-based (as opposed to line-based) diff, then show it
> using linebreaks of the destination file (pluses line)?

I tried the "using linebreaks" but I discarded it because I did not think
it would work.  If we rewrite the last three lines above with this single
line:

> Wouldn't be enough to use magic?

and apply that algorithm between the two, then we would get a long single
line that has words painted in red, two lines worth, followed by green "to
use magic?"  and finally an end-of-line.
