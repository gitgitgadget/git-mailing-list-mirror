From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] setup_tree_pathspec(): interpret '^' as negative
 pathspec
Date: Tue, 14 Sep 2010 09:06:44 -0700
Message-ID: <7viq288g2z.fsf@alter.siamese.dyndns.org>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
 <1283961023-4491-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 18:07:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvY2A-0004vO-GZ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 18:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab0INQGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 12:06:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab0INQGy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 12:06:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF6D2D5E2C;
	Tue, 14 Sep 2010 12:06:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eeKTvSR2QEMy
	toHEqEY0nPF/2UQ=; b=NJ0BXKg+zJMSW/4Wc7vxa/1yr46Qm8rZHBQVmk7p8zp7
	vOJCwl0fAqBrlWzPcZfPQF9+Gb42CFUuONTiDXbU60Tg91916s5Sg3b3rMfij7bK
	TqQfIbU36bMTAX3FTpNEPVah41cFzLmRoA5yjZnACdb1UMFM2NS19dgIKkCTLcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NsJt1V
	n5084DMpoVsx8Bq1EJVxaDU4eXYJPp5/hMHyNt/zLa6f4W8v/sOI4AKy77PoclfR
	mOtqApov+vc1s9Y/pzQo34cpBcKizSwlZE2ELiSDtIHAqKryXj+qtJR5lnVNZJYt
	BAE8S25SpNuCxIM6wleCL0NI/cnaHfVSOKs3k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAF51D5E27;
	Tue, 14 Sep 2010 12:06:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D189BD5E25; Tue, 14 Sep
 2010 12:06:45 -0400 (EDT)
In-Reply-To: <1283961023-4491-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  9 Sep
 2010 01\:50\:22 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 157EC3EC-C01A-11DF-B8A5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156198>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This patch does preparation work for tree exclusion in
> tree_entry_interesting(). '^' has similar meaning to '!' in
> gitexcludes. '!' is not used because bash does not like arguments wit=
h
> a leading '!'.

Do not even mention gitexcludes as you have to make awkward excuse like
this.

Instead say something like

    '^' works exactly like prefix '^' for revs (e.g. "log ^maint master=
")
    to mark what is prefixed is excluded.
