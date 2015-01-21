From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] move MAXDEPTH definition to the cache.h
Date: Tue, 20 Jan 2015 16:24:07 -0800
Message-ID: <xmqqfvb5yo9k.fsf@gitster.dls.corp.google.com>
References: <1421777797-14781-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:24:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDj5k-0005hF-9P
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 01:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbbAUAYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 19:24:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751665AbbAUAYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 19:24:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F4532081;
	Tue, 20 Jan 2015 19:24:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=djL0pEKsXYYM1K0ZlrnDPlIw26c=; b=KpF9Vg
	a+DCfCuNqiUso2uGgUn4rgr84sSlQKkDeG1qFEknxVfi8bOuXwB/oUJuIqcc2wL0
	9RSiObMS3TgMPcRfEThVIvC6hneQaqb83AasNXliNND6cIInLqreqQ2TOxyVfXQ4
	LbV5zC/mgmrzLzPFhEHA+Ckk8UvP4Dmzgmcjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EDMNnzsGgTjDY9ByP4ZtjTwAvI5Ia7at
	5x0vbUZTJOgylpdNPl/EusGQ52SBkJ2ZWVQIK9zi1bnE8skQWAFkqfEXI26BPXfj
	m3FUAROnS+Yn7nfZTxMoAKeiH9B9VnU87z0j4wpmue3KuLdNLwguHnqU5E2JQYS+
	t4UujfuIZY8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5168632080;
	Tue, 20 Jan 2015 19:24:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDC0A3207F;
	Tue, 20 Jan 2015 19:24:08 -0500 (EST)
In-Reply-To: <1421777797-14781-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 21 Jan 2015 00:16:37 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0D4F336-A103-11E4-82AA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262707>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> There are a couple of source code files as abspath.c, lockfile.c and etc...,
> which defines MAXDEPTH macro. All of these definitions are the same,...

Are they the same by design (because there are logical linkage
between these values and there is a reason why they must share the
same value), or are they happen to be the same (i.e. one can be
raised for some reason without affecting others)?

I am guessing that it is the latter, and if that is the case, then
they should not be made into a single symbol.
