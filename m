From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 2.0.0 regression? request pull does not seem to find head
Date: Mon, 02 Jun 2014 14:27:25 -0700
Message-ID: <xmqqzjhv2e9u.fsf@gitster.dls.corp.google.com>
References: <20140602210131.GA17171@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:27:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZlY-0005i7-OB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbaFBV1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:27:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59662 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbaFBV1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:27:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 896A21D1C9;
	Mon,  2 Jun 2014 17:27:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fCAIjbNIXM0gvrNfqxiRZFB/aFE=; b=A4OJPG
	24Zs9tVVh+8bGuRoYmiaZdE/Rp3Aofgzpx/Zyhc1s3ttDQ1Q3wdMSZs1doaXvy7I
	rLvdcB8v/b/+idVY/aQ9tUB2P+XcOVBYOSYRHCjmAB1ZK5xgh28pnnZx+xv5FXEA
	Z/yzPzOx3XlKPAuvrRfvwD2asB86f2JLj7tYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w9w7rSIJKBt5p+ZjD36sV4r95YDPzxuo
	r8+KaOFWkBWr0fVRhTVeKPAphX8DGmj/ocduU5cJ8juOviP0Wm4BFmkDz1Qc64bE
	xwIJ+0MKepP9x8mizkK7d56FMD3hYZxH2Yd8LlVgGcP6BlWV29NNDKkvs0GTJVAW
	mGsj13lQry0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80B981D1C8;
	Mon,  2 Jun 2014 17:27:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF9F21D1C6;
	Mon,  2 Jun 2014 17:27:26 -0400 (EDT)
In-Reply-To: <20140602210131.GA17171@redhat.com> (Michael S. Tsirkin's message
	of "Tue, 3 Jun 2014 00:01:31 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1CAE176-EA9C-11E3-89EC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250597>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Looks like pull requests no longer work for me on linux.

Wasn't "does not seem to find head" was very much deliberate?

Linus's patch wanted the users to explicitly tell the tool, without
tool trying to be too helpful and risking to guess incorrectly.

> Some other trees (non-linux) work fine but I didn't yet
> check whether it's the local or the remote tree that's
> at issue.
>
> Or maybe it's a configuration change that I missed?
>
> Note: I have
> [push]
>         default = matching
> configured in .gitconfig.

This should not affect anything in request-pull, I think.
