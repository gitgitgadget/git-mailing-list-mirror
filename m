From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Wed, 20 Jun 2012 15:56:47 -0700
Message-ID: <7v4nq5twwg.fsf@alter.siamese.dyndns.org>
References: <m2vcil4n0w.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:56:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTpW-0001K0-LU
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 00:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab2FTW4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 18:56:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab2FTW4t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 18:56:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F39988A6F;
	Wed, 20 Jun 2012 18:56:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kus2ksZ2/lAa
	HUo1mieFQ+XS2EM=; b=PizmTUbusQs6c3RaZcqtcx/JQYhA4gSu+2TX+tVHOJ0+
	qzqsEIsDduLy28a9RLF4Htg0L9HfxjregGy9/3oc4nLDGgNB1heH+3A7KxxGDE9a
	93/sGPMke9K3caI57zhtN3uyofn8u1mLUvOGUR1Y9xVuUhvji2vMA/cLc+xJHhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ag3MPK
	ZaptqEuHMf1UVxqYdt89yqEgOjlBOYEITWu87XJZwgOstB7bcGR4tcRgTulWCZra
	QXU+9ZgHVgwoHKbDRs9xCqOGPIHcumfmt37Z8/voGHN/YfmRlmaQVt/f6oGys4Uz
	mLlCpAmGiSBqBg138muLi/AXvkQwuPqy7NqVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EACE88A6E;
	Wed, 20 Jun 2012 18:56:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 760688A6D; Wed, 20 Jun 2012
 18:56:48 -0400 (EDT)
In-Reply-To: <m2vcil4n0w.fsf@igel.home> (Andreas Schwab's message of "Thu, 21
 Jun 2012 00:49:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37614210-BB2B-11E1-AE54-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200374>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Remove the open block markers from the status.showUntrackedFiles entr=
y
> as they cause all remaining entries to be indented one level too much=
=2E

Hrm...

I looked at http://git-htmldocs.googlecode.com/git/git-config.html
and am unsure what "one level too much" you are referring to.  Also
looking at the output from

$ git config --help

I see (RHS end truncated to avoid line wrapping in MUA):

    status.showUntrackedFiles
        By default, git-status(1) and git-commit(1) show files whi
        tracked by Git. Directories which contain only untracked f
        the directory name only. Showing untracked files means tha
        lstat() all all the files in the whole repository, which m
        systems. So, this variable controls how the commands displ
        files. Possible values are:

        =C2=B7    no - Show no untracked files.

        =C2=B7    normal - Show untracked files and directories.

        =C2=B7    all - Show also individual files in untracked directo

        If this variable is not specified, it defaults to normal.=20
        overridden with the -u|--untracked-files option of git-sta
        commit(1).
