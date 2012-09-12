From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [git-am] Handle "git show" output correctly
Date: Wed, 12 Sep 2012 12:07:23 -0700
Message-ID: <7v1ui7cb6c.fsf@alter.siamese.dyndns.org>
References: <vpqligfz1sa.fsf@bauges.imag.fr>
 <1347464989-17421-1-git-send-email-pjones@redhat.com>
 <vpqbohbz11h.fsf@bauges.imag.fr> <7v392ndu59.fsf@alter.siamese.dyndns.org>
 <1347473108.12986.6.camel@eddie.install.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 21:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBsHh-0003Tg-ID
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 21:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab2ILTH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 15:07:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab2ILTH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 15:07:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD68D852E;
	Wed, 12 Sep 2012 15:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tCd5srWsD4gw+UxIzxIO/ugbSdQ=; b=nckSBc
	0KG1LmHY2PXsqXukOd6KxC+gzpkWROOJu2V9YwFffLBpCT6qoHHNrJ/3mFI/TPQb
	nUm2LszUtJTdJT7+pSpYuK301BlMqIHlobnTSrf0EHfzFRliWoJ0n55MA7EHAuPu
	pzV/ufLvq6ihYS6Og8uG/jtlWcdcuUJHrjBrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gLOQ03meqWJE6rjS4dpSzY0qaaDfvLE9
	hl6qPahzQibQ2TzTT7RlP4S7m7C3K8GpyaeH7/beZwsOFn4QcUdKMZJkpT8xX4o8
	xgDXQTBjLQ3gqyCgoOeDBaNgV8wkMqEpWmZp39PgN4gOwD60XYHQ+tJG1B3Xmg2d
	/0CnO6Hze78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAC3D852D;
	Wed, 12 Sep 2012 15:07:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 235C2852C; Wed, 12 Sep 2012
 15:07:25 -0400 (EDT)
In-Reply-To: <1347473108.12986.6.camel@eddie.install.bos.redhat.com> (Peter
 Jones's message of "Wed, 12 Sep 2012 14:05:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 167D2978-FD0D-11E1-B933-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205325>

Peter Jones <pjones@redhat.com> writes:

> Let me put it a different way - if you won't accept git-am handling "git
> show" output because "git show" has output that wasn't designed to be
> parsed ever, would you be opposed to a patch that switches the "git
> show" output to be something usable?

The output from the command is optimized for humans, but you could
invoke "git show --pretty=email" if you want to, so I do not think
you need any patch to do that.
