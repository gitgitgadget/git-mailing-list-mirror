From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 01 May 2012 09:47:01 -0700
Message-ID: <7vsjfjalx6.fsf@alter.siamese.dyndns.org>
References: <201205011323.45190.tboegi@web.de> <4FA00E09.2090708@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	jnareb@gmail.com, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 01 18:47:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGEk-00019O-EV
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 18:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757790Ab2EAQrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 12:47:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128Ab2EAQrD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 12:47:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DCA67811;
	Tue,  1 May 2012 12:47:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lleMqq574rJo
	eaPSUsJvL/TS/RU=; b=p97jYh+v2EpXMDoxlN4MvJi90ZZ946VMEbXZo2zJeFKG
	zGV1xL+pUew5YDm4uh7pvKyU6Xg+oi6JGcl3zYnOi3dVmXQlF6dFNJzdjBACzk7O
	oX6hwdILlbbh9D6YUdMEiqvoUlJYh28XzfbZZYlCwR0i4GXRgiFkdhAMmiv7pWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R9qTjJ
	KSMgMCda6enT71uwlpjQz0lANm1oY3wF9DRk/6ACXgYjXz5X/M6ySqhF8p8bMhoM
	/sqhC24ObiH8rPTqbBJutrd1kcfPQNyjqz/ZSPoDvja/Q/WzlkkQJtxO9l3eeCAa
	uJCAoGeEyK6SExY8f6xi+Yyvi0+r7PRr40p0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4525F7810;
	Tue,  1 May 2012 12:47:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D558B780F; Tue,  1 May 2012
 12:47:02 -0400 (EDT)
In-Reply-To: <4FA00E09.2090708@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Tue, 01 May 2012 18:23:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47126630-93AD-11E1-8210-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196694>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> Hm, I see that most scripts have #!/usr/bin/perl, and only two have
> #!env perl [1]. So in general we usally rely on using perl in /usr/bi=
n.

The #!/usr/bin/env variants should be eradicated.  Our Makefile rewrite=
s
"#!.*perl" with "#!$PERL_PATH" in scripted Porcelains before installing=
,
so /usr/bin/perl is the right thing to write there.
