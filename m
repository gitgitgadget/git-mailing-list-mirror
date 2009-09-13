From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 13:57:37 -0700
Message-ID: <7vfxaqpnpa.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <20090913204231.GA8654@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 22:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmw8u-00021E-TL
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 22:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbZIMU5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 16:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbZIMU5n
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 16:57:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbZIMU5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 16:57:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F5D031A45;
	Sun, 13 Sep 2009 16:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uVVqiyDrlTtvv+rscOK1aTFbdhQ=; b=lNN0tU
	L+zVXf+Rha7mqh3qXsEhDnZ18RPH3oHm9LCIW8sPpzHB9RnQx52zoVe51O7R9/VB
	iQ3KzK1XZVSbo7Klza8W4C+8npDVQmLvrSROOX4A8ZZsabEFyh4G2r8u2EFI+tL/
	D47ZrMEJtbVux1GeHCUT2UVlvfWwiFFIMpxDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzGupfme+vdK1Fij5wktnT+z1cG7PdRo
	RMPQ7KtPjAc4YahtqFT3RRa7PCE/qPzHnVXlSyA5cIEqZxyVikFDH7+egvcKxBrx
	+O5eaEW94MweFou1XPu1mq9gu1Qi8/Ix26q5zOV2l1ZvPor+aTUCCUR7ePz5dPPJ
	TTyP5zcl86s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25BF131A44;
	Sun, 13 Sep 2009 16:57:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81D7431A43; Sun, 13 Sep
 2009 16:57:38 -0400 (EDT)
In-Reply-To: <20090913204231.GA8654@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 13 Sep 2009 16\:42\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 142E7628-A0A8-11DE-A09C-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128412>

Jeff King <peff@peff.net> writes:

> What you have here is precisely what we observed. But I think one of the
> complaints was to say more explicitly "that ref doesn't exist on the
> remote", which I think should be the case if we have got to this point
> (anything else would have triggered an error in fetch).

Wouldn't you get into the situation with this?

	[remote "origin"]
        	fetch = refs/heads/master:refs/heads/master
	[branch "master"]
        	remote = origin
                merge = refs/heads/next

I think saying "does not exist" will repeat the same mistake of
overguessing you are trying to rectify.
