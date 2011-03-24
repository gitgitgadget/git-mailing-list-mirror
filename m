From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #04; Wed, 23)
Date: Thu, 24 Mar 2011 00:30:32 -0700
Message-ID: <7vpqphasbr.fsf@alter.siamese.dyndns.org>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 08:30:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2f0P-0001Nb-HP
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364Ab1CXHao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 03:30:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933172Ab1CXHan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 03:30:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7D4B3BEF;
	Thu, 24 Mar 2011 03:32:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Kfcig67ldjPW5Y0kyhkWJnfmc0=; b=mmLQP9
	pLn3eimIPl2rm0/65vvo1FqVe9k4VKt8NMOQBiJYAUm2IW/yWsrz5FdbJuM2Tsor
	EVb68hfeCn4rppvMLanAAuxQOja3NZOlEh4o+RLyi2+02aEM/t4zJgks5zIZDPk2
	W/bBuulW5id3E4nuGWqExpbB1ZTK0wF1vWHtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RFiVtiyaHHmshYVt4R1HBwNSRwEGOSGM
	bonBC61JGCuycM8bcsRtwqp9cGbG8xEC7Q/9HpnXYenxsAClGHYN9PqkjehntP0a
	6Yo0lVTykWywXn5FT4ICyzIO9rY2LwA+TftLtgh2U0DA4b6eNQO+JegQQ6z0jZ6N
	SFnpy/5W800=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B57CF3BEE;
	Thu, 24 Mar 2011 03:32:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CAB663BED; Thu, 24 Mar 2011
 03:32:15 -0400 (EDT)
In-Reply-To: <7v62r9csqr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Mar 2011 16:38:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D93E04DC-55E8-11E0-AAF7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169897>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * jh/merge-sans-branch (2011-02-10) 4 commits
>  . merge: add support for merging from upstream by default
>  - merge: introduce per-branch-configuration helper function
>  - merge: introduce setup_merge_commit helper function
>  - merge: update the usage information to be more modern
>
> There was an objection to the tip one that determines the upstream in a
> wrong way? I've been wanting to move this forward for quite some time but
> also hoping somebody else would send in a final version.

It turns out that most of the change in the series looked necessary only
because the last one tried to implement a wrong thing.  The branch.*.merge
configuration variable names the branch on the remote side to be fetched
and merged by "git pull" and its value typically is refs/heads/something,
not the name of the remote tracking branch of such a remote branch.

I ended up redoing most of it and came up with a two-patch series, which
I'll be sending out shortly.

I won't be doing the tests, though.  At least not tonight.
