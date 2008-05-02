From: Junio C Hamano <gitster@pobox.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 19:38:38 -0700
Message-ID: <7vtzhhxwep.fsf@gitster.siamese.dyndns.org>
References: <4819CF50.2020509@tikalk.com>
 <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com>
 <20080501152035.GB11145@sigill.intra.peff.net>
 <20080501203940.GA3524@mithlond.arda.local>
 <2e24e5b90805011906g769723f0g3ffbbe6588cf23d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Teemu Likonen" <tlikonen@iki.fi>, "Jeff King" <peff@peff.net>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Sitaram Chamarty" <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 04:40:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrlBm-0001aT-4N
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 04:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbYEBCiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 22:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbYEBCiy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 22:38:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbYEBCix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 22:38:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AC865610;
	Thu,  1 May 2008 22:38:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9284F560A; Thu,  1 May 2008 22:38:46 -0400 (EDT)
In-Reply-To: <2e24e5b90805011906g769723f0g3ffbbe6588cf23d0@mail.gmail.com>
 (Sitaram Chamarty's message of "Fri, 2 May 2008 07:36:18 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6E3AC56-17F0-11DD-B12C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80950>

"Sitaram Chamarty" <sitaramc@gmail.com> writes:

> On Fri, May 2, 2008 at 2:09 AM, Teemu Likonen <tlikonen@iki.fi> wrote:
>
>>  -M" didn't detect the rename but "git diff -M4" did. To me it looks like
>>  this works nicely, better than I expected, actually.
>
> err... I didn't realise -M had an option, and I just double checked
> the man pages for diff, diff-files, diff-index, and diff-tree.  What
> does the 4 mean?

The option to -M<num>, -C<num>, -B<num>/<num> are "raise or lower the
similarity threshold to <num> / 10^N" where N is the number of digits in
<num>.  IOW, you will always be expressing number between 0 and 1.

You should also be able to say -M40% but that is an ancient part of the
code base so I might be misremembering things.
