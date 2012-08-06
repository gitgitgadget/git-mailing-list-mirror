From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_index_from: remove bogus errno assignments
Date: Mon, 06 Aug 2012 10:03:37 -0700
Message-ID: <7vsjc0ymty.fsf@alter.siamese.dyndns.org>
References: <1344252429-7377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 19:03:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyQiZ-00021Y-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 19:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab2HFRDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 13:03:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756718Ab2HFRDk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2012 13:03:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D098F62C9;
	Mon,  6 Aug 2012 13:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xEoz+TbBlBi1
	zRsp21zrAtawQNI=; b=Gthu3P16cYQUosKaspN0R9vDc/R1IwzIVo8FjAO+k0Oi
	HNSrmMnIdzGVndn9MDXY2tambeFGskW3SmShvPVNpT9/69tErGUwp2BfgLfCZYqS
	akuX47hrrcXQ4SJj+ymA6ua369lxbsFhRZIxQi+yLod10Ex4rq9bb/P51MFSTAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Jhj6RC
	cqhnWbrEjQ8CtOawqyQ42BicLKjzEyIBTHms1kS3yZ2yHRISbcCNYAbA1B0bfLzz
	dsiR9lWTAKtp3k8s03Fl/z2tfBUIHHZXt/ZHLDhpDpftDE3C6cih7ztkPAHqCYsv
	k2w3UcihAJglOSUmlxaLjnAkaDHvhqRPj+8a8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF5662C8;
	Mon,  6 Aug 2012 13:03:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4211662C7; Mon,  6 Aug 2012
 13:03:39 -0400 (EDT)
In-Reply-To: <1344252429-7377-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Aug
 2012 18:27:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB09F752-DFE8-11E1-B69C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202969>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> While at it, move die_errno() next to xmmap() call because it's the
> mmap's error code that we care about. Otherwise if close(fd); fails,
> it could overwrite mmap's errno.

Makes sense and is a sensible fix.

Thanks.
