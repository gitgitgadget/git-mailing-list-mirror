From: Junio C Hamano <gitster@pobox.com>
Subject: Re: leaky cherry-pick
Date: Mon, 09 Jan 2012 15:19:54 -0800
Message-ID: <7vk450cvl1.fsf@alter.siamese.dyndns.org>
References: <20120109223737.GA1589@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 00:20:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkOVY-0007q3-3I
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 00:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479Ab2AIXT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 18:19:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933450Ab2AIXT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 18:19:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49AEE71F9;
	Mon,  9 Jan 2012 18:19:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sHXl0tYjrg9y8w7+WBzz8s8KH/w=; b=Oh+ZEt
	Z+H6UPNeCH6dWnnsOk3EaK+SxmU34bJxujCKUmj1P8GZG71qmBh0lrozK3Qv6WvG
	ObT7M1DrAPe5zZMoqwQM7hXYN2075zh5Q6C+4pgO9WKwlEXzBOe8pgDXxC9yyWBk
	XwTs4ZpqhG0MdbDK08Pnswu8Dl0AtGmp9oTXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FPTM8HX7o0rqeOsH7yPKyUJ0RaN51Dvb
	bB9pE5C24jgpfLIuNO8tbN1UKAqaPomczHLsmFGBgpNra609Nssbgl+pBDnZlQQX
	HAcYlMoumOOh2U2DBtoZwvOHA7Y7It+KNm8XtsqVEwez74/bf8WnqHdCfWolv+vZ
	qAHC5ecxNQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D8B871F8;
	Mon,  9 Jan 2012 18:19:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C773B71F7; Mon,  9 Jan 2012
 18:19:55 -0500 (EST)
In-Reply-To: <20120109223737.GA1589@padd.com> (Pete Wyckoff's message of
 "Mon, 9 Jan 2012 17:37:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70F670EC-3B18-11E1-89BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188200>

Pete Wyckoff <pw@padd.com> writes:

> I've got a big tree, and rebased 200 commits today using
> cherry-pick.  It ran out of memory....
>
>     valgrind --log-file=/tmp/vg.out --leak-check=full \
>     /home/pw/src/git/git cherry-pick 8d535b6^..2cf53a0

The cherry-pick and revert machinery was written to be single-shot and the
multi-pick feature was bolted on to it later; I am not so surprised if
nobody carefully looked at the memory usage when that happened.

Ram?
