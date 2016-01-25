From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Mon, 25 Jan 2016 14:03:45 -0800
Message-ID: <xmqqa8ntfha6.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
	<CACsJy8D2x1DtzNGB+zjoLxNwZoG2cVkkU9=ziHtRiV6rfBVc7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:03:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNpEl-0002At-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 23:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbcAYWDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 17:03:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751763AbcAYWDr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 17:03:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A2F440B4C;
	Mon, 25 Jan 2016 17:03:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xVTgU+xFG82ctdpXn35x2FAJCn8=; b=XvV1EC
	08VKZv8xtYpBu7WKWjeDokPOI173z7l4F1NdWbqgm7LtdumpH0tsbtj2aER+PVOR
	Cgg7AZEnF7gvorEt1Lfia9WMvuvEFLQwz2yTqQf/izg43LofkK0bvnqd/AP3kOsS
	vORD2HFIXIP2Geo5Odd2dS/AF/Ueoo4Q/rBcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S5xt5pJ/qZsHh9D0ze4Vz/jNDZNbHzkW
	N2uDxoVbw1FAVyL9AKRsgoV57uFCLk0wx4MEpHD5JTmdANaUll+ptQ2DT7h9ncPd
	d+ba2T48/x9fb9toRg5BdomTsujYBv5mYhHeAxKiE4T5WEZEI3bcOWleCjeORoV9
	xCpQX5lwSA8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F40A040B4B;
	Mon, 25 Jan 2016 17:03:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6900C40B4A;
	Mon, 25 Jan 2016 17:03:46 -0500 (EST)
In-Reply-To: <CACsJy8D2x1DtzNGB+zjoLxNwZoG2cVkkU9=ziHtRiV6rfBVc7Q@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 25 Jan 2016 16:56:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8186C9CE-C3AF-11E5-9E01-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284761>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 12, 2016 at 6:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * jk/graph-format-padding (2015-09-14) 1 commit
>>  - pretty: pass graph width to pretty formatting for use in '%>|(N)'
>>
>>  Redefine the way '%>|(N)' padding and the "--graph" option
>>  interacts.  It has been that the available columns to display the
>>  log message was measured from the edge of the area the graph ended,
>>  but with this it becomes the beginning of the entire output.
>>
>>  I have a suspicion that 50% of the users would appreciate this
>>  change, and the remainder see this break their expectation.  If
>>  that is the case, we might need to introduce a similar but
>>  different alignment operator so that this new behaviour is
>>  available to those who want to use it, without negatively affecting
>>  existing uses.
>>
>>  No comments after waiting for a long time.
>>  Will discard.
>>  ($gmane/278326)
>
> I carried this in my tree and didn't realize it's dropped from 'pu'.
> There's actually a comment last month [1]. By your last comment, does
> it mean I should check if "it" breaks anything to resurrect this one?
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/277710/focus=282886

Ahh, yes, I remember that your response was that the patch is good
and we do not need a new separate way (as there already is one)
to specify the other behaviour.  So if that is truly the case (I
didn't check it), we would certainly want to resurrect it, as there
wouldn't be any downside to it.

Thanks.
