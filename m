From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/3] submodule add: If --branch is given, record it in
 .gitmodules
Date: Wed, 19 Dec 2012 09:43:30 -0800
Message-ID: <7vhani9bul.fsf@alter.siamese.dyndns.org>
References: <20121212230217.GB7729@odin.tremily.us>
 <cover.1355932282.git.wking@tremily.us>
 <2c8df95b9f4cc9ceb9d6d96d5deac22320541dd9.1355932282.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: wking@tremily.us
X-From: git-owner@vger.kernel.org Wed Dec 19 18:43:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlNgP-0007Iz-1M
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 18:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab2LSRng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 12:43:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072Ab2LSRne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 12:43:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 919E2B230;
	Wed, 19 Dec 2012 12:43:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VEmxDudFNDNQt6pYg5rf1oEpOuU=; b=cgWtpb
	3odd+yz8vzXbKrzskHVH/0iv+m5uHXDfGySCCBdFsT4afU1vi+onxDZdKS/oLaWa
	kjRd7snnpo5+EUr/uewKI5rTPJJiMZKsnHgEOpBhH2QdrjgdsUg0HuhcsJYHtfbr
	ms3M47CGQG6eNY+akL7PNdafRg54xQ6geQ5Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a6Dl9QNagBpWd+5DZG4UnN18vvylwtd8
	SvzqpVB2GqgU3YcQZReOWaBCL5+HFoUNQqoAqq7qeaJjyty91ES5tm5G4JusNhHg
	H6XHf+5sHUqbqiBLur70+bzeaHM3zuFZkgyF7rA+zs2MDO+2t5qsOUK0RSWfNfhk
	F35AVdphGOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE65B22D;
	Wed, 19 Dec 2012 12:43:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD9CBB22A; Wed, 19 Dec 2012
 12:43:32 -0500 (EST)
In-Reply-To: <2c8df95b9f4cc9ceb9d6d96d5deac22320541dd9.1355932282.git.wking@tremily.us>
 (wking@tremily.us's message of "Wed, 19 Dec 2012 11:03:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B81A3C2-4A03-11E2-B1ED-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211837>

wking@tremily.us writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> This allows you to easily record a submodule.<name>.branch option in
> .gitmodules when you add a new submodule.  With this patch,
>
>   $ git submodule add -b <branch> <repository> [<path>]
>   $ git config -f .gitmodules submodule.<path>.branch <branch>
>
> reduces to
>
>   $ git submodule add -b <branch> <repository> [<path>]
>
> This means that future calls to
>
>   $ git submodule update --remote ...
>
> will get updates from the same branch that you used to initialize the
> submodule, which is usually what you want.

I agree that it would usually be what you want when you are using
the --remote option.

Will replace the previous round with this.  Thanks.
