From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 13:09:38 -0700
Message-ID: <xmqqtwxmt43h.fsf@gitster.dls.corp.google.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cR52GKNZkgsytUrb0m3wwY2T68cxjNB_OV+uLxvQUh=VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 21:09:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXEr4-00079o-MT
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 21:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbCOUJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 16:09:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751166AbbCOUJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 16:09:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87DE43F01E;
	Sun, 15 Mar 2015 16:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KMVTrBUP6SN9kE3HFHKb4qukuK8=; b=rEsyU0
	mCaFhaU4yv7b6Hfm1DjPrBFmZqfcYOn+DK2hbOTlEDwx4LRi72Un1P5qOufpKEuu
	CHrlz66/aajurjg8wlaLChyOSzl2MhQdu0u3ClxAbBycGeSx4xoDrt9jCm6qjVae
	ZG/hUGHTpM9Nvyq9mh9zsrzbA+bz+AuRaFgpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nM93XGjfikTh/Dh3kL/kUUxilWQi8SzV
	KfOut7EobdSYQiJLf7BjiQYocYhixlIxm3c5oIW7AJKeFkhRNZyWMwetjxKjtr3D
	eBageAlOf5S45vti0O5W1LjzzToL237t2+LzjgW3dor7KhjvwG14YkPeoWy8A6T5
	wt0HWBD9LKk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F55D3F01D;
	Sun, 15 Mar 2015 16:09:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C8253F01C;
	Sun, 15 Mar 2015 16:09:39 -0400 (EDT)
In-Reply-To: <CAPig+cR52GKNZkgsytUrb0m3wwY2T68cxjNB_OV+uLxvQUh=VA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 15 Mar 2015 14:12:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 363B5100-CB4F-11E4-921E-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265518>

Eric Sunshine <sunshine@sunshineco.com> writes:

> The commit message is missing the important justification for why this
> new option is desirable, and why only git-add needs it.

I think that is a very good point.  I actually do not see why this
option is ever needed, in a modern world that has the negative
pathspec magic.

Is there a reason why this is undesiable

    $ git add -- \*.c ':!secret.c'

and has to be spelled as

    $ git add --exclude=secret.c -- \*.c

I do not see why...
