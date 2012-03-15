From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [PATCH 2/3] help: Add '--follow-alias' option
Date: Thu, 15 Mar 2012 15:46:30 +0900
Message-ID: <4F619046.1050308@lge.com>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com> <1331779969-8641-2-git-send-email-namhyung.kim@lge.com> <7vehsummit.fsf@alter.siamese.dyndns.org> <4F6188FB.7020406@lge.com> <7vvcm6l6w0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:46:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S84SL-0006le-WF
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab2COGqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 02:46:33 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:61376 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab2COGqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 02:46:32 -0400
X-AuditID: 9c93016f-b7cedae00000438b-39-4f61904692a2
Received: from [192.168.0.31] ( [10.177.201.156])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id E8.BB.17291.640916F4; Thu, 15 Mar 2012 15:46:31 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vvcm6l6w0.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193187>

2012-03-15 3:23 PM, Junio C Hamano wrote:
> =EA=B9=80=EB=82=A8=ED=98=95 <namhyung.kim@lge.com> writes:
>> 2012-03-15 3:00 PM, Junio C Hamano wrote:
>>> Namhyung Kim <namhyung.kim@lge.com> writes:
>>>
>>>> The --follow-alias option will look up the alias definitions and
>>>> use the first word as a command. For example, if I set my aliases
>>>> as follows:
>>>>
>>>>    $ git help br
>>>>    `git br' is aliased to `git branch'
>>>>    $ git help ru
>>>>    `git ru' is aliased to `git remote update'
>>>>
>>>> adding --follow-alias (or -f) option will show man pages of
>>>> git-branch and git-remote, respectively.
>>>
>>> What would happen when somebody has this?
>>>
>>> 	[alias]
>>>           	br =3D branch --list
>>>
>>> 	$ git help --follow-alias br
>>> 	... man page for git-branch is shown ...
>>>
>>> NAK.
>>
>> I'm sorry I don't understand what you meant by this. What should be
>> happened for this?
>
> You _somehow_ restict the output, or at least draw the user's attenti=
on,
> to the description of --list mode in the resulting "git-branch" manua=
l.
>
> I do not think that is feasible.
>

Actually I was thinking about moving to an appropriate point in the doc=
ument=20
by checking second argument (if any) and searching it (using regexp?). =
But I=20
coundn't be sure it'd be possible too.


> But showing the whole manual page, without telling the user that "br"=
 is
> not aliased to a plain vanilla "branch" without any option, is not a
> solution, especially if you are going to let the user set a configura=
tion
> variable to allow him to forget about this setting. Progressive revel=
ation
> would not have such a downside and I think it is more appropriate app=
roach
> for something like "help".
>

OK. That makes sense to me too. This was just a quick thought hoping th=
at can=20
be helpful for someone who uses alias as a simple abbreviation.

Thanks for taking your time and giving me detailed comments.
Namhyung
