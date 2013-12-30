From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Mon, 30 Dec 2013 11:44:57 -0800
Message-ID: <xmqq4n5qrume.fsf@gitster.dls.corp.google.com>
References: <20131226202805.GV20443@google.com>
	<1388131515-3015-1-git-send-email-rkagan@mail.ru>
	<20131227200708.GD20443@google.com>
	<20131227203443.GA9189@dcvr.yhbt.net>
	<7veh4yj5mm.fsf@alter.siamese.dyndns.org>
	<CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Benjamin Pabst <benjamin.pabst85@gmail.com>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Mon Dec 30 20:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VximI-00061T-CR
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 20:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab3L3TpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 14:45:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116Ab3L3TpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 14:45:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293A35F854;
	Mon, 30 Dec 2013 14:45:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mZ2/K/vCuvwFHC2RxTg1IFz2oYY=; b=aPZt+A
	n5qtJNwVPDhXLzaJfc10au8Hd0ASaSWSi0Ngm7z7P7w8aJZFpWVjwhrICKY6keHC
	TciicJi55HGUYI6aQQ37jBM5XKSDnvcTQIAfWA9Ylvi8OIuyJrDapKtxrNfoYmOe
	3/apDg4cld9Az4QCy+sE/eswQB0hEQfZ4hbaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DX4abhAZXOUuOemjbyISv5FzFAudpxy1
	rFMxqzDWsk/dR5msL0ZB92SUoIEQW1I3/Be170HEiy7yW0NclvDdy9Qd9PpZDZEG
	wzg2N3yMbPjbzhY1fOQLH1ESMvTOx6Xii0dMAJqZktjtRQstq4nBRvIS4pGWhMu7
	9SdIutGltUY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1427F5F852;
	Mon, 30 Dec 2013 14:45:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB6F5F84E;
	Mon, 30 Dec 2013 14:45:00 -0500 (EST)
In-Reply-To: <CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
	(Roman Kagan's message of "Sat, 28 Dec 2013 13:58:22 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE5BD532-718A-11E3-AF97-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239818>

Roman Kagan <rkagan@mail.ru> writes:

> 2013/12/28 Junio C Hamano <gitster@pobox.com>:
>> Eric Wong <normalperson@yhbt.net> writes:
>>>   git://git.bogomips.org/git-svn.git master
>>>
>>> for you to fetch changes up to 2394e94e831991348688831a384b088a424c7ace:
>>>
>>>   git-svn: workaround for a bug in svn serf backend (2013-12-27 20:22:19 +0000)
>>>
>>> ----------------------------------------------------------------
>>> Roman Kagan (1):
>>>       git-svn: workaround for a bug in svn serf backend
>>>
>>>  perl/Git/SVN/Editor.pm | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> Thanks. I almost missed this pull-request, though.
>>
>> Will pull.
>
> Thanks!

That's redundant; the project should thank you for contributing, not
the other way around.

> I'd like to note that it's IMO worth including in the 'maint' branch
> as it's a crasher.  Especially so since the real fix has been merged
> in the subversion upstream and nominated for 1.8 branch, so the
> workaround may soon lose its relevance.

I do not quite get this part, though.

If they refused to fix it for real, it would make it likely that
this workaround will stay relevant for a long time, in which case it
would be worth cherry-picking to an older maintenance track.  But if
this workaround is expected to lose its relevance shortly, I see it
as one less reason to cherry-pick it to an older maintenance track.

Confused...
