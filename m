From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Tue, 13 May 2014 11:19:54 -0700
Message-ID: <xmqq1tvxpmlw.fsf@gitster.dls.corp.google.com>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
	<1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
	<CAAhxitED0iV+Pcird2kZzt3nSnr83+isBDZF2Czmh0LzNzQf8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Tue May 13 20:20:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHJE-0008It-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbaEMSUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:20:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58666 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277AbaEMSUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:20:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31449166D7;
	Tue, 13 May 2014 14:19:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o77zR5LYnQ5irZU/n6W1rUh3UPg=; b=derC6U
	mkpMnZmpZoX+taM9/VmAJ9/MZXexkEYk+Im08bV4Wf/sNZBBDxFyhB8bccplOFOn
	MJBu4qqH0/4b/4ZFsTTxpTzBWGI3tyX+DRErs7m5EtDGmBAKoKHo2Cjrmb5CByk4
	WWjtKEbxZJOwpQxOoDXAt5tYgNZ5eomMVMwns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gLSgEO3sYPm53xgKl7wlyFNtYnOiYAOy
	ZypyhUT/FoTn4vnRMx6zotLKkZdEGKeM2sdkDpcV7KP++0D04VRf5sgihCVZwjEW
	KWBAnvl1kk4XJqptup8xl5tSKJys/lYv0dYzmV1ByBGcDKyEtpFicQMEJ/bzaHrg
	uY8wJsbWPQ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 263B5166D6;
	Tue, 13 May 2014 14:19:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 63BA8166D2;
	Tue, 13 May 2014 14:19:56 -0400 (EDT)
In-Reply-To: <CAAhxitED0iV+Pcird2kZzt3nSnr83+isBDZF2Czmh0LzNzQf8g@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 13 May 2014 14:01:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2FB55652-DACB-11E3-8758-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248798>

Martin Langhoff <martin@laptop.org> writes:

> On Thu, May 8, 2014 at 9:33 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> No updates since 2010, and no tests.
>
> NAK.
>
> IMHO, this is quite unfriendly.
>
> Is this removal based on your opinion, or Junio's position (or
> consensus from maintainers from the list)? If there is a clear
> consensus or direction for old code such as this, please let me know
> (but copy martin.langhoff@gmail.com, not just my very old address!).
>
>> Plus, foreign SCM tools should live out-of-tree anyway.
>
> Says who? Is there consensus on this?
>
> It's generally the privilege of the maintainer -- in this case Junio
> or perhaps Linus -- to take harsh stances like this.
>
> Junio, what's your position?

We may think longer when somebody proposes to add a new thing that
may better live outside our tree (including the contrib/ area) than
we used to, simply because Git is more mature these days and the
ecosystem is there to support successful third-party tools, but
removal of existing subcommands needs to weigh the impact of such a
removal to existing users. "No recent updates" does not say anything
with respect to that---we cannot tell between "The tool is perfect
to fill needs of the users" and "Even though the users are reporting
issues, the area maintainer is not being responsive" by non activity
alone, and we know there weren't many unresponded issues in the
recent past.

"There is no longer any project that still hosts anything worth
salvaging in tla", if such a claim can be substantiated, might be a
valid reason to propose a removal, but I do not think this is such a
proposal.
