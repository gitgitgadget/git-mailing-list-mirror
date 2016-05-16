From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 15:19:50 -0700
Message-ID: <xmqqzirpzlvd.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
	<xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuMdWdw2kcfs_P-_Ax1zXpKNHqMjNL80hBj3=SSp2zSQ@mail.gmail.com>
	<xmqqh9dx1xku.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbJxf6qnj1vqkbFzXBU+6Cfh6RMvs2NqqeASZAPLFXu8Q@mail.gmail.com>
	<xmqq8tz91x1b.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaP7rPu64ORXrGcONyoM2jA+gfPpy3LFkbp0Axff9dsHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Qrt-0006xp-8m
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbcEPWTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:19:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751091AbcEPWTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:19:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19B911C277;
	Mon, 16 May 2016 18:19:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3apXhisx0Fm1pfalWVPCNaB+kro=; b=kUa+3V
	hfuRVtw/XNEA1ufEneQYctGE+gGcxJqRV+I9QlxZVJrFWqPO+6wmdQBDU78iWeN8
	WRcjF7fN68MiClw42F56Qf49OOFT39+oZZuQF1KOkiknVLjY0udJT8/9BsMXymds
	BTGmfj70NLWAKFRJXSZjUDXysluuF8ZP5KrOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tRb/wHOeixLxtsZhKm/N0x3o93NIsvct
	aS6gp+AjJrHmtedWUylJUU+fXjmdWt4ihQ1fWVywWCZGW0JCuFu3pjx4k0mKn4qg
	bceBD/Az2qpytWXC6glCJw9TC3rKydRqBAnetjdk6W5mBPDts9nv+jVCcD+3C95c
	IeKyKKniHEU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10DF31C276;
	Mon, 16 May 2016 18:19:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A0AD1C275;
	Mon, 16 May 2016 18:19:52 -0400 (EDT)
In-Reply-To: <CAGZ79kaP7rPu64ORXrGcONyoM2jA+gfPpy3LFkbp0Axff9dsHg@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 15:09:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FA6DF68-1BB4-11E6-9E29-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294807>

Stefan Beller <sbeller@google.com> writes:

>> Ah, of course.  I thought that you were trying to limit ":(attr:<attribute>)"
>> magic only to attributes that begin with "label-", which is where my
>> "why not?" comes from.
>
> And going by the logic you presented before, we would
> need to error out for the given pathspec ":(<string>)" if
>
> * either the string is not well known (e.g. diif, eol )
> * or is outside of the labeling namespace.

I do not think that follows _my_ line of thought.  What is "well
known"?  Doesn't that change over time?

If we are to do the "attribute match", there is no useful
enforcement point.  An arbitrary version of Git cannot differentiate
a random cruft users will write in their .gitattributes from a
legitimate attribute that will be introduced in the future, so both
"data in .gitattributes" and "pathspec magic that referes to attribute"
cannot be limited by us.

So if we are going to take the arbitrary ":(attr:<attribute>)"
route, "label-" prefix would be limitation on the "core Git" side
and does not limit what end-user does.  We will promise that we
won't use names that begin with the prefix ourselves and leave them
up to the projects.  If the end user uses an attribute "foo", which
does not begin with "label-", the end user is risking to be broken
by future versions of Git.

If you want to compile an authoritative list of attributes used by
core Git and maintain it forever, you are welcome to add warning,
but I wouldn't bother if I were doing this series, at least at the
beginning.
