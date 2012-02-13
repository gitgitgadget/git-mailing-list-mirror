From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-merge-octopus creates an empty merge commit with one
 parent
Date: Mon, 13 Feb 2012 10:48:48 -0800
Message-ID: <7vipjafu27.fsf@alter.siamese.dyndns.org>
References: <1329133736-20817-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:49:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx0xU-0004WM-2K
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 19:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab2BMSsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 13:48:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757425Ab2BMSsv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 13:48:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCB48706F;
	Mon, 13 Feb 2012 13:48:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0JwWbtXuPrNu
	cKV6gHMhkBf5NBM=; b=q0KWvwrUCY3Wiaq6srXIdANZPGDWD/2KRb2qa8fsVI4M
	lvN7FNAaHfQjebhQlL9Cy+UxwXT0yMwklzvbk0451LGQQqp5eYAx8/A+8hOlspf/
	gT04WPrKj4Kc4zPP+WfWGTK+EKZus4qkSiD6hC18hz78FPlLhPfMvmRGhYKK3ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GhxKDU
	gTv8Xjys020QjWUKXIdy9f5PGL2GzzNIS+UqglpersQmU0P6e5LAdpLElgdgmP1a
	IHCTTLJ5ce54q18haHpyxWOUwWXm8empT7joCov9943UHK4oVQOKDiDtZmKr5CaH
	dZkXv8KVOF1y2QB4dkPPw6W6orwAGeCK0DEDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3ACE706E;
	Mon, 13 Feb 2012 13:48:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BB7B706D; Mon, 13 Feb 2012
 13:48:50 -0500 (EST)
In-Reply-To: <1329133736-20817-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Mon, 13 Feb 2012
 12:48:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E763EA4-5673-11E1-B091-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190646>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> This happens when git merge is run to merge multiple commits that are
> descendants of current HEAD (or are HEAD).

I am reasonably sure you meant ancestors here.

> to origin/master but accidentaly we called (while being on master):
>
> 	$ git merge master origin/master

I am very tempted to throw this into "don't do it then" category.
