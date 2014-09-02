From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/32] nd/multiple-work-trees cleanup
Date: Tue, 02 Sep 2014 10:29:18 -0700
Message-ID: <xmqqk35m2aoh.fsf@gitster.dls.corp.google.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOrtf-0008EF-A3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 19:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbaIBR3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 13:29:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58755 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbaIBR3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 13:29:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59AA9360B7;
	Tue,  2 Sep 2014 13:29:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SpET8mVQVYS6
	qcTyYrxeHgD+gZs=; b=upmjThrfn5kL3cCJKhUGAMm3H5bereHVpuPshzCQz8Ig
	6u/aC7PNToXtg0GEy1gC074Q72joj/yZm3ZqTi9mQDCGVtJahesIxXACr4CmR4qX
	M4LWGXC0eFmKtP+TYG00mfHpFxHQMP4sMTE6jaR8A4ka/yrfAnBdgKOShXXi+Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KsRAJe
	LEPbcxmfNuO2WJsi1Few2EXjBK+2Ty+tPyVps73WpMx5tRficAEc/xHOX8QFnxsF
	uZJOcRC+BawBsKtfgEdYHzDIVhnFRqtX0MVwrVQVepf6HF8ppXvClwxEZtfOXYrj
	0xpKaWb6u8SN8NYUN7MkAwT/36EeVbzoIN/1U=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E614360B6;
	Tue,  2 Sep 2014 13:29:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8BD2360A4;
	Tue,  2 Sep 2014 13:29:20 -0400 (EDT)
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 30
 Aug 2014 15:33:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC953630-32C6-11E4-B758-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256326>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This collapes some bug fix patches into the main ones, adds a few mor=
e
> tests to cover recent changes, and removes advice.checkoutLocked (whe=
n
> things are controversal, probably best to go without them until they
> are settled).

This essentially replaces how the refs (and other things, but the
most invasive part of the change is about refs) in $GIT_DIR/ are
accessed from other working trees via symbolic links in the
contrib/workdir script with a built-in logic.

Unfortunately the way $GIT_DIR/refs/ and $GIT_DIR/packed-refs are
accessed even in the main tree is being updated with a series of
large topics that are in flight X-<.

How well would they play together?

Will drop the one in 'pu' and replace with this round, but it may
turn out that I may have to ask you and Ronnie to coordinate these
topics.  We'll see.

Thanks.
