X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: introduce --parents parameter for commands branch and tag
Date: Mon, 20 May 2013 16:10:08 -0700
Message-ID: <7vbo85s0xb.fsf@alter.siamese.dyndns.org>
References: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de>
	<1368648883-9412-1-git-send-email-tobias.schulte@gliderpilot.de>
	<20130520221340.GA8781@dcvr.yhbt.net>
	<7vobc5th0c.fsf@alter.siamese.dyndns.org>
	<20130520224645.GA9557@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 May 2013 23:10:22 +0000 (UTC)
Cc: Tobias Schulte <tobias.schulte@gliderpilot.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=akQuWaslSgigCW9t0o62zPh81LY=; b=QEo9em
	l9v+Kd8czoNZGWxU9G9fbWY3twTxlxjxYggWT7VASxo0ClVYuGCcZksSAo+N+Gg5
	Gk+vq+yIoCoZZ1OrvOVqjsciKep4YhQoN6aNdiZAYAxmJdC8Eh6IUCxrI2KSv7IH
	vLTgZO5pWZfrGX2VHt766wwH5EZ39wIHRx7Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OmK8r9QUFrSkGd0VDHkthyt017iUjVoA
	SFX6UnGl0KXGFMFiMddkP4SFfNO/2tu/W0gJ/nlninfa1OTisrmjyOBDG1tSLdsd
	Iw3QwmgtwsA1N+NqJpyzN46gyxZoP92ELfMlFXBcZafBfNupbWZ0rpBWoct03Ig+
	502oqQHr/l8=
In-Reply-To: <20130520224645.GA9557@dcvr.yhbt.net> (Eric Wong's message of
	"Mon, 20 May 2013 22:46:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B2F3A24-C1A2-11E2-BE03-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1UeZDh-0003U0-3c for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 01:10:21
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758441Ab3ETXKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013
 19:10:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65531 "EHLO
 smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1757095Ab3ETXKL (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 May 2013
 19:10:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A1F20D29; Mon, 20 May 2013
 23:10:10 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF76320D27; Mon, 20 May 2013
 23:10:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2509620D25; Mon, 20 May
 2013 23:10:10 +0000 (UTC)
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks; is it a good time for me to pull?
>
> Yes, I think so.  Thanks!
>
> The following changes since commit de3a5c6da194928868b5eee4a9c4d538b4194727:
>
>   Git 1.8.3-rc3 (2013-05-17 12:19:20 -0700)
>
> are available in the git repository at:
>
>   git://git.bogomips.org/git-svn.git master
>
> for you to fetch changes up to f4f4c7fc00e8acf91150c717cf005fc36c1dd120:
>
>   git-svn: introduce --parents parameter for commands branch and tag (2013-05-20 22:05:54 +0000)

Will pull; it looked somewhat funny that the two commits from others
are both from Dec 2011, but I see Jonathan reminded us of them about
a week ago, so all look kosher ;-)

Thanks.

>
> ----------------------------------------------------------------
> Jonathan Nieder (1):
>       git-svn: clarify explanation of --destination argument
>
> Nathan Gray (1):
>       git-svn: multiple fetch/branches/tags keys are supported
>
> Tobias Schulte (1):
>       git-svn: introduce --parents parameter for commands branch and tag
>
>  Documentation/git-svn.txt                | 36 ++++++++++++++++++++----
>  git-svn.perl                             | 19 ++++++++++++-
>  t/t9167-git-svn-cmd-branch-subproject.sh | 48 ++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+), 6 deletions(-)
