From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Mon, 12 Oct 2009 15:49:27 -0700
Message-ID: <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <alpine.DEB.1.00.0910120941150.4985@pacific.mpi-cbg.de>
 <200910122340.13366.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxTky-0006B9-Qk
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871AbZJLWub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757216AbZJLWua
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 18:50:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636AbZJLWu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 18:50:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AACC754DB;
	Mon, 12 Oct 2009 18:49:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ahI72ESAgNzMFrEce8ao3wU+xhs=; b=NVee1P
	t6CcugMoD2SPIpuzWx8vLrt/sbiEhHCNdFIzph0UWwkrOC7fEv/sDSdB4WOfu3B/
	IoTx7TdBGRo3jD9pBJ6e8ooNdESCzExeRoZmfx5EKqWfASkBfQmThAMUUUjAMZJi
	ACiguPCgFjrr9KEhLPaXFjEw3/y6soSVpoN1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sUxPd4+sCvOejrLtefn3izTVCWkDQanl
	AuDxDnTL1rBVRqKVK3/URmFc0dHggyugpQlHjCcBs35WUBW/1z+JoEi/EsD5eguk
	q7pYv9ASNv7oCjNYatQMb+oJSZBeJU0hW3uq37FsUzJTNUDYERtT3SBV7ZfD9wRx
	Fra/zpcmQ7c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2514C754D9;
	Mon, 12 Oct 2009 18:49:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE59D754D5; Mon, 12 Oct 2009
 18:49:28 -0400 (EDT)
In-Reply-To: <200910122340.13366.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 12 Oct 2009 23\:40\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85CBEDB6-B781-11DE-B244-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130088>

Thomas Rast <trast@student.ethz.ch> writes:

> Your idea is also a backwards incompatible change, so we can just as
> well implement the original suggestion and force scripts (or us) to
> use some other means when they want to detach.  Say, why not just
> invent an option along the lines of
>
>   git checkout {-d|--detach} $ref
>
> to make it explicit.

Or can't you go the other way, say

	git checkout -t $remote_tracking

to create a local branch forking from the named remote tracking branch?
