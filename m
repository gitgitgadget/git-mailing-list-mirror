From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 06 May 2014 12:34:38 -0700
Message-ID: <xmqqsiomem5t.fsf@gitster.dls.corp.google.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
	<xmqqoazb944d.fsf@gitster.dls.corp.google.com>
	<20140506080749.GD23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 06 22:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whl8Y-0002ei-VP
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbaEFTen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:34:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56269 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbaEFTem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:34:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1442A14A76;
	Tue,  6 May 2014 15:34:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d7h/fB4oPVcxCyR7TAiL/AWBWd8=; b=Iwf6nJ
	AsUJwodItqGFEjh/yGEoIJVOvw/4Ymrf19r0voDBzohfnZ1x6gopEzfVFc9dloIT
	0W30pmmITNoELDS9RvKxrm3jRl0dVgcbEnXMgVgWZvnNX8BqiIZPSKzBONu4sjIF
	4o68Q01/KAjf+in4/r8dA6LuHqcVdcDuzEo6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FtuoOHx56EKd2gVTqeohrAyZ3CszcO8P
	frXuwQYpdxcZiv+kiQcoSlEGwVdIbKkcvMszZqBuM9C/Iz8bzfFmhZWpRcRazy/C
	Li8+epnZxwPmzbRQTl+7Zgr636VuZcGWZS2g8BVTiBLim+XI6kdsMB2LVZzYb/40
	MdfB+qy6Bnk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 090A314A75;
	Tue,  6 May 2014 15:34:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B371414A72;
	Tue,  6 May 2014 15:34:39 -0400 (EDT)
In-Reply-To: <20140506080749.GD23935@serenity.lan> (John Keeping's message of
	"Tue, 6 May 2014 09:07:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 770C18AE-D555-11E3-B91F-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248242>

John Keeping <john@keeping.me.uk> writes:

> On Mon, May 05, 2014 at 04:50:58PM -0700, Junio C Hamano wrote:
>> ...
>> At the same
>> time, however, the interface the remote helpers use to talk to Git
>> has not been as stable as you seem to think, I am afraid.  For
>> example, a recent remote-hg/bzr series needed some enhancements to
>> fast-import to achieve the feature parity with native transports by
>> adding a missing feature or two on the Git side.
>
> This doesn't qualify as an unstable interface for me.

That is true, but that does not change the equation very much, no?
To a remote-helper maintainer, bundled is easier to maintain than
unbundled, because both sides are changing, and regardless of the
nature of the change, s/he would know how the Git side looks like if
bundled.

Having said that, I agree with the conclusion of your message:

> There is a different level of urgency between "you cannot use this new
> feature until you update Git" and "if you update Mercurial then the
> remote helper will stop working", and that's why I think the remote
> helpers may benefit from a separate release schedule.

and I am inclined to be persuaded that the users of remote-hg/bzr
may better off if they are unbundled from my tree.
