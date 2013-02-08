From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git checkout --orpan` leaves a dirty worktree
Date: Fri, 08 Feb 2013 12:17:24 -0800
Message-ID: <7vvca2zhkb.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
 <20130208200402.GB8461@google.com>
 <CALkWK0mdLabT7XyuYsDCROBC5FX+tDgyMnjMRbdkO41PTWd_Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uOY-0006j7-Hq
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946944Ab3BHUR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:17:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946902Ab3BHUR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:17:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4233B786;
	Fri,  8 Feb 2013 15:17:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CEYymlSboZQK1GFLgKfGvP0TMOg=; b=p2nDns
	Dz4FE0AcXZ9GOoQ2kWDFsaJvQV9ndEBOP88HssoJlmDZ1918r9GerxW03xZyYCoS
	Zow3+SsKRKZ56CqQas8zfkrj/2H21XAV31ErAF5mBo3cVWgy73AF6aVbBsu7p0j0
	Bd8rCqe3m65imb48OUClUYo+2EGVX8yBiAtgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjRMZeoZZfGyOGxmThKZCjwI6wIzsy5m
	ZzTU873/G+iXqd6hVMNI8aOfofcLJOPO3WpLoJHU17+yoFRuL5o25plF071WEESy
	SXEHh2wKo3XwlOTDN5u9y2nr3/QqQZMWyuFgjF9mgbWfMngUJHksd8efIgf3u4OD
	2Lnj9AAEpv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99704B785;
	Fri,  8 Feb 2013 15:17:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CB86B782; Fri,  8 Feb 2013
 15:17:26 -0500 (EST)
In-Reply-To: <CALkWK0mdLabT7XyuYsDCROBC5FX+tDgyMnjMRbdkO41PTWd_Ug@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 9 Feb 2013 01:41:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E035BCC-722C-11E2-88F9-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215813>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> BTW, Is there a better way to clean out the worktree than `git rm -rf
> .`, since that fails for submodules?  The impulsive `reset --hard`
> obviously fails because there is no HEAD.

I _think_ the "git rm" is one of the things on Jens's roadmap.  Also
I think "reset --hard" these days does know what to do when you do
not have any history yet.
