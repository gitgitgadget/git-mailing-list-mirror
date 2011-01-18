From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/fast-import: put explanation of M 040000
 <dataref> "" in context
Date: Tue, 18 Jan 2011 07:04:21 -0800
Message-ID: <7v1v4amex6.fsf@alter.siamese.dyndns.org>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20110116022234.GA28452@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 16:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfD72-00039M-M4
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 16:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1ARPEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 10:04:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1ARPEl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 10:04:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5842629A3;
	Tue, 18 Jan 2011 10:05:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SUlFYRoecCfz/3fEkAcCzMr6QI8=; b=pr19tJ
	l4lckAO3s2cRNFyC3IR96Ib2fR1nmp633LFzphMsOEoMN+u5xXeMkXrCZJ47Btgo
	GeHlU8R9OrIYuW7IXfmiWWrCW+zpMEiOgVqWHSHcBednBztYJXrwsThWcODnc5yT
	b1PevkyJqO+UQSexjY++gF2DUqgwZNPOFGWMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XkJpShpVlKTgpTwRjvYa6syDCfp5lO/0
	UElWlXMdsJmGv6NxdVphhfyd48N73aDjDteu98IU6b/lPSYlO/PIfMc4RZB2WzZb
	BbKHtWBANagRidpMBzzqhFRxVASMbHs40GEkRjBx8AEZodCHdZVNUYhNjV4dGI5i
	bknVazsZp4A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC3B7299F;
	Tue, 18 Jan 2011 10:05:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7C2C299E; Tue, 18 Jan 2011
 10:05:07 -0500 (EST)
In-Reply-To: <20110116022234.GA28452@burratino> (Jonathan Nieder's message of
 "Sat\, 15 Jan 2011 20\:22\:35 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5BDCD74A-2314-11E0-A4E7-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165199>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Omit needless words ("Additionally ... <path> may also" is redundant).
> While at it, place the explanation of this special case after the
> general rules for paths to provide the reader with some context.
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index f56dfca..e2a46a5 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -545,6 +542,9 @@ The value of `<path>` must be in canonical form. That is it must not:
>  * contain the special component `.` or `..` (e.g. `foo/./bar` and
>    `foo/../bar` are invalid).
>  
> +In `040000` mode, `<path>` can be the empty string (`""`)
> +to specify the root of the tree.
> +

Thanks, but is "In x mode" an appropriate wording here in the first place?
I would expect x to be some action (e.g. In navigation mode, typing many
keys just beep, and in edit mode, typing most keys just insert -- vi) but
the word "mode" doesn't fit that pattern (unless we take a bitpattern "x"
to mean "the act of creating a path with mode bits x").
