From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: display dirty submodule working directory in git gui and
 gitk
Date: Mon, 04 Jan 2010 11:05:42 -0800
Message-ID: <7viqbhelmh.fsf@alter.siamese.dyndns.org>
References: <4B3F6742.6060402@web.de>
 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
 <fcaeb9bf1001040951r3f797750o5ebd25e93c0272ea@mail.gmail.com>
 <4B423633.6090603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRsFs-00010p-BG
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 20:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab0ADTGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 14:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724Ab0ADTGH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 14:06:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab0ADTGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 14:06:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF0EA8EE39;
	Mon,  4 Jan 2010 14:06:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jDL5ZPJmElm+jGhL75/8UD51T9g=; b=MBNXp9
	xMbJ2yL6RBvU7WgaOwBuN8LjE7RRiljNkPg6LlxucPpfBjROu+6cYUAMUgF/0lF5
	MLUAdGr40t+6WsD0TeNrzzFsl3Ia+39z5WAnZY/P5awa6SpcubY4wWLvUEtF8WPk
	64SqegAxyxuRNUpNk+qNGS4735ezNs0BeKw8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0D4iv8ZR4kRf6xqUY/48Y6Bxy9y6q1b
	OZXpeeZ9kDQ1iw/5FnkXA/KB4Ep6UBHQHk5+ODFyTCxmWNCN+qhP1xwLov+51PPe
	BH9C6g4vctDF2Qt/EK/CwvRS3OCjFW+xrKBh6muHOjtxHN3Ohw0lnFYkHd2eXFjv
	1x+7g7zekDU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36E1F8EE38;
	Mon,  4 Jan 2010 14:05:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABBC88EE37; Mon,  4 Jan
 2010 14:05:44 -0500 (EST)
In-Reply-To: <4B423633.6090603@web.de> (Jens Lehmann's message of "Mon\, 04
 Jan 2010 19\:40\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E9E96F4-F964-11DE-B76B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136136>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 04.01.2010 18:51, schrieb Nguyen Thai Ngoc Duy:
>> Incidentally I was just drafting git-super.sh it see how far it goes.
>> The goal was to implement some cross-module operations over time. "git
>> super status", "git super commit" and others could be handy.
>
> Hm, i'm not sure if this will really help us. I would rather see "git
> status" and friends do the right thing for submodules too. Maybe this
> has to be configurable but i think the separate commands that one has
> to use for submodules now are part of the usability problems we are
> seeing.
>
> IMHO putting the functionality of "git submodule summary" into "git
> diff" was a step in the right direction. This thread is about adding a
> line to the diff output when diffing against the working directory and
> a submodule has a dirty working directory too. Then you can ask "git
> diff" and it tells you anything you need to know about the submodule
> before committing or checking out in the supermodule (And IMO later on
> "git status" should give us this information too).

Both will be valid approaches to work toward the same goal.  A separate
prototype implementation can be a way to easily figure out what the
desired features are.

If "git super status" does turns out to be consistent with what "git
status" is supposed to do, you can decide to fold that into the latter at
that point.  On the other hand, information people may want from "git
super status" could be different from what people want "git status" from,
in which case it might be better to either become a new option to "git
status", or become a new subcommand to "git submodule".

You start the prototype by changing "git status" and later decide that the
end result either needs to become an optional behaviour, or maybe even a
separate command.  Either way the end result will be the same---a good
feature to help people is placed at the most logical place.

For the past 12 months, you and Johan Herland were the people who had more
than one patches with substance to git-submodule.sh and I would really
appreciate and at the same time want to encourage experimentation by
people like you who are heavy users with need for a better submodule
support.

Thanks.
