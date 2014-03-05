From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/3] merge: Add hints to tell users about "git merge --abort"
Date: Wed, 05 Mar 2014 13:20:45 -0800
Message-ID: <xmqqob1kfiky.fsf@gitster.dls.corp.google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
	<20140226203836.GM7855@google.com>
	<CADgNjak3aqPDV0iZYc8b6QJ9y+6bUd28n0UJOm6WjufQhjfuwA@mail.gmail.com>
	<xmqqa9d4ijmu.fsf@gitster.dls.corp.google.com>
	<CADgNjamZE5140U2vupgZMKyBq+e22+qOAAWKe=iRk7sxzhonvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLJFJ-0006If-JI
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 22:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211AbaCEVUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 16:20:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbaCEVUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 16:20:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86C696F772;
	Wed,  5 Mar 2014 16:20:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K0ZIBOXxAXXWTALCC3vx9HvPwK4=; b=I9IWl+
	eDuaUgL+1OYb91p3lfp7PfHCrQfamE0dhPUUU8JmQP0QEGpeqeMa1/YRCQXNz+kW
	LALtgOln4UhtRHYi41RT42ulRZAu05+4F5r19gCbvDWY/OyDPK+B7K3+ZFv16jS/
	dTh6HXWUZwaDYjTv+KZ2bxELJHuvW77Zgf+rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RGjcjfl+/PBEvpuAR7Om84XBtBgJDjJ3
	wNamCsxEVWB/ZZVL1UBVaNBOrIsEQZRWEG2K6stHPAMQKYKWwjLEf0BmbN5hVj9A
	OnPEDAEGDwGPAHDz2/8twleujtvr8WnXzds5S/rL05P0e95pEIIgijj9pmSKDG0F
	LWIZe9/rksk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 722CA6F770;
	Wed,  5 Mar 2014 16:20:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89E536F76C;
	Wed,  5 Mar 2014 16:20:48 -0500 (EST)
In-Reply-To: <CADgNjamZE5140U2vupgZMKyBq+e22+qOAAWKe=iRk7sxzhonvA@mail.gmail.com>
	(Andrew Wong's message of "Wed, 5 Mar 2014 15:51:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 058DC42C-A4AC-11E3-9571-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243481>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> ... merge hints in the future as well.

I actually wish we did not have to add any hints in the first place.

> Having one advice config/variable
> for every single situation seems a bit overkill, and we would end up
> with too many variables.

That goes without saying.
