From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Thu, 02 Feb 2012 17:02:17 -0800
Message-ID: <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:02:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7Xl-0002rY-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab2BCBCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 20:02:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831Ab2BCBCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 20:02:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E46D6806;
	Thu,  2 Feb 2012 20:02:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWviZjm0oX0e5+dz0xCCiaa4AD4=; b=IIt6Tc
	I6PA5WQEVOXGbOvWAScyrYLc8HwTfCghsjka/wxrViBYkypYdE96cNk/dxtPB84s
	wxrz5anDex3TUKKSJcfY8j+vgUrPufi90krGwfcLpYiqT31BDHteVipTp6x9BrcY
	9jkjpQLDTWSsf1921fpPp8NLzZuJLhytIs8c0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udPVgwp+wyTka2h0W/6OtYDLc2nkLI+x
	VOszZG4Ml9uswlDQHhl+gumEWbt4SmQDJxlAeqzH9O915vRNyI20bcNHUstme0zY
	to5cvFe+7bH2qB6FE+bfl+b6FhuGfSftxoZ6eXrRBUbFKOoRHcMoldAD9R8aeJ0e
	JZjiF/nPcR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85D3D6805;
	Thu,  2 Feb 2012 20:02:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A90A6804; Thu,  2 Feb 2012
 20:02:19 -0500 (EST)
In-Reply-To: <20120202200240.GC9246@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 2 Feb 2012 15:02:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8904B10-4E02-11E1-859F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189726>

Jeff King <peff@peff.net> writes:

> I wonder if a better solution is to use a known-good shell instead of
> trying to work around problems in a bogus shell.

Yeah, I think that is a better approach.

What prevents us from doing 's|^#! */bin/sh|$#$SHELL_PATH|' on everything
in t/ directory (I am not suggesting to do this. I just want to know if
there is a reason we want hardcoded "#!/bin/sh" for some instances).
