From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] t4059: test 'diff --cc' with a change from only few parents
Date: Sat, 11 Apr 2015 22:51:10 -0700
Message-ID: <xmqq1tjp6gj5.fsf@gitster.dls.corp.google.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
	<1428076716-4449-1-git-send-email-max@max630.net>
	<1428076716-4449-2-git-send-email-max@max630.net>
	<xmqqa8ye5q7m.fsf@gitster.dls.corp.google.com>
	<20150412054332.GA28555@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Apr 12 07:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhAnd-0006ZK-BR
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 07:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbbDLFvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 01:51:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbbDLFvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 01:51:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE34348F05;
	Sun, 12 Apr 2015 01:51:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tdx0Ah4wWQVvFZwtefObAhV6DF4=; b=FLJwPU
	zbknpA6341+FY4cyLhd0RfDvOvPXYEzm0/35gMe0i6cB3LdKBsad4WCC7gw/bP38
	oHPKQ56lMEeV44NuVbgp2veBI2R9MNGVM390K7FXYYqg25Ks+Ufu1QoOZK6eBsuS
	02bVbKT4gTmB5oxx+fG1pLr2rply1WvpXeEn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rSHcak5O+9woV2xyh1HSGc+FaIrSwnug
	2N8iZDzW7kAu0LJRmqNYPAtLHD7ZYbeMnacMV6OwxCnkcpxX30LituBuc9YtJFYj
	gqMStNa5giU2jYV7S9hAHJdQSd4U0gdO1YaW6fsILl086Ec8EexAxFC+IRVlRWGU
	jbxCo6pqUP0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA3A848F04;
	Sun, 12 Apr 2015 01:51:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FE6648F02;
	Sun, 12 Apr 2015 01:51:11 -0400 (EDT)
In-Reply-To: <20150412054332.GA28555@wheezy.local> (Max Kirillov's message of
	"Sun, 12 Apr 2015 08:43:32 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC3E64F4-E0D7-11E4-BBBC-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267039>

Max Kirillov <max@max630.net> writes:

> My exact case was that there was a change in one branch
> which was overwritten during merge conflict resolution by
> fully acepting the other branch - in a 2-parent merge. I
> started looking for a way to visualize such cases. They
> are not visible in usual diff, because they look same as
> accepting change compared to the unchange branch.

Hmph, isn't that exactly why "diff -c" exists, not "diff --cc"
that omits (usually) uninteresting hunks?
