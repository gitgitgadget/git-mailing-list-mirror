From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Thu, 21 Aug 2008 21:59:01 -0700
Message-ID: <7vr68hejca.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
 <Pine.GSO.4.62.0808212304200.9108@harper.uchicago.edu>
 <alpine.LNX.1.00.0808220023170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@uchicago.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 07:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWOl3-0003YQ-TB
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 07:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbYHVE7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 00:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYHVE7L
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 00:59:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbYHVE7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 00:59:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 42D5662405;
	Fri, 22 Aug 2008 00:59:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 37B4762403; Fri, 22 Aug 2008 00:59:04 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808220023170.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 22 Aug 2008 00:34:13 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0DF60A8C-7007-11DD-A6AF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... these are actually distinguishable, IIRC, by whether the 
> mode bits are set or not, but current code doesn't check that.

IIRC, mode bits all zero means something different, so I do not think that
would fly.  If we really wanted to do this "intent-to-add" properly, we
probably should give one of the flag bits in the in-core index structure.
Unlike on-disk flag bits, they are not scarce resources anymore these
days.
