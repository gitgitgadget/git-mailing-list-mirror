From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Introduce git submodule add|update --attach
Date: Mon, 13 Jan 2014 09:31:14 -0800
Message-ID: <xmqqd2jv7pr1.fsf@gitster.dls.corp.google.com>
References: <1388368184-18418-1-git-send-email-ceztko@gmail.com>
	<CABURp0pQHw7qvG_tq8oK=6DBOUoYy=Rb5othV+zBpNonuv=PLw@mail.gmail.com>
	<CALas-igDaweib14zaLJk3m1zmBWk=14oA7h_e7G82vpxmBjiOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 18:31:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2lMf-0005Bk-MG
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 18:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbaAMRbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 12:31:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748AbaAMRbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 12:31:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4372660BEA;
	Mon, 13 Jan 2014 12:31:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q/Z/W4qONgXkAFsscZLrEXgpvco=; b=BkjFdX
	PwyZ4833joGaQeobHgnj9hO3IdZryMC202onaKn1ZB01VxhDQzmjJ6+gtQKS2M20
	uNr38JHGI25y0mr4bxXXgdghO59KGky76N2477x1PHgLB1Ml0FM7ZiK4NSOisWlL
	+2Z2Poq6QJXJSpQlPqIAnbZimsfJGcKZZpC20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YHzI8hymVnXN+/dtCvSIR4dLovg1h5u3
	OgvlPYf5wa9dNb3SQwe46e6V56KO8XC8EAr4Fc5c5jKRPhrbvuy2+Nz04LKVrV3d
	GdGUV+EBvECuFCGtk77ANB/jGozxz+t387UIPwWjzqYboi0zyilZCtHLIOgb0UBF
	bkxofV4nGhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B42560BE5;
	Mon, 13 Jan 2014 12:31:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE64F60BDA;
	Mon, 13 Jan 2014 12:31:19 -0500 (EST)
In-Reply-To: <CALas-igDaweib14zaLJk3m1zmBWk=14oA7h_e7G82vpxmBjiOg@mail.gmail.com>
	(Francesco Pretto's message of "Thu, 2 Jan 2014 19:48:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83BACB30-7C78-11E3-8703-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240363>

Francesco Pretto <ceztko@gmail.com> writes:

> Thanks for the comments, my replies below. Before, a couple of general
> questions:
> - I'm also writing some tests, should I commit them together with the
> feature patch?
> - to determine the attached/detached state I did this:
>
> head_detached=
> if test "$(rev-parse --abbrev-ref HEAD)" = "HEAD"
> then
>     head_detached="true"
> fi

Use "git symbolic-ref HEAD" to read off of it.
