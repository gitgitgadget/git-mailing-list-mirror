From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Fri, 26 Mar 2010 12:32:44 -0700
Message-ID: <7v8w9elvz7.fsf@alter.siamese.dyndns.org>
References: <20100322145947.GA1709@pengutronix.de>
 <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net> <7vaatxobef.fsf@alter.siamese.dyndns.org> <4BAB18C6.6010202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:33:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFHC-0002sI-EG
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab0CZTc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:32:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab0CZTc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:32:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B3F0A52DD;
	Fri, 26 Mar 2010 15:32:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PkNFXDXdbVjTsNb47ZSHkGMLeGU=; b=OYmeiMn52ymuKlOxuohTprU
	krlnIkiU98SuL7OgWcB/LnGuGAqTRRbxk5THeAhnrhWBO7+f1BPzICLLlSnEsAnV
	RnOAWREuzjUocEvSh0PCi+a2N+ol/egHLEycCXab/0FpTIfy+0gggTCcX+eXupBg
	DCyaV3MHrkAFO/oBzUaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LJn+hNUvZnZYf4OqWXLj8OfzsEDYvVJTSEp0T5ADwHQEJXhTK
	s1M3TwGYbqgz/pY12AEyvZVfk2DkgriU20VQzdW+BWLRuvv8KH7vaNWhnzilSELL
	p7gmA3ZUQ0GKAIDK3H89fBYrwFBD1+87KopBUuhb5KBGtDJ2LoFn5gh+k4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 196F8A52D9;
	Fri, 26 Mar 2010 15:32:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F33FA52D2; Fri, 26 Mar
 2010 15:32:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5DBE5BB0-390E-11DF-BDB4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143271>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>     However, "git var GIT_EDITOR" run without a tty (think "cron job") would
>
> Also think "hook" ;)

Yes, remote hooks invoked over ssh transport won't usually have a tty, but
the local hooks (e.g. post-commit) usually do, I think.

> Yep, I'm fine with this.

Thanks.
