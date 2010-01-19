From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: honor NO_CURL when setting REMOTE_CURL_*
 variables
Date: Tue, 19 Jan 2010 15:31:52 -0800
Message-ID: <7vockp7jtj.fsf@alter.siamese.dyndns.org>
References: <1263915552-32537-1-git-send-email-j6t@kdbg.org>
 <20100119165858.GA24065@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXNYV-0007aj-AN
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 00:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab0ASXcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335Ab0ASXcJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 18:32:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab0ASXcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 18:32:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0DF3927CE;
	Tue, 19 Jan 2010 18:32:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=bOOFfuVvvgS06N7R8y85HLViIiw=; b=iu1cJZT5eCHg4y3IXMh609H
	hPryt+hHKczor8maz12fc7ZUuAb60KlD5gN+s2sj7MXwhuXx+Xk5J4XmxfDy9wQm
	6OMgea55dd1MF1C7SpBO1Xq3rEBKy3xD+vZLVGYk/8lFwPXtFZCD/gnun7GU+swc
	9czwPIWtv4KgfYMMwaVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lDe/e2aNAL6YgP5oxKZlTpZfwGE3O9HxefaaS1Z2xTcjVgH6n
	3xQMxh5iGIEOjqurEho15a9HpjU4gmSbDQygFdaYDUqPGZFguXRLudkp8TfoeYMb
	T/Ux8tZuztok2BbRtE8VGK22acipLvGM6/57BIN4CYKMbeQV1USfbt2OVw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74A20927CC;
	Tue, 19 Jan 2010 18:31:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD840927C9; Tue, 19 Jan
 2010 18:31:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5A8425C-0552-11DF-A2AC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137501>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Tue, Jan 19, 2010 at 04:39:12PM +0100, Johannes Sixt wrote:
>> Previously, these variables were set before there was a chance to set
>> NO_CURL.
>> 
>> This made a difference only during 'make install', because by installing
>> $(REMOTE_CURL_ALIASES), the rule  tries to access $(REMOTE_CURL_PRIMARY),
>> which was never installed. On Windows, this fails; on Unix, stale symbolic
>> links are created.
>  
> <snip patch>
>
> I didn't even compile-test it, but based on quick look I don't see any
> obivous mistakes. There are no references to REMOTE_CURL_* in section
> moved over, and the variable values should not differ unless section skipped
> sets NO_CURL. So:
>
> Acked-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
>
> -Ilari

Thanks.
