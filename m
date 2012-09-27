From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Configuring the location of ~/.gitconfig
Date: Wed, 26 Sep 2012 23:09:04 -0700
Message-ID: <7v6270t2tb.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Anurag Priyam <anurag08priyam@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7Hi-0008S3-M4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894Ab2I0GJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:09:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab2I0GJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:09:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679016B72;
	Thu, 27 Sep 2012 02:09:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkpqm0rTdiz8Bwpsxw/wSNgtZw0=; b=jb/Xf3
	Z6MALcfYe6mzYxwiDRR6Nt9bTWgQxQIZ7WBZOHKNzBIgGP8sSxb4+zbvuEP2AaPm
	ePiyxaYgrBOc59SSzT5CwKqZdrTsqwIKum97qhJl0Gi9cnCmhWt/g909T6GqN9vp
	JQOBZri0WqjfxsSZ6dxgJQTZe2lln0Ed33OcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FWmk6hzrQlAsR2onlDVD5HS6RmMnpE4v
	PhsRZ39Sq2yr0Si34ETuca96tkIPmmUuIgMGVMOLnrzm07zAjOsFQIL8JOR+j2PY
	5rd7hXwJmqEaADzTTDMz3ogKXIqZGSaMaIvb3T8aGPNZDPv3iZy7qKH77H9omjsN
	fs7sQmkKR9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54A8C6B71;
	Thu, 27 Sep 2012 02:09:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C59236B70; Thu, 27 Sep 2012
 02:09:05 -0400 (EDT)
In-Reply-To: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 26 Sep 2012 19:44:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7B656C0-0869-11E2-BE47-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206460>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'd like to configure the location of ~/.gitconfig through an
> environment variable.  My usecase is a simple enough: I have a
> repository with all my dotfiles, and I don't want to symlink
> ~/dotfiles/.gitconfig from $HOME after cloning it.  Does anyone else
> think the feature will be useful?

Not me. For that particular use case, my approach (long before I
switched the vcs that controls my dotfiles to git) have always been
to have ~/src that is version controlled, with a Makefile that
builds/adjusts dotfiles appropriately for each box and installs them
in the proper place.

Of course, if .gitconfig _is_ the same across all boxes I use, that
Makefile is likely to "install" by making a symlink ~/.gitconfig
that points at src/dot/gitconfig without "building".
