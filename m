From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Wed, 07 Mar 2012 21:23:22 -0800
Message-ID: <7vr4x3is39.fsf@alter.siamese.dyndns.org>
References: <1331036512-7626-1-git-send-email-vfr@lyx.org>
 <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
 <CABURp0rOFgwLu0pX0W5txOH=CH6Yb4NchYLaj91m1nMve_zjDg@mail.gmail.com>
 <7vvcmgkq20.fsf@alter.siamese.dyndns.org>
 <CABURp0run5zYLBkUsNQEJq3h_1y7bQ44XZb9BPja+RjX8OLyfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 06:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5VpG-0000ac-OK
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 06:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab2CHFX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 00:23:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab2CHFX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 00:23:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49114709F;
	Thu,  8 Mar 2012 00:23:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s+Ed1XF07QP2ZMP7dLLxinDDTY4=; b=Rc/OH1
	lyv59yy7VvS9gLIWoaoP/b5EoqAYprWKi9xOEdQ8FOuNcahDYCF4srmyGRvNdLjI
	mZeYb6g3Wwspt6ZEmqW4SjIJXN5sldEuTpfAn+BQEnM90FenDfAtQ0R8eFSppAfM
	o7b8kYtyWsHl4g3i+NM11dCaUnkokAHHMV8tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GFUIbq94xMPpl4+mA6+xYuPHe1HYJYQJ
	vegiSUKbaQMjPvuvSY8RaBtoEbh6RRdqOMM4qWGb1RCLWxa8eMlOgtbMax9vpQb1
	smyi7YWm2STg1Ya4Y4i2Vmgej4/lo6+PdXYaZTImqmbeWI9HzQMwqg9MQ4VzXW6w
	djznYjd/k28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FD49709E;
	Thu,  8 Mar 2012 00:23:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB832709D; Thu,  8 Mar 2012
 00:23:23 -0500 (EST)
In-Reply-To: <CABURp0run5zYLBkUsNQEJq3h_1y7bQ44XZb9BPja+RjX8OLyfg@mail.gmail.com> (Phil
 Hord's message of "Wed, 7 Mar 2012 22:08:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D36F41E2-68DE-11E1-8879-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192519>

Phil Hord <phil.hord@gmail.com> writes:

>>> .... 'mergetool' uses this command to
>>> avoid asking the user to resolve files which git rerere already
>>> resolved for her.
>>
>> Ok, so "Print paths with conflicts that are not resolved." indeed is
>> sufficient.
>
> If you goal is to say as little as possible, then yes.  But I had to
> read the related commit messages several times before it dawned on me
> what the distinction was.

The goal is "Concise, coherent and clear"; "as little as possible"
never is.  We need to elaborate as needed but make sure we do not
tire readers with irrelevant explanation.

The first problem I had with the patch (go back and re-read the
patch and its initial review) was "Like 'diff', but...".  It is not
"Like diff" at all (if anything, it is more like "status", but
"status" in turn is not "Like diff" either). We can first drop that
part and spend more words to describe what it really is.

> The main problem was that I didn't
> understand that I was missing 'rerere.autoupdate=true' in my config,
> or why it mattered. I only know that rerere was letting me down
> sometimes, and 'rerere remaining' seemed to be missing some
> clearly-still-unresolved files.

Personally, I think you are being *good* by not using autoupdate.
Once you let rerere auto-update, it will become hard to notice a
mismerge when previous resolution is applied when it shouldn't, and
even harder to correct it ("checkout -m" will not work).

> Thanks to this proposal, I understand it better now.  But not from
> reading this email thread.

Care to give a crack at it, then?
