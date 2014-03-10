From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] simplified the chain if() statements of  install_branch_config() function in branch.c
Date: Mon, 10 Mar 2014 09:36:31 +0100
Message-ID: <87d2hua1rk.fsf@fencepost.gnu.org>
References: <loom.20140310T083649-236@post.gmane.org>
	<loom.20140310T085652-521@post.gmane.org>
	<vpqd2huihsc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nemina Amarasinghe <neminaa@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:36:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMvhU-0006DD-Gy
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 09:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaCJIgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 04:36:41 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:55095 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaCJIgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 04:36:40 -0400
Received: from localhost ([127.0.0.1]:54137 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WMvhO-00005V-SX; Mon, 10 Mar 2014 04:36:39 -0400
Received: by lola (Postfix, from userid 1000)
	id 52CB0E05E7; Mon, 10 Mar 2014 09:36:31 +0100 (CET)
In-Reply-To: <vpqd2huihsc.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	10 Mar 2014 09:23:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243714>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nemina Amarasinghe <neminaa@gmail.com> writes:
>
>> Nemina Amarasinghe <neminaa <at> gmail.com> writes:
>>
>> Sorry for the first patch. Something went wrong. This is the correct one
>
> Please, re-read Documentation/SubmittingPatches. In short, don't inline
> patch headers and don't forget the sign-off.
>
>> Subject: [PATCH] simplified the chain if() statements of
>>  install_brach_config() function in branch.c
>
> Keep the subject line short (ideally <50 characters), and avoid past
> tense. We usually use imperative (the patch asks the codebase to
> refactor itself => "simplify if statements ...". We usually prefix the
> subject line with the place/subsystem where the change is done =>
> "branch.c: simplify if ...".
>
>> -		else if (!remote_is_branch && origin)
>> -			printf_ln(rebasing ?
>> - _("Branch %s set up to track remote ref %s by rebasing.") :
>> -				  _("Branch %s set up to track remote ref %s."),
>> -				  local, remote);
>> -		else if (!remote_is_branch && !origin)
>> +		else if (!remote_is_branch && (origin || !origin))
>
> Is it me, or is (origin || !origin) a tautology?

Since it _is_ you, that question is a tautology because of its first
part already.  But the second one would be just as good.

-- 
David Kastrup
