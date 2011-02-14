From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: document the gui.maxfilesdisplayed variable
Date: Sun, 13 Feb 2011 23:51:04 -0800
Message-ID: <7v39nruk9j.fsf@alter.siamese.dyndns.org>
References: <20110213125324.GA31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 08:51:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PotDN-0003Yy-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 08:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab1BNHvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 02:51:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1BNHvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 02:51:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECC092740;
	Mon, 14 Feb 2011 02:52:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SzYpYELTHH54Iq+8e8jwxpPis3I=; b=BRTvxV6cN5Hk5Be8MjRwN0c
	rQO/IMMmizJgCe6eGHEXra3Q8iHNXfo9AcOk1E2tASgFl4mw+9X1wZI1oc0qtXTR
	GxawQayGRfDXOTXtB894BxbBS2q0LPhI0K8VcFdquiWxKHZFppwC1F++1jAF9rzI
	qDhSqMbD/OKnCHWGuzzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GG6VxlXzHvVZpx3RaH0ITTEc9OOLsvRIMTaQScYTd8AewMfx5
	nrnm5B39ShA+CNCHsQoI12Rsg9Bg9R+DcjA2NapHzJxMvfkAEO1Vz4Y0HhLOy/Hd
	G84xXgyeHsmhN9EbIYEPjtpqr8e45GOmqQ8v7zeVhou+PdV+5IfClEWFNE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCBD7273C;
	Mon, 14 Feb 2011 02:52:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8ADA7273B; Mon, 14 Feb 2011
 02:52:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55DD1E6C-380F-11E0-AF5F-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166695>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> I am not sure how we should go about this patch. Should I split it in
> two since it removes the TODO line in git-gui and adds the
> documentation in git?

Two opposing thoughts.

 1. We can keep git-gui and git proper separate projects, move git-gui
    documentation out of git to git-gui, and with clever Makefile trick
    include and build git-gui related documentation conditionally only
    when git-gui appears part of the git project tree (this anticipates a
    future where git-gui is bound to git not with the subtree merge
    strategy as we currently do, but as a submodule).

 2. Just like the Linux kernel project, we can make each subsystem with
    separate maintainers just different repositories of the same git
    project with their own focus.  We already do this for git-svn (which I
    delegate to Eric Wong by pulling from him) and some parts of contrib/
    tree; we have already been halfway there for gitweb/ (which I don't
    regularly "pull from", but I mainly act as a patch monkey without
    actively managing that part myself).  I don't see why we cannot extend
    that model to git-gui and gitk.
