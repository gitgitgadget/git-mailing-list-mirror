From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can you git clone -partial? I am looking to make a mobile app and it would be nice to have.
Date: Wed, 01 Oct 2014 10:38:01 -0700
Message-ID: <xmqqtx3npu6e.fsf@gitster.dls.corp.google.com>
References: <CAOHoyPr3E9U3XPEjmrSNkT0okHcRN2H7OKyrt-Ar3WMMDL=4vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: James Hancock <james@bookstobrains.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 19:38:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZNqs-0001GU-Sl
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 19:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbaJARiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 13:38:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57369 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbaJARiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 13:38:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08BAD3DAA5;
	Wed,  1 Oct 2014 13:38:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aBfsc5joFpmKuxO51aXvvIsw5bg=; b=dKvOIl
	DJlkocqchrUZMFO2uiAFE8Cd1TsoZSBQRpRJVKYr+CiaI0j0GPaUmMTA5RXrHYNS
	62wAJjZ3TQk8ZyQIZzaMBENkEcowYHLKNd6bsD2xZADPraUrT//LghaFA96larym
	+U/mfBTAHde4yFvXKdTuuPhC5XfxLb3JIFsdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rUDSgcQUjwwl8eyg3USUnGBZvUHVjAeZ
	2/Lo+ja89RREjKJfQkgD7oV743Wg1VzYD/FpQwe+6biiRve1E+BcfgdqDD6twHGw
	PgSzKRSQxdDKbdsI/jpaBtCR33iUNd06127Eb04J5CU1lkenBj9+rcZTAOV/vmtW
	Iwf1XFQB4xM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F01C03DAA4;
	Wed,  1 Oct 2014 13:38:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 604AB3DA9F;
	Wed,  1 Oct 2014 13:38:03 -0400 (EDT)
In-Reply-To: <CAOHoyPr3E9U3XPEjmrSNkT0okHcRN2H7OKyrt-Ar3WMMDL=4vw@mail.gmail.com>
	(James Hancock's message of "Thu, 2 Oct 2014 00:51:58 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B20B216A-4991-11E4-9BBF-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257760>

James Hancock <james@bookstobrains.com> writes:

> i am thinking about developing an app and I want to integrate it with
> git but I only want to store a portion of the file on disk. It is
> going to be in a mobile enviornment and I want to just get one file or
> a small group of files.
>
> I read that you can clone and then only look at one peice but is it
> possible just to clone one peice? And if not what would it take? Maybe
> this is a feature people would like to have. Just hypothetically, what
> would need to happen?
>
> Either
> git clonepartial /repo /file/or/folder/in/repo
> Or
> Git clone -partial /repo /file/or/folder/in/repo

You keep saying "file", but the thing is, Git does not track file.
It tracks history of collection of files.

What are you trying to achieve, exactly?  What does your "app" need
out of that operation?  Does it need these selected files with their
history?  Or does it only care about the contents of the selected
files at the tip of the 'master' branch of that repository?

I'd imagine that your answer would be the latter, and suspect that
you may want to run "git archive --remote" with a pathspec to limit
what gets grabbed.
