From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/13] ident: don't write fallback username into
 git_default_name
Date: Sun, 20 May 2012 19:54:24 -0700
Message-ID: <7v7gw69rbz.fsf@alter.siamese.dyndns.org>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231933.GH30031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 21 04:54:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWIlV-0000ZB-56
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 04:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab2EUCy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 22:54:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab2EUCy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 22:54:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC0A889C;
	Sun, 20 May 2012 22:54:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1dzX4G3BcSawqfLqsQr/Xxo3DWg=; b=pyOF3M
	Iw/yKRP6OakRz/+z3JhTbUNWoEbVE3yA9CshMEF6/o9Nq9NfRTM3oNlRPSvPQD89
	DKCt+cTZ+Nws+2DqmM5fj2vO9XhN/4pp+LshgArW8xPojLPIGFk2eOF8johCfTOU
	O0e7jLbETnUd552vYa5omcI9qDdjeEGMw/Vkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Et2xRhB4X+Rtsn43bBynh6HwzfoMhGJ3
	vGrV7qkzRr934DnORCprHNAMLevLDJG2ZY2KMWevDopuIcvkoCHyxm6PauRHqj74
	44bj+LtUDAEWRv7OgUZxm3QnJqB2zG1zC6bItA5kPvzLl1gg9yxxwnQe2O+0QlFm
	tboSxSZYKlI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87793889B;
	Sun, 20 May 2012 22:54:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CB61889A; Sun, 20 May 2012
 22:54:26 -0400 (EDT)
In-Reply-To: <20120518231933.GH30031@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 18 May 2012 19:19:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46C980E4-A2F0-11E1-8951-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198078>

This step seems to break t/t4014-format-patch.sh; the last output when the
test is run with "-i -v" indicates that Message-Id: and In-Reply-To: lines
have "<long-hexdigits.long-decimal.git.name@host" without matching closing
">" on it.
