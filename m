From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 10:24:05 -0700
Message-ID: <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
References: <483AC2CE.7090801@gmail.com>
 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
 <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1POf-0005cT-9y
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 19:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYE1RYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 13:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbYE1RYR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 13:24:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbYE1RYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 13:24:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E015D46FA;
	Wed, 28 May 2008 13:24:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 06AF646F8; Wed, 28 May 2008 13:24:08 -0400 (EDT)
In-Reply-To: <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 28 May 2008 12:33:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E5B0DEA4-2CDA-11DD-B5FE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83115>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> As an unhappy Windows user myself (sometimes), I think it might be
> better to simply fix git to *survive* failing to create files like
> 'nul' on Win32, rather than trying to *fix* such files in the repo.
> It sounds (from the original post) like git has a *fatal* error
> ("cannot be checked out on cygwin") when trying to create 'nul'.

Please learn to think before typing, let alone sending such a message to
waste other people's time.

We give the user an error message, and signal error by exiting with
non-zero.  You cannot have that path on the system, and we are being
honest about it.  It is not like we are suddenly painting the screen in
blue and refusing to get any more user input when you try to check out
such a tree.  Which part of that is _not_ surviving?

The system with a *fatal* error is not git but the one that does not want
an not-so-unreasonable name "NUL" on it.  Git survives on such a system
and tells you what happened --- you cannot do certain things, such as
checking out such a tree.  You live with it, or get a better system ;-)

What alternatives do you want to implement?  Certainly not silently
creating "nul-garbage" file instead and pretend that nothing bad happened,
as that would lead to madness.
