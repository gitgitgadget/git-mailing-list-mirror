From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Thu, 08 May 2014 14:56:46 -0700
Message-ID: <xmqqzjis0w9t.fsf@gitster.dls.corp.google.com>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
	<878uqcotxg.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 08 23:57:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWJD-0006Hk-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 23:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814AbaEHV4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 17:56:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55012 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753994AbaEHV4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 17:56:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5724E1501C;
	Thu,  8 May 2014 17:56:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xEzfuZXRwroOoN+yvFftAYd7QM=; b=NTq9lt
	2gA7EsoWf64vF6oinbXKkO1I5m8slUfAhWmBP6im5qT5HFrN4omVanBXYUrqu9+f
	/J3lFrzF/RdiLH/v6k782rUOETsKySEUQNbEkS7Pn2uWGsc/B2UM2eRmWZ5UkqKJ
	NT+huUTty3H0K0V6DXaxvd66lh+JCRBY8M37k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4pTdElBAMAWyK3WdyV/4OcgMF4CbACA
	+TQ5YzpLp+C8X7dT5w6AXH20OWOw4o7J00OjM2aAKyO9U9tPEnkxvn5aodNQfrMz
	gwXwaVnWbB1tD4Rm1J/XMHxWvEJVwR2n1KXWThzDkfaW/rxY41y0weCi3jUNaU1I
	ZzXIKJFIH98=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CC421501A;
	Thu,  8 May 2014 17:56:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DD30F15018;
	Thu,  8 May 2014 17:56:47 -0400 (EDT)
In-Reply-To: <878uqcotxg.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 08 May 2014 23:13:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A70F4D80-D6FB-11E3-A5EE-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248453>

In short:

 - I am not considering nor proposing to change the default at all.

 - I have two choices, either change the behaviour of "-b", or
   introducing a new option (the latter includes "-b -b"); I am
   slightly in favor of the latter, but not by a large margin.

 - I have two choices, regardless of how the new mode is triggered,
   for outputs.  Either fill it with "Unknown" name and leave
   everything else as is, or blank all information from the boundary
   commit out.  I am moderately in favor of the latter.

Hope that clarifies.
