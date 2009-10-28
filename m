From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Wed, 28 Oct 2009 00:18:30 -0700
Message-ID: <7v63a0t29l.fsf@alter.siamese.dyndns.org>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
 <1256589116-6998-3-git-send-email-bebarino@gmail.com>
 <20091027185223.GH10505@spearce.org> <4AE7A1B9.5010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32nx-00085M-M8
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbZJ1HSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbZJ1HSj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbZJ1HSi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC71069DDF;
	Wed, 28 Oct 2009 03:18:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jRlWthJn4DIY/cqBJtthZSWhAwE=; b=tfYxxeJeb2TXEAHEY4UA0Jp
	VYoeM72pW9dRMVPnyhfj/9xI6Z84Tvct2es3cRN70dpFYKPOHXNHzWx7G/CkCHTI
	kjMQvIiBPZCOho9SIWNN3G1xpTMwx8AAroO7QiYV3cDQkgAqdhS08W/cTT6qnb8G
	QXD3FG3CTrT6igSFgYqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=McJBrmnVmfcn1SHAJ/GHMsIJiO3zNhH0YLzc85LxAgpIn2evk
	bshT2KwBPPJWad3zxVDmsxx9OdgYbVWgEQkubQ7sPqY12djT0VkB3wFZrVnwhMle
	ey4CozqyOHT+hQhhpE+rEECDBzIeBhLVODSsOLRhg74u52eY71GAKG8M/c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7043669DDE;
	Wed, 28 Oct 2009 03:18:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75B6769DDD; Wed, 28 Oct
 2009 03:18:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CD91E74-C392-11DE-9A45-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131421>

Stephen Boyd <bebarino@gmail.com> writes:

> Ok. Following Junio's suggestion I think we would have to do the following:
>
> (1) Revert the rename (git-completion.bash.in -> git-completion.bash)
>
> (2) Add a "generation" mode to git-completion.bash.generate to
> generate the lists and output them to a file
>
> (3) Add logic in git-completion.bash.generate to source the generated
> file if it exists
>
> (4) Source git-completion.bash.generate in git-completion.bash to get
> the functions moved there

Sorry, I do not quite see why an extra *.generate script is necessary.
