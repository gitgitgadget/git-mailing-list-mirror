From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Fri, 22 Jun 2012 16:52:44 -0700
Message-ID: <7v62ainbub.fsf@alter.siamese.dyndns.org>
References: <m2vcil4n0w.fsf@igel.home>
 <7v4nq5twwg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 01:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiDem-0001QD-Ca
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 01:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab2FVXws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 19:52:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756463Ab2FVXws convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 19:52:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E7A48265;
	Fri, 22 Jun 2012 19:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kRGeqdCpIGas
	vD8ZUGBToMDYNpg=; b=UYhoZY/Qdts4IGhZ+mWO/HHzAUACg08qdVijPMIrjN5i
	KUNMOGQPQsvmo/eNMFhCTBvxZN5h6wjfAB2Pdr5l0VYM3IzMZN2NMeRSp9H4rPJt
	3FSvDMV2RLTroTUC8KJv48bq3Une6cGAmsbakU0qh3e0XHkv4eRsDUP7uGzPbYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vs9790
	SKDq9t3lEN3CP8wImRq6J/t5YCQ+Bb1Q1bMZ4jIeK8Rlebu7ObbP4i8Lbh8R1kb7
	lmemIDtUgDl2llKcGmrPSKUSvXG7umi4UGDAUsCLiFf2ehq+iHA9UHpf2JP82m3j
	3mSRVS+vdF1QaRp+2Kw+Njb4Gyl7/71zBHJWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 150DB8264;
	Fri, 22 Jun 2012 19:52:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61742825A; Fri, 22 Jun 2012
 19:52:46 -0400 (EDT)
In-Reply-To: <7v4nq5twwg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Jun 2012 15:56:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DAE13A8-BCC5-11E1-9B20-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200488>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Remove the open block markers from the status.showUntrackedFiles ent=
ry
>> as they cause all remaining entries to be indented one level too muc=
h.
>
> Hrm...
>
> I looked at http://git-htmldocs.googlecode.com/git/git-config.html
> and am unsure what "one level too much" you are referring to.  Also
> looking at the output from
>
> $ git config --help
>
> I see (RHS end truncated to avoid line wrapping in MUA):
>
>     status.showUntrackedFiles
>         By default, git-status(1) and git-commit(1) show files whi
>         tracked by Git. Directories which contain only untracked f
>         the directory name only. Showing untracked files means tha
>         lstat() all all the files in the whole repository, which m
>         systems. So, this variable controls how the commands displ
>         files. Possible values are:
>
>         =C2=B7    no - Show no untracked files.
>
>         =C2=B7    normal - Show untracked files and directories.
>
>         =C2=B7    all - Show also individual files in untracked direc=
to
>
>         If this variable is not specified, it defaults to normal.=20
>         overridden with the -u|--untracked-files option of git-sta
>         commit(1).

Worse yet, with AsciiDoc 8.5.2, here is what I see with your patch
(again, RHS end truncated to avoid line wrapping in MUA):

    status.showUntrackedFiles

            By default, git-status(1) and git-commit(1) show files w
            Directories which contain only untracked files, are show
            Showing untracked files means that Git needs to lstat()=20
            repository, which might be slow on some systems. So, thi
            displays the untracked files. Possible values are:

               * no - Show no untracked files.

               * normal - Show untracked files and directories.

               * all - Show also individual files in untracked direc

                 If this variable is not specified, it defaults to n
                 with the -u|--untracked-files option of git-status(

So...
