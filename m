From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 04 Dec 2014 10:41:20 -0800
Message-ID: <xmqqppbztfzj.fsf@gitster.dls.corp.google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbLc-0005OX-0V
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbaLDSls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:41:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932215AbaLDSlr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 13:41:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9DF2223C5;
	Thu,  4 Dec 2014 13:41:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FHm8BB26ohw4LKtBlYEcPKMa86A=; b=fFjSze
	Y9PhASjxI/P9b6EO0ijbb4N3tm3WIisRifWc7k0L0eXWSp42dgY1LkBaBasZ+0EL
	RzimnjGyIo/oRHcS9Qp+4i3UZjZb4rsfIzZiQISxMSQ/l4eFyRsBKX7F/18nO6k3
	I96hJFwVFvcHeW4lv4R1omXvKhaPiFPjiOIUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h5TeLy/MwG4jiGWqbNQSTlruoYWj9ujG
	R9N7m0gO29I+FFg/oCHfscqpvco32tBit/WRhsETPz5ms7M0QE57pSKCOf+uSdXq
	SjKtO77MhOm3IoyqyuWO1avuOhktwazCMIoBMhAgj7ASqlTvxK2ERuLlG/WfJMYS
	HiH3fiGRgsQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0917223C4;
	Thu,  4 Dec 2014 13:41:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CD63223AE;
	Thu,  4 Dec 2014 13:41:22 -0500 (EST)
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 4 Dec 2014 00:29:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24CF4142-7BE5-11E4-A253-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260779>

Stefan Beller <sbeller@google.com> writes:

> This is the whole refs-transactions-reflog series[1],
> which was in discussion for a bit already. It applies to origin/master.
>
> The idea is to have the reflog being part of the transactions, which
> the refs are already using, so the we're moving towards a database
> like API in the long run. This makes git easier to maintain as well
> as opening the possibility to replace the backend with a real database.
>
> If you've followed the topic a bit, start reading at patch
> "[PATCH 06/13] refs.c: add a transaction function to append a reflog"
> as the first 5 patches have been discussed a lot separately and
> can be found in origin/pu already[2].

> The first two patches are deduplicating code.
> The third patch is ripping some code out of log_ref_write and introduces
> log_ref_write_fd, which does the actual writing.
> The patches 4+5 are renaming variables for clarity.

Thanks.  It seems that we have a bit of hashing out the approaches
that is necessary between Michael's and this one.  I'll refrain from
picking this up for today (even though I would read it through as
time permits).  It might turn out to be necessary to drop those five
early patches from my tree when this series gets rerolled to take
input from the alternative Michael's working on, but that droppage
does not have to happen today.
