From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/15] git-am.sh: replace using expr for arithmetic operations with the equivalent shell builtin
Date: Thu, 04 Feb 2016 11:33:13 -0800
Message-ID: <xmqqoabwi83q.fsf@gitster.mtv.corp.google.com>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:33:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPea-0004WT-D4
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934105AbcBDTdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:33:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932976AbcBDTdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:33:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A05441201;
	Thu,  4 Feb 2016 14:33:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/0Bql9D+VdW1+Lqo2JxTW9dEX90=; b=RFYY9G
	0HGKX+jEqoFQonh8ra4zgklksXXaiOslW7svZ5FKINwHLlgO7g3PC6ehtGjHU6Nf
	SmajYIXRrLv8TFe0mNey2fiS5OuXTgeRrOSgqik6Jc1VBiHHa4zvguwRXrwIFjZN
	N3ZDy3CSsqtKqeEPA7J8JlZoiA1PYLBWwkCb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yVgUAisdMQdDRGv9JC4ZSZzA67QytNdj
	0OwwbebBQx3oSvwlfOcMs8PQAk7btK+ivfqOpiCyGk/pDHbDxEUFQQclgYZzqL0f
	pJWozxSIeP+8yBxXXAXo7K/PPCaV8wzNqqzJ/BDFHkNXx/z3PS7yzLOS2pcSCTFh
	drMbbPkE8Bo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0137F411FF;
	Thu,  4 Feb 2016 14:33:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6F477411FE;
	Thu,  4 Feb 2016 14:33:14 -0500 (EST)
In-Reply-To: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 4 Feb 2016 10:20:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 222E7110-CB76-11E5-9F68-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285482>

As pointed out already, quoting of "$this" inside the arithmetic
expansion would not work very well, so [14/15] needs fixing.

I do not see 01/15 thru 13/15 here, by the way.  Is it just me?
