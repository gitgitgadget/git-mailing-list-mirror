From: Junio C Hamano <gitster@pobox.com>
Subject: Re: breakage in revision traversal with pathspec
Date: Wed, 11 Sep 2013 12:21:36 -0700
Message-ID: <xmqqmwnjrwov.fsf@gitster.dls.corp.google.com>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
	<522F8ED2.9000408@bracey.fi>
	<xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
	<5230AD23.2050009@bracey.fi> <20130911182444.GD4326@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 21:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpz9-0007h4-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 21:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab3IKTVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 15:21:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab3IKTVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 15:21:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED82D41A2E;
	Wed, 11 Sep 2013 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VyoC4Hn37Y5x3OQOAteF55RlK3g=; b=KCtLGh
	aS71vSJw+9NNTsyfX85Io2l9gkEaEcuKdCTB4fNWGZ09GF+HOWwenneGsreUaD+K
	6odvubhB9prZUSh2yS3ARF+BqNKu+2VNrIhXt/5Pq01vggbHgICQCOPnSzITUleE
	pQuRcmk8sUWLm0aujGMMQEk4uAegTSJyLK7k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bHPCU8sXQLdB1kshVoKj4EWqawCluq5C
	YXMaVlfze9ANKQRqsU5xDOqVOPxeTSiuZgVtTg0owEfZKE1qfgtnGiwMLrFvf1Bz
	+pQWykkeEwzrTgK96aT4RlLVyDYUOdUfo0rp4uIMD6gbMNFK1yamMfousbUAYMwf
	ABvhrGBp374=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A76B41A24;
	Wed, 11 Sep 2013 19:21:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA67741A1A;
	Wed, 11 Sep 2013 19:21:47 +0000 (UTC)
In-Reply-To: <20130911182444.GD4326@google.com> (Jonathan Nieder's message of
	"Wed, 11 Sep 2013 11:24:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6704C440-1B17-11E3-A067-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234602>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I think you're right that dropping the "don't follow off-graph
> treesame parents" rule would be a sensible change.  The usual point of
> the "follow the treesame parent" rule is to avoid drawing undue
> attention to merges of ancient history where some of the parents are
> side-branches with an old version of the files being tracked and did
> not actually change those files.  That rationale applies just as much
> for a merge on top of an UNINTERESTING rev as any other merge.

Sounds sensible.  Thanks.
