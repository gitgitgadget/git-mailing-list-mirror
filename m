From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: make -M -C mean the same as -C -M
Date: Fri, 23 Jan 2015 14:34:47 -0800
Message-ID: <xmqqvbjxp1mg.fsf@gitster.dls.corp.google.com>
References: <1421978835-9921-1-git-send-email-mh@glandium.org>
	<xmqqr3ulqr09.fsf@gitster.dls.corp.google.com>
	<20150123222659.GA22303@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:35:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmoe-0001fe-TW
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbbAWWex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 17:34:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753272AbbAWWeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 17:34:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5219A31AAB;
	Fri, 23 Jan 2015 17:34:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jekjVwC7CBrUfvuVq8gwe2m8+W8=; b=QCV12k
	Y0++2EO0X7EpO2Di7QO9ig2Y28Ez4YoIyD0JNIrKRLJ5bN+yR3Ip/PnBgPrfS+2e
	q/ExQgJF1hl3FLXUab/mb1Tddk17uMHo3djDSerSfgnSCjBBbdzlYNhpAQwOlQC9
	2X4IxF3tCW6PSZVOYjlci8IaureSfv2evJv4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vFELIqvXQB0gs2rNlYq0kq9gN0efIayb
	foJPLgCB98mmdPdmdEzLlQsBOXOrRyEcHBRN1P4TIhH8iecC4PZ0vA0GqM02dIg+
	bZFXRkAiBcwogcYQpi0bWJLfx6dMToVxmv1SL64kgXCq90ldKPyzPHosaVR8JDhj
	7d2Rx1xkyAw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 482AE31AAA;
	Fri, 23 Jan 2015 17:34:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 977F331AA9;
	Fri, 23 Jan 2015 17:34:48 -0500 (EST)
In-Reply-To: <20150123222659.GA22303@glandium.org> (Mike Hommey's message of
	"Sat, 24 Jan 2015 07:26:59 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09DF6762-A350-11E4-A4D3-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262971>

Mike Hommey <mh@glandium.org> writes:

>> In the context of "git blame", "-C" and "-M" control orthogonal
>> concepts and it makes sense to use only one but not the other, or
>> both.
>
> In the context of blame both -C and -M |= a flags set, so one doesn't
> override the other. You can place them in any order, the result will be
> the same. Incidentally, -C includes the flag -M sets, so -C -M is
> actually redundant. What -C and -M can be used for is set different
> scores (-C9 -M8).

Yes.  That is what I meant by "orthogonal" and "makese sense to use
only one but not the other, or both".  As they are not related with
each other, it makes sense to mix them freely, unlike "-C/-M" given
to diff.
