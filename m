From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Fri, 11 Feb 2011 23:42:47 -0800
Message-ID: <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
References: <20110212070538.GA2459@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 08:43:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoA8K-0001bF-Ka
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 08:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab1BLHnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 02:43:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab1BLHm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 02:42:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5ED2D253A;
	Sat, 12 Feb 2011 02:43:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rG/Qwmv/jPyzU0npqNI5ouP5Ev4=; b=mqpXoF
	VU93trHKbFl8BJtUa+tHFACjHRM7xX5C4XG0FndDJ2oB9aPAlpKkJ2737GX8JW6l
	+9RJosD0GM1lmTkCl0SzvCbX+wX9P60mZ3o9PxG2l5T7XP3oyh0h+eF8lQv2VJZt
	fJFmA+FznzWh3EHMRq7igjJhZS5zsFshxU8hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VHj73tZuN7abXkgG5VRjDhi+jkj2bVIg
	MZOF/cwI+SImMP8rAXFDOZsbhYuq3CIMnog0erdcRi+H6TUcG2oIJ5bu6Q8x3s0f
	A9OjAnTl5uxrb/86vkaLu4o7x9txmkOl0zO2R9GrWtAwYZszWmvXfV0/deTtLjZP
	38/kwyEPBfM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EDAD2539;
	Sat, 12 Feb 2011 02:43:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D54B2538; Sat, 12 Feb 2011
 02:43:51 -0500 (EST)
In-Reply-To: <20110212070538.GA2459@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Feb 2011 02\:05\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D874F538-367B-11E0-BA0B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166596>

Jeff King <peff@peff.net> writes:

>   2. When leaving the detached state, notice that we have commits not
>      contained in any other ref and pop up an "are you sure you want to
>      lose these commits" dialog, with an option to create a branch. This
>      is something we considered and rejected for the CLI, but I wonder
>      if it makes more sense for git-gui.

Hmm, I don't recall the discussion on this for the CLI, but it intuitively
feels like a good thing to do, unless it incurs an unacceptable cost.
Temporarily detaching HEAD by scripts like rebase and am that know what
they are doing should never have to pay the penalty, but an expert user
who worked interactively on the detached HEAD can be made to wait for 0.2
second more.

Your 1 and 3 both sound like sensible things to do, but I am not a good
judge on them as I rarely if ever work in GUI.
