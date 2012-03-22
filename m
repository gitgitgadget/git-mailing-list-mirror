From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin
 mas<tab>" if the ssh key is encrypted
Date: Thu, 22 Mar 2012 11:45:57 -0700
Message-ID: <7vehskxymy.fsf@alter.siamese.dyndns.org>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl>
 <7vmx78y1eq.fsf@alter.siamese.dyndns.org> <vpqvclwo70a.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Hong Xu <xuhdev@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn1W-0002S0-0E
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758880Ab2CVSqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:46:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab2CVSqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:46:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF51A6209;
	Thu, 22 Mar 2012 14:46:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g434PvM2WrCFmie3vnRIKhp6VsU=; b=rMgAHc
	o0hfBpPLS3y6tpc8G0TGjfD3ehkDkeWnFUlT6aoms8F+KyR1uNcvhnTRPqNwi25f
	6OdBWk6ceDGxLTYiGZqaDxWqwCQWqPtIS/7poy/hqIwYAgFp9VYrBsufPoE+KDVr
	ehHuugsJ0w+UJt3ZycFjKfZgJF/e1pTY/xS1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JzKGI+OW1svj2n+bhfY/qy9C0ccdaVqH
	CSVMXjcEpJSQnH2TV+PdTxvXR1XBicndP3h1p93V6ECHwKJHEHIee1yEyMV4aWf2
	SDO1w64cAZ93dhPNdayNsX+7Bz0Zj505mcJfJ+xg7gctAMlZPyqPL6f5G9MAt/Zu
	gD8IwvuUGl4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3F0D6208;
	Thu, 22 Mar 2012 14:46:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2BD66200; Thu, 22 Mar 2012
 14:45:58 -0400 (EDT)
In-Reply-To: <vpqvclwo70a.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 22 Mar 2012 18:55:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43EE239A-744F-11E1-83B1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193680>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I would rather think that the completion should ask for refs only when
>> dealing with local repositories, without going over network, whether the
>> query involves authentication or not.
>
> It depends on what "network" is. When the network is just a machine on
> the same Gb-ethernet LAN, completion can still be useful (only if you
> have password-less authentication of course). I don't use it much with
> Git, but I find it handy that ZSH completes rsync remote pathes for
> example.

Yeah, I agree it depends on your latency-tolerance (which implies that
this begs for an "I am impatient, do not go over network" switch).
