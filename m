From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/15] Add new simplified git-remote-testgit
Date: Wed, 21 Nov 2012 10:26:37 -0800
Message-ID: <7vboeq3h0t.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFlF-0004bT-2x
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab2KUTOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755764Ab2KUTO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76AE964C;
	Wed, 21 Nov 2012 14:14:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=zYwT/tnYNXnT3rMzMM9y1GIskS0=; b=Njmj8s/2BBCCXhS3b6Tx
	k1D6J4F05NnYAtcm4+R6xDZK+PqJ4oo69N6/p11AHbzKu/3wWdFYnq4NWRO3UQIP
	WMWqc+pZUzv/Ro5BYgl4L4H/mmRFyQNI8BsUKJtK67hldziKOA69w/gDuHR6bfAu
	ZNlVfapZsLMQFNqsJ9lAs0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SKMcLJpMMgBhytaMEE7cfyJT0qwFkBrnCkWrJdR1zG91Zo
	O7WgWKG3Z2kDpJyOGrJ5zamCqP14ODWGbAxdFerY9s+uaUuHnC+q0JEBskhcwDPQ
	IY28lqwncgTI9cjDSW8uMiEFM5JMxUSZP6WtcE2jZ9FRn9HnXPVlVPnfHuS2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0EDE964A;
	Wed, 21 Nov 2012 14:14:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E3D59646; Wed, 21 Nov 2012
 14:14:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABA883B0-340F-11E2-8099-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210156>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's way simpler. It exerceises the same features of remote helpers.
> It's easy to read and understand. It doesn't depend on python.
>
> It does _not_ exercise the python remote helper framework; there's
> another tool and another test for that.

You mention why you _think_ it is better, and what it is _not_, but
with your excitement, end up failing to mention what it is.  I'll
try to reword the commit with this sentence:

	This script is to test the remote-helper interface.

somewhere.  Please check what I'll push out on 'pu' after I'm done
for the day (probably in 8 hours).

>  git-remote-testgit                   |  62 ++++++++++++++++
>  t/t5801-remote-helpers.sh            | 139 +++++++++++++++++++++++++++++++++++
>  3 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100755 git-remote-testgit

I hinted at this in an earlier message, but creating this file as a
tracked file at this point in the history is a bit irritating for
bisectability.  After you build and test an earlier commit, this
path is a generated and ignored, and then checking out this commit
or a later one will fail without "make clean".  It is only a minor
irritation, but still noticeable.

Thanks.
