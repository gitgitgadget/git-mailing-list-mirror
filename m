From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: --force is quiet about new tags
Date: Tue, 12 Mar 2013 20:33:43 -0700
Message-ID: <7vy5ds3re0.fsf@alter.siamese.dyndns.org>
References: <1363130021-28624-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 04:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFcSC-0002Zr-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 04:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800Ab3CMDdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 23:33:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065Ab3CMDdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 23:33:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35862B306;
	Tue, 12 Mar 2013 23:33:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=51ZJduD1icFOFNy+dtz3/yv+Xs0=; b=f8FFsd
	GxbODqjWPDfnHX/CaaILJcXkL/8rfTiv05SsDNWg0J7XCCiGgD6RxKGaaHPPRUub
	AL4DMLVlV+Wk2f7cEniqFXFZLDACyya81avdyCODbSXtzV3X03FIX7pRhQw2z/uy
	oXB+8EN/1AjSGc27JuvmMChN7J/92SRyBJkZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OSrzw+3MqBgvkna5E4Mu2e1ojdAkZP1l
	uk5AGWQI6VoYst4qgei8YWBBp+JPqJRbHQj9GRU2ChdBCTJWM8A71IGKMc6XyEDr
	dspvkOhGFpM4VTI11pp5/E0J9+jtmPqWaGKH3kBXUUOj3KcpXNXWSZEv1LEdK4Fx
	2Fj2nR6UfAQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29743B304;
	Tue, 12 Mar 2013 23:33:46 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 875E9B302; Tue, 12 Mar 2013
 23:33:45 -0400 (EDT)
In-Reply-To: <1363130021-28624-1-git-send-email-hordp@cisco.com> (Phil Hord's
 message of "Tue, 12 Mar 2013 19:13:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF649C9A-8B8E-11E2-A090-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218028>

Phil Hord <hordp@cisco.com> writes:

> git tag --force is used to replace an existing tag with
> a new reference.  Git helpfully tells the user the old
> ref when this happens.  But if the tag name is new and does
> not exist, git tells the user the old ref anyway (000000).
>
> Teach git to ignore --force if the tag is new.  Add a test
> for this and also to ensure --force can replace tags at all.
>
> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---

I think we would still want to allow the operation to go through,
even when the --force option is given, to create a new tag.  I agree
that the message should not say "Updated".  So teaching Git not to
issue the "Updated" message makes perfect sense.  It is somewhat
misleading to say we are teaching Git to ignore the option, though.

Thanks.
