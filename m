From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Tue, 19 Nov 2013 08:53:33 -0800
Message-ID: <xmqqbo1g9vua.fsf@gitster.dls.corp.google.com>
References: <vpqiovpfxd1.fsf@anie.imag.fr> <201311191336.31000.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Noufal Ibrahim KV <noufal@nibrahim.net.in>,
	Andreas Krey <a.krey@gmx.de>
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Nov 19 17:53:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VioYW-0005oT-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 17:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab3KSQxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Nov 2013 11:53:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab3KSQxg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Nov 2013 11:53:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C6B551016;
	Tue, 19 Nov 2013 11:53:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jxveB6HjUamo
	l8GIecu2iBfi8t4=; b=smOzKIwJaitJZBHVD7Q9vdpmhNWd2RZ+xDDVX1hto65I
	nzI0Djjpvke/kM+WSk50od1gcIQjjmIX0W1I3Ove0qxD2srrW9ivvpi41+j5ASJ0
	fqc4f91H5TZHuHqM8y/AHJ7WpFr3HamN+FIo/43NkWH8IEwynHeYfzAjLuxcrT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r1vYxf
	J9l9OUL1w9vayoJVOenljPdKjTzErt5G14pJlAYZR0sgJDrBBDf+XtYQpSFFxGS6
	FetGRQx14Vp0Iy2pfQLhkmBXHqNBv4EdhLgXj6ue8GaWETZvL6I1EgHbhvbUyE86
	iuTE0SMSBUHoSQ0dKEhpBqD+9XMsQkgdTkz3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D29F51015;
	Tue, 19 Nov 2013 11:53:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAB5E51013;
	Tue, 19 Nov 2013 11:53:34 -0500 (EST)
In-Reply-To: <201311191336.31000.thomas@koch.ro> (Thomas Koch's message of
	"Tue, 19 Nov 2013 13:36:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20F4A484-513B-11E3-AF47-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238029>

Thomas Koch <thomas@koch.ro> writes:

> I'm a software engineer now with an education as a high school teache=
r. From a=20
> theoretical point of view it's preferable to avoid any abstraction do=
ne by a=20
> GUI and use commandline Git. Only gitk is useful to have a visual _fe=
edback_=20
> of the actions done on the commandline.
>
> But also from experience I can tell that without exception everybody =
whom I=20
> teached Git understood it only after being introduced to the basic co=
ncepts of=20
> Git and how to inspect and operate them on the commandline. Others to=
ld me=20
> from similar experiences.
> ...
> My collegues meanwhile dumped their graphical Git tool because they l=
earned=20
> that they have better control over Git when using it from the command=
line.

Interesting.  I think any UI needs to fill three objectives:

 - make common tasks easy;
 - make complex tasks possible; and
 - help users build the right mental model.

As a tool from Linus school, we started from the second and the
third point.  Our UI (i.e. CLI) has long been notorious for lacking
in the first department, and we have worked long and hard to improve
on that front.  While there are more work needed for CLI, your
observation, and a similar experience by Noufal in the thread, hints
me that the available GUI tools have concentrated primarily on the
first point but are still lacking in the rest.

Perhaps I am being na=C3=AFve, but I would expect that a GUI is a much
better vehicle to help users build the right mental model.  Unlike
CLI, it has a canvas to draw pretty pictures and present the users
what the user is really doing after all.

And I am sure GUI people will eventually realize that potential in
the tools they are building, and the world will become a better place
for both GUI and CLI users ;-).  I found "ungit" an interesting
experiment that goes into that direction.

Being forever hopeful...
