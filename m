From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Mon, 01 Sep 2008 21:53:46 -0700
Message-ID: <7vfxojrvvp.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
 <20080901223802.GK7482@spearce.org>
 <94a0d4530809011552h59e476e0q9033f0b917288a8f@mail.gmail.com>
 <20080902043951.GB13248@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 06:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaNwG-0006Y9-Fp
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 06:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbYIBExy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 00:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbYIBExy
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 00:53:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbYIBExx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 00:53:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 58E9652A23;
	Tue,  2 Sep 2008 00:53:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9B44952A22; Tue,  2 Sep 2008 00:53:48 -0400 (EDT)
In-Reply-To: <20080902043951.GB13248@spearce.org> (Shawn O. Pearce's message
 of "Mon, 1 Sep 2008 21:39:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23A19FE8-78AB-11DD-81D7-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94645>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> OK, that argument makes sense.  Then I wonder if more specific
> error ignoring would be better:
>
>   --ignore-error=already-deleted
>   --ignore-error=already-deleted,missing-mark,missing-copy-source
>
> I'm not really fond of turning an existing error condition that
> exists to catch broken frontends into a generic tolerant flag.
> But being able to selectively turn it off while leaving other
> errors as errors isn't entirely unreasonable.

I think selective loosening of consistency check makes sense very much,
but I have been wondering if these should be command line options.

The only example we saw so far is about output from one exporter.  Perhaps
it should be given to fast-import as initial set of commands ("#pragma"!)
that describes the nature of the input file?
