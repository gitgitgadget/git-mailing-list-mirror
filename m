From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Mon, 23 May 2011 07:14:19 -0700
Message-ID: <7vd3j9wll0.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
 <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com>
 <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
 <BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com>
 <vpqk4dhzsvh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnaud Lacurie <arnaud.lacurie@gmail.com>, git@vger.kernel.org,
	Claire Fousse <claire.fousse@gmail.com>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 23 16:14:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOVu4-0004wc-Is
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 16:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab1EWOOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 10:14:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab1EWOOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 10:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 586C14322;
	Mon, 23 May 2011 10:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jCNPPpI+T1SCuaPiM6ijdaH/BlA=; b=LUdf0l
	6tdzT5lDFmiOxBqlW8Iz9uzdA6ZQpmh5wcVMn4ReHCXc3n7LAg+S0xZokVRdpIBJ
	jpnc8ilp2G4IPjleRMmcteZ/GXN85CxZES+2usI+ePgAlVzEk5QgsLaqj+jKUHHW
	rXewNMWQXhEqGDNRbbFrN2CzSFpBJdveYhRew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mISCrOgggwjCYFk40Jg3c0PkeoIPxtnm
	GZYfTl2xgFEb4+urkOb5npO9MSbgV5JQqBV6vuy5Q178KKYaOzyZyM4vVwzLL/Db
	6NXSTKS7ovigO0MJ54VxHMM8YU7FDwc1OUDvpSBpAjq53ObpbHDwTotwrbEe+YYo
	uc9UG2weSuw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06BFA4315;
	Mon, 23 May 2011 10:16:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 89AB04314; Mon, 23 May 2011
 10:16:28 -0400 (EDT)
In-Reply-To: <vpqk4dhzsvh.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 23 May 2011 11:08:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43E5EF6A-8547-11E0-89DC-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174244>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>>        git clone --vcs=mediawiki http://some.where.xz/wiki/
>...
>> Is vcs a standard argument (I can't see it anywhere) or do we have to
>> change something in order to implement it?
>
> I don't know, but anyway, it could be
>
> git clone mediawiki+http://some.where.xz/wiki

I know it doesn't ;-)

As "clone" is a moral equivalent of "init" possibly followed by some
auto-configuration followed by "fetch" and "checkout", it is a natural
consequence of already supporting the "remove.<name>.vcs" configuration
variable, and if we want to avoid the insane svn+http:// syntax, it is a
logical thing to add such support.
