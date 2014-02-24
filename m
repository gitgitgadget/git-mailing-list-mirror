From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Add a bunch of docstrings and make a few minor cleanups
Date: Mon, 24 Feb 2014 09:58:21 -0800
Message-ID: <xmqqa9dg9yv6.fsf@gitster.dls.corp.google.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:58:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHznX-0000cm-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbaBXR6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:58:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbaBXR6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:58:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD2996BD87;
	Mon, 24 Feb 2014 12:58:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6A+ipz80TGRM7dyfGFOHqbb7Epk=; b=CpOUX6
	WrDMuCIyFx7p3cSjmOo031kbDzx2yHuZ1DZmD2g+xlniFacOPx88LLcicFLPc0xp
	HeQ+zXvff8gdQVN+FBykZeN1bdmeFx1yvosI6mTF5DubQmHmO1YqGKPk/K6FCZKF
	5ShtFXGZPoPTZgNrH5XwbbYG5JlUCdFMTHLNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ncuUDpfZtUeDbrv1AitTWDICeE/E6Oig
	0xwB6zq0BfGKCsHIDthpmk/EKEozNJEvBv46p3xkkYabFBVM1AvLc5rQnKXuj7aL
	/mU7TcekLNfc0sljAgi7l0jvU+8cxxHUOubIYNlc7ipLSSTsNe3jrNMutM+rn7fx
	UzO/e8sYWxI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8AB16BD84;
	Mon, 24 Feb 2014 12:58:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4D216BD83;
	Mon, 24 Feb 2014 12:58:22 -0500 (EST)
In-Reply-To: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 21 Feb 2014 17:32:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 405BEFA6-9D7D-11E3-9C73-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242626>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I was reading around in the neighborhood of fsck, objects, and packs
> and I had the familiar and discouraging experience of having to read
> code all the way up and down the callstack to understand *anything*.
> Please let's all make more of an effort to document functions,
> especially things that are not obvious from the name and signature,
> like who owns the memory that is being referred to.
>
> This is my attempt to document a number of the functions that I was
> looking at based on what I inferred from my reading.  It is also a
> selfish trick to get other people to double-check my understanding.
>
> I also fixed up a couple of small things that I noticed along the way:
> "refactoring for understanding".
>
> Michael Haggerty (6):
>   Add docstrings for lookup_replace_object() and
>     do_lookup_replace_object()
>   replace_object: use struct members instead of an array
>   find_pack_entry(): document last_found_pack
>   sha1_file_name(): declare to return a const string
>   Document a bunch of functions defined in sha1_file.c
>   Document some functions defined in object.c

Queued 2, 3, 4, and 5, expecting 1 and 6 will be rerolled.

Thanks.

>
>  cache.h          | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  http.c           |  2 +-
>  object.c         | 23 +++++++++++++++-
>  object.h         |  7 +++++
>  replace_object.c | 17 ++++++++----
>  sha1_file.c      | 66 ++++++++++++++++++++++++--------------------
>  6 files changed, 157 insertions(+), 42 deletions(-)
