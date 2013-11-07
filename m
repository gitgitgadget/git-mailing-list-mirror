From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 13/14] builtin/update-index.c: cleanup update_one
Date: Thu, 07 Nov 2013 13:40:44 -0800
Message-ID: <xmqqwqkjq49v.fsf@gitster.dls.corp.google.com>
References: <527BA483.6040803@gmail.com> <527BA738.9000104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 22:40:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXJv-00046F-6U
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 22:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab3KGVks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 16:40:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab3KGVkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 16:40:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E2D850652;
	Thu,  7 Nov 2013 16:40:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=882y9ofXp1yk8GTpayTnaM6ZmV8=; b=tpBfaLQv1u3Rr5Cp5SQn
	HJbwpd7f3S0h2mckLsVUaelDXj4lj/bB8SxOhgcL70PZK6FWYJxR36pxMgMDtnK7
	URPmNRYG1SV8e0O2IdsxRfrq3DDZek3DoEmqYEW4Vl3EvVsLqKVXqbUTszrGAsGh
	K42J/i2+Gv1Y6BFSqZDh5g8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QGXCQv14Ko3AS4BbIUIgPUl6BdFIeUPUKpPtcZzfH7s/D2
	frwuPbHX3aclLW6mvEL3xxmhfsPfizy0OHuYsypnuIr9cPWy6lFK7iGDzSqwmWJb
	rzEH+KTUnWxLEZm/ILm5SxSk2PfAO150tr2Pvx2kmP1UD6xtwSeWU8FUF4dNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE1650651;
	Thu,  7 Nov 2013 16:40:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94BC950650;
	Thu,  7 Nov 2013 16:40:45 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 424D7A38-47F5-11E3-82D4-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237431>

Karsten Blees <karsten.blees@gmail.com> writes:

> -			if (p < path || p > path + strlen(path))
> -				free((char *)p);
> +			free(p);

The non-const cast was there for a reason.  I'll locally fix it up
(there is another instance of the same) to get it compile before
queuing it on 'pu'.

Thanks.
