From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Tue, 15 Jan 2013 08:17:50 -0800
Message-ID: <7vvcay4dzl.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ross Lagerwall <rosslagerwall@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv9DJ-0001Qe-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab3AOQRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:17:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118Ab3AOQRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:17:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A09C6ED;
	Tue, 15 Jan 2013 11:17:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D4VhPJGa+sAEX20hdD9PvmDHnjw=; b=bXQTR5
	fOsk0jvW8rQJAnzg9Adko8odE2qMCM5Ad4KghhNaLIcThbRu2Yp+XsTnIa/67csw
	URKlVPa9X3uJYtd0p2TAfDTDwAHAVJV5h9pH1r2DEFwbJlMw2iPwPp6/jj5ADDl6
	ICPEuhIxoAI/XJZqSp+27WCo+Kn6/fvZxN/lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cShecKg2lv8irquXVyIi2EfUaar+7MNQ
	UK+OPTwWpObzrhqAP32Nr+YNY9GlChZ5WHLHXko4B2tMi3Wzy89RI1sDdrwVXMrT
	q6bnTlqvdqwDdF+7gmbkW32LaFC4Or7g9QJEZX+dYvZLdYqBVPEKsncKz7vDki5K
	khs3OmSf1VQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CC60C6EC;
	Tue, 15 Jan 2013 11:17:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D36C2C6E8; Tue, 15 Jan 2013
 11:17:51 -0500 (EST)
In-Reply-To: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 15 Jan
 2013 20:35:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C60DE96-5F2F-11E2-9F15-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213645>

Good spotting and a nicely explained patch.  Thanks.
