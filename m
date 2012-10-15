From: Junio C Hamano <gitster@pobox.com>
Subject: Re: nd/attr-match-more-optim, nd/wildmatch and as/check-ignore
Date: Mon, 15 Oct 2012 15:13:56 -0700
Message-ID: <7vr4ozv0wr.fsf@alter.siamese.dyndns.org>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Adam Spiers <git@adamspiers.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 00:14:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNsvL-000889-M8
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 00:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab2JOWN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 18:13:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079Ab2JOWN7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 18:13:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A8C8728;
	Mon, 15 Oct 2012 18:13:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WI18a3kly/0C
	UQKX3fRtsMEB7Z0=; b=T8TP5H82jiGFmfoeYLUKbm6rBLjvifVWLoHiNC//fQhC
	/r5dDkWMos/xky7ldkysimA5ueCwSk3/6FUta0aAQ3yLQtiLJgcymmFbUC7gp47N
	Hr6nsRcvyzNFWtHAr5I/g4juwXfIuJaKpR+TuD8t4BMDftkSoIr/38q40wn/hZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EwBe92
	9u+9fMy7wRXd2EnqpRN/WgZsHQm5wZCy7Ct8U6u9D9/sFzG011/t4ITTavEgqgq3
	gFG6o2kfkEB2rgQgRB8exqt7TM1tHTqVR/Zc+VOFeF0jdpamjEfh45xUtNtIw4y5
	FN9sJ0zQ7RwxGiM13oCww4MOn8LEHA01UBphU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40E108727;
	Mon, 15 Oct 2012 18:13:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B11328725; Mon, 15 Oct 2012
 18:13:57 -0400 (EDT)
In-Reply-To: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15 Oct
 2012 13:23:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D6B26CA-1715-11E2-8C24-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207782>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> These three series all touch the same code in dir.c and cause
> a bunch of conflicts. So I rebase nd/wildmatch and as/check-ignore
> on top of nd/attr-match-more-optim and resolve all conflicts.

Thanks for working on this.  Makes my life much easier.

If not "my life", it certainly will make it easier to shift blame to
others when things go wrong (it is called "easier to bisect" ;-)
