From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a script to generate a (long/short) options overview
Date: Thu, 31 Oct 2013 17:09:41 -0700
Message-ID: <xmqqtxfx2da2.fsf@gitster.dls.corp.google.com>
References: <5272E1B9.6000705@googlemail.com>
	<1383260682-12364-1-git-send-email-stefanbeller@googlemail.com>
	<5272E316.5090108@googlemail.com>
	<20131031234514.GC41460@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, tr@thomasrast.ch,
	mhagger@alum.mit.edu, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Nov 01 01:09:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc2JB-0007zK-H7
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 01:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab3KAAJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 20:09:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272Ab3KAAJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 20:09:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B7724F248;
	Thu, 31 Oct 2013 20:09:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qtrKogImFYKOp70nB8I7NZrr2OE=; b=IMzIfS
	iTV2IGIYTgRsgC9Yyw8aZqBrgo+n3hQa5H+6lV3N+rWFafTxe/tF1A4pE+1l8Q5D
	xn1PWMy34dNfE8uDc0B/m6glyFFO8m8yGDasqvR3bYTWBmBnvUGIRmHj1el1857m
	76iyG1UlUVENDRCrCqK+UTf9btz41DfvH51zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nvMUfNTccrwQ5ZLqDEEFRRhXOCbXAdt1
	1CFId7oGuGMcWayDevXhp3TMhejZKsMGwrJBuBDyInQ0UawH3rt+HrRpX8ceL4JY
	UZiricwa1Fn70eyl8z6TIVEzJsq8r+CEHb3kRMftUMgaksTldPnsGUryzCjHjFru
	F0qOp9DvYwE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E9F64F247;
	Thu, 31 Oct 2013 20:09:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 734A14F245;
	Thu, 31 Oct 2013 20:09:43 -0400 (EDT)
In-Reply-To: <20131031234514.GC41460@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 31 Oct 2013 23:45:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E8CAD8F4-4289-11E3-A1A0-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237197>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> RFC 5321 forbids lines exceeding 1000 octets (including CRLF).  RFC 5322
> forbids lines exceeding 998 characters (excluding CRLF).  If you want to
> get around that, you need to base64-encode the content, which is
> generally discouraged when sending patches, I believe.

All true.

A message like the one posted before and got a positive "wow, good
work", is a good thinkg to motivate somebody to work on bringing the
codebase and build procedure to aspire for producing that table from
within the build procedure; I do not think this information fixed in
time belongs to the source tree (iow, making it into a patch form is
of no use).  It will go stale over time without a way to automate
the synchronization somehow.
