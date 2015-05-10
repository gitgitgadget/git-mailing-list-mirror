From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple push remotes via aliases
Date: Sun, 10 May 2015 11:46:27 -0700
Message-ID: <xmqq4mnkgtj0.fsf@gitster.dls.corp.google.com>
References: <20150510181703.GC225482@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun May 10 20:46:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrWFI-0003lw-LH
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 20:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbbEJSqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 14:46:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751922AbbEJSqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 14:46:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE0754FA75;
	Sun, 10 May 2015 14:46:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KwNjRfbXFNHAg++w0ElvKnuun3w=; b=YAJ7n/
	PF8HNrEFAS+XZcA+Gnl3XfGt5eYPbW3C4NF8fMBaimocikkNPj8CaBBYOc7j2Jvi
	xODcekr6HPiGVpjV9IT53xLvK5CNfP545YYGwo4EYJ57UJe7HrkD0r4Ceun2EmcA
	OxUMFZLA4PTWnCGVvgkvxbxlQrNJyV3Oi8Yxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DIflHfoBY7XYHq/ciR4vKR4QY97GXzxT
	O7IsoqWdopToMej9Z7XL3aVsvlQf+KzTa0rxavKOJn56Wuc5SYcv9y0xN/f2arnm
	iz5qUl4TKVyDp3I+Zr4OJKAA2V1bPUm3r9FmGSjj+vZzj/b1Ve1C+UNQqPe3Muq4
	/dPVnTCWcjk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6F844FA74;
	Sun, 10 May 2015 14:46:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 257474FA73;
	Sun, 10 May 2015 14:46:29 -0400 (EDT)
In-Reply-To: <20150510181703.GC225482@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 10 May 2015 18:17:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE8E944A-F744-11E4-82F2-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268736>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I recently discovered that it was possible to specify multiple push URLs
> for a remote.  This is useful for me because some of my projects live
> both on GitHub and on my own server, and some live only one place or the
> other.
>
> One feature that I'm looking for, however, is the ability to specify
> those URLs by reference to another remote.

Two issues that immediately comes to my mind are

 (1) how you deal with a misconfiguration that makes a loop;

 (2) how would you disambiguate a local directory and a nickname.

I do not think either is insurmountable and as long as clean
solutions for them are implemented I would say "why not?" for the
new feature.  Of course there may be other issues other than these
two knee-jerk ones.
