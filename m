From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] help: Fix help message for aliases
Date: Wed, 14 Mar 2012 22:23:04 -0700
Message-ID: <7vipi6mo93.fsf@alter.siamese.dyndns.org>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 06:23:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S83A4-0006wt-11
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 06:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab2COFXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 01:23:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab2COFXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 01:23:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4566137B4;
	Thu, 15 Mar 2012 01:23:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=A50VR/RArympk1lM/oh4sDpI5f4=; b=RKFv/nNfgGWW2PrT9th2
	omADGynzQjuS0KR6pyHfT9uF/SPekZWfcVLv0rw8wvSuPiJJdV6i8llyO6x92IUF
	0YAx+ms54YpgAZl/k1IeFSHvRF4BIxW/mdfnLUzm4/0WsP/FKBxWYJVwAF+LlF7v
	ekKrRuigTgIkiqvwKi/jmb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KsApHeFNK52EQfspMbVJDbNXF0HQDnX8l0B/m+Uh3j2cWT
	wDluO2OdxKPOhhuoGbQwBpeXKxeOuYyM6yNfsbSnutCtTpH99bcjHghPblv7Pdbw
	G3cr2EU3zL5BbsVImz3mhplfNjcN3K+qYybkReFVNjzkKcdP20H5EE+YHL8M0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA0637B3;
	Thu, 15 Mar 2012 01:23:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3A2737B2; Thu, 15 Mar 2012
 01:23:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1A801FA-6E5E-11E1-B60D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193179>

Namhyung Kim <namhyung.kim@lge.com> writes:

> -		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
> +		printf("`git %s' is aliased to `git %s'\n", argv[0], alias);

NAK.

What would the above change will do to one of my favorite alias?

$ git help who
`git who' is aliased to `!sh -c 'git log -1 --format="%an <%ae>" --author="$1"' -'

Wouldn't removing "git " from the first phrase be a better solution?
