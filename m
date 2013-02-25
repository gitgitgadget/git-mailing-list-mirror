From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in ref advertisement
Date: Mon, 25 Feb 2013 11:27:25 -0800
Message-ID: <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
 <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
 <1361819916.24515.5.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3iL-00037p-9T
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759216Ab3BYT12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 14:27:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758947Ab3BYT11 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 14:27:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73964A207;
	Mon, 25 Feb 2013 14:27:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=433XOAUgewVM
	4oUcZ8bqclAVRXY=; b=GiI8ZG6Q37v9Zko4rB+nOyqqV7HiN96D1pIVUuQyRX9u
	LVhonHMAaY1wgGXg+h0/bjDMNAODu6emOayOeH0nUzKZWSUlyEp0vN4ejid0sl5Y
	ejyXOwZrAw+lV5a3Rk59e9Wfsi3zqoGSjq5zu8tbm9nVfHnorTzU/qoobX6uHFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VwCbDK
	0QNtLNEBAqGqh5xwHKDIMPG7NylLaKIzeFybY4IVeYcJ7OqfGjmqIjYrjmQfTL+7
	7M7t9HUIk1F11CvWQqzdGP4BsqYP8puld1IZifg6QQYuXLAOjNXk9SwZKyQyJOmG
	edrzbdCLnUTmmZjivsZ3KjF2BKW4Sjr/tumi4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6818DA206;
	Mon, 25 Feb 2013 14:27:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFE99A205; Mon, 25 Feb 2013
 14:27:26 -0500 (EST)
In-Reply-To: <1361819916.24515.5.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 25 Feb 2013 20:18:36
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 635FE4D2-7F81-11E2-9A17-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217089>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Mon, 2013-02-25 at 10:31 -0800, Junio C Hamano wrote:
> ...
>> Interesting.  "git ls-remote . | grep 1.8.0-" for maint, master,
>> next and pu produce identical results for me, all showing peeled
>> ones correctly.
>
> Bisection leads me to Peff's 435c8332 (2012-10-04; upload-pack: use
> peel_ref for ref advertisements) and reverting that commit brings the
> -rc3^{} back.

A shot in the dark, as I do not seem to be able to reproduce the issue
with anything that contains the commit.  Perhaps your .git/packed-refs
is corrupt?
