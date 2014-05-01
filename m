From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] CodingGuidelines: give an example for control statements
Date: Thu, 01 May 2014 11:00:32 -0700
Message-ID: <xmqqk3a5crb3.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-5-git-send-email-gitster@pobox.com>
	<87ppjxziyo.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 01 20:00:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfvHw-0004IZ-C1
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbaEASAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 14:00:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65430 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbaEASAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:00:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10189111CA;
	Thu,  1 May 2014 14:00:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yLZoa+H4n/sMb4otvd/JAGnRYFs=; b=v6wRAX
	sipsodVpS27cWhj+WvcDYp9bRoh22LOmFqKel/EIR0JcJCcOLLVIBlMN4YjTKBKC
	ptxxiIxVtIL1WAS4HBwgLBaTNH+eLbvz2PxPATXFT1iaDJySIyA5a63TZsXIqw80
	EBEZsGNI4NR2nQFff1xwLmc2RljmibBPQeMp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xmAatSQfRqkpKfITKZ56ql3CHrnJCmPy
	uV8iUEgn6TZHaMsmOjxpvkmPfMImArCvTgKBNhuSEQZx5eIlKNN+MRC2kvoxE1J0
	NIQ+flcSK+6gRUHliPg3KnsBzA4iliryrafKL6gmD6wxnGHCha4FgvDj+s+vMVZK
	gTaxpCUMNLQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01B9B111C9;
	Thu,  1 May 2014 14:00:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E9C85111B6;
	Thu,  1 May 2014 14:00:33 -0400 (EDT)
In-Reply-To: <87ppjxziyo.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 01 May 2014 16:12:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7DD5A8A2-D15A-11E3-BE13-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247819>

David Kastrup <dak@gnu.org> writes:

>>   - We do not write the noiseword "function" in front of shell
>
> s/noiseword/bashism/

That is outside the scope of this patch, but since you brought it
up...

I did consider between noiseword and bashism when I wrote this part,
and decided against "bashism".  XCU 2.4 "Reserved Words" lists it
(among others) and says

    ... may be recognized as reserved words on some implementations
    ... causing unspecified results

Even if "bash" were not the only shell that uses "function" keyword
to introduce a shell function definition, we wouldn't use it.  As we
say in the introductory part, we may say "It is not in POSIX, but it
is supported so widely and using it give us so great a benefit, so
we do use it" for some things, but "function" is not one of them.

The reason is because it is a noiseword and its use is not necessary
in order to define a shell function.
