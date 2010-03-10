From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 11:59:39 -0800
Message-ID: <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
References: <loom.20100310T203316-38@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: MALAISE Pascal <malaise@magic.fr>
X-From: git-owner@vger.kernel.org Wed Mar 10 20:59:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpS4O-0000ja-8U
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 20:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949Ab0CJT7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 14:59:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab0CJT7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 14:59:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC6AA0D26;
	Wed, 10 Mar 2010 14:59:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=go9qNGSKBMF63p3LmAhmP8GDBVo=; b=CHkWHT
	Iw3gbCYiEZA15Oxhf8Jd4RMnYyKUSQOfpKgK6YNoNn8gJzgLcVtGd1btEkrSxcoh
	IvS4oTt6Wnnca4o+un4NFWGe8nN6R3Y1wR7n5HDtnsc3n2TP1Zn8jOesi3kaI2SI
	Ip3cDdBnl0ekMuDkAdqd4sHMJK19Jpy3QVf/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NnLGEt8rm+TYvF8kBiRWSeY5HXaoVdR7
	R1qeBgN91Zjd/pWoJA3qzXQqtIGNWIcPdlG4p0PigG1K7Hhh2kUf9jidwjPNglIg
	xFzvVNFDyl7wWz6lfGTR1i6vDF2t5GaXL5XzpjxnsziXBASkFWDZv2YKGSXkunO1
	ZeMpufrC6UQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD99EA0D25;
	Wed, 10 Mar 2010 14:59:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA91A0D24; Wed, 10 Mar
 2010 14:59:40 -0500 (EST)
In-Reply-To: <loom.20100310T203316-38@post.gmane.org> (MALAISE Pascal's
 message of "Wed\, 10 Mar 2010 19\:43\:18 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7879D7AE-2C7F-11DF-A91E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141916>

MALAISE Pascal <malaise@magic.fr> writes:

> Many projects are organized so that the result of compilation is mixed with
> sources.
> It would be very useful to configure git gui so that untracked files are not
> listed in the un-staged list.
> I have patched git gui, function rescan_stage2, line 1414 to do so:
>   # set fd_lo [eval git_read ls-files --others -z $ls_others]
>   set fd_lo [eval git_read ls-files -z $ls_others]

Shouldn't this line instead be running this:

    ls-files --others --exclude-standard -z $ls_others

so that it would use the usual .gitignore mechanism?
