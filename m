From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Thu, 05 May 2011 10:31:08 -0700
Message-ID: <7v39kt9hr7.fsf@alter.siamese.dyndns.org>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <20110504073850.GA8512@sigill.intra.peff.net>
 <7vliymfp4t.fsf@alter.siamese.dyndns.org>
 <20110504212848.GA27779@sigill.intra.peff.net>
 <7v62ppdhh5.fsf@alter.siamese.dyndns.org>
 <BANLkTinaoopUxOHC0XaUxMLXj4pCXND+UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 19:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2Oe-00026n-CC
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab1EERbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 13:31:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1EERbW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 13:31:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD3285A62;
	Thu,  5 May 2011 13:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xaRP0awPF2CWJGOl/Rwsc0a7cOQ=; b=hwHBB2
	fPSVInFOboflNXnhOKcDmrsdE696mTFwS9NNVWuqgytDvcLWB0sc+9yZ3L+a0fZP
	SuqmWdMX2YPk65fPAFRL5n4aHItPskm3jytagZoWHoD+GjfgMsZNv8RgJjtwZYIR
	3kGjjYWZX46fMlrhmNi6mpcvS8N1/9jFkYJr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hMrvXZhJvd0CV6OVL/RbFn2rynkSK/rm
	zCKd2f4OjgGuA28sYzWHIjQOa+CXXIWdVMqZvXNMxzKVDc9+KcQAO/fQdwPOesfG
	1aKnfYlSCrTGXf5NzrUIdBhiVERwZaSRY/kB9w6l/m6QP0ERErrHqnhHH/QBfagU
	MHpSc7moxSs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89BED5A5E;
	Thu,  5 May 2011 13:33:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 410155A57; Thu,  5 May 2011
 13:33:13 -0400 (EDT)
In-Reply-To: <BANLkTinaoopUxOHC0XaUxMLXj4pCXND+UA@mail.gmail.com> (Sverre
 Rabbelier's message of "Thu, 5 May 2011 13:15:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C484EBDE-773D-11E0-9FBC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172855>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> So do we need more tests for git-submodule to find out, or is this a
> hint to the submodule people to chime in? If so, should they be cc-ed?

I could queue a version without any conversion of in-tree users, so that
stakeholders can verify and convert their use of require-work-tree to the
new saner alternative one by one.  Actually I tend to like that better.

I am not convinced myself if it is a sane use case to run "git pull" from
a totally random place and let fetch and merge magically happen somewhere
completely unrelated to your current working directory only because you
have GIT_DIR and GIT_WORK_TREE set to begin with.  After getting into a
habit of relying on these environment variables so much that you do not
even think about their existence, you will reach a point where you have no
idea where to go offhand when a merge conflict actually happens and you
have to go there to fix things up.
