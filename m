From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Sun, 12 Sep 2010 10:44:18 -0700
Message-ID: <7vfwxeeu19.fsf@alter.siamese.dyndns.org>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil> <7vy6bajvnd.fsf@alter.siamese.dyndns.org> <1464835923.7527323.1284144028047.JavaMail.fmail@mwmweb047> <1529126586.2758911.1284228699341.JavaMail.fmail@mwmweb045> <7v39tgf5zw.fsf@alter.siamese.dyndns.org> <1982035721.2791029.1284236591083.JavaMail.fmail@mwmweb045>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, Brandon Casey <drafnel@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 12 19:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouqbl-0001X0-FZ
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 19:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab0ILRod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 13:44:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0ILRoc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 13:44:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DED77D5FFD;
	Sun, 12 Sep 2010 13:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D8ZTZKbpDKegzaxC6lCqzJE60Qo=; b=JSu2Gs
	ylTsuEsa3NqGbTrkli00fJWqDB90f10uGPqFRdMWL7kg/eTmGp+DxRhKoumcSgiG
	7+EjPFoznq5LFGDfn89rEFmCi1299FLlmFLxOux18J+8lah74fMkWNUdxkODZqzM
	Yza3ND58zi4lM7AI/86rGB1f+PbJf1Cxpk7Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k1U8p3oCmMbgGA3d/9YnMxS15aW/5EmC
	gPhWUKqDCvnF0S2Z+YkCOrXcoY9X4OcaTui30Jmb0BQ/xoWWlFl3hw4Roe5WQmrn
	cHD82TdCJLChaOyuPF5fdWJ6C7i7y8TY4WO/71xJhBKiSpIl6fA9KhzMeVM1I9kk
	nPXwVwTIKYM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87FA6D5FF8;
	Sun, 12 Sep 2010 13:44:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CC21D5FF7; Sun, 12 Sep
 2010 13:44:19 -0400 (EDT)
In-Reply-To: <1982035721.2791029.1284236591083.JavaMail.fmail@mwmweb045>
 (Jens Lehmann's message of "Sat\, 11 Sep 2010 22\:23\:11 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63084B5A-BE95-11DF-999A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156040>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>Jens Lehmann <Jens.Lehmann@web.de> writes:
>>> And maybe we should teach "git describe" the "--ignore-submodules" option, then
>>> you could tell describe what to pass to the diff-index command. Thoughts?
>>
>>It is sensible to add the option, and handle_ignore_submodules_arg() call
>>to grab "diff.ignoresubmodules" configuration) to the command, perhaps.
>
> Ok, I'll look into that and prepare a patch.

Thanks; and thanks for biting my sanity check weatherbaloon ;-)
