From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Easy Non-Fast-Forward Pushes
Date: Wed, 04 Mar 2015 17:42:53 -0800
Message-ID: <xmqqfv9k5iea.fsf@gitster.dls.corp.google.com>
References: <loom.20150227T170215-199@post.gmane.org>
	<CAGZ79kZ3_ohE6ebY5MvOk6+QfChppR_OtcmVaw5LBoutTWm3ZA@mail.gmail.com>
	<ygeioel2cw1.fsf@lassekliemann.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lasse Kliemann <lasse@lassekliemann.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 02:43:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTKoX-0000X6-4c
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 02:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbbCEBm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 20:42:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753612AbbCEBm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 20:42:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 332E63D23A;
	Wed,  4 Mar 2015 20:42:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fJW/JciaLN7zD/y4MNjU/BF28ZU=; b=Ncn3Hh
	B27yvrVpnHMO1TJts3eu/jl1JWXaYY62PUWDg2g+sm1rteEjOFr/deNf88hXj8MC
	V70/xE+b4ZbS+XEq2p234yj89HlO1inmC3SMTToKJi3fqaQVQDJf4pl1Pjpx6sgE
	nMT0slrFC4eI0UoQMOyP8r7dZDVJwgZftxugk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BhnwtAcLoZBLk+RuGoK8fujq5jmDyo6n
	Wc8Tg59S+pGds7YLmo0JsDZEkRoDl/I1NQt4xA5Cb20S05dyPHZsxhS7neETrNkp
	qXIXY7v6i0SNmt5XCMwLP0PRjrnE7BNn9YOPRkBL9/Iq6X55YTnLKnWxjfmXWEyj
	mvYnywISQUM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BBDA3D239;
	Wed,  4 Mar 2015 20:42:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A76D73D237;
	Wed,  4 Mar 2015 20:42:54 -0500 (EST)
In-Reply-To: <ygeioel2cw1.fsf@lassekliemann.de> (Lasse Kliemann's message of
	"Sun, 01 Mar 2015 12:08:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F16A5F5E-C2D8-11E4-A4A2-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264809>

Lasse Kliemann <lasse@lassekliemann.de> writes:

> 1. Try pushing to origin/master. If it works, fine. If not, goto 2.
>
> 2. Push to the appropriate personal branch.

I wonder what happens to this user _after_ that change gets
integrated on the project side.  Presumably somebody picks up the
change from the "personal branch", does necessary merge and updates
the master, so the next time "git pull" is done, it will
fast-forward?

I have a feeling that running trivial merges on the server-side when
a push is made, and immedately pulling that result back might help
such userbase who does not care too much about the history better,
instead of using the bare-metal 'git pull' and 'git push'.  You'd be
scripting on the client side to do the above two steps for your end
users anyway, so it would not be too much of a stretch to make that
script a bit smarter still?
