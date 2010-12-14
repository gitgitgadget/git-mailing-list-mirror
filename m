From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/14] t3032-*.sh: Do not strip CR from line-endings
 while grepping on MinGW
Date: Tue, 14 Dec 2010 11:44:30 -0800
Message-ID: <7vaak8ta01.fsf@alter.siamese.dyndns.org>
References: <4D07B904.8040206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSarT-0003Mi-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab0LNTom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:44:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab0LNTom (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:44:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0C4530CF;
	Tue, 14 Dec 2010 14:45:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SkdqHGk86iK57MyyVrVlfzG8+0o=; b=aAokuyVwjFnej2q1LkPLIKS
	jxJg96V3rmNMQCzWrf0C6FsVYd66rh7AcF0E1ItgZ8z2ta4CYjonyYpUwG5NIzTl
	7Pw4As1pRQud4yqanxsSn+mKQI8hHmCl1DFOJ/zMSJHYsoXm83d99fW0TGy3qoK0
	ZNU4IH+EZG1zBiEtzKYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=E8Ouelpe6f7ARYQoIdTAmQEJzH9V2OG5aU0xAgt2ciENVP9Pu
	hl9HhNAUaNU48ZgKBAB8aA+7ssSGd+CYn63Zg5wogcJ/LUHb0JUeKdsSsTNee0QN
	V0DDgV+IWyMCfqrzKFDCcyP/HgXwVvsgAy8BKXiUEu4RIK10YW29A91o2g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 888AE30C8;
	Tue, 14 Dec 2010 14:45:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 644BA30C3; Tue, 14 Dec 2010
 14:44:58 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A46C67FC-07BA-11E0-8954-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163684>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> By default grep reads in text mode and converts CRLF into LF line
> endings, which causes tests 4, 6 and 8 to fail. In a similar manner
> to commit a94114ad  (Do not strip CR when grepping HTTP headers,
> 2010-09-12), we set (and export) the GREP_OPTIONS variable to -U so
> that grep will use binary mode.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Adding these GNU specific options leaves a bad aftertaste in my mouth, but
I'd pass them, as their use is limited to certain platforms with "prereq".

Thanks.
