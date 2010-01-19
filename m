From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Tue, 19 Jan 2010 09:29:38 -0800
Message-ID: <7v1vhmatq5.fsf@alter.siamese.dyndns.org>
References: <4B547EA6.5070203@isy.liu.se>
 <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com>
 <4B555BA1.90605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	Jens.Lehmann@web.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXHu7-0001rd-It
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 18:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab0ASR3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 12:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327Ab0ASR3x
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 12:29:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0ASR3w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 12:29:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5FF9261D;
	Tue, 19 Jan 2010 12:29:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c/5LaayCSioA+Y8kSL6Yl9hpVMA=; b=DEQIDE
	wqpyy3RHT2HU4P76jaJyC7ZEizCzY067u166F5SW9wAKttuJqTQyFF9i/VIkLM2R
	mBBcu+ceJhD8xKGpEvVwBU4cwvsh8raZ3rjdi8ecUaawm22uEIEy2A8Yv+Zfu8Td
	hGhxYOj2T3K9Tdw0vBxRP6xax+jqka05W/7ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3nzt54/IR5rzhcxuL+pU4I9SeEybXfx
	mbhSvZxPiSGTK90Gi8cnL5OqoiB0OUsviYn96fIsZUD8P0XrE/tS3GKPlLF29kMb
	+OwVoyBOC3EOYiPjotar0qmI80lh+nlRS+u8oSPKjFBGosRKfjR8DDiedCCSVKH+
	HRl4ruc+Jsg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB64792612;
	Tue, 19 Jan 2010 12:29:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F021F92608; Tue, 19 Jan
 2010 12:29:39 -0500 (EST)
In-Reply-To: <4B555BA1.90605@viscovery.net> (Johannes Sixt's message of
 "Tue\, 19 Jan 2010 08\:13\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3CAA9F6E-0520-11DF-B174-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137476>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jacob Helwig schrieb:
>> If there is no output from git status in the submodule, then git
>> status in the superproject shows the submodule as being clean.
>> However, if there is _any_ output from git status (untracked files,
>> modified files, deleted files, new files), then the superproject shows
>> the submodule as being dirty.
>
> But isn't it a bug that a submodule is considered dirty just because an
> untracked file appears?

My take while commenting on this series has been that we have been buggy
not to show submodule dirty when the end user may have files he forgot to
add, just like "git status" reminds them at the end.
