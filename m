From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Let core.excludesfile default to ~/.gitexcludes.
Date: Wed, 30 Dec 2009 11:49:25 -0800
Message-ID: <7vk4w4z1h6.fsf@alter.siamese.dyndns.org>
References: <4B06A7EE.2090801@atlas-elektronik.com>
 <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
 <20091230224135.6117@nanako3.lavabit.com> <vpqhbr8ttwv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4YU-0001ii-Gv
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 20:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbZL3Ttg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 14:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbZL3Ttf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 14:49:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbZL3Tte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 14:49:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18ED3ABCA2;
	Wed, 30 Dec 2009 14:49:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=06X8xHCSDWrl9ZVYnGNVDa9TPUk=; b=arIAIhPO/iK9nDyeTXZE0ig
	emwnnypGtElY6/zEC+I38OnjypQt5MRFLD9edwQhAfL7sr9bhsXjKaY9j0Gk4Umu
	B5tcJlPsPovaeXqDYHw0AmjcysHC4jiOWs1DRg7IEHlAJMUEh6HVlL3u0SIO0hEY
	8te9DEg+Vol931Z94xck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FdfvowMzbJ2NC21wArp0KMkxG/YC6D5VWtkANHhljsDkP2DOP
	pt4LDCgFV9qC4O8Xu9Gsc6ntop5qgtVn/UXxrMLHLa0i9NX0fPbNsAv56wTDb1Wz
	EbCfo5bCimDDzh4zgbB0j/F3GkmKxsU0FyzapmLDtc+oZVSdsskUwJMUgs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC1B7ABCA1;
	Wed, 30 Dec 2009 14:49:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7526ABCA0; Wed, 30 Dec 2009
 14:49:26 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7236983A-F57C-11DE-9D23-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135921>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Junio, could you tell us what happened to this thread?
>
> I'm not Junio, but I can try ...
> ...
> So, I dropped the patch until we get closer to a consensus on what the
> default value should be.

Thanks for status updates.  Should we start trying to reach a consensus on
how to move forward, or is it not your itch?

It is not _too_ bad to treat ~/.gitconfig specially and support reading
from ~/.$SOMEGITTTYNAME/{excludes,attributes} files.  We can also add
support for ~/.$SOMEGITTYNAME/config and try reading from it as well, but
even if we did so I don't think we should stop reading from ~/.gitconfig.

I don't have strong preference myself either way.
