From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: show detached HEAD if --all is specified
Date: Tue, 09 Sep 2014 10:04:06 -0700
Message-ID: <xmqqlhpslo8p.fsf@gitster.dls.corp.google.com>
References: <1410247756-10879-1-git-send-email-max@max630.net>
	<xmqqppf4loaq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:04:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XROq9-0005Fa-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 19:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbaIIREL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 13:04:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62042 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757371AbaIIREJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 13:04:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3676376E2;
	Tue,  9 Sep 2014 13:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LO6IY3TRZtPZ0aLLe4ap7KdAS+I=; b=LUS36T
	JAohmLdsEmvXWJE4J7r7MbeDPG+Ioo/2f9//UFXmCgkAU10GVj1/xe+HDgImqCAj
	lUSvVFrxNxEp7BC/kv+m6rB+xcGJq6AMMSQX1jda4Vt7eNtzDdvahA3Ro7IroKRP
	my0y6J9C1yC5vBZCJaGaM0rNYMumxRzLD5t3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Abh8/fUrEIcx6bjk+LOimI5QYZGtsLoG
	bpL7hA6R1HtIDUKGb2KNUWS4IyQf2nxu149v7/L9JP/Tl4uCMPnfzMrUV86JlDp4
	IwY9rOw6v7fWlUG9tOdiKF9G9OE0o+wsvnTFSvXVNCGlA02pjb5XK3wNyW9SmLH1
	SFotNyZtF2o=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7D0C376E1;
	Tue,  9 Sep 2014 13:04:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3617A376DE;
	Tue,  9 Sep 2014 13:04:08 -0400 (EDT)
In-Reply-To: <xmqqppf4loaq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Sep 2014 10:02:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4FE46C76-3843-11E4-8052-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256695>

Junio C Hamano <gitster@pobox.com> writes:

> Max Kirillov <max@max630.net> writes:
>
>> If HEAD is detached, 'gitk --all' does not show it. This is inconvenient
>> for frontend program, and for example git log does show the detached HEAD.
>
> "git log" does use the same revision machinery as rev-parse uses
> internally to parse its command line arguments.  What does it do
> differently?

Ah, nevermind.  I misremembered that rev-parse does not use the
revision machinery.
