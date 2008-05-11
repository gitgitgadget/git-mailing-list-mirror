From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Sun, 11 May 2008 09:27:31 -0700
Message-ID: <7vod7c6c24.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
 <alpine.DEB.1.00.0805060954470.30431@racer>
 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
 <alpine.DEB.1.00.0805071223450.30431@racer>
 <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
 <20080508103436.GB3300@mithlond.arda.local>
 <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com>
 <46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Teemu Likonen" <tlikonen@iki.fi>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEPh-0004Hk-Be
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbYEKQ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbYEKQ1s
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:27:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYEKQ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:27:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B78036AB;
	Sun, 11 May 2008 12:27:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D933936AA; Sun, 11 May 2008 12:27:34 -0400 (EDT)
In-Reply-To: <46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com>
 (Ping Yin's message of "Sun, 11 May 2008 21:16:11 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E1DA9C2-1F77-11DD-9FA5-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81790>

"Ping Yin" <pkufranky@gmail.com> writes:

> With following patch, the diff output becomes (i don't know which one is better)
>
> OpenOffice.org has {+a }user setting for defining the minimum length for
> words to be hyphenated. By default the word length is counted from the
> whole word - even for compound words. For example the {compound +}word
> 'elokuvalippu' is {+considered }12 characters long. The word will be hyphenated like
>  'elo-ku-va-lip-pu' in all cases when the minimum word length is set to
>  12 or less. If the minimum length is set to 13 or more the word is not
>  hyphenated at all.

Yeah, after playing with it a bit, I realize that my original stated goal
of not playing games with "newline suppression" goes very against what
color-words, which is a word oriented diff, tries to achieve.  It appears
that it is necessary to reintroduce suppressed_newline.
