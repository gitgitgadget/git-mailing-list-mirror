From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 19:40:41 +0200
Message-ID: <vpqfvtb5k9y.fsf@anie.imag.fr>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
	<xmqqeh8wzl0h.fsf@gitster.dls.corp.google.com>
	<vpq61u7akin.fsf@anie.imag.fr>
	<xmqqob7ztgpb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 19:43:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJoRg-000625-9a
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 19:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab3IKRnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 13:43:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35606 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686Ab3IKRnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 13:43:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8BHedQI025480
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Sep 2013 19:40:39 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VJoPB-0003Cj-TF; Wed, 11 Sep 2013 19:40:41 +0200
In-Reply-To: <xmqqob7ztgpb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 11 Sep 2013 10:24:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Sep 2013 19:40:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8BHedQI025480
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379526041.50369@rEp/ruJZZyku0o3gBG/0nA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234585>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> But at the same time, I feel that these redundant lines, especially
>>> the latter one, would give the users a stronger cue than just saying
>>> that "bar is Untracked"; "do X to include" reminds that bar will not
>>> be included if nothing is done.
>>
>> The one which draw my attention was "(use "git commit" to conclude
>> merge)" which is particularly counter-productive when you are already
>> doing a "git commit".
>
> Oh, no question about that.  Nobody would object to the removal of
> that one; it is clearly nonsense.
>
> I was commented on the value of keeping "hints" like this:
>
>       # Untracked files:
>       #   (use "git add <file>..." to include in what will be committed)

Yes, I understood your argument.

I have no strong opinion on whether they should be removed either, but I
went for the removal essentially because it keeps the code simple.

If we want to keep the advices, and if we want them to be really sound,
then for example the advice for "Changes to be committed:" should be
changed when running "git commit --amend" (we currently hint "git reset"
even for files which are not in the index in this case). Same for
--only/--include. So, giving accurate hints in all cases seems
non-trivial.

I think the value of these messages is smaller than the potential
confusion and/or the code complexity to select and possibly modify the
hints.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
