From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Mon, 10 Jun 2013 00:00:30 -0700
Message-ID: <7v1u8amovl.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
	<CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
	<7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
	<20130607191643.GA31625@goldbirke>
	<7vwqq5snzi.fsf@alter.siamese.dyndns.org>
	<20130607204430.GD31625@goldbirke>
	<7vk3m5si4h.fsf@alter.siamese.dyndns.org>
	<20130608001147.GA32350@goldbirke>
	<7v1u8bouam.fsf@alter.siamese.dyndns.org>
	<CALkWK0kvSvK=bFJo13=yw+2EZmGyv46_DUEZaniYGCe7D_V2wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulw5m-000292-LG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab3FJHAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 03:00:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab3FJHAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:00:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E9F126B6C;
	Mon, 10 Jun 2013 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZuDSVYtdAIi9mG7JKVcylqzpTg4=; b=EUnPVV
	28YTFTj1pdKqpIV1JK8COPIWEzDnjCyhAEG9iGgw+GxzZ6cmhcXwKQG6zfLeYj1Z
	9fFuYGtmkgQe9Hq7PyH97RK3DGJWqXk6KamzdOngSMwn1uNi1yxmdw24OLXj6w97
	cEvMJoGgZxj3QyOG+yVVITQO+RghwrWJmhJ3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnQA9PMvcL3q0Y9QVhqUWWNl4KBL6jnV
	J6D05IcCVVMxjkB6w/zM70i6F0GPLyGMB8tVuN4m/ZMxb6Sv4Q8rcfEyPalhsvJc
	2SudYhL5rnPyRD28vPu4m0VWGjuHoB51+LTOSCM0ZM6kYYvnTrf4+nnJY+ZDSEKj
	rUD9CrMra2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8592626B6A;
	Mon, 10 Jun 2013 07:00:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6D4A26B67;
	Mon, 10 Jun 2013 07:00:31 +0000 (UTC)
In-Reply-To: <CALkWK0kvSvK=bFJo13=yw+2EZmGyv46_DUEZaniYGCe7D_V2wg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 10 Jun 2013 11:55:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70F1506A-D19B-11E2-8E05-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227245>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>     Revert 77c1305 and 3c3b46b
>
> The core of the argument seems to be that
> __git_complete_revlist_file() is a misleading name for the completion
> done by archive and ls-tree, but __git_complete_file() is somehow a
> less misleading name?  Irrespective of what the valid completions of
> the various commands are, I want to know which completion function
> will be _used_ when I'm reading the script.  And that is
> __git_complete_revlist_file().
>
> To me, it looks like mega-bikeshedding; a huge amount of time and
> effort going behind a non-functional variable rename (and the best
> part? the rename isn't getting us a "better" name; just a "historical"
> name).  But whatever.

To me the most important part is that we have two separate functions
that are used consistently by how the completion is to be done for
their users.  The complete-file variant can then lose the A..B range
completion, and then be given a better name than FILE to express
what it does if somebody can find one.  When it happens, the same
better name should be used to rename complete-revlist-FILE by
replacing the "FILE" part.

I initially thought that FILE referred to the pathspecs (i.e. the
last part in "log <rev> <file>"), and felt it was strange to call it
FILE.  Perhaps that (i.e. it not being pathspec) is what you find it
misnamed).

But it turns out that in the context of these functions it refers to
"what users consider paths in objects stored in the object database"
(as opposed to working tree paths).  That is what ls-tree would take
(i.e. <tree-ish> and <tree-ish>:<path>).  And I do not offhand think
of a better name myself to strongly oppose to using the word FILE to
refer to what it does.
