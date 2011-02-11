From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/4] merge: introduce setup_merge_commit helper
 function
Date: Thu, 10 Feb 2011 17:36:21 -0800
Message-ID: <7voc6j1hey.fsf@alter.siamese.dyndns.org>
References: <1297381964-7137-1-git-send-email-jaredhance@gmail.com>
 <1297381964-7137-3-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 02:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnhw6-0006HE-Kb
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 02:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634Ab1BKBgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 20:36:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757639Ab1BKBgc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 20:36:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6772945D0;
	Thu, 10 Feb 2011 20:37:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RaaGS25G0oDegAJEW8VT4+mhNSA=; b=sbAPIV
	mHeSBPKgWdGNSw2e/YAvHGQ9C/Ksnp+zwU3HMRublnMmQlLjgIptU+dnRbs8OL92
	2LzpKbVDNgTl/adcJ63VaemSfnXau3Mss7+2TrFLc+mo6QEO9pBkc2Sxh4XGQBoH
	XEAqRxrBJr4O4kLAtgOE9NSTtq4fE5U7iaAfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHTDrp/0N8ZwlYK+PVWgShD99kkjanv1
	cACFojIJLOuBEDXNbGTFdqYHSdXBO4Up92ZdSIXt64gozMNUR/ogTD7GdG9TM7tg
	iKGp3rZhiQSkjPAHRTi0tklK1BN5Qo/CCB2cLurUJMXiocBn6mBgEjSmjqbeO8LG
	Wmv86m98kRA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41D2245CE;
	Thu, 10 Feb 2011 20:37:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5255945C8; Thu, 10 Feb 2011
 20:37:27 -0500 (EST)
In-Reply-To: <1297381964-7137-3-git-send-email-jaredhance@gmail.com> (Jared
 Hance's message of "Thu\, 10 Feb 2011 18\:52\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D69889A-357F-11E0-9049-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166532>

Jared Hance <jaredhance@gmail.com> writes:

>  	for (i = 0; i < argc; i++) {
> -		struct object *o;
> ...
> -		strbuf_reset(&buf);
> +		setup_merge_commit(&buf, &remotes, argv[i]);
>  	}

Micronit; the body becomes a single statement and you should lose the {}.

Thanks.  No need to resend.
