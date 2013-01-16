From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/14] imap-send.c: inline imap_parse_list() in
 imap_list()
Date: Wed, 16 Jan 2013 07:34:52 -0800
Message-ID: <7vip6xywdf.fsf@alter.siamese.dyndns.org>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
 <1358237193-8887-8-git-send-email-mhagger@alum.mit.edu>
 <20130115185147.GB14552@ftbfs.org> <50F66422.3010502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:35:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvV1L-0001l3-De
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 16:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab3APPe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 10:34:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab3APPe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 10:34:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49DD3AB94;
	Wed, 16 Jan 2013 10:34:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YwIEILR63z2oQdcEXweMrhklMrg=; b=ns4ZKd
	XerKpXGlz4afxgG5AolxymYxRravhbw1SMNrnyKqAR4/R6hmrtEo0yTt9uryHBN8
	JVTPqD12O8KfoTi3u3g0IULeYG8LSvYxVizwBW6eUv+60PFtqMW4ggqHIqXZXDvd
	R1l9zBPaEURi1R/nRLXrqJyG2J68GjuCctN8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aWJVpEJno3tk70GxRoq+WlAhfktfxSxR
	EIOZaR2CYMTn9uvaNs7y/y+hNUcT1yZYAnNNEN4MeQ0x6g5/FSCM1lShdm5kwWo/
	MlxuxoXHJlX9hKAGhsCSFowUmwfdzQRnX6uZHybcavRmpaplGj2qBPVjeQOW05Ay
	3/wzvbfHwzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E75AAB93;
	Wed, 16 Jan 2013 10:34:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1A9CAB92; Wed, 16 Jan 2013
 10:34:54 -0500 (EST)
In-Reply-To: <50F66422.3010502@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 16 Jan 2013 09:26:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46B2436A-5FF2-11E2-BD1B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213758>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/15/2013 07:51 PM, Matt Kraai wrote:
>> On Tue, Jan 15, 2013 at 09:06:25AM +0100, Michael Haggerty wrote:
>>> -static struct imap_list *parse_imap_list(struct imap *imap, char **sp)
>>> +static struct imap_list *parse_list(char **sp)
>> 
>> The commit subject refers to imap_parse_list and imap_list whereas the
>> code refers to parse_imap_list and parse_list.
>
> Yes, you're right.  Thanks.

I think I've fixed this (and some other minor points in other
patches in the series) while queuing; please check master..3691031c
after fetching from me.

Thanks.
