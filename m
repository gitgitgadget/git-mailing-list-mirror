From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git submodule: Teach add to accept --group
Date: Wed, 20 Jan 2016 20:45:55 -0800
Message-ID: <xmqqegdbzgjg.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-2-git-send-email-sbeller@google.com>
	<xmqq1t9c54qz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaHLkQpaHOY2aqPgdNvWjmpbuMZSogqzPkkVHRUXyibYw@mail.gmail.com>
	<xmqq37tr3ibb.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYY950Ob252ob=sqCkEh_48geBi-a9t-p0jPCn6naCWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 05:46:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM78E-0002eS-8E
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 05:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbcAUEp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 23:45:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752074AbcAUEp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 23:45:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29FBF3E530;
	Wed, 20 Jan 2016 23:45:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4irvKp7U4XW2lp1VmoCJQnSwWzs=; b=ELUei/7JpED1oJHNEFFc
	Ih7R6GJs9cBHbVekaQoynpViypFGkgqLAslR7++xWnyofFXrTccsNPv5b8JAeizc
	XcFWrRKKgX7miEpoP3W71JZs2jLvgzinJhrLmINU01VwGvjmRh595rM24g/JiMNI
	wmRXnpjwrXW9tc9QTAjES6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=J9jQJp6wR/YXfP1FbqraXcvx+CKaKWvjpZB2ffBwabQ+iQ
	sXIecAWCZlmuGbgHJflyz6jZYSNCUPaE+o8KwWXiUsBT7B1g/vpZWbmfBSc0YFnn
	v7Z2rOpW75jHRQzp80uB9897lc29Ywv5w8VihO1atJgaeQhHvgA7HX48C5YhQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21E973E52F;
	Wed, 20 Jan 2016 23:45:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9432D3E52E;
	Wed, 20 Jan 2016 23:45:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC2A2E02-BFF9-11E5-8484-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284502>

Stefan Beller <sbeller@google.com> writes:

> Right, that's what I have here now. I should have said that.
>
> I was not trying to excuse anything, but more explaining the situation
> when reading the second sentence. (You seem to assume I'd want to rewrite
> all the shell scripts. Which I am not)

I think it is a reasonable way to spend your time by not rewriting
everything in C but the parts the matter the most.  But it makes it
even more important to do the part that will be left in shell for a
longer time in such a way that will be helpful to the end users (by
accepting both "--group name" and "--group=name", in the codepath
under discussion).
