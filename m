From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Mon, 12 Nov 2012 16:37:41 -0800
Message-ID: <7vd2zigwx6.fsf@alter.siamese.dyndns.org>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
 <1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
 <1352760759.18715.7.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4Vq-0004l6-9h
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 01:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab2KMAhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 19:37:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab2KMAho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 19:37:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C470DAC2A;
	Mon, 12 Nov 2012 19:37:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNdUBea/lOIJtSZCFof03X3y2Lo=; b=tMLLTN
	18gfEcRFIigMDF/VKmMfX0kfQfSpmOd9ruSWB300hES1NH1+oWTP5g9KrlUBhO7v
	jCHU4b92NRgcaEUvO1oACRGBMaIkKGRB40w7duAyv0Lcpi3Pw1qd9BrLV64FD2pY
	0oh+upLBwNkQbqwaq0WDIouQbNO5TaP5oPxvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YTGmZo4bmEIeQFiYFXUAKAaCWe7PVbYi
	IWUiUC9e+Onwh/c20cGxCRLKzesTOpEQ5wrBdVJ6jo6SnXuN6gcXYV0JpNoJ+Uru
	HSApIj/n5Ha0IXLb9WR80PZwfqjaPVCZ3VBJR+Ni4LU2prPuVD2JG0j5M/yD5DKV
	muvKjm59zMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B275BAC29;
	Mon, 12 Nov 2012 19:37:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19137AC28; Mon, 12 Nov 2012
 19:37:42 -0500 (EST)
In-Reply-To: <1352760759.18715.7.camel@joe-AO722> (Joe Perches's message of
 "Mon, 12 Nov 2012 14:52:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 561C7D2A-2D2A-11E2-B635-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209553>

Joe Perches <joe@perches.com> writes:

> On Tue, 2012-11-13 at 03:21 +0530, Ramkumar Ramachandra wrote:
>> Felipe Contreras wrote:
>> > cc-cmd is only per-file, and many times receipients get lost without
>> > seing the full patch series.
>> 
>> s/seing/seeing
>> 
>> > [...]
>> 
>> Looks good otherwise.
>
> s/receipients/recipients/ too
>
> Practically this is ok but I think it's unnecessary.
>
> Output from git format-patch is always in a single
> directory.

Sorry, but I do not see how the usefulness (or necessity) of this
new option is connected to the fact that you can tell the command to
write the patches into a single (possibly new) directory.  Care to
explain?

> My work flow is to use a script for --to and --cc
> lines that can be set to emit the same addresses for
> all files in a patch series or generate different
> addresses per patch file.
