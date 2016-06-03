From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] Reference iterators
Date: Fri, 03 Jun 2016 14:33:55 -0700
Message-ID: <xmqqporyneik.fsf@gitster.mtv.corp.google.com>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:35:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wjJ-0007kN-0z
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbcFCVeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:34:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752084AbcFCVd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 17:33:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3503C21BFC;
	Fri,  3 Jun 2016 17:33:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HOLO6oxJ++BWLhCkCW/EWy9Iz8s=; b=sZzJlE
	paeXvAirUNByjjMiTJ+umyIPxshYwDnvQXghyhIkwheTXcGiaxNmErJMcsHxd7Tr
	TYcPerkO//5jXD4qtz0MNnfB4TZ6V5hCgcUPnjMlQGE1zW9HwqnrY3zVp6rBY2RO
	TOuXcjLXnQK0uVKZ0GDosuQHk8tKolzY8NAVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wlumlUf7YOfWipLkiHSkIPG9aoTh7vU3
	gU0W3xoUwLaRz0vFP40xNlfyMrGQQcq3aiCsCXbggkiYmuBW1ASA1QGAGBoyRxXn
	xIm+ElkTi4W7120GMDlX5TJGoVIt8UaRzZsrDHm4xrOfEgq4BD/fP5Hnbc/sYRdz
	5syqV96iMbA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D6C021BFB;
	Fri,  3 Jun 2016 17:33:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4F8B21BF9;
	Fri,  3 Jun 2016 17:33:56 -0400 (EDT)
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu> (Michael Haggerty's
	message of "Fri, 3 Jun 2016 14:33:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E07CBCD4-29D2-11E6-AA68-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296413>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This patch series applies on top of mh/split-under-lock. It can also
> be obtained from my GitHub repo [2] as branch "ref-iterators".

Ah, that reminds me.  What's the doneness of the dependent topic?

The patches in this series looked all good to me.


> Michael
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/295860
> [2] https://github.com/mhagger/git
>
> Michael Haggerty (13):
>   refs: remove unnecessary "extern" keywords
>   do_for_each_ref(): move docstring to the header file
>   refs: use name "prefix" consistently
>   delete_refs(): add a flags argument
>   remote rm: handle symbolic refs correctly
>   get_ref_cache(): only create an instance if there is a submodule
>   entry_resolves_to_object(): rename function from
>     ref_resolves_to_object()
>   ref_resolves_to_object(): new function
>   refs: introduce an iterator interface
>   do_for_each_ref(): reimplement using reference iteration
>   for_each_reflog(): don't abort for bad references
>   dir_iterator: new API for iterating over a directory tree
>   for_each_reflog(): reimplement using iterators
>
>  Makefile             |   2 +
>  builtin/fetch.c      |   2 +-
>  builtin/remote.c     |   8 +-
>  dir-iterator.c       | 185 +++++++++++++++
>  dir-iterator.h       |  86 +++++++
>  iterator.h           |  81 +++++++
>  refs.c               |  20 ++
>  refs.h               | 139 +++++++-----
>  refs/files-backend.c | 629 +++++++++++++++++++++++++++++++--------------------
>  refs/iterator.c      | 384 +++++++++++++++++++++++++++++++
>  refs/refs-internal.h | 226 +++++++++++++++++-
>  11 files changed, 1440 insertions(+), 322 deletions(-)
>  create mode 100644 dir-iterator.c
>  create mode 100644 dir-iterator.h
>  create mode 100644 iterator.h
>  create mode 100644 refs/iterator.c
