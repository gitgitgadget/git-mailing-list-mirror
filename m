From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Article about "git bisect run" on LWN
Date: Sat, 07 Feb 2009 10:16:27 -0800
Message-ID: <7vskmqw1s4.fsf@gitster.siamese.dyndns.org>
References: <200902050747.50100.chriscool@tuxfamily.org>
 <20090205141336.GA28443@elte.hu> <200902060623.16046.chriscool@tuxfamily.org>
 <200902070541.29955.chriscool@tuxfamily.org>
 <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 19:18:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVrks-0006DO-3N
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 19:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbZBGSQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 13:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbZBGSQq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 13:16:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbZBGSQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 13:16:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DFD4972CE;
	Sat,  7 Feb 2009 13:16:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 553B8972C7; Sat,
  7 Feb 2009 13:16:30 -0500 (EST)
In-Reply-To: <ee77f5c20902070455h360d8476re76294735673b4ca@mail.gmail.com>
 (David Symonds's message of "Sat, 7 Feb 2009 23:55:34 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7918DC56-F543-11DD-A021-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108872>

David Symonds <dsymonds@gmail.com> writes:

> On Sat, Feb 7, 2009 at 3:41 PM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>
>> It might be useful to have a list of always good commits too, and use it
>> like this:
>>
>> $ git bisect start <bad> <good> $(cat always_good.txt)
>> $ git bisect skip $(cat always_skipped.txt)
>> $ git bisect run ./my_test_script.sh
>
> Your test script could just do this at its start instead:
>
>   if cat always_good.txt | grep $(rev-parse HEAD); then
>     exit 0
>   elif cat always_skipped.txt | grep $(rev-parse HEAD); then
>     exit 125
>   fi

Don't cat a file into grep, please.
