From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Thu, 03 Jun 2010 14:58:19 -0700
Message-ID: <7vsk537p8k.fsf@alter.siamese.dyndns.org>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <08e635cee993d97e2a38d7766ced11c064ef7d87.1275575236.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 03 23:58:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKIQt-0005BL-N5
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 23:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756468Ab0FCV6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 17:58:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab0FCV63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 17:58:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10B69B8FF0;
	Thu,  3 Jun 2010 17:58:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dgfak1ey9qEcwVAJdDNZLe5YEwc=; b=AXuIAocaAPd8FE7zALoDwsr
	uzM1npTazYz4A3utrf1kBxOT5UPDlXMa+uGYDIB9ywFdQibRw7uTKkkP8fRO5mHB
	w4zNGVizt+lCPYQUfTRTp6/QwiA/3ZC8x3/dkeKK7gnhwr5ORKfhJ33ebq9Y+aVG
	ubYf7r2Z6W3cy6a6Gbu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QWtR3QELK/46RVqsrEb9dL+rWztfQ3Cktf8PzFfI92Xm5Gk3s
	poTcgWPLtUk+WRN1RD4+qLIoC8/pGG2oYcVZKk/WZGeA9INoXvLcqxIB6dR0gTzx
	cR9XNzo0vabpFGBcdhlTxcqN018TzFecLg46vqYQHHRVmcf7oIFFihGZBs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C58CB8FED;
	Thu,  3 Jun 2010 17:58:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBB9AB8FE9; Thu,  3 Jun
 2010 17:58:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21DFF6A2-6F5B-11DF-AB0D-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148367>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This puts the "No newline at end of file" warning for both code paths

This is not a warning.

It is an integral part of the diff output specification that allows patch
recipients to correctly reproduce incomplete lines.  Removing this from
the output is simply out of question.
