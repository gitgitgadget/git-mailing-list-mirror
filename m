From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git log --follow support --find-copies-harder.
Date: Wed, 21 Apr 2010 22:54:55 -0700
Message-ID: <7vbpdc6ngw.fsf@alter.siamese.dyndns.org>
References: <1271860641-29305-1-git-send-email-struggleyb.nku@gmail.com>
 <7v8w8gbv75.fsf@alter.siamese.dyndns.org>
 <m2p41f08ee11004211927w88506198sfd740da672b5c6f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 07:55:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4pNl-0000Uo-KS
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 07:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab0DVFzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 01:55:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab0DVFzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 01:55:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B1A8AC8CC;
	Thu, 22 Apr 2010 01:55:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qcsnOSuOWepFZPPpTvBW7ZtyFmM=; b=mr5pYp
	R8R4SbFuE1FVuvIg5e65dkQFtqAJi/La8CAOney30cSPpshVpcn83U/pMI+Hb0Tn
	3U56asT/wBuwqA0rCX6/RhIwobR3tDIL1lGftjirQIt84Y63+A+rc0gB/UDxAAAV
	ndqKTKM5ioOSG4Xz5epCuXxlOk7YKoA8FxVbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u42rsyp//GPhEfQcXyfajdWMaORywS/Z
	McJ2j+kDNLm+fJ6G2D8KwK+o8JCtEs0qBGEn5Jo6Z3WUy8e3cpsLayd2b0OIGN63
	V+9xyfURaP9VSr0zLKV5ZqmA4paM8BO38T9xmm7/xCPLRWFEOyoTZ563j14RcqQ4
	7Rt5/H+iEVo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE940AC8C7;
	Thu, 22 Apr 2010 01:55:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24C58AC8C2; Thu, 22 Apr
 2010 01:54:57 -0400 (EDT)
In-Reply-To: <m2p41f08ee11004211927w88506198sfd740da672b5c6f7@mail.gmail.com>
 (Bo Yang's message of "Thu\, 22 Apr 2010 10\:27\:55 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97744B06-4DD3-11DF-9A3E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145502>

Bo Yang <struggleyb.nku@gmail.com> writes:

> This because in diff_tree,
>
>               if (opt->nr_paths) {
>                         skip_uninteresting(t1, base, baselen, opt);
>                         skip_uninteresting(t2, base, baselen, opt);
>                 }
>
> And this give no chance for later rename/copy detection.

That is rather an old news.  This thread may help to avoid rehashing the
same issues:

    http://thread.gmane.org/gmane.comp.version-control.git/10225/focus=10259
