From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* Bug report: reset -p HEAD
Date: Fri, 25 Oct 2013 09:54:52 -0700
Message-ID: <xmqqiowljnoj.fsf@gitster.dls.corp.google.com>
References: <CAPWpf+wi0zH2sOnuqiZuKkf+kC0RMug_ASb-J-TGGLd2RFT1wg@mail.gmail.com>
	<CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com>
	<CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
	<CAPWpf+zkA68pzR3qx5xma8BNiONwt5o8iNba0x8fmmiDAWpHuw@mail.gmail.com>
	<xmqqvc0mj9wi.fsf_-_@gitster.dls.corp.google.com>
	<20131025042421.GB11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maarten de Vries <maarten@de-vri.es>,
	git mailing list <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 18:55:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZkf5-0001P5-6F
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 18:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab3JYQy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 12:54:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab3JYQyz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 12:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC88E4BCE9;
	Fri, 25 Oct 2013 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eHUBhxP22DVptl5bFx4STgGaX9s=; b=ev7ICS
	PlE4X5I2RVwEg6f8xsrFEbOyq2pGhc2fBIl76bx6Q5dH0JonDHVL7wS2jKTGqCSi
	JH3TqIOxh0uibsfKdi1PjYaYSso/r3EMdZDuCsqsTOoZ9g01gXib9dID8zm4MYZW
	CW/6FzSJxI0hCXD6CwtlcnOxNcq0uMBOdBoIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJSkuJYRXJYx7R2vq9SCZJHHs4z4Z3tg
	soVrvoBCV7SSVQ8QEulxCM1P1F23fFCq4THzJG4V7GOMEE6ZAVJRyibS9EGTpq+L
	ddOJReEtEWqNVMhaXMKpqh7Znk6cWuoCAKFKTPED4BqYENnik1TSHTQMTKYt83i1
	gd5k6QcClUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B949E4BCE7;
	Fri, 25 Oct 2013 16:54:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1934C4BCE5;
	Fri, 25 Oct 2013 16:54:54 +0000 (UTC)
In-Reply-To: <20131025042421.GB11810@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 25 Oct 2013 00:24:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2BD6A6E4-3D96-11E3-B5F7-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236710>

Jeff King <peff@peff.net> writes:

>   3. Teach add--interactive to recognize the empty tree sha1 as an
>      "unstage" path.
>
> I kind of like (3). At first glance, it is wrong; we will also treat
> "git reset -p $(git hash-object -t tree /dev/null)" as if "HEAD" had
> been passed. But if you are explicitly passing the empty tree like that,
> I think saying "unstage" makes a lot of sense.

Thanks; makes sense after twisting my mind somewhat, exactly for the
reason you stated here ;-)
