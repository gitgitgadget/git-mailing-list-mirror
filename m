From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --diff-filter=T does not list x changes
Date: Thu, 16 Oct 2008 19:00:13 -0700
Message-ID: <7vhc7cq8uq.fsf@gitster.siamese.dyndns.org>
References: <871vyhbsys.fsf@cup.kalibalik.dk>
 <20081016102201.GB20762@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 04:01:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqeen-0007g1-DJ
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 04:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYJQCAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 22:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbYJQCAY
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 22:00:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbYJQCAX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 22:00:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 737F76F63D;
	Thu, 16 Oct 2008 22:00:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43BBA6F639; Thu, 16 Oct 2008 22:00:15 -0400 (EDT)
In-Reply-To: <20081016102201.GB20762@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 16 Oct 2008 06:22:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B70EB6A-9BEF-11DD-925E-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98441>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 15, 2008 at 08:42:35PM +0200, Anders Melchiorsen wrote:
>
>> From documentation, I would expect --diff-filter to list changes in
>> the execute bit, but it does not. I hear on #git that this is
>> intended, though I still do not know how to filter on the execute bit.
>> Is it impossible?
>
> Looking at the code, I think it's impossible, and one would have to add
> a new --diff-filter letter. However, at the very least, the
> documentation should clarify this situation. The --diff-filter
> explanation says:
>
>   Select only files [...] have their type (mode) changed (T) [...]
>
> which to me indicates that your test case should work. 

That documentation is quite loosely written.  Typechange diff is what T
has always meant, and it never was about the executable bit.  The word
"mode" in that sentence only means the upper bits S_IFREG/S_IFLNK (iow,
masked by S_IFMT).
