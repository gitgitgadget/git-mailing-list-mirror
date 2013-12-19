From: Junio C Hamano <gitster@pobox.com>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 12:37:53 -0800
Message-ID: <xmqqsitoefvi.fsf@gitster.dls.corp.google.com>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
	<20131219190333.GE23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtkM5-00011q-LD
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab3LSUh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:37:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982Ab3LSUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:37:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE1645BCED;
	Thu, 19 Dec 2013 15:37:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CFoiLkXREvTqkYT+F+6CGc2A4oY=; b=EN+evW
	VbSoeA0HWeXGsTuKOj9toRwIZLpLdtRErtmyK0jdesjYzNJdLw6OV6rnATLFa6fy
	bNaBb8evTQESOSLdHK1Ql4BH7bDD21vs/cEpKRQGMHODSw3Xz1Awg0QYv7nsQidl
	ZuviujkLmxM5uMSku0+e8rJ2jaRJarcMKymu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E0Sq9abhguscov2Jswo1UTPiDKO15umn
	SUtoB1QLdpqNB3AntaPSAHZzFHx3Yb5DYtjNNoSbK8h9myxPQblfBxFfaMIrYsVT
	RrD1O8Ml6TN1FKyR5wH0BvXRSSbQyUYoWasLaYaDRbT4how01mGZLa6nxITBrCa5
	Wdau+O9KLKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A02D15BCEB;
	Thu, 19 Dec 2013 15:37:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E95D65BCE7;
	Thu, 19 Dec 2013 15:37:55 -0500 (EST)
In-Reply-To: <20131219190333.GE23496@pacific.linksys.moosehall> (Adam Spiers's
	message of "Thu, 19 Dec 2013 19:03:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70C39DC0-68ED-11E3-807B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239541>

Adam Spiers <git@adamspiers.org> writes:

> On Thu, Dec 19, 2013 at 06:36:45PM +0000, Adam Spiers wrote:
>> I wanted to be able to experiment with the TREESAME example given in
>> the git-log(1) man page, so I built this script which recreates it:
>
> [snipped]
>
>> Would it be worth including this in (say) contrib/, and then referring
>> to it from the man page, in case anyone else feels a similar urge?

I doubt it.  75% of the work for such a person to understand the
behaviour from such an example is to understand what kind of history
the example is building.  As you noticed, we do have existing tests
to build "interesting" sample histories, but the fact that you did
not bother with them and instead rolled your own should tell us
something ;-)  The next person is unlikely to read your sample in
contrib/ but will roll his own, which is probably more efficient way
than learning from a series of commands.

What we _could_ do instead may be to better annotate sample
histories in the existing tests.  Some of them (e.g. 6004, 6007) do
have topology illustrations with what paths are changed at each node
in the graph, but many lack such a visual aid to help readers
understand what is going on at a glance.
