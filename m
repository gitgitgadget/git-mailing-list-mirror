From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Which file is older in history?
Date: Wed, 20 Mar 2013 13:46:49 -0700
Message-ID: <7vobeddcjq.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:47:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPup-0001Li-T8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886Ab3CTUqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 16:46:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab3CTUqw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 16:46:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86572A25F;
	Wed, 20 Mar 2013 16:46:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7Tg20m4Im0Bp
	yfbtUvU+81x4H8M=; b=UmN6MvsUGXm5dBdGjpQzJYrkrbRcYzxhoTSmKdXpd9vj
	FeekWn6c0yi+DAuybpEtgQbREcHCo7UteJ4gmmZtrqKfh702ZYQNooExXvGGZMG/
	WTSPyzWyDcd5g5tG6rfuLg/EYmLoYsRyFiSZp7+c1UQRRrCIykTuZU3/hvNgJ8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Fv03ae
	Etl7m58uGPNmJ5ANepjJ2WXUR3QMyITVXlRl+l4lWATs+apslHRDHXliKIwpusCb
	289saNIP3iA+l7XUx/PFR1fMZh3mRqfjkK5q9fB+l3y6kx7zH+ah91QR85y9TELC
	45FaNi3C39JcZwow6AsxOAA68tp9ZcbJAZAtw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C022A25E;
	Wed, 20 Mar 2013 16:46:51 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 023B2A25D; Wed, 20 Mar 2013
 16:46:50 -0400 (EDT)
In-Reply-To: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 21 Mar 2013 01:51:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A7E7322-919F-11E2-848F-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218681>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I want to compare two files in a git repository and tell which one wa=
s
> introduced into the repository earlier, assuming that they're in the
> same history line (by ancestry, not timestamp).  The naive way to do
> this is to find the individual commits that introduced the files
> (`rev-list HEAD -- <filename> | tail -n 1`), and...

This must be a trick question but the na=C3=AFve way I think of is

	git log --diff-filter=3DA -- path1 path2
