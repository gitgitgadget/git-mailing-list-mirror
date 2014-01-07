From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/17] safe_create_leading_directories(): add explicit "slash" pointer
Date: Tue, 07 Jan 2014 09:41:15 -0800
Message-ID: <xmqq4n5fg05g.fsf@gitster.dls.corp.google.com>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
	<1389015935-21936-4-git-send-email-mhagger@alum.mit.edu>
	<xmqqppo5hsf9.fsf@gitster.dls.corp.google.com>
	<52CBC854.2060602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:41:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0aea-0002Li-Rm
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbaAGRlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:41:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbaAGRlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:41:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE2C160C7B;
	Tue,  7 Jan 2014 12:41:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RRnW6r/7Bc1W5eQi6EZDw8lHULg=; b=TxwqV4
	1ZVGOduoh+dT+ZHGkQUCtWXt/78EYAVRXO+ejd9Sl+iR9Hq0kCiG1L+u9MmOwVY3
	PYn2c9T/ZAKTZ0XCIsfFFQ9SClIhcXs7QJy8RIAfw5Sd2RoBAQylITKNZbvOkTkS
	GzPaSLHVL/nj03HSv8+DHLUz4T1/3Xc7h69zY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hKk264ELSTLvK7C2nFdj6i1MNcEFMdZW
	/nttIvgzj11DMmksxSlzaczC8mliQcdg2jAa7+xKpnyj5p/Yg8OM7AcqGfBEjvei
	rmc5fTZbpM4UZqSEnlA5vxPw7Qtb/xc4nZoYor3wIn3pFENP//6KkDPlNrEKzJDr
	DliU8B50EOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B14A260C7A;
	Tue,  7 Jan 2014 12:41:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B7DD60C78;
	Tue,  7 Jan 2014 12:41:17 -0500 (EST)
In-Reply-To: <52CBC854.2060602@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 07 Jan 2014 10:26:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E988319C-77C2-11E3-820F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240115>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I agree that it would be reasonable to use is_dir_sep() in the
> implementation of this function, at least unless/until somebody does the
> work to figure out whether callers should really only be passing it
> forward-slash-normalized paths.
>
> Please be careful, though, because I don't think this function is
> capable of handling arbitrary Windows paths, like for example
> //host/path format, either before or after my change.
>
> Let me know if you would like me to merge or rebase the is_dir_sep()
> changes into this patch series.

I'd want SSchuberth and windows folks to be at least aware of this
series and preferrably see that they offer inputs to this series,
making their is_dir_sep() change just one step in this series.  That
way I have one less series to worry about ;-)

Thanks.
