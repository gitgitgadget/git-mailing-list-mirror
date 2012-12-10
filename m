From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use of a mailmap file with git-log
Date: Mon, 10 Dec 2012 10:48:10 -0800
Message-ID: <7v38zdbv6d.fsf@alter.siamese.dyndns.org>
References: <CALKB1SXdNVsQop5VYmShOMx93+j5SPdkGF9yNU5k7nXg87TwMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rich Midwinter <rich.midwinter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 19:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti8P1-0003qi-MI
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 19:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab2LJSsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 13:48:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab2LJSsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 13:48:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B339654;
	Mon, 10 Dec 2012 13:48:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=znK03El4G4ECV95ecuZJNg9lxiE=; b=MXgBN+
	W0WCehwSiEWwHS9ogzk/YBNY613tZ99lf80HctQ05k7tnezIkEM2mFuY9zxtRJcX
	e0nH70S8wSvS+r13OQo93/r5a8WZ1bZ9d92M8JZE7rkK+AkVvAhv2xBWNqpuE1zp
	yYar2/a38LYhM6m8F0a14Jh9NQ/rFY6Q5VxKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VmhTZZc8oX22N/IHtzo6DTKFcG1LPW51
	DrsAgTV45tF/jscPleD+unzl/L7OBPhUQRXwjuaLKGlOD1o+7l9CD+RgszHsMYY/
	ovkhSnyDSgL+/d/30ws+Z9w/BeuiswmH4sLvdBahlzjE8nIz2RZHTBH4GECA2HIJ
	rOsdEVuuxQY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4C9E9653;
	Mon, 10 Dec 2012 13:48:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4596F9651; Mon, 10 Dec 2012
 13:48:12 -0500 (EST)
In-Reply-To: <CALKB1SXdNVsQop5VYmShOMx93+j5SPdkGF9yNU5k7nXg87TwMw@mail.gmail.com> (Rich
 Midwinter's message of "Mon, 10 Dec 2012 18:22:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26187576-42FA-11E2-9A5E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211268>

Rich Midwinter <rich.midwinter@gmail.com> writes:

> I'm working on a project for a large organisation that wants to make
> widespread use of git and the mailmap feature.
>
> This seems to be supported by default in git-shortlog but not git-log
> (and other variants) without specifying custom formats, which isn't
> really something I want to try and 'fix' across the organisation. Is
> there a reason for this feature omission or has it just evolved that
> way and could it be fixed?

I think it was pretty much the latter, but people may already be
depending on the command to give them the "true as recorded back
then" names in the output.  A fix may have to involve inventing a
new option "log --use-mailmap" that is explicitly given from the
command line.
