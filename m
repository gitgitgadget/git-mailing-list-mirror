From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 12:12:36 -0700
Message-ID: <xmqqha2iv3kr.fsf@gitster.dls.corp.google.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	<1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	<xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
	<20140713173356.GA8406@sigill.intra.peff.net>
	<20140713183629.GA19293@sigill.intra.peff.net>
	<xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
	<1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
	<xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
	<1405445234.2577.0.camel@jekeller-desk1.amr.corp.intel.com>
	<xmqq7g3ewkp8.fsf@gitster.dls.corp.google.com>
	<1405449076.2577.3.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>,
	"sunshine\@sunshineco.com" <sunshine@sunshineco.com>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:12:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X789h-00033r-1F
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932891AbaGOTMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:12:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52842 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932850AbaGOTMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:12:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3538C29D37;
	Tue, 15 Jul 2014 15:12:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvALlgLkfHwcdvVN8HrBV7gW4lk=; b=AFsoxs
	UCHBP0yhaPANt+TGJiipRzKX2A2p3dzUpvbYtGAwAX3jN2XFJSNsNI08O1jePRuN
	VeDbuimat5u9rO7ZMDybexf+heqd69kbdle4RCx33kx46TECJvnDRxNfzmoIzbE0
	hNkURb2Q7a8qurvSM97JOhgbbdkG2JTiWiB3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1lHjvkXpJvB00fQ14bgABcFK0e+iMg5
	JaC/kl3zKOYgPcnVSzomdBXJ4Yk+daiDK/r4zt9Gi3CHCbGNiSmmVJOrjjkoy8Rr
	pdtyduKNAls4kSI96NMjxKK1QgV8V1eyaydtsQzc6cykRnt8SDDmIONn5F2sy54/
	gjqx6pyU75M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28E4C29D36;
	Tue, 15 Jul 2014 15:12:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1CEBD29D1D;
	Tue, 15 Jul 2014 15:12:20 -0400 (EDT)
In-Reply-To: <1405449076.2577.3.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Tue, 15 Jul 2014 18:31:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F17D6C70-0C53-11E4-831B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253586>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> I am going to re-submit this with an enum-style return. I am also
> changing how we parse so that we can correctly report whether the sort
> function or sort atom is incorrect.

Oh, our mails crossed, I guess.  As long as it will leave the door
open for later enhancements for more context sensitive error
diagnosis, I do not particularly mind a solution around enum.
