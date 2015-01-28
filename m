From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Score in diff-format
Date: Wed, 28 Jan 2015 10:57:23 -0800
Message-ID: <xmqqegqeivho.fsf@gitster.dls.corp.google.com>
References: <20150128062309.GA29506@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:17:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZ3V-0008Lc-I6
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbbA1URb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:17:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753953AbbA1UR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:17:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2C8D321E0;
	Wed, 28 Jan 2015 13:57:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=heFTI+jIrVcyUVgKb9dV9gnbDZc=; b=wzt34b
	lvSiHhdt5NGRNYUMG1ng1gvnn4WggA5n0MsCO57nbIxWUFFn/yaK7y2wm1Aom501
	E3LgxcmZoZQgEYiS9wyNYnfBS8/ZCx+EIkQ76kNfx+iK1EgRw5HszZv9U02G6/Vc
	eH2yAag/vUsqgCC86SBDxeWUjIUbm/BKSuYAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EUL4oaFc+E7Z2bzaQ9m5wHbf51lzrVOb
	WVOeTUaFyILNis/FmS01uE4mCxY7cvyV5jXsrofaxcWT/bIkEffCwtgIb62YkPqS
	I1OHaAndTwmQgmi0FrG+bQf6XHV6x0NxDLG4+HA5foPLloHVZ4LjfhkT1NOLU17B
	LjwVxZYrKZQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9D3A321DF;
	Wed, 28 Jan 2015 13:57:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61953321DA;
	Wed, 28 Jan 2015 13:57:24 -0500 (EST)
In-Reply-To: <20150128062309.GA29506@glandium.org> (Mike Hommey's message of
	"Wed, 28 Jan 2015 15:23:09 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EF9C7D6-A71F-11E4-9467-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263105>

Mike Hommey <mh@glandium.org> writes:

>   (snip)
>   Status letters C and R are always followed by a score (denoting the
>   percentage of similarity between the source and target of the move or
>   copy), and are the only ones to be so.

Good eyes.  I _think_ what happened was that break-and-then-merge
(aka complete rewrite detection) came way after this was originally
written, and "the only ones to be so" is stale in the world with
complete rewrite feature enabled.

Perhaps update

    , and are the only ones to be so.

to

    ; M may be followed by a score to denote how complete a rewrite
    the change is.

or something like that?
