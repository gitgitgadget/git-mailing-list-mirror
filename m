From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: reset: describe new "--keep" option
Date: Mon, 08 Mar 2010 00:31:49 -0800
Message-ID: <7v3a0b1afe.fsf@alter.siamese.dyndns.org>
References: <20100305202537.25469.73470.chriscool@tuxfamily.org>
 <20100306081034.GA4827@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 08 09:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoYNu-0000mL-Ar
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 09:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab0CHIcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 03:32:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0CHIcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 03:32:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87C74A0559;
	Mon,  8 Mar 2010 03:32:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YSl5NcLIMu8TCDajwfhnImJgdqk=; b=Fz/8H74f+GWZ7mmfA+QHSdr
	iuCDqh77VrISs9ADSAoY/lWUpfC6ScrDBiDMPF3HSQ0tNFEgoLm9Qp6+KMB/Hik6
	bnsAqXhwaT3rgIkb15nbX7hvxWa/XOV91M4wg61OgalIgCydtaLL/wunk1VU0Jt2
	VYKu9Gw311f3fV/MosCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nk38zL6NxRqrIP9y0iqdJZwwltyqHP+XpmQV9x7bxPAK73PhK
	DRRwzDPFQspMeoyFMVjSHey70pFDmlmkMR7f4+vfxhMoYNCb5V6m9LALXvBy94xP
	bZ1p4GkXFdlIS9s2ofcIYC1uRGPgulai+Jkkm6bRlTTC7rtURzyTi/rggc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07FE6A0558;
	Mon,  8 Mar 2010 03:32:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E303CA0551; Mon,  8 Mar
 2010 03:31:50 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 108068FA-2A8D-11DF-9D14-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141753>

Peter Baumann <waste.manager@gmx.de> writes:

> On Fri, Mar 05, 2010 at 09:25:36PM +0100, Christian Couder wrote:
>> and give an example to show how it can be used.
>> 
>> +--keep::
>> +	Resets the index to match the tree recorded by the named commit,
>> +	but keep changes in the working tree. Aborts if the reset would
>> +	change files that are already modified in the working tree.
>> +
>  
> Huh? Keep changes (by not touching the worktree) and then aborting if we
> touch the worktree. Seems like a contradiction to me.

Here is my try...

    Reset the index to the given commit, keeping local changes in the working
    tree since the current commit, while updating working tree files without
    local changes to what appears in the given commit.  If a file that is
    different between the current commit and the given commit has local
    changes, reset is aborted.
