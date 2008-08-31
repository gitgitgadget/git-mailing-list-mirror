From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: treat -crlf files as binary
Date: Sun, 31 Aug 2008 09:25:17 -0700
Message-ID: <7vej45b18y.fsf@gitster.siamese.dyndns.org>
References: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
 <32541b130808291456k3de953a2yd1e93bc27ad14293@mail.gmail.com>
 <7vljyefaps.fsf@gitster.siamese.dyndns.org>
 <81b0412b0808310216h6c349e1en740a1f4c7fef75e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org,
	arman@twinsun.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 18:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZpmb-00037W-Sj
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 18:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYHaQZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 12:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYHaQZ3
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 12:25:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYHaQZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 12:25:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 098AB547E8;
	Sun, 31 Aug 2008 12:25:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B813D547E5; Sun, 31 Aug 2008 12:25:20 -0400 (EDT)
In-Reply-To: <81b0412b0808310216h6c349e1en740a1f4c7fef75e6@mail.gmail.com>
 (Alex Riesen's message of "Sun, 31 Aug 2008 11:16:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B8EFE6E-7779-11DD-B8A2-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94490>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> 2008/8/30 Junio C Hamano <gitster@pobox.com>:
>> diff --git i/Documentation/gitattributes.txt w/Documentation/gitattributes.txt
>> ...
>> -       through line endings conversion upon checkin/checkout.
>> +       Unsetting the `crlf` attribute on a path is tells git
>> ...
>
> "+       Unsetting the `crlf` attribute on a path tells git"
>
> (remove "is" before "tells")

Yeah, thanks.  I reworded the sentence number of times and somehow crufts
were left behind.  Fixed, together with the double space before "upon",
before committing.

I am actually more surprised by the lack of any surprised comment about
the unadvertised presense of "binary" (pseudo)attribute, though.  The
support has been there since f48fd68 (attribute macro support,
2007-04-14), two days after introduction of gitattributes mechanism.

Maybe somebody should re-read the log message of that commit, and refine
the attribute macros sections the patch under discussion has added.

Somebody who can write and spell English better than me, that is ;-)
