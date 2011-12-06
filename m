From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Query on git commit amend
Date: Tue, 06 Dec 2011 12:03:55 -0800
Message-ID: <7vobvlfowk.fsf@alter.siamese.dyndns.org>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Viresh Kumar <viresh.kumar@st.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Vijay Lakshminarayanan <laksvij@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 21:04:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY1FD-0007U8-RF
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 21:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab1LFUD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 15:03:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760Ab1LFUD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 15:03:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DFC3697F;
	Tue,  6 Dec 2011 15:03:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jOVdJbuLBhBB1OINIH2h6yL6eJg=; b=D3OloZ
	S2QClFmpN52lqDBkQk/4vELvmmMez9lsMzF6CbMnnzu6J9IoLQxuafgWeaz9cKII
	xdDoew5qwV9YX3WIq1oIsFLFwMKunXvvsPXONAjtX2ORUpqvDbzgEaTJWoTksbgz
	xPxyJOaobndTddW1uwlbxJ6Zv1j3gAlvNRNdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hHHgQh80XZz/WH+SHdC5YnM/irpk9bDb
	ZOwomPsgTpL/8L4wpO35qgpfkad72miQDPPgQoU7LOtbwebdpbnhF8YSZXbnh1XS
	dzIWFHX6pB13iOLhmXwfYUI+uxf/QRHf4p3zGFdYeQE9nVKR9YZ1ACJSzXWfmqj5
	EI0pIemOLt8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8577C697E;
	Tue,  6 Dec 2011 15:03:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AD4F697D; Tue,  6 Dec 2011
 15:03:57 -0500 (EST)
In-Reply-To: <87fwgxwvn9.fsf@gmail.com> (Vijay Lakshminarayanan's message of
 "Tue, 06 Dec 2011 21:16:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E2EA3CC-2045-11E1-A97B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186376>

Vijay Lakshminarayanan <laksvij@gmail.com> writes:

> I've found 
>
> $ GIT_EDITOR=cat git commit --amend
>
> useful.

Are you sure it is a cat?

I almost always use

    $ EDITOR=: git commit --amend

when rewriting the contents without updating the message, but I think
we should allow people to say:

    $ git commit --amend --no-edit

which is accepted from the command line but is not honoured.
