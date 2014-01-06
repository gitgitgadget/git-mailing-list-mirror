From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: Re: Re: [Bug report] 'git status' always says "Your branch is up-to-date with 'origin/master'"
Date: Mon, 06 Jan 2014 09:12:48 -0800
Message-ID: <xmqqlhytjapb.fsf@gitster.dls.corp.google.com>
References: <20140106154552.GA22189@google.com>
	<CAGyf7-FX1sPjwvKdxeEXopffFPiftgDRqoe7NRWyM1Cm=5n6Sw@mail.gmail.com>
	<1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
	<1283978462.720554.1388999328222.JavaMail.ngmail@webmail15.arcor-online.net>
	<1067660482.1596252.1389024023072.JavaMail.ngmail@webmail11.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, bturner@atlassian.com,
	worldhello.net@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:13:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DjW-0006EU-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbaAFRMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:12:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbaAFRMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:12:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D62B85D62D;
	Mon,  6 Jan 2014 12:12:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hcf5VT2OB4s8hnLasE6RVqOJEzc=; b=Gauwcy
	/1y5RO0zMoDe4AWJ+Cp8DsZUSpeynlhDAQT7Te2Nx21TFzMbF5h+qGjEa2re3X4m
	nA04WH0DJ2rJW1z5BCn8AKyFN5IHGDFqGPgYee9w55OwWHDpk3danIrNCmvhQ+EE
	WLoCj3KsMRYj7kamVU/qdNuatTK2rEuOSqvwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L2kX+p3Izznr2loMU9GxO5rwERsjjee3
	7398oF7B2IgYn3EPFZgiKuvUMwJ6Ztmst1ki9Z+ZsNYD7H3ZkthUz0LF7rj1gohG
	i3V7LHldO1sJ8cx2afBFwL+vAAi3EOgn8yprqhkorXsDS+Nt9ZMQwjw9rgD+nDX3
	NHPwuO5S9i4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C43585D62B;
	Mon,  6 Jan 2014 12:12:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0B325D626;
	Mon,  6 Jan 2014 12:12:50 -0500 (EST)
In-Reply-To: <1067660482.1596252.1389024023072.JavaMail.ngmail@webmail11.arcor-online.net>
	(Thomas Ackermann's message of "Mon, 6 Jan 2014 17:00:23 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5DDD706-76F5-11E3-9FD9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240028>

Thomas Ackermann <th.acker@arcor.de> writes:

>  
>> > But for the simple use case where you only have a master
>> > branch I consider it not really helpful and - at least for me -
>> > misleading.
>> 
>> I see what you mean, and you're not the only one.
>> 
>> Git follows a rule of "never contact another machine unless explicitly
>> asked to using a command such as 'git pull' or 'git fetch'".  To
>> support this, it makes a distinction between (1) the remote-tracking
>> ref origin/master and (2) the actual branch "master" in the remote
>> repository.  The former is what is updated by 'git fetch', and the
>> latter is something git does not know about without talking to the
>> remote server.
>> 
>> What documentation did you use when first starting to learn git?
>> Perhaps it can be fixed to emphasize the distinction between (1) and
>> (2) earlier.
>
> I think it's not the problem of the documentation but of myself
> not having it read thorough enough ;-)
>
> (This new feature in V1.8.5 of course is not documented in any of the books
> up to now but in the future could be used to explain the above mentioned
> rule.)

By the way, this is nothing new in 1.8.5; we didn't bother saying
up-to-date before, so you may not have noticed, but its silence was
already telling you that your branch was up-to-date with respect to
what you are building on top of.

>
> Thanks to you, Bryan and Jiang for your help!
>
> ---
> Thomas
