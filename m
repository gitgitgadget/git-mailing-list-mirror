From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 12:31:28 -0800
Message-ID: <7v7i3ym3tr.fsf@gitster.siamese.dyndns.org>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil> <slrngp21uj.i22.sitaramc@sitaramc.homelinux.net> <1234295272.10335.26.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzI0-0006Wa-My
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbZBJUbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbZBJUbh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:31:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbZBJUbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:31:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 55B4A98686;
	Tue, 10 Feb 2009 15:31:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D307298684; Tue,
 10 Feb 2009 15:31:30 -0500 (EST)
In-Reply-To: <1234295272.10335.26.camel@ld0161-tx32> (Jon Loeliger's message
 of "Tue, 10 Feb 2009 13:47:52 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CF7C3014-F7B1-11DD-9B7D-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109303>

Jon Loeliger <jdl@freescale.com> writes:

> On Tue, 2009-02-10 at 04:51 +0000, Sitaram Chamarty wrote:
>
>> I use cross-branch stashes all the time.  Stash it here, go
>> there, and pop the stash.  I hope that does not change :-)
>
> Perhaps 'git checkout -m other_branch'?

Sure, or even "git checkout other_branch" without -m.

"Stash it here, go there, and pop the stash" is what you would use when
you have many changes that you _know_ "checkout -m" will run a 3-way merge
to produce a heavy conflict, and you suspect you may need to be able to
retry the unstashing after taking a break.

If you are lucky and manage to resolve the conflicts easily (or did not
even get conflicts when applying), then pop will drop the stash and you
have everything you want in your index and the work tree.  Otherwise, your
work tree would be a mess, and you may have to "reset --hard" out to start
from scratch, but then the stash will still be there.
