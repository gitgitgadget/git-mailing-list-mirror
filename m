From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should notes handle replace commits?
Date: Mon, 11 Jan 2016 08:09:43 -0800
Message-ID: <xmqq60z0yu60.fsf@gitster.mtv.corp.google.com>
References: <20160108012830.GA2110@glandium.org>
	<xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
	<20160108214939.GA22801@glandium.org>
	<xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
	<20160109002510.GA30050@glandium.org>
	<xmqqmvsfzhq4.fsf@gitster.mtv.corp.google.com>
	<20160109012542.GA2445@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:09:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIf2V-0003E7-1t
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 17:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760807AbcAKQJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 11:09:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760805AbcAKQJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 11:09:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9EBA3790C;
	Mon, 11 Jan 2016 11:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1TzCjw07BLnA5NPcp+uPJOV4Yj8=; b=X9ko+5
	A7bCjH95U/NNFEnOVQuc49rkaF+Zd1zc8TvosBRLS/PKHluIMPIADwDG68UVTLkj
	0oKN7aZT2/nJfckc7um1s9TYyonlv+sAVW2EPnVMDb9FFrsiBrqfne0HbOsLWdxt
	sZtJv0UMus7l6KAjqYu8gr7Oc2L8XzqohoNus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PbLFQPbz4TrK1QW+ck/2ZThTkcm6pW/m
	0JDh425QLyPb6GvCr/6GU9ic8Bxu5sPmseggGrF270WbaKwAPZ8x59kD2nAqcK/Y
	kZppX9wuwNMFyAk6YPrYHXQdlMMJdoyyyQ6jYHXLgsTbsM+kcOYCz+qFvyDUWIpP
	vO6sFynZ/1c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF41A37909;
	Mon, 11 Jan 2016 11:09:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6236137908;
	Mon, 11 Jan 2016 11:09:44 -0500 (EST)
In-Reply-To: <20160109012542.GA2445@glandium.org> (Mike Hommey's message of
	"Sat, 9 Jan 2016 10:25:42 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA815EDE-B87D-11E5-A378-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283664>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Jan 08, 2016 at 05:04:03PM -0800, Junio C Hamano wrote:
>> It is not graft vs replace.  It is about what you replace with what
>> other thing: "replace" is a content replacement mechanism, not
>> identity replacement mechanism.
>
> I guess this is where opinions diverge: in what notes are.
> I'd argue notes are content just as much as the tree, except they're not
> stored inside the commit.

There is no room for any divergence in opinion around what
"contents" are in the context of Git, though.

Iff the name of the object would change if you change something in
it, then that something is "contents" of the object.  So the list of
parents of a commit is part of the contents of the commit object.

Notes are not.

In fact, that is the primary reason notes exist---the whole point of
notes is that with them you can add pieces of information ABOUT an
existing object without changing the contents of the object.
