From: Junio C Hamano <gitster@pobox.com>
Subject: Re: speed of git reset -- file
Date: Tue, 31 May 2011 14:54:05 -0700
Message-ID: <7vpqmyilj6.fsf@alter.siamese.dyndns.org>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 23:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRWtI-0007AV-92
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 23:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658Ab1EaVyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 17:54:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758298Ab1EaVyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 17:54:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64356578D;
	Tue, 31 May 2011 17:56:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NI6fePLQnXxDy4u0PZnoh2Lp8xM=; b=gukRE8
	n5UmS+/BbKAlr2CSu9tXroamrBn3UOAa1nRnHTCeMwoTe9elP4FuunhKFnW2TgWS
	XAhJKaszt2POAn3upA6UvHsfvsFL5p+ZRISv9kJZfMmgiNHaNhxexMhv0vWpSlxX
	hxguIXHjh9eeesk3kuQ8DFloSbIy0CzHodVwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rOvp/vL5129emh2biEUWGeewXktYZzdl
	8Khutzhb73IuS3hrybYVp+8+uV42lDtzyplqfxa7FKwudClTtJ384AwOS8Vd27KP
	creEAxUss81xu9AQ35/lgSHcuuDWJ5GriaOT6L0F9ZPTrnk1eigf9eQ36SjXzitB
	I3vPodlSv3c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DDF6578B;
	Tue, 31 May 2011 17:56:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F41EB578A; Tue, 31 May 2011
 17:56:15 -0400 (EDT)
In-Reply-To: <20110531212639.GA13234@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 May 2011 17:26:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D13E2686-8BD0-11E0-8DE7-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174832>

Jeff King <peff@peff.net> writes:

> Conceptually, no, I don't think so.

Hmm, don't we have to say like all other reset types which paths are
dirty, i.e.

  $ git reset HEAD -- diff.c
  Unstaged changes after reset:
  M       diff.c
  M       diff.h

which would mean we would need to refresh the index anyway?
