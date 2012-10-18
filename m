From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 02:26:11 -0700
Message-ID: <7vbog0m8r0.fsf@alter.siamese.dyndns.org>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
 <alpine.DEB.1.00.1210171759230.3049@bonsai2>
 <CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
 <alpine.DEB.1.00.1210171936170.3049@bonsai2>
 <CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
 <CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
 <CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
 <alpine.DEB.1.00.1210181031320.3049@bonsai2>
 <CAMP44s2wOX0-UrTM5t5ewZ4yhOJJU=+SfB9PoTQKdsP4Pzsnpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmN2-0001ET-4F
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab2JRJ0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:26:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab2JRJ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:26:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C734098F3;
	Thu, 18 Oct 2012 05:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4dOwNyocG0FenJALYK+5kTcB/tE=; b=xN6nzP
	ehIWtpnFeimHGYtQXMW3jRBHbYY08aJgnAqKoygvaP0EuTGWCtxo6aJJoc/3ChgI
	1zHcSKBUC32h32fk098Z75KbDUrUSY+Dm6vzBN19DMLEHtVtvKLMxF9GRgEJewGo
	3V3gs0UVTHoHHv/HTHha9/LTw6A4HTmER/vkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W7wXj0PrxtjCLrqZupw8oxpKdDlx+cB5
	Qg9N08lt54Xv6NOljHg8i8tWJ8F65leWipTST06TA9k5TY7ftiD6Gq+bW2CL1Kge
	yNNCsOFLpuOBes5hoO0tDkfLcLqyY0Le7xMnp1KvOggnCmJcX5pYLe3HNxkp5NbL
	Q0u9FSIaVlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2B1A98F1;
	Thu, 18 Oct 2012 05:26:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 027DC98E8; Thu, 18 Oct 2012
 05:26:14 -0400 (EDT)
In-Reply-To: <CAMP44s2wOX0-UrTM5t5ewZ4yhOJJU=+SfB9PoTQKdsP4Pzsnpg@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 18 Oct 2012 11:03:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD244AF2-1905-11E2-9D53-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207987>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> As to the functionality you seek: git-remote-hg found in
>> git://github.com/msysgit/git works. It has the following advantages over
>> every other solution, including the one proposed in this thread:
>>
>> - it works
>>
>> - no really, it works
>
> Not for me.

Felipe, an argument along this line would not help very much.

Please elaborate a bit to describe what does not work and where you
are having problems more concretely.  Even for people who may want
to see if they agree with your "It does not work", "Not for me"
alone is too little for them to try out.  Others who may want to and
are capable of helping you won't know where to start.

Thanks.
