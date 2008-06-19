From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
 routine
Date: Wed, 18 Jun 2008 17:32:24 -0700
Message-ID: <7vzlpiw9gn.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org>
 <20080618224919.GA22599@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org>
 <20080618231316.GB23053@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org>
 <20080619000842.GA25117@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:33:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K985k-0006WH-7r
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbYFSAch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756786AbYFSAch
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:32:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703AbYFSAcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 20:32:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 36FE924F41;
	Wed, 18 Jun 2008 20:32:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 19ADE24F40; Wed, 18 Jun 2008 20:32:28 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806181721580.2907@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 18 Jun 2008 17:23:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35C013D4-3D97-11DD-AF7D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85435>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 18 Jun 2008, Jeff King wrote:
>> 
>> Have you read "man git-config" lately?
>
> That whole program is there just for scripting. Of _course_ it talks about 
> the machine format!
>
> Nobody should ever use "git-config" normally. You should fire up your 
> editor and just edit the damn file in place. But no, we don't have a 
> man-page for that.

I was asked to proofread a git book somebody is starting to write, and the
first thing the book taught was to use "config user.name".

I gave a suggestion that we should not teach config as the first thing but
instead we should show editing the $HOME/.gitconfig file manually, to give
the feeling that what git deals with is approachable, but I realize the
suggestion is not convincing when our own Documentation/gittutorial.txt
does it fairly early in it, too.
