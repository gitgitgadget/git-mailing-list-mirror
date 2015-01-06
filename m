From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] format-patch: Add config option format.coverbodytext to change the cover letter body
Date: Tue, 06 Jan 2015 10:57:07 -0800
Message-ID: <xmqqd26rpwjg.fsf@gitster.dls.corp.google.com>
References: <1420486105-30242-1-git-send-email-sbeller@google.com>
	<xmqqzj9wp52y.fsf@gitster.dls.corp.google.com>
	<CAGZ79kabhx1q2pxY0_UXAy64G94GQZaP4nSUgeUjV0c_sjt+QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8ZJd-000762-Vw
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbbAFS5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:57:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbbAFS5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:57:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DB602CB57;
	Tue,  6 Jan 2015 13:57:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CBEodrC8vYum6cq/obEKiaDEsxY=; b=bOyoij
	VMDjgziISxYDSkrB2vATKQiEEpJE9BIlyZH8rlOfEQ8p/nHs5zeDFfzucEpYG5AQ
	uEPjs6bUzEZwtM91xrCS7fUs/0RTp8ieXlifwunKwnpj1ub2/jqC0FLbx83fzq/v
	O4rxoGAS49z0mfuoEOiIjQUMu4+FxwRScE3M0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lsdBLX4RLZoPw9CYtnBfshLFaLECfIZz
	nQg6f8qS/LSH6ZpeyLqVOdcIgHl9J1EtcJ28uMzYQQJkmLAeZ6MQckylSfSfcVAq
	nEfPA199CgcxLOB8DY39MmCwbVTyQgO2ZoFA4/JN9ZSfG1YvRimNjB026GX2hzDn
	i4eXsyu174Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 342282CB55;
	Tue,  6 Jan 2015 13:57:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13CA92CB52;
	Tue,  6 Jan 2015 13:57:09 -0500 (EST)
In-Reply-To: <CAGZ79kabhx1q2pxY0_UXAy64G94GQZaP4nSUgeUjV0c_sjt+QQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 6 Jan 2015 10:08:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0C4F582-95D5-11E4-8B0A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262087>

Stefan Beller <sbeller@google.com> writes:

> The disadvantage is that I need to have the high quality in a branch before
> sending it out for review. But I personally find it easier to deal
> with git branches
> than with patch files of different versions. Branches do not forget
> anything once
> I edited it in which turns that point into an advantage for me.
> ...
> But how do I know if a patch is perfect?

You said it yourself above, didn't you?  While perfecting your
branch and while perfecting reroll of your branch.

>> Perhaps --add-header="x-reminder: what changed since the last?"
>> would be sufficient for your purpose instead?
>
> I am not quite sure if that is my problem any more. Say I have the
> following check list:
> * Do I follow the coding style?
>   * indentation by tabs and spaces
>   * no superfluous braces
>
> * The code itself
>   * Does it embed into the current logic flow?
>   * memory leaks?
>   * Does it compile and test (git rebase --exec=make --exec="make test") ?
>
> * Is a patch small enough?
>   * Does it do one thing? (move code or add code, not both!)
>
> * Do I have a proper commit message?
>   * spelling and grammar
>   * Does the commit message (still) describe the changes of the patch?

All of the above sounds like what you want to do once-per-patch, not
once-per-series, so a reminder while reviewing each individual
patch, not while writing the cover letter, would be a more
appropriate place for them, no?

> * After doing changes, wait at least 12 hours for second self-review

This is certainly once-per-series.

> * sending out:
>     git format-patch --cover-letter --notes --subject-prefix=PATCHvX

This is not even helpful reminder if that is only shown after you
run format-patch, no?

> Most of it is on a per-patch basis, but it is easier to check for the whole
> branch/series in one go after some time when you found some mental
> distance to the code you wrote yourself. And for me this is usually
> the next day, when I review it again and ask myself: Do I send out or not?
>
> As you can see there may be quite some discussion on what you want
> to put into that check list, hence it should be configurable. We could of
> course think about pre-populating the check list for new comers.

Yes, but that is a separate discussion where the check list is given
(per patch or per series?) and how it is presented (overriding the
"blurb here" comment or something else that can also be used for the
non-cover messages?).
