From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/GSoC] Proposal: Make git-pull and git-am builtins
Date: Wed, 25 Mar 2015 10:54:50 -0700
Message-ID: <xmqq4mp92c9h.fsf@gitster.dls.corp.google.com>
References: <20150324163730.GA8366@yoshi.chippynet.com>
	<xmqqwq265jjl.fsf@gitster.dls.corp.google.com>
	<CACRoPnTL78ZrqPYYNPkNcW7vConHZXZ66z5P2=3HySrtmZKcrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YapWM-0003LB-GU
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 18:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbbCYRzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 13:55:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753216AbbCYRzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 13:55:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B721C42F94;
	Wed, 25 Mar 2015 13:55:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZGphH7GcyfgD9bbURAgo/C+HOac=; b=ET/B2i
	5lHT4sKVAeH/AGhI5mNz7fimRKA7Y3LtOyr0HmOkDKsA6ZG6YPO+UyLiSYWcmE0d
	Ct3YX4zw3FA8zx4Et8vWH/SFJp6lBfva1xGsBDeyfYN9c6UyBTixnhfe3V/dNgG/
	+VdaLq1T4YPq01aC3MwMoA90BLa8l4GmLvHCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpIZaFM5vO04Hb2aOczmJFwfYe7Nu5bU
	qMyyKZpIbz0I1RwK9H0bKP0f7g3KjXNJCyVJ7oUoC0pQDSLZFTFvcl3XwWsyhm7c
	eVIwpyPlh00ZMT485yx357EOHiq3NMcVKRMXeMsWleyRREUttBBs3dC55g13MM9G
	Uk1sYTa7/Vc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 656B042F91;
	Wed, 25 Mar 2015 13:55:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE79C42F83;
	Wed, 25 Mar 2015 13:54:51 -0400 (EDT)
In-Reply-To: <CACRoPnTL78ZrqPYYNPkNcW7vConHZXZ66z5P2=3HySrtmZKcrg@mail.gmail.com>
	(Paul Tan's message of "Wed, 25 Mar 2015 13:55:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09603AC6-D318-11E4-A1E4-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266288>

Paul Tan <pyokagan@gmail.com> writes:

> I think it's still good to have the ideal in mind though (and whoops I
> forgot to put in the word "ideal" in the text).

Using or not using fork is merely one of the trade-offs we can make.

"If all other things are equal, no fork is better than a fork" is a
meaningless statement, as all other things are never equal in real
life---doing things internally will have a cost of having to clean
up and a risk to get that part wrong, for example.  Engineering is a
fine balancing act and setting an absolute goal is not a healthy
attitude.
