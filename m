From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement ACL module architecture and sample MySQL ACL
 module
Date: Tue, 14 Aug 2012 09:12:32 -0700
Message-ID: <7v1uj98nbj.fsf@alter.siamese.dyndns.org>
References: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Novotny <minovotn@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 18:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Jja-0004MG-4H
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 18:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419Ab2HNQMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 12:12:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755082Ab2HNQMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 12:12:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA3416F92;
	Tue, 14 Aug 2012 12:12:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0SqYTgZo12PMOMrFr4zqAROHaVo=; b=MnObH7
	6Aj5rRTEQ84OB78lSDu1Q4x1uYctqIe+inSlSO2l7RckoSG+g1FXLBMf8O9xV5Je
	NKpgI4Klk4zYs0e8cFPs1GoCWixGLPRuTAkRNJv1u5qW9zIaQzLp5sBWpH/SGpw6
	LZf780beQUA+mlU6S93RRI/T60TuvEzVK8o4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G+gRZBWd8nW5mvbpsw3uP4aiBIGvzx3Q
	hmX9Z94bZzIaZBA4OI6wnvKyX9sxr6gY35unP/3anIFDBBfB4H2tBFPLp4LPFTjU
	BVdunM6eJDrdbXupSz7JdqZSSKyukpUX5Yfo620+P7KYtYJPlLnuKvSdo5HfKmxs
	hJkKb4P+1/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 988046F91;
	Tue, 14 Aug 2012 12:12:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16B346F8F; Tue, 14 Aug 2012
 12:12:33 -0400 (EDT)
In-Reply-To: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
 (Michal Novotny's message of "Tue, 14 Aug 2012 11:59:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB5AF03A-E62A-11E1-AA66-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203410>

Michal Novotny <minovotn@redhat.com> writes:

> Hi,
> this is the patch to introduce the ACL module architecture into git
> versioning system.

No, it doesn't.  It adds something only to "git daemon", but does
not affect any other uses of Git.

    Side note: I am not saying other uses of Git must be ACL
    controlled by MySQL database.  They shouldn't be.  I am only
    saying that the proposed commit log message must match what the
    change does.

Please familiarize yourself with Documentation/SubmittingPatches
first, and then imitate the style in existing commits in the history
and posted patches by the "good" developers (you can tell who they
are by observing the list traffic for a few weeks), by the way.

As "git daemon" already has a mechanism to specify what repositories
are served with whitelist or blacklist, I am not sure if this patch
adds enough value to the system to make us want to add further
complexity only to carry more code to be audited for security.

Opinions?
