From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Speedup fetch with large numbers of refs
Date: Sun, 25 Oct 2009 00:16:32 -0700
Message-ID: <7vd44cymcv.fsf@alter.siamese.dyndns.org>
References: <20091022210444.18084.61685.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Oct 25 08:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1xLM-0002tu-0i
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 08:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbZJYHQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 03:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbZJYHQg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 03:16:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZJYHQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 03:16:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C91585211;
	Sun, 25 Oct 2009 03:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/9H/0hRDJ/anrT2OejtnRpHZ8js=; b=MT4x3T
	4hggSNnsoqlBrTYwcuxpX1qUIFEPno+adRlsaOC9KB5oWMqSjO0HYngVac22bLir
	tITejCnPQGK2Sd/fKZNRrAO6K/AqCzKAjLrcoWx98QuaeLdi269ae3YyzqdW7U4j
	a0DLybh6r14FR31SXTXvqaHYYNtdL1qIBp/j4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MNSQzzPw7A8Ygzx4NRWw6s+CexADaIXA
	06mFhZmdEBfC3pDQxifvsGh0W5Cpsxpv/qqRoLipyW9pBvCWMDMACsybYqVVsVpD
	eyqx5e0t6pSMRnrcYuX0D2VlsaoMzlGQP3y3k6IlAPrJq8cjUbgUg9Rq6O9K5VVu
	qNR25CuaRxc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 606F385210;
	Sun, 25 Oct 2009 03:16:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 464578520F; Sun, 25 Oct 2009
 03:16:34 -0400 (EDT)
In-Reply-To: <20091022210444.18084.61685.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Thu\, 22 Oct 2009 22\:06\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 560956FE-C136-11DE-8A41-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131190>

Hmm, t5515 does not seem to pass with this series for me.
