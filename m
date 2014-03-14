From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Fri, 14 Mar 2014 09:54:28 -0700
Message-ID: <xmqqiorghgaj.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
	<1394742059-7300-1-git-send-email-zhaox383@umn.edu>
	<CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yao Zhao <zhaox383@umn.edu>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:54:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOVNW-00066q-80
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 17:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbaCNQye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2014 12:54:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061AbaCNQyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2014 12:54:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC556754D6;
	Fri, 14 Mar 2014 12:54:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jd5mZ1URFZow
	V8SjU3ACcrABmJQ=; b=GYF1sM7y8zO9aOtCwnZ5j8wSASaJb9oIiYKOs0yyGJ+B
	siUZfgNRzqeMkgNWXF/L+ix2p2bzT5Bg0qYxxDP+K9155qCyxRNjORkLySn/xqmb
	6e4niu2oOuq6ZnNED2I99Lr8w8su9+oBCfhOhui2TRU5WJFPBkwXM1scMIGC2vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=E/Xd+F
	VJ25Mdn7wkKi0YT4IG/zI8IOIxFjXGhpuLq1kVY1MRNSQphwq4XxcrF5K0aLnHCP
	TDxhFeUGSsX4tUw0oiDWRz/W3jCsYkrNJRRJg02CSIakbZ3SyJuj5yCG2y7YMRfi
	vIg1Z3co+Crdmb0Z2l5hQzRCfX3eyXrsbLFnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99DA2754D5;
	Fri, 14 Mar 2014 12:54:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1F08754D3;
	Fri, 14 Mar 2014 12:54:29 -0400 (EDT)
In-Reply-To: <CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 13 Mar 2014 22:16:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F3894D2-AB99-11E3-8672-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244095>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for the resubmission. Comments below.

Thanks, Eric, for helping so many micro exercises.

> On Thu, Mar 13, 2014 at 4:20 PM, Yao Zhao <zhaox383@umn.edu> wrote:
>> Subject: [PATCH] GSoC Change multiple if-else statements to be table=
-driven
>
> It's a good idea to let reviewers know that this is attempt 2. Do so
> by saying [PATCH v2]. Your next one will be [PATCH v3]. The -v option
> for "git format-email" can help.

Yao, I think Eric meant "git format-patch".

> When your patch is applied via "git am", text inside [...] gets
> stripped automatically. The "GSoC" tells email readers what this
> submission is about, but isn't relevant to the actual commit message.
> It should be placed inside [...]. For instance: [PATCH/GSoC v2].

So in short,

	Subject: [PATCH/GSoC v2] branch.c: turn nested if-else logic to table-=
driven

or something.

>> +       typedef struct PRINT_LIST {
> ...
>> +               int b_origin;
>> +       } PRINT_LIST;

We do not do ALL_CAPS names and tend not to introduce one-off
typedefs for struct.  Instead we would just use "struct print_list"
throughout (if we were to indeed use such a new struct, that is).

>> +       PRINT_LIST print_list[] =3D {
>> +               {.print_str =3D _("Branch %s set up to track remote =
branch %s from %s by rebasing."),
>> +                               .arg2 =3D shortname, .arg3 =3D origi=
n,
>> +                                        .b_rebasing =3D 1, .b_remot=
e_is_branch =3D 1, .b_origin =3D 1},

>> I am confused here: I use struct initializer and I am not sure if it=
's ok
>> because it is only supported by ANSI
> ...
> Indeed, you want to avoid named field initializers in this project an=
d
> instead use positional initializers.

Correct.

> Translatable strings in an initializer should be wrapped with N_()
> instead of _(). You will still need to use _() later on when you
> reference the string from the table. See section 4.7 [2] of the GNU
> gettext manual for details.

Correct.

> An alternate approach might be to use a multi-dimensional array,
> where the boolean values of rebasing, remote_is_branch, and origin
> are keys into the array. This would allow you to pick out the
> correct PRINT_LIST entry directly (no looping), thus eliminating
> the need for those b_rebasing, b_remote_is_branch, and b_origin
> members.

Correct.

After seeing so many "table driven" submissions, I however tend to
agree with your earlier comment on another thread on this same
micro, where you said an nested if-else cascade that was rewritten
in a clearer way (sorry, I do not remember whose submission it was
offhand) may be the best answer to the "Would it make sense to make
the code table-driven?" question, even though I tentatively queued
d7ea7894 (install_branch_config(): simplify verbose messages logic,
2014-03-13) from Pawe=C5=82 on 'pu'.

Thanks for a review.
