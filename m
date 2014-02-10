From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hashmap.h: make sure map entries are tightly packed
Date: Mon, 10 Feb 2014 11:48:10 -0800
Message-ID: <xmqq8utisq9x.fsf@gitster.dls.corp.google.com>
References: <xmqqtxcatze2.fsf@gitster.dls.corp.google.com>
	<52F6BF5B.9090807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 20:49:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCwqp-00075w-LX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 20:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbaBJTsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 14:48:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbaBJTsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 14:48:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B56AA6B3E6;
	Mon, 10 Feb 2014 14:48:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3h3Cg6cfAyqSr0uwd2nMug6oICM=; b=vig08v
	yKKi+Bgr48CE/ABM8Ai5o1FOySBvGjz9pXpzu//qw5HVY1G64KvRx9tBJH3Le4Pg
	TD1GY3Ye1wH28LYAia/83BVRRqw99BHJfzZomxKPhPWjMewQiqP4k31bKlZA4z8D
	nBU041KelbbrcMlGmIqVlDVVmAFrYLs73zwSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tgD63oCKrf81TzEpPyZ1PwodNZsk56pn
	rnYFfDqDF4viAM2ULZfSjGRjIYZJ30oBUxZOM+Je2Yv+dKqkk2i1pBc8vmmFvMNu
	cxT8EIM0cKSmCuEH9Y33PNVB7gAi/VryB4MplyfXBVhMF89t4U9Dyex/uWGrajFD
	CiAZjgz6qJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D7216B3E4;
	Mon, 10 Feb 2014 14:48:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 681256B3DE;
	Mon, 10 Feb 2014 14:48:12 -0500 (EST)
In-Reply-To: <52F6BF5B.9090807@gmail.com> (Karsten Blees's message of "Sun, 09
	Feb 2014 00:35:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46560DD4-928C-11E3-A9A1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241927>

Karsten Blees <karsten.blees@gmail.com> writes:

> ... At the very least we shouldn't
> stall the rest of the patch series on a hunch that the last
> (unfortunately non-standard) patch may break on some legacy
> system.

Oh, no question about it.  I was planning split out the last one and
merge the rest to 'master' after the current cycle.
