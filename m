From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: replace each tab with 8 spaces for consistency
Date: Thu, 07 Apr 2011 00:36:24 -0700
Message-ID: <7vhbaafr7r.fsf@alter.siamese.dyndns.org>
References: <1302156081-3286-1-git-send-email-andrew@andrewgarber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 09:36:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7jlg-0002VB-5w
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 09:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab1DGHgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 03:36:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab1DGHge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 03:36:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C20392301;
	Thu,  7 Apr 2011 03:38:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pYWPQIROJ8ileNCLPgnVRJ3ycGM=; b=VLFwbQ
	l8MqBtBHWMs8anArjepzCek4Ih79SB4NOwZuvt+1S8LD7sobSIgyzpK+uqU0MRn7
	iY/7oo/X13of86OsYBktV5BLd3RMaarG8gDnhR9ahlFOrcgO9dJzQmoeHZHt6jqq
	SPH+ZvdId8VQ+ia3WrFEpfZyWeyAn82WtoMHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kTWKTXt8Xke1PcsngCKTxm6XJzBGxr/t
	D5EaK6Uc58NdS2g4QhiUMWVjKSoLUv/n/k44frntDobb6ukTzPG1IQsOdtms+jDt
	E2j461ZeUbb5UVkcZFKQovC3m3iwkQCAZhLg0Lh3D6qlOQphSc5z4HTiYQEABXkp
	00ALr16qfJE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A047922ED;
	Thu,  7 Apr 2011 03:38:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C140922EB; Thu,  7 Apr 2011
 03:38:21 -0400 (EDT)
In-Reply-To: <1302156081-3286-1-git-send-email-andrew@andrewgarber.com>
 (Andrew Garber's message of "Thu, 7 Apr 2011 02:01:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 051F2A5C-60EA-11E0-9391-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171047>

Andrew Garber <andrew@andrewgarber.com> writes:

> Note that the majority of git-p4 uses spaces, not tabs, for indentation.
> Consistent indentation is critical to the functionality of Python
> scripts: mixing tabs and spaces in Python can lead to hard-to-find bugs.

Mixing tabs and spaces can lead to hard-to-find bugs, I agree.

I just threw this in to my .git/info/attributes:

    contrib/fast-import/git-p4 whitespace=!indent,tail,tab-in-indent

and then did this:

    $ >contrib/fast-import/git-p4
    $ git diff -R | git apply --whitespace=fix
    $ git diff

The changes I get out of the last step seem to exactly match your patch.

Thanks.
