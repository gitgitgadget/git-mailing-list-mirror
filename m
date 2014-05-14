From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT GUI PATCH] git-gui: use vcompare when comparing the git version
Date: Wed, 14 May 2014 14:49:34 -0700
Message-ID: <xmqqk39ohvyp.fsf@gitster.dls.corp.google.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
	<871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com>
	<5369E58D.4030908@gmail.com> <53728D70.4020506@web.de>
	<5373200D.7020108@web.de>
	<xmqqlhu4jhcb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	patthoyts@users.sourceforge.net, GIT <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 14 23:49:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkh3f-0000Fz-T1
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaENVts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:49:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62590 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbaENVtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:49:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 906DA18969;
	Wed, 14 May 2014 17:49:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TE8kC/5BHV+4mhd60Ek0lsV/9BU=; b=AfuQ3w
	XpZcoKTdROA/pUdYPPJz4TJoVyA8uuNqNLlUZ00422X4bOo9ITnaj4ndFu0VaZMS
	ILxYS//aQh9rZ+ZcuqenxMP6pHvbefUmY4xnDB9MTCm44JJni/so94NyTwRBfu9p
	g9qtDIv+TXKKs3ctr5Gncum9HVjsbkUzayo9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xj1DrajvAHnlMA4b3x/POiwO49SfI85h
	VjZvzj9Knt2+sZ5iIAvEkz/cXIiMC96poUucTlEihYDQFtuPPM7v6E8ZYvoHHFWU
	6ECqLNtD5rUlHNWOwQ+jWQrQL52TnPCMrtMOVqOfo29ttLsh2LCMIG3v79QSB2rX
	Z7Us2DcSJgM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8719F18968;
	Wed, 14 May 2014 17:49:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9FA7A1893E;
	Wed, 14 May 2014 17:49:36 -0400 (EDT)
In-Reply-To: <xmqqlhu4jhcb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 May 2014 12:22:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A47E22CA-DBB1-11E3-8FDD-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249001>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Junio, I believe this issue needs to be fixed before 2.0 final. Otherwise
>> git gui will not work inside submodules anymore due to the major version
>> number change from 1 to 2. I'd like to hear Pat's opinion on this; even
>> though I think my patch is less risky (as it doesn't change behavior for
>> pre-2 versions), he might like Chris' proposal better.
>
> Thanks; I share the same feeling.

So after checking git://repo.or.cz/git-gui.git/ and seeing that I am
not missing any commit from there, I tentatively created a fork of
it, applied your patch and merged it somewhere on 'pu' that is close
to 'next'.  We may want to fast-track it to 2.0 without waiting for
an Ack from Pat but let's give him one more day to respond.
