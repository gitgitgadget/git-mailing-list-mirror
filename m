From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 13:44:54 -0700
Message-ID: <7vaa049uex.fsf@alter.siamese.dyndns.org>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
 <7vzk849zxg.fsf@alter.siamese.dyndns.org>
 <20120615193724.GB26473@sigill.intra.peff.net>
 <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com>
 <7vmx449w3j.fsf@alter.siamese.dyndns.org>
 <20120615202441.GA12163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:45:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfdOA-0003fJ-HR
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab2FOUo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:44:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757768Ab2FOUo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:44:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F17348ADB;
	Fri, 15 Jun 2012 16:44:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Op3rl48PcFLOJ/7PZdYWQ4oFBfc=; b=vYnDT2
	ctLieCgArirRjwRq5a0szUbGfFMTOjJwLWvz1qbVTfEq3LtnBG6trAyZB2bj/n+U
	3VvGuX2WDDEzp2k+6z+QMr4tPy9PUTgog4oa+ifYZnQw9UXXxOVCqUgEkAZBiv/4
	wN+BOGNHvZuXj9enStXCSA16yF78oEDiBqhBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ul6BIv72lbf+KKPxV/ZT7AkRWu5Gl7+w
	V9lEDPjuQEYARnM3W31iebLhwMbncvyQB7NQ8bXPUjfT8zHpOvd/Xg+wlPdSOBgE
	Sh9fe/6BnnuH4Nb61XYis5uQFMbdO1n6mB9tjQkZonfj4J5qOz5UFSL0BxuTDAaZ
	k/KcVWfailM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E80D38AD9;
	Fri, 15 Jun 2012 16:44:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88C1E8AD8; Fri, 15 Jun 2012
 16:44:55 -0400 (EDT)
In-Reply-To: <20120615202441.GA12163@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Jun 2012 16:24:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F770E902-B72A-11E1-8D1B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200097>

Jeff King <peff@peff.net> writes:

>   2. If --check is used, then we will not be compatible with diff(1) in
>      our exit code. But diff(1) does not have --check in the first
>      place, so there is no point in us trying to be a drop-in
>      replacement.

Sounds sensible. Thanks.
