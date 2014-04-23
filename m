From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to trim the fat on my log graphs
Date: Wed, 23 Apr 2014 10:30:43 -0700
Message-ID: <xmqqha5k0x8c.fsf@gitster.dls.corp.google.com>
References: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
	<xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
	<CAHd499AovROt2fVAvh-ST9Vb7Hq8LpUS68i4eXWZaNszuKeUfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:31:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd10i-0006v9-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757790AbaDWRay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:30:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34754 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757667AbaDWRar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:30:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDEC87EBA5;
	Wed, 23 Apr 2014 13:30:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/V+v7IfJmtjweIg6EmqXJGbf0j0=; b=aNF3Q6
	6M/ndIblCGWFEz4Nl2YcuIppb4wsejEW7dut8ttU7tTWn4oVCY9NICq1yop7L+67
	l+ujPFZvd74eNL9csAjGxqpQicpdh61B0WoEg7TqTkAjk0v1mYZdkp4OMZt89i/c
	VHsHMH8sl+t6bPuS+YcAetFNzg/z+Fhnmn9Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pGukUUC+MwZCzbTi3YNmHRoLMh6D5k1K
	BXAi0Tjb/sLBBej5ULc3BaO6pAxUZVBP07qPk8EeuxyQb2l39BH2UdPOFTpJwzAy
	WgvLYWyTQzd9W8uqGkcvl81ZrqrXGgEs++lrFkVoT650PvpKBtBl3p6WqvYNl1N2
	c/5r2Zpg+t4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C62FE7EBA4;
	Wed, 23 Apr 2014 13:30:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E50A27EBA2;
	Wed, 23 Apr 2014 13:30:44 -0400 (EDT)
In-Reply-To: <CAHd499AovROt2fVAvh-ST9Vb7Hq8LpUS68i4eXWZaNszuKeUfg@mail.gmail.com>
	(Robert Dailey's message of "Wed, 23 Apr 2014 11:32:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0034A748-CB0D-11E3-88BD-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246853>

Robert Dailey <rcdailey.lists@gmail.com> writes:

[Administrivia: because people read from top to bottom / why is it
bad to top-post? / please do not top-post.]

> On Tue, Apr 22, 2014 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Robert Dailey <rcdailey.lists@gmail.com> writes:
>>
>>> git log log --graph --abbrev-commit --decorate --date=relative
>>> --format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
>>> green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
>>> white)%an%C(reset) - %C(white)%s%C(reset)' --branches --remotes
>>> ...
>>> The goal is to weed out the really distant and irrelevant commits. I
>>> really just want to see the commits that are closely related to my
>>> current branch. Thanks in advance.
>>
>> For a starter, how about dropping "--branches --remotes" from that
>> command line?  A merge from elsewhere will show as "Merge branch foo"
>> which should be sufficient without the decoration.
>
> Thanks, removing those two options did help quite a bit already.
> However, the history can still get pretty crazy. Is there a way to
> hide all tags from the log graph? Really I just want the LABELS to be
> hidden.

As you had --decorate and a lot of %C(cruft), I was assuming that
you do want to see all the bells and whistles when I suggested to
omit --branches and --remotes.

If you do not want --decorate, I think you can omit that from the
command line without changing what the output means.
