From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-tag -s must fail if gpg is broken and cannot sign tags
Date: Wed, 05 Sep 2007 23:20:14 -0700
Message-ID: <7vd4wwe2n5.fsf@gitster.siamese.dyndns.org>
References: <20070906042115.GA343@spearce.org>
	<20070906042653.GQ18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAj5-00036b-5n
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080AbXIFGUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757242AbXIFGUW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:20:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757080AbXIFGUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:20:22 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A1C3C12EED6;
	Thu,  6 Sep 2007 02:20:39 -0400 (EDT)
In-Reply-To: <20070906042653.GQ18160@spearce.org> (Shawn O. Pearce's message
	of "Thu, 6 Sep 2007 00:26:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57831>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> If the user has misconfigured `user.signingkey` in their .git/config
>> or just doesn't have any secret keys on their keyring and they ask
>> for a signed tag with `git tag -s` we better make sure the resulting
>> tag was actually signed by gpg.
> ...
>>  I think this and my prior contrib/workdir patch should both go into
>>  maint.  This one in particular; it hurt us today when an automated
>>  tool that runs `git tag -s` didn't notice the GnuPG problems.
>
> I'm sorry, despite the subject of this email this is actually a
> *one* patch series.  The 2/2 is because I applied and tested this
> on top of the contrib/workdir patch I was talking about above and
> my email sending script thought it was a two patch series.

This seems to fail the test depending on the order processes
happen to be scheduled.  I haven't looked at it closely yet.
