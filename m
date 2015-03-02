From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 01 Mar 2015 19:47:40 -0800
Message-ID: <xmqqioekawmb.fsf@gitster.dls.corp.google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
	<CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
	<CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 04:47:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSHKd-0003AB-It
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 04:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbbCBDrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 22:47:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753148AbbCBDrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 22:47:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08AA03CB46;
	Sun,  1 Mar 2015 22:47:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tJZDSmROCxdQnZw2fFYmY1X4Dck=; b=QEXZCl
	Lrb+ZHrt7D6oACYTm8p8JYPJF6mXyv+C1fCp/VEpTuhlcNYt8MExOrcsW+heEYfc
	bwLxJk5IBiNBLF4C2ZL0py+f1tltL7squcT+4WV9cvEcF3htDxTfwZBK3qklO5GF
	l/QYrR0Zucy9AU0tY1prvYbbHz/gajT/BCC/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ww2Twx+jfb7n5cC6n+ync1g7As25djRK
	TWudlb8sGkVLGQbkDllWdUyI0oxT51/Mdja1mJYUqNOJuesRSGd3dG9lWuD41Xwj
	+KoxQ/UbWOUOHg/YsyNCCMhiatN+S49BPegw9IAj5vNXHxPAJffD1mQRyLmYfSOl
	nBy0YVA89Ks=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3A123CB45;
	Sun,  1 Mar 2015 22:47:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B8753CB44;
	Sun,  1 Mar 2015 22:47:41 -0500 (EST)
In-Reply-To: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 27 Feb 2015 16:46:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0ABBE16-C08E-11E4-9C83-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264577>

Stefan Beller <sbeller@google.com> writes:

> A race condition may be a serious objection then? Once people believe the
> refs can scale fairly well they will use it, which means blasting the ref
> advertisement will become very worse over time.

I think we are already in agreement about that case:

    A misdetected case between (new client, new server) pair might go
    like this:

        - new client connects and sends that no-op.

        - new server accepts the connection, but that no-op probe has
          not arrived yet..  It misdetects the other side as a v1
          client and it starts blasting the ref advertisement.

        - new client notices that the ref advertisement has the
          capability bit and the server is capable of v2 protocol.  it
          waits until the server sends "sorry, I misdetected" message.

        - new server eventually notices the "no-op probe" while blasting
          the ref advertisement and it can stop in the middle.
          hopefully this can happen after only sending a few kilobytes
          among megabytes of ref advertisement data ;-).  The server
          sends "sorry, I misdetected" message to synchronise.

        - both sides happily speak v2 from here on.

However, I do not think it needs to become worse over time, because
we can change and adjust as the user population and their use
patterns evolve.  For example, you can introduce a small delay
before the new versions of server starts the v1 advertisement, and
make that delay longer and longer over time, as the population of
v1-only clients go down, for example.

Difficulty (see J6t's comment) in other implementations may be a
more important roadblocks.  It seems, however, that our current
thinking is that it is OK to do the "allow new v1 clients to notice
the availabilty of v2 servers, so that they can talk v2 the next
time" thing, so my preference is to throw this "client first and let
server notice" into "maybe doable but not our first choice" bin, at
least for now.

Thanks.
