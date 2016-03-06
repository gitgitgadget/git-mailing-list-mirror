From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable clone
Date: Sun, 06 Mar 2016 11:48:05 -0800
Message-ID: <xmqqh9gjtmkq.fsf@gitster.mtv.corp.google.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	<xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1603060831570.3152@virtualbox>
	<CACsJy8Donxwx0LE0jDwpLbS4D-m4JzWne29GHAG0jfh2CH3pdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 20:48:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acef9-0007WD-Aw
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 20:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbcCFTsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 14:48:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750819AbcCFTsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 14:48:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38E6048134;
	Sun,  6 Mar 2016 14:48:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YoNDQrM3ZqbbreW2Y9fbc3Jsgkk=; b=jxmzVi
	Q621VFgJSI3A+xfxwp4wsmfEFTRBIVcGp9Nsw36zVG+dWVgxWOHTDSP4WPfyJv6L
	F7yiQf3d1mivMFpuUUXQytpCq+DumI+gIrlOx5B1own6U4JSoLNj1+3fLWPk0ecW
	5/oaHI6dGaqYz6ZAgz6F57jclEARuzZGmwijc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SB3AyVROrbxxK4EPjYwyZgtbqR0So1cL
	IZ8RPF6Aiy9VHKkOgnaw9zTHsh2vb0zAOi6ucGlvy9cDo+RHBELCiQQkrOg2A3PR
	nMNyRDi6pl8nqj35B86VwkUp6vVPQEcHscW1jG7sH0qByE5UjNpQOmkxM96xv4Jp
	Jg2mO3S+MUA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3040748132;
	Sun,  6 Mar 2016 14:48:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 971A748131;
	Sun,  6 Mar 2016 14:48:06 -0500 (EST)
In-Reply-To: <CACsJy8Donxwx0LE0jDwpLbS4D-m4JzWne29GHAG0jfh2CH3pdQ@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 6 Mar 2016 15:49:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58C188AE-E3D4-11E5-88DF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288365>

Duy Nguyen <pclouds@gmail.com> writes:

> One thing Junio didn't mention in his summary is the use of pack
> bitmap [1]. Jeff talked about GitHub specific needs,...

Do not take it as the "summary of the whole discussion".

I deliberately tried to limit the list to absolute minimum to allow
building a workable initial version while leaving the door open for
future extension.  There are other things that I didn't mention
because they would not have to be in the absolute minimum necessary
for such an initial design.
