From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] sha1_file.c: support reading from a loose object of unknown type
Date: Wed, 25 Mar 2015 13:32:08 -0700
Message-ID: <xmqqmw3024zb.fsf@gitster.dls.corp.google.com>
References: <5512618B.2060402@gmail.com>
	<1427268105-16901-1-git-send-email-karthik.188@gmail.com>
	<xmqqzj7028mn.fsf@gitster.dls.corp.google.com>
	<55131885.5000706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:32:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaryK-0001Iv-2I
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 21:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbbCYUcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 16:32:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750873AbbCYUcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 16:32:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B848142ADF;
	Wed, 25 Mar 2015 16:32:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pXuc30nmc9CfKQkbnisoQhytiB0=; b=w5RHaA
	uCKKQtiE7oo0mCqm7VzbHTDr68CLqLrPtPMl1HiMzQXMxH0whRJvfTAr+9uPUc3o
	cE+vs8U62p4xbJNVSPOv0SIz/9PShYhvfvGd2PCeT1ty/NYcufE5p6LDgKr7u6JF
	cMiPuB34hSAX15x7sM3xhaGfYnlgYdjW1QS20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVOk2A580pmxwVArkVzMwM2D40K6bCeq
	SJuJn1jkLOR9KSNC3B3IP8YVrKqhMig/mk9TlVGbJopjpvr5PGFRapVRZc8CQ8dA
	09XMkLAdVAQZIRq2ojL15QBHTJyiEx3UAcZh9R57zD09mzFbqLoAZCJNz04U3RRF
	iihhY5SSEwU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B02A442ADE;
	Wed, 25 Mar 2015 16:32:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 349D342ADD;
	Wed, 25 Mar 2015 16:32:09 -0400 (EDT)
In-Reply-To: <55131885.5000706@gmail.com> (karthik nayak's message of "Thu, 26
	Mar 2015 01:50:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02868758-D32E-11E4-8017-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266301>

karthik nayak <karthik.188@gmail.com> writes:

> I hope you meant the former.

I did mean the latter, which spends more lines without much
information (i.e. only closing braces), only to reduce the
duplication of two simple lines.

But you are right, I did miss the distinction between hdrbuf.buf and
hdr, so they are not identically duplicated.
