From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] merge -h: show usage even with corrupt index
Date: Fri, 22 Oct 2010 11:31:26 -0700
Message-ID: <7vtykem64h.fsf@alter.siamese.dyndns.org>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino> <20101022064945.GG6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:32:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MPu-0006ta-4T
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab0JVSbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:31:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab0JVSbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:31:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FAFE11EB;
	Fri, 22 Oct 2010 14:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7iRngrR7CE032Z4sQcGEpfoRcbo=; b=CoFMurWTbhBnzQJMcHRjXCc
	g46T08ufwrmVK5buU9bKZIiCDTVfeJl3alwCDjg4iYMFOMs35Jh0rpO7qOnLLbiS
	R10Gm7tWlTTJnWVdISVrXkW9xBzIn8Kc7V1YRxBudjQ261PILnXHlqYj77Kd5ZQf
	D3sTzkIi8/O5J6EsM0U4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=u7rOYX5nCXdNDEiuAhOAB5b5DSm1st1UxW4PDa6wqL352WhTC
	9YtPvCNWkWP4Yy+cpNcI9TQnOuYkIOLoX82G8kAqfZSK3AZe15D4Hmc+Ta5gbnSB
	mxzujIkvYgtQbBohMeTCrl0VZOMEWBCOJtL/jf4ubNiE1t4sDRzuscCbTY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B37E11CE;
	Fri, 22 Oct 2010 14:31:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 765FBE11C9; Fri, 22 Oct
 2010 14:31:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97D9E08E-DE0A-11DF-8AAD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159725>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +test_expect_success 'merge -h with invalid index' '

You say "in broken repository" in 1-3, "with invalid configuration" in 4,
"in corrupt repository" in 5, "with invalid index" here, and "with corrupt
index" in 7.

> +	mkdir broken &&
> +	(
> +		cd broken &&
> +		git init &&
> +		>.git/index &&

I think describing which aspect of brokenness the test is interested in on
the title line is better; let's restate "in broken/corrupt repository"
(1-3, 5) to be more specific, and match others in terminology.  E.g.

 1. corrupt ref
 2. corrupt index
 3. corrupt status.showuntrackedfiles config
 4. corrupt gc.pruneexpire config
 5. corrupt index
 6. corrupt index
 7. corrupt index
