From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git show" does not use diff.external like "git diff" does
Date: Tue, 28 Dec 2010 09:52:45 -0800
Message-ID: <7v39phyec2.fsf@alter.siamese.dyndns.org>
References: <201012281510.oBSFAMm14943@momjian.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Momjian <bruce@momjian.us>
X-From: git-owner@vger.kernel.org Tue Dec 28 18:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXdlX-0006n4-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 18:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab0L1Rwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 12:52:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab0L1Rww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 12:52:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2C9639DC;
	Tue, 28 Dec 2010 12:53:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mq+kHqtwiAaC4Z1P6seiNLjHrc8=; b=Uq9hVZ
	+1HZWHBGPmWCalbKBK9ApOeDHxCEXdq+R8eTUrLkRdv+OyN4vU2196FmkDTt8laO
	jRg5SDG/d1fX9knFOCR6Ui64AdKANUoc7aTT9F1lalRn4JU/goCEbGcnJiRJmJuo
	WKXHMT+JZRbrCF92vPXOLNY+r/jGgBzPEwRjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CPgYqmKWug8ey17Fnhy7Uj0BhA8E5kK5
	/Ry3teXJC7QSJC9hzNAb3diiYjP3hsW92cAwpzPDOnzTWm06Q0pS6fhKLcrKaLfs
	A8m8KZzlR/9D99SN0vVsR86apNNovF59z9WgeFMLF4CwlAW3io/RE0uQAPGX6tmo
	SO/JhndlIvs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F47039D8;
	Tue, 28 Dec 2010 12:53:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A368339D7; Tue, 28 Dec 2010
 12:53:18 -0500 (EST)
In-Reply-To: <201012281510.oBSFAMm14943@momjian.us> (Bruce Momjian's message
 of "Tue\, 28 Dec 2010 10\:10\:22 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C20A3EA-12AB-11E0-8BA9-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164278>

Bruce Momjian <bruce@momjian.us> writes:

> I have diff.external configured properly, and it is used by "git diff",
> but "git show" does not call the script and only returns unified diffs.
>
> Is there a way to make "git show" use an external diff script?

"git show --ext-diff"?

We end the Description section of the manual with "This manual page
describes only the most frequently used options." without explicitly
saying "Options from the underlying this and that commands can be given as
well", which is rather suboptimal.

The only existing hint there is one sentence before, "The command takes
options applicable to the git diff-tree command...", but the reader needs
to be both careful and vaguely familiar with the way the git command set
is structured to take advantage of that hint.
