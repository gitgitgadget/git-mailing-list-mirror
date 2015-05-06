From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Tue, 05 May 2015 20:41:58 -0700
Message-ID: <xmqqegmucqyh.fsf@gitster.dls.corp.google.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 05:42:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpqDo-0003oC-52
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 05:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758823AbbEFDmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2015 23:42:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758804AbbEFDmC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 23:42:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EAB34F598;
	Tue,  5 May 2015 23:42:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=82p+sayO/fJP
	+gGHn9Scu4yPzjI=; b=VLTYDfpY7TnSTgQLaL4Y8Kdy6DeND4pM5qU+XWrsAx91
	j07z3tfV52hxX/KtC0JHh2M7bDgO4gpSXCs1w6fHpCO7xrmfB1rIinaojDwq3vZn
	Lki7wRgxtTMn2run9d4bcdtmy4FMlsS4EZY4pXYnOeZSUJ6X5kKZ1QTPjsixIqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V2f+5B
	8RouN/utz3sNC+uJfYHzLoLXQyDgK0NkYoyeC4WfBAA+06dmb60F9OiPUny7PH4m
	e1vhSezjzHcFnLxZ0k/qPwlV3+7EolcZqV0BwDCHqeN0AgqzlxiE63pGkE2Sd43s
	k6GkK6cPE1jO3ijy9FKl/s70gk3Zy/uGdmVTo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 136D74F596;
	Tue,  5 May 2015 23:42:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 003F84F592;
	Tue,  5 May 2015 23:41:59 -0400 (EDT)
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
 (=?utf-8?Q?=22S=C3=A9bastien?=
	Guimmara"'s message of "Mon, 4 May 2015 22:28:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9F81394-F3A1-11E4-BDC4-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268443>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

>  command-list.txt    | 64 +++++++++++++++++++++++++++++++------------=
----------
>  generate-cmdlist.sh | 43 +++++++++++++++++++++++++----------
>  help.c              | 28 ++++++++++++++++++++++-

I did not apply any of these patches to my tree, but

    $ git grep command-list.txt

shows that Documentation/Makefile and Makefile reads from
command-list.txt to do their own useful tasks.  A patch series that
does not touch either of them makes me suspect that it may be
breaking a lot of things.
