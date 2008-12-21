From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fast-import: add special '-' blob reference to use
 the previous one.
Date: Sun, 21 Dec 2008 14:24:55 -0800
Message-ID: <7vlju9kvyg.fsf@gitster.siamese.dyndns.org>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
 <1229825502-963-2-git-send-email-felipe.contreras@gmail.com>
 <20081221221149.GB17355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWkj-0000SR-8t
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbYLUWZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYLUWZG
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:25:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbYLUWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:25:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0DAB489492;
	Sun, 21 Dec 2008 17:25:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0752289491; Sun,
 21 Dec 2008 17:24:56 -0500 (EST)
In-Reply-To: <20081221221149.GB17355@spearce.org> (Shawn O. Pearce's message
 of "Sun, 21 Dec 2008 14:11:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 34F085A2-CFAE-11DD-B75B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103724>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Hmph, so if create a new path with a blob of "-" the repository
> will be corrupt because the zero id was used and error was produced.
>
> Actually I think you have the same bug in the prior patch with the
> mode being inherited.  I wonder if we shouldn't put error checking
> in too to validate that versions[0] describes a file entry.

Why are these patches necessary?

The proposed commit message describes what it does, but does not give hint
to even guess being able to use this new feature helps in what situation.
As far as I can see, these changes allow the exporter to say "this aspect
of the new data is the same as the previous one", but I thought that the
way in which fast-import works already revolves around "you have this
tree, and the next tree is different from it in this and that way."  Why
does one need be able to mention "this is the same as the previous one"
explicitly in the first place?
