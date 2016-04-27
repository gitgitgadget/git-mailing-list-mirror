From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is created
Date: Wed, 27 Apr 2016 08:13:11 -0700
Message-ID: <xmqqinz3axvc.fsf@gitster.mtv.corp.google.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
	<xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
	<xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604270846430.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avR9U-0007AG-ES
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbcD0PNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:13:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752322AbcD0PNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:13:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C19B714CA3;
	Wed, 27 Apr 2016 11:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L9RfMZE52jj9PVm9br+FgwII7qc=; b=LJNAXT
	5m4fUPxHp8s7+wNld6JtVb+XQYqVfmxNvWvnzXgu31b67qFmn9yKMJzOyvxnZTnc
	bhwh5jubKLQmwJGry2cMXzRD9+J4OELsE+Yl+onqk/C9QWRCXhJhuk8S6U+VVqI2
	71ZwlDCF43/UMaeyZTcPJiMThBBreBA8z7E/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GA0YJduT+X4XyJBja2+v/UZS69AwzAdw
	rBBOPa2hJ51prLIRxrV0B+NrfXce/5Hw9Khilv6K1mNDdVdtV995eMy/+DB3gaAY
	s8BgAq6uS0F3CJYc4n9JiSO3+lAIDCGeLfzw22L3JEAsD/baXDLEbI937YDbngug
	VAnudd7M/TM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7C1C14CA2;
	Wed, 27 Apr 2016 11:13:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CD0014CA0;
	Wed, 27 Apr 2016 11:13:13 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604270846430.2896@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Apr 2016 08:50:01 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F57F8F6-0C8A-11E6-83EC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292729>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am not sure about this double negation "no_commit_impossible" (I only
> understood what you meant because I had read the commit message first,
> something I won't do when stumbling over this code later).
>
> Maybe something like `disallow_no_commit`?

That would be the best name once we start dying in there.  It might
be still better, even while we merely warn but let it pass, than the
double negative.  Or it may not.  I dunno.
