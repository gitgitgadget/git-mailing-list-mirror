From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv7 1/4] wt-status.*: better advices for git status added
Date: Tue, 05 Jun 2012 12:32:19 +0200
Message-ID: <20120605123219.Horde.4685bnwdC4BPzeAz2LLCYAA@webmail.minatec.grenoble-inp.fr>
References: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vtxyqr89y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:32:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbr46-00012B-3P
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 12:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272Ab2FEKc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 06:32:27 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:51719 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932361Ab2FEKcY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 06:32:24 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 39E1E1A02A9;
	Tue,  5 Jun 2012 12:32:20 +0200 (CEST)
Received: from wifi-030006.grenet.fr (wifi-030006.grenet.fr [130.190.30.6])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Tue, 05 Jun
 2012 12:32:19 +0200
In-Reply-To: <7vtxyqr89y.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199227>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> @@ -728,6 +729,167 @@ static void wt_status_print_tracking(struct =20
>> wt_status *s)
>> ...
>> +static void show_am_in_progress(struct wt_status *s,
>> +				struct wt_status_state *state,
>> +				const char *color)
>> +{
>> +	status_printf_ln(s, color,
>> +		_("You are in the middle of an am session."));
>> +	if (state->am_empty_patch)
>> +		status_printf_ln(s, color,
>> +			_("The current patch is empty."));
>> +	if (advice_status_hints) {
>> +		status_printf_ln(s, color,
>> +			_("  (use \"git am --abort\" to restore the original branch)"));
>> +		status_printf_ln(s, color,
>> +			_("  (use \"git am --skip\" to skip this patch)"));
>> +		if (!state->am_empty_patch)
>> +			status_printf_ln(s, color,
>> +				_("  (when you have fixed this problem run \"git am --resolved\=
")"));
>> +	}
>> +	wt_status_print_trailer(s);
>> +}
>
> Perhaps s/fixed this problem/resolved conflicts/ or a similar
> rephrasing is a good idea.
>
> Conflicts from mergy operations are perfectly normal parts of a
> regular workday, and it is not a "problem" that needs to be "fixed".
> Both words scare the user by implying something is broken (or worse,
> "git broke something") in the contents of user's repository.
>
> There are existing messages that use the verb "fix" on "conflicts",
> only because it is shorter than "resolve", but this one that calls a
> conflict a "problem" goes too far in the wrong direction.

I agree. Still, experienced users probably have their advice.statushint=
s
disabled and won't have any problems resolving a conflict. However, for
"beginners" that need the advices, resolving a conflict may not seem
as trivial as it is. And even though the word "problem" may scare them,
it will attract their attention.
