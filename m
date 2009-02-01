From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sun, 01 Feb 2009 15:56:38 -0800
Message-ID: <7vr62hr9s9.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0902012349360.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 02 01:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTmKv-0004iC-Mq
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 01:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbZBAX4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 18:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbZBAX4t
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 18:56:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZBAX4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 18:56:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CC30A2A406;
	Sun,  1 Feb 2009 18:56:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BDE032A405; Sun, 
 1 Feb 2009 18:56:39 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902012349360.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 1 Feb 2009 23:59:57 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB64A4B0-F0BB-11DD-864C-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108027>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> at the cost of annoying
>
> - a few oldtimers
> - now, instead of later

Nobody seems to have realized this, but suddenly changing the default to
refuse without giving people enough advance warning to adjust will hurt
not just the old-timers (a rough definition is people who are from the
kernel circle and have been using git since summer of 2005), but people
who picked up a recipe from various how-to web pages to push to a live
repository and updating the checkout that is otherwise never touched by
the humans with its post-update hook running "reset --hard".  Old timers
may be savvy enough to know what has changed and may be able to grudgingly
react, but what is your plans for these recipe following kids?

How many times do I have to repeat that it is much worse to break a
working setup of people without advance warning and sound transition
guidance than having a known breakage that users can be trained to avoid?

And realize that I am not saying we need to keep the known breakage
forever.

The only thing I am saying is that you need to have a smooth transition
plan for changing the default, and a mechanism to guide people in place.

I'll ignore you if you keep repeating "all it takes is for old timers to
flip a switch".  Such an argument shows that you didn't learn a thing
after the 1.6.0 fallout.
