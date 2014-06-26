From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it possible to list unpushed tags without accessing remote?
Date: Thu, 26 Jun 2014 12:04:29 -0700
Message-ID: <xmqqlhsj4hmq.fsf@gitster.dls.corp.google.com>
References: <BAA3119F-8351-4BFD-B42A-C96E4C7A1440@jetbrains.com>
	<CAJo=hJvdMURuaEZA3XEWE_Uuq8QRZ+mt8K2H8XrbTuZsVX9gKQ@mail.gmail.com>
	<874mz76281.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Shawn Pearce <spearce@spearce.org>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0EyO-00050n-JM
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 21:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaFZTEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 15:04:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51385 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbaFZTEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 15:04:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AADC22841;
	Thu, 26 Jun 2014 15:04:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4WSjE657josSp8DLLG1/kx5YZw4=; b=iF6ZeV
	YzlljsT8Wn5YBTE0KCnl5Jjuk1yUFg7YBte6CXhHOrX8FBVoFSkNUi3CD45ENCoA
	9LalxZyjGsUzOZEZ4CAQp13jPTD6bKFvCIPHnxAfN86eMR29ozCOI4T8wZq76aqu
	QCRKpuLZI5T5iUxwYyAPCX+WYyzpjnziWYAU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UovecunNgxztGtLg1uWplbExmcuggfKM
	nee5Wl1atNbzKEr2qewAjkzOVOl4SjuQiEk2+wmlKrf68M74Rwt8tuW12xQHnU/b
	6rtw6kn9jFDw+3rnHlLfM+qJ2BQVzlDVTt8gmwBxM092VfU6W3LhyJYobh42akyr
	kH3ZwAorwns=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C01A2283E;
	Thu, 26 Jun 2014 15:04:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C2952282E;
	Thu, 26 Jun 2014 15:04:24 -0400 (EDT)
In-Reply-To: <874mz76281.fsf@igel.home> (Andreas Schwab's message of "Thu, 26
	Jun 2014 18:54:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B0141534-FD64-11E3-AFAF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252517>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Shawn Pearce <spearce@spearce.org> writes:
>
>> On Thu, Jun 26, 2014 at 5:42 AM, Kirill Likhodedov
>> <kirill.likhodedov@jetbrains.com> wrote:
>>> is it possible to know which tags are not yet pushed to a remote via a completely local command?
>>>
>>> (e.g. the list of unpushed _commits_ may be received by ‘git log <upstream>..’)
>>>
>>> I know it is possible to execute 'git ls-remote’ or 'git push --dry-run’, but both ask the remote server.
>>> I’m almost sure that the answer is “NO”, but want to receive a confirmation from Git gurus :)
>>
>> No. The client doesn't track what tags the remote has.
>
> Not by default, but it is easy to configure your clone to fetch tags to
> a separate namespace.

But then in order to learn what tags the remote has, you need to
talk to the remote and it won't be "complately a local" operation
anymore, no?
