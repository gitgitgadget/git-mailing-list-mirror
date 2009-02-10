From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 03:46:26 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp1u4h.i22.sitaramc@sitaramc.homelinux.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
 <7vr627qd4p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 04:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWjbZ-0003SA-Tx
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 04:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbZBJDqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 22:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZBJDqg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 22:46:36 -0500
Received: from main.gmane.org ([80.91.229.2]:47541 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236AbZBJDqg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 22:46:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWjZy-0002Aj-A8
	for git@vger.kernel.org; Tue, 10 Feb 2009 03:46:35 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 03:46:34 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 03:46:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109178>

On 2009-02-10, Junio C Hamano <gitster@pobox.com> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>
>> Adding git 'shortstatus --mini' to PS1 is not noticeable or 1sec
>> maximum in my tree. As a worst case it takes 10secs in a clone
>> of WebKit.git.
>
> Frankly, I think having to spend one second to add only one or two bits to
> PS1 is simply spending one second too much.

[snip]

> Do you really need more than "diff-index --cached --exit-code" in your
> $PS1 code, and so why?  Does the added feature your "shortstatus --mini"
> offers over "diff-index --cached --exit-code" justify the latency penalty
> to the user?

I wonder if I could ask people opinions on a trick I pulled,
which is basically maintain a state of the value of $SECONDS
each time the user is shown a bash prompt.  If the value is
the same as last time (meaning he hit enter twice in a row
very quickly), it runs the extra stuff.

It sounds like a dirty trick, but seems to work fine and
give you the best of both worlds.
