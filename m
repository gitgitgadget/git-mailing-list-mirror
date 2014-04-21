From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 14:52:55 -0700
Message-ID: <xmqqa9be8i4o.fsf@gitster.dls.corp.google.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
	<5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
	<53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
	<53559020.1050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcM9D-0003Si-3z
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbaDUVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:53:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489AbaDUVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E65247FB92;
	Mon, 21 Apr 2014 17:52:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=smqAstXk1j+HGKh0DiVu+JdpoUE=; b=RKg9AY
	gQDjEQJ717Igs2Lmk7DpAAJDN5yiZ546Z5TKDqwHJANx/8dcpbLi+lMfUO7DSmdz
	JHc9tsTwyoZIAVN2ebWB3l7igbLiQCbEweEv7i1OmDlzuIUHIs24N/Gh8s08ZeqF
	XG3ngUAL8Eis9t1PbQB/ZCkgtcN2MSfuYjbVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hc5ONxBgvvagIQp87nLbGYeShnQIHnMz
	seBCzuhkkyGaIDDkxT0dCUdS2uU3lPVUUBo6a42PviwhmqGfSHVYsWpzMKYdLof/
	+AscqpR0K1mw/RFM5Alie2ztAhUOZRYVMheaBxRCqEY29CWLrw/URfd+4j6uVtgx
	l4ln+8SSJi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C6B7FB91;
	Mon, 21 Apr 2014 17:52:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F2387FB8F;
	Mon, 21 Apr 2014 17:52:57 -0400 (EDT)
In-Reply-To: <53559020.1050407@gmail.com> (Ilya Bobyr's message of "Mon, 21
	Apr 2014 14:39:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4C95861C-C99F-11E3-8E33-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246654>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> On 4/21/2014 2:17 PM, Felipe Contreras wrote:
>> Ilya Bobyr wrote:
>>
>>> Also, most have names that start with either "pre-" or "post-".
>>> It seems reasonable for both "pre-update-branch" and
>>> "post-update-branch" to exist.
>> I don't see what would be the point in that.
>
> Do you see the point in the other hooks doing that?

pre- and post- are primarily so that people can tell that "pre-
happens before the operation and its primary motivation is to stop
an operation from happening" as opposed to "post- is called after
the fact and there is no way for it to intervene---it is too late;
it is primarily for things like logging" easily.

As long as you can tell what you can use it for and when it is
called from the name of the hook, there is no fundamental reason why
you need to have pre- or post- prefix in your hook names, but unless
there is no other strong reason not to, it is probably a good idea
to follow suit.  There is not much value in trying to be "original"
in naming things, just to be different; it will only confuse the
users.
