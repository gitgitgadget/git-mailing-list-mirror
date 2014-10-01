From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init - Honour the global core.filemode setting
Date: Wed, 01 Oct 2014 10:10:44 -0700
Message-ID: <xmqqy4szpvfv.fsf@gitster.dls.corp.google.com>
References: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>
	<5427F68E.5030003@web.de>
	<CAE1pOi1dAO7XFZtrgZyNm-eLVKQx=KpeejbGmF8khCofAppDLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 19:10:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZNQW-00065n-MX
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 19:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbaJARKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 13:10:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62459 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbaJARKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 13:10:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D47CF3D115;
	Wed,  1 Oct 2014 13:10:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sg+yf5i3UFVGaLCrIjpUporNlfo=; b=k44aBg
	6UM/1B/B+Jcpim0uUzJCV8tazqJhshwqjIVwGeQWF9fiO+7KT3ahUnJZ7jNqtdKy
	adN4kQUlB9z/ZV06hW5Gc9G+KczX/tQ1LX4RtuzQCN15S+M38VGVFB58VKALivDa
	OOPVOUVWgMGjtvpfZIFNvrHGFwWEz6JdMngpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qH0lhZVIImvXdXxuoDiS21wt1zQaikVN
	MJz4OqmG5/3+C9EoN6ceeiIOT4QbOci5Ekd1N/RfdU/vpQf44ra98liavb6uwjJV
	o2ZGp2EYIiHii0NnvCYxSPXcjZYWKHXx/H4QUV4T7Hg0VxIRVwVWSholwqr1MgSo
	z456a5Nq1wg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D3823D114;
	Wed,  1 Oct 2014 13:10:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53A523D113;
	Wed,  1 Oct 2014 13:10:47 -0400 (EDT)
In-Reply-To: <CAE1pOi1dAO7XFZtrgZyNm-eLVKQx=KpeejbGmF8khCofAppDLg@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 30 Sep 2014 18:55:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2E14282-498D-11E4-A058-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257759>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> Perhaps I completely misunderstand the meaning of core.filemode but I
> thought it determined whether Git cared about changes in file
> properties?

By setting it to "false", you tell Git that the filesystem you
placed the repository does not correctly represent the filemode
(especially the executable bit).

"core.fileMode" in "git config --help" reads:

       core.fileMode
           If false, the executable bit differences between the
           index and the working tree are ignored; useful on broken
           filesystems like FAT. See git-update- index(1).

           The default is true, except git-clone(1) or git-init(1)
           will probe and set core.fileMode false if appropriate
           when the repository is created.

Maybe our documentation is not clear enough.  A contribution from
somebody new to Git we would appreciate would be to point out which
part of these sentences are unclear; that way, people can work on
improving its phrasing.

Thanks.
