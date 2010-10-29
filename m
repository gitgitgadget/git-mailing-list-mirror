From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Gitweb caching v7
Date: Fri, 29 Oct 2010 15:25:54 -0700
Message-ID: <7vbp6c63gt.fsf@alter.siamese.dyndns.org>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Oct 30 00:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBxOl-000861-Q3
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 00:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980Ab0J2W0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 18:26:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab0J2W0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 18:26:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 144522C1E;
	Fri, 29 Oct 2010 18:26:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e1/Byok8sNYZV5WKD7brbLkMmw4=; b=byVx6N
	a3/0PthklXkuhPEkix+iPmSQ3hxVXRBiS94cKWS5DAoNzywWTIRp3LypJmU74gJ0
	ZrbMv0Le/YnXSBjMRm+8ILNVme4NJ7M00unbfs2dkV8pn5KIoADxmW+1R5KD8dKF
	k9wJhq2hZKPFRVkjGUeKBkS2rPahkTvZQq5Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NlP1+Ju70tnrsAObKrvMSrykd5Bk9Hcc
	T3W+gMBxs8cQaXlLt0ZOsZ8Ts89ZtqUA0kEzRjNJCANw0MU3xnBgNOY34Scgio7x
	0vQM0AOryCxMUHbJpAao2RXQ//rRRh2Ie9/81Dg+J4AAgp3e2OYrS1SNbX050JOa
	SykbWDqrIVI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4E372C1D;
	Fri, 29 Oct 2010 18:25:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A7B72C1C; Fri, 29 Oct
 2010 18:25:56 -0400 (EDT)
In-Reply-To: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
 (John Hawley's message of "Wed\, 27 Oct 2010 17\:42\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 811692A6-E3AB-11DF-B111-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160365>

I am getting this in the gitweb.log:

    [Fri Oct 29 22:21:12 2010] gitweb.perl: Undefined subroutine &main::cache_fetch called at .../t/../gitweb/gitweb.perl line 1124.

which seems to cause t9500 to fail.
