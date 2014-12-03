From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Disabling credential helper?
Date: Wed, 03 Dec 2014 09:14:27 -0800
Message-ID: <xmqqbnnkk64s.fsf@gitster.dls.corp.google.com>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
	<20141203005953.GB6527@google.com> <20141203012148.GB29427@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDVb-00054h-4A
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbaLCROb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:14:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbaLCROa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:14:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12BE021941;
	Wed,  3 Dec 2014 12:14:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CIybXncgN7AFqVZWXGzplE7Fflo=; b=E2t+/6
	272zzMhRPQd/GwWwLTrGee7t530uRF/tuJqCt4qoDmvaXkMhDa3rh+wCox69OM3b
	gVM7S1imVZB2JEbSnSfTyaqEHeDRYvw/2+OXn/rjsz+4bzpwMQz4TH7B7cYcubCc
	hrbUWSJGYSjxH1J0JkkWWO60LzWRhHXQOgiuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N5XFg/3j0eiGpqv51Hv8RgwvCt4XbM3P
	wD4TYZGQ3b12HvvhaBeuhKL7QodjiOa6iPYkRlmZJYpAen9QcotRxt7ofGHoZ1WC
	9vI8zpcPdT5hROqmSAALluFitfwvUeS6ttXlLJaE5LTU2CF7PioayQ1x3NGCUR22
	8v2im+QlNyM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0403221940;
	Wed,  3 Dec 2014 12:14:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D8642193D;
	Wed,  3 Dec 2014 12:14:29 -0500 (EST)
In-Reply-To: <20141203012148.GB29427@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 20:21:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D73F67C0-7B0F-11E4-ACE6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260664>

Jeff King <peff@peff.net> writes:

> Yeah, it's fine (as is GIT_ASKPASS=true). You could also provide a
> credential helper that gives you an empty username and password. But in
> both cases, I think that git will then feed the empty password to the
> server again, resulting in an extra useless round-trip.
> ...
> You probably
> instead want to say "stop now, git, there is nothing else to be done".
> ...
> We could teach the credential-helper code to do that (e.g., a helper
> returns "stop=true" and we respect that). But I think you can do it
> reasonably well today by making the input process fail.

Yeah, it is roughly equivalent to the 'ASKPASS=true' approach, and
probably is a good enough solution, I would think.
