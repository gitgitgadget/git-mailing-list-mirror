From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7800: avoid arithmetic expansion notation
Date: Fri, 14 Oct 2011 11:00:06 -0700
Message-ID: <7v4nzb1mjd.fsf@alter.siamese.dyndns.org>
References: <837ad77348b459aa5f5f79e556dbeeeba41027e7.1318594392.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:00:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REm3O-00038T-OR
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab1JNSAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 14:00:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab1JNSAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 14:00:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9834A6471;
	Fri, 14 Oct 2011 14:00:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4d5fVJl1EYMzC1K5tG0YVl9BkzU=; b=K8YJgV
	64Q2VilClp8N2/Nuv/ly4WDLWqeYJVXvj5pHTFmoRFjMHVHAWnC2kxJu8/pXtM/6
	xjPa07kU4YXJQ7KUnYddIdlKK9sdnJN3Dis/g0fe17eQ98PTwwexQTPXcAP0ouQ+
	BHYiiM3/B+VhcU/69tHdywigrSGRovJ0FimqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=isnFOY57fsHwUgnVVB8mnQKXEWNw1x6p
	quCIqt3fd2d1ZXS+bzmCMTUClvdHGZOTbPjyUHdleTsnXaf1yCQeirpyP+zyv5b1
	xeventNvpNItEr2sTOreI7O+2zka8hbuVXEzf+XCMaEtiX1EmQSIdZinmY1KFw66
	9D0hdg0L9CE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC016470;
	Fri, 14 Oct 2011 14:00:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13C756457; Fri, 14 Oct 2011
 14:00:07 -0400 (EDT)
In-Reply-To: <837ad77348b459aa5f5f79e556dbeeeba41027e7.1318594392.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 14 Oct 2011 14:15:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A415F5C-F68E-11E0-8E0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183588>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ba959de (git-difftool: allow skipping file by typing 'n' at prompt, 2011-10-08)
> introduced shell code like
>
> $((foo; bar) | baz)
>
> which some shells (e.g. bash, dash) interpret as an unfinished arithmetic
> evaluation $(( expr )).

Ahh, thanks, I should have caught this. I recall I rewrote a similar one
to $( (command; command) | command ) more than once before.
