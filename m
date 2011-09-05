From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add option -h
Date: Mon, 05 Sep 2011 13:08:39 -0700
Message-ID: <7vk49mbvlk.fsf@alter.siamese.dyndns.org>
References: <20110903170612.GA3536@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 05 22:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0fTM-0002l7-C2
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab1IEUIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 16:08:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686Ab1IEUIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 16:08:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21326423B;
	Mon,  5 Sep 2011 16:08:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xRN49847PNIFGwqWQdEGaj1IWKw=; b=axwceZ
	EuCstIi+5I3Y4ex9gBYySvZsXHnPrVt7YdPO2srydqpW57RSoB2/jdjd5LeLm+I3
	hEncVZJWFDoyj+ipUSkuikJyBQBCvX7m+oC1vuECJ0E6+R2IP13yhlFjJhV22t6U
	9D8vAweJ9MuaWdpT8SeyECpJNg07DpitBL3hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pARkBno+kESnJhm2KOcaT8wWcwVKangP
	Hot9Qzw+axD5mlrvgM8qSjdSPD22Ll3l+AAIxiN5aB36iuLtyHKCUS+GcO1t0T5b
	UUvULO8r6AOujRK+aOcFwYWrDeXxZIPE/rW7cIW1Cjz5NaxC0/JQiFc6wyeBj41m
	Rx046alvm/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A771423A;
	Mon,  5 Sep 2011 16:08:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F7224239; Mon,  5 Sep 2011
 16:08:40 -0400 (EDT)
In-Reply-To: <20110903170612.GA3536@ecki> (Clemens Buchacher's message of
 "Sat, 3 Sep 2011 19:06:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D92ECD8E-D7FA-11E0-96EA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180757>

Clemens Buchacher <drizzd@aon.at> writes:

> Most other git commands print a synopsis when passed -h. Make
> send-email do the same.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ...
> +my $help;
> +my $rc = GetOptions("help|H|h" => \$help,

I do not think what the patch aims to do is wrong per-se, but

 $ git send-email --help

already shows the full documentation, and I find it is misleading to say
"help|H|h" here to pretend as if a long-help is triggered with this
command. For that matter, do we have any other place that accept -H for
help?

IOW, shouldn't this line be this instead?

> +my $rc = GetOptions("h" => \$help,
