From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Generating patches/Cherry Picking for a large number of commits
Date: Fri, 28 Aug 2009 15:35:43 -0700
Message-ID: <7v1vmvh8hs.fsf@alter.siamese.dyndns.org>
References: <ae09c2a40908281226r744141bm3a5bf4161ddab3e7@mail.gmail.com>
 <20090828194556.GA13302@coredump.intra.peff.net>
 <ae09c2a40908281250r42275a3o96825b89e725bace@mail.gmail.com>
 <m3k50nllt6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alydis <alydis@august8.net>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 00:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhA3D-0000Ru-3s
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 00:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbZH1Wf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 18:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbZH1Wf5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 18:35:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZH1Wf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 18:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAC2C3A3A9;
	Fri, 28 Aug 2009 18:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H6rJLO3jNAxPZCUv3/bVab9Qrkg=; b=HWpxg0
	OfXv8oz02NP90JHNe+WKleQBEXlQEjXY14KTaABqDA0SrGsj6DLQRgjOmr9Nj1g+
	+9jaPdy7ghVVpLvKUI/bNQIW9VlDHGgYG7Mw8Y1nhAttd3UeivyTSd0ocJrmGfkA
	6m+C3DifcrYcnNVKq4xEwZHQ5zAfDt8+unwvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhAHQDRSlg3pS6yAUnRFugIuVmIX6Jh7
	8tZZyyBxEPrPJbIHvHR6OhEDxcn6/G6g2Jx6KXAW1yXeFxwvG18vPK5rTCOyJPyi
	1R+Egwr5c2V3FWj6P4rPtItbGliyGdS2UIRMAYX1+n8xIq5g4Aizojb6PUl2bH4D
	RePpsBxMMJE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FF2E3A3A7;
	Fri, 28 Aug 2009 18:35:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F0B4F3A3A6; Fri, 28 Aug 2009
 18:35:46 -0400 (EDT)
In-Reply-To: <m3k50nllt6.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri\, 28 Aug 2009 13\:34\:36 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25C472F2-9423-11DE-9601-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127360>

Jakub Narebski <jnareb@gmail.com> writes:

> git-format-patch | git-am pipeline has to work correctly, as it
> originally was the way (modulo extra options) git-rebase was
> implemented.  So yes, "git am <dir>" should understand and apply in
> correct order result of "git format-patch -o <dir> <revspec>".

You are not making any sense.  rebase is done using --stdout and does not
rely on the intermediate files nor ordering of their names.
