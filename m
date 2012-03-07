From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Maintaince script for l10n files and commits
Date: Wed, 07 Mar 2012 11:17:13 -0800
Message-ID: <7vr4x4mdae.fsf@alter.siamese.dyndns.org>
References: <1331146034-85804-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 20:17:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5MMc-0001bi-ET
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 20:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759780Ab2CGTRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 14:17:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759755Ab2CGTRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 14:17:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF52D686B;
	Wed,  7 Mar 2012 14:17:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YmnwAM6PyYvK1UinII35/tvDMpA=; b=dWWE3M
	eHX0GQLknUYFPwH5S0QtAu9tRKyX/NE5GEnT1PkIhvLzbngnDpBAIWEzP1X98bFv
	EWhzFH3AaWimK4vL0B+v7LyppQqVh5jZx7UIVHvVhpnBPd1VP+Ywdfc1HqOFGeVi
	cRhwE6Dg+dGzeJ3adEyuxVJYsbSC0hdW4lrt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vTMEl320VQgs67tuEyS9QMn7cKvmedeP
	iji1L9f/hBAYz4yTeTIHPhbKG0k6XAK8nxT7H1qorV5hH2pdadOSENUlCcYeMsPP
	VqrCtkDpjc9oF8UeQiCVvOekQJBB/B9bLrJeyCBuCG76RPUPDYOtv8py+RFCddSo
	bhQ2Dg+MIOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3A08686A;
	Wed,  7 Mar 2012 14:17:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 498F16865; Wed,  7 Mar 2012
 14:17:15 -0500 (EST)
In-Reply-To: <1331146034-85804-1-git-send-email-worldhello.net@gmail.com>
 (Jiang Xin's message of "Thu, 8 Mar 2012 02:47:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 262DDE8E-688A-11E1-BEA2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192474>

Jiang Xin <worldhello.net@gmail.com> writes:

> Usage of this script:
>
>  * rake commits      : Check commit logs written with non-ascii chars,
>                        but without the correct encoding settings.
>                        Always report Non-ascii in subject line as error.
>
>  * rake pot          : Print the summary of the update of git.pot file
>
>  * rake XX.po        : Create or update XX.po from the git.po tempolate file
>
>  * rake check[XX.po] : Syntax check on XX.po

I would relly prefer not to add another language dependency to the
system.  Are you doing anything that cannot be done with what we
already use, e.g. make and shell?
