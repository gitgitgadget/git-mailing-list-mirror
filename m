From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] clone: print advice on checking out detached HEAD
Date: Mon, 09 Jan 2012 20:49:38 -0800
Message-ID: <7vlipgb1r1.fsf@alter.siamese.dyndns.org>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-6-git-send-email-pclouds@gmail.com>
 <7v4nw4cs1x.fsf@alter.siamese.dyndns.org>
 <CACsJy8CuYkzFVrEG6T2HUAwJGnjit2xWt3VSN-9USt7h+B_CBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 05:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkTeb-0007Qr-Ub
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 05:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab2AJEtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 23:49:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062Ab2AJEtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 23:49:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 064076177;
	Mon,  9 Jan 2012 23:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgd0k/VIbY7vL51FKHcth/NMfa0=; b=TbFvfW
	tJ3KTOs3zbj5OsPQaGOYQcgCJPw5QabAk0XHEA/tXU76VziCN84E3tcTQBNsMWuE
	PubhgRnDQXE3ozS5Dr+1glzVTSH1FdVi3tCz5+R8L2doIYzeRN74465ZiA29MLSQ
	+mfVfjFavAb4sQf7AyxpcwV18au1hfMwwhPhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fs3cS3ZwEVmD45N73pRwVAggoKIOI4BJ
	crt9r7EQViCdFlYggr+GlFEaBkXMMyuVEkQngAgkQL7MyDgVjv13oY+fV6522VKf
	6cJbIQ5fBJUlavtiZyWllUIbfi/nSCcbIl11V+dCHp+oF5LVjvSk8upr6QSma9kW
	mBORzR3xdlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F176D6176;
	Mon,  9 Jan 2012 23:49:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86A4B6175; Mon,  9 Jan 2012
 23:49:39 -0500 (EST)
In-Reply-To: <CACsJy8CuYkzFVrEG6T2HUAwJGnjit2xWt3VSN-9USt7h+B_CBw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 10 Jan 2012 08:54:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80FCB414-3B46-11E1-B090-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188215>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/1/10 Junio C Hamano <gitster@pobox.com>:
>> This patch makes 100% sense _if_ we let clone result in a repository with
>> a detached HEAD, which I am not sure if it is a good idea, or if it is
>> better to fail the attempt to clone to give incentive to the owner of the
>> remote repository to fix it.
>
> Then a hostile remote can stop users from cloning his repository by
> detaching HEAD? That's not nice.

That's crazy talk. Why does anybody from a hostile remote to begin with?

> On the other hand, if specifying --branch=<wrong-branch> leads to
> detached case, then we should probably refuse to clone.

If you mean "nonexistent" by "wrong", yeah, I agree, as we do not know
what the user asked us to pull down in that case.
