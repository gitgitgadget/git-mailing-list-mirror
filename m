From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 08 Feb 2013 11:13:58 -0800
Message-ID: <7vobfu1uvd.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com> <7v38x766b2.fsf@alter.siamese.dyndns.org>
 <20130208074813.GA7337@elie.Belkin> <7v622343uy.fsf@alter.siamese.dyndns.org>
 <5114D5B0.5080906@drmicha.warpmail.net>
 <7vobfu3ev3.fsf@alter.siamese.dyndns.org>
 <CALkWK0nYRiPLnBXFarp8UzZgGvA5Y6motvr5HMFy56ANr161HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:14:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3tP1-0004VS-3m
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 20:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760328Ab3BHTOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 14:14:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760323Ab3BHTOC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 14:14:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B713FC02D;
	Fri,  8 Feb 2013 14:14:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sojzegqiCYKj6ZLvlNv+qr6WCmM=; b=Xyw69q
	Gpay6rAYJToCuQFg2cNp/7UIufpoYuVpNpb7wo6BG9oqkH9Ms4lNKdc6p+YZl1KK
	s24Myoz8W7eE7DnVBhOmPM35n371ys0EZUfOZFIi2fh3zZrEeZTPV/v04YUVCxYW
	qdTAsn0+IqTZCna5uR6Ac9jO0mnCgyCRoJVnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t5LZG1Bgs/1QwJIOfIorfv2B8EHJAEnO
	Y71db2bNKeNHx1gHCTPLrR7jPF+z7HylzVrJgihL6A/B6hPMmGFGxvv2o7SXyhwF
	xOdraBRH1BTCswADNC6JE8Mr/49rrQxpQkChGlotJjDCSgeB2VrIbge1FQUlXBoQ
	P6DhMVst0Kw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A305BC02C;
	Fri,  8 Feb 2013 14:14:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CC23C02B; Fri,  8 Feb 2013
 14:14:00 -0500 (EST)
In-Reply-To: <CALkWK0nYRiPLnBXFarp8UzZgGvA5Y6motvr5HMFy56ANr161HA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 8 Feb 2013 23:59:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B185408C-7223-11E2-BC2B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215803>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>         [remote "origin"]
>>                 url = ... where Ram fetches and pulls from ...
>>                 pushurl = ... where Ram pushes to ...
>>                 fetch = refs/heads/*:refs/remotes/*
>>                 updateTrackOnPush = no
>>
>> Then "git fetch" (or "git pull") will update the remote tracking
>> branches Ram fetches from, and once his topic is finished, he can
>> push to his publishing location, which won't touch the remote
>> tracking branches used to keep track of the place he fetches from.
>
> A "push" should never touch remote/refs/origin/* if there is a pushurl
> configured.  Otherwise, it should.

That is a horrible design, no?

Because one of the main use case for pushurl is to use url = git://
for less overhead and pushurl = ssh+git:// for authentication but
otherwise going to the same place.  So if "git push" is allowed to
pretend you immediately turned around and fetched, push to that
pushurl will pretend it was followed by a fetch from the
corresponding url.

You need a way to tell if the pushurl/url pair is used for that
purpose to let Git know if that is the case.
