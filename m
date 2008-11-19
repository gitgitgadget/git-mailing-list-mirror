From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Wed, 19 Nov 2008 05:22:07 -0800
Message-ID: <7vd4grsveo.fsf@gitster.siamese.dyndns.org>
References: <20081118211237.234d8035@crow>
 <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
 <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
 <20081119095452.3018d2de@crow>
 <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2n2C-0002z7-QK
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYKSNWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYKSNWm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:22:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYKSNWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:22:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59B6A17091;
	Wed, 19 Nov 2008 08:22:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 60751170B8; Wed,
 19 Nov 2008 08:22:09 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 19 Nov 2008 12:27:45 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 235D0E12-B63D-11DD-A574-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101340>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 19 Nov 2008, Mark Burton wrote:
>
>> Having said that, I still like the concept of being able to add named 
>> files without touching the index.
>
> That's just impossible.  You cannot create a tree object, let alone a 
> commit object, without touching the index (AKA staging area).

I do not think Mark really _means_ "not in the index".

The wish is more like "I want to let git know that I am interested in this
path, but I'm not ready to say what exact content I want for that path in
the next commit, not just yet".

I do not think that is an unreasonable wish.  On the other hand, it is
unreasonable for anybody to insist that we satisfy the wish without
touching the index.  The index is the most natural place to do that.

We have a half (probably a quarter) of what we need for that implemented
already, by the way.
