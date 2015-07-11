From: "Simon A. Eugster" <simon.eu@gmail.com>
Subject: Re: [PATCH] Documentation clarification on git-checkout regarding
 ours/theirs
Date: Sat, 11 Jul 2015 07:26:07 +0200
Message-ID: <55A0A8EF.4080701@gmail.com>
References: <1436516877-21064-1-git-send-email-simon.eu@gmail.com> <xmqqy4inkc9c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Simon A. Eugster" <simon.eugster@eps.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:21:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDoAZ-00070x-8Z
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbbGKGVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2015 02:21:47 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34568 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbGKGVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:21:46 -0400
Received: by wgov12 with SMTP id v12so78794213wgo.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LS23S14i43aFwPWwP+8q/kajvROtEGeQFLaAedy75dw=;
        b=hpnB4ExDSk9KtByRVXZOvPQclATf7u0A3zo3d+hc+em38KQ+xBy8Cs7xDT9syZA6za
         BugnyXDi9nFOP80GesN9IHY7IvwMjGFrXuzO9WBkW0dajBe6RcQq/XZ5UcEtobfBOpcf
         w16jZkjksBTWcbYryPm+tKUa255UUMMuknUb3smNHaqFJpkLUqDFPuQ6/sP6MwZjPsdX
         rwERDr7nRq/miZwyCWFxlnqP/K3o/Zl1EcFam9xwZRgXFXAnQpU0hG5t0MELa2u5aQ2/
         ieHDynxf1r/js+bnQnfhjyArDwLTl1mpLPq/DHfEwX1+57rGvK4lrAi/93xNafRYw/zi
         aUbg==
X-Received: by 10.180.78.73 with SMTP id z9mr3897092wiw.15.1436592368698;
        Fri, 10 Jul 2015 22:26:08 -0700 (PDT)
Received: from ?IPv6:2a02:1205:c6a4:a8f0:f2de:f1ff:fe8d:cf4e? ([2a02:1205:c6a4:a8f0:f2de:f1ff:fe8d:cf4e])
        by smtp.googlemail.com with ESMTPSA id bg6sm16543827wjc.13.2015.07.10.22.26.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2015 22:26:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqy4inkc9c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273843>

Am 10.07.2015 um 22:07 schrieb Junio C Hamano:
> "Simon A. Eugster" <simon.eu@gmail.com> writes:
>
>> From: "Simon A. Eugster" <simon.eugster@eps.ch>
>>
>> Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
>> ---
>
> For those who are looking from the sideline, this is a reroll from a
> month-old thread $gmane/271680.
>
>>   Documentation/git-checkout.txt | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-chec=
kout.txt
>> index d263a56..d69306f 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -115,7 +115,21 @@ entries; instead, unmerged entries are ignored.
>>   --ours::
>>   --theirs::
>>   	When checking out paths from the index, check out stage #2
>> -	('ours') or #3 ('theirs') for unmerged paths.
>> +	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.
>
> I'd drop the change on this line.  Your conflict may or may not be
> from these two places when you are using "checkout".  Even if it
> came from "git merge", when you are doing "merge", the roles 'ours'
> and 'theirs' are very clear and mentioning HEAD/MERGE_HEAD does not
> add more clarity than it clutters the description, I would think.

Agree! How about the reference to git-merge? I had to google for stage=20
to find the documentation on it.
>
>> +	See linkgit:git-merge[1] for details about stages #2 and #3.
>> ++
>> +Note that during `git rebase` and `git pull --rebase`, 'theirs' che=
cks out
>> +the local version, and 'ours' the remote version or the history tha=
t is rebased
>> +against.
>> ++
>> +The reason ours/theirs appear to be swapped during a rebase is that=
 we
>> +define the remote history as the canonical history, on top of which=
 our
>> +private commits are applied on, as opposed to normal merging where =
the
>> +local history is the canonical one.
>
> It appears to me that this patch text predates my comment in
> $gmane/271720 and your response to it?

Yes.

>> +During merging, we assume the role of the canonical history=E2=80=99=
s keeper,
>> +which, in case of a rebase, is the remote history, and our private =
commits
>> +look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need to=
 be integrated on top
>> +of =E2=80=9Cour=E2=80=9D work.
>>
>>   -b <new_branch>::
>>   	Create a new branch named <new_branch> and start it at
>
> Thanks for reminding of the discussion that did not conclude with a
> patch.
>
> How about this?
>
> -- >8 --
> From: "Simon A. Eugster" <simon.eugster@eps.ch>
> Subject: checkout: document subtlety around --ours/--theirs
>
> During a 'rebase' (hence 'pull --rebase'), --ours/--theirs may
> appear to be swapped to those who are not aware of the fact that
> they are temporarily playing the role of the keeper of the more
> authoritative history.
>
> Add a note to clarify.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
> ---
>   Documentation/git-checkout.txt | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index d263a565..8c921e7 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -116,6 +116,21 @@ entries; instead, unmerged entries are ignored.
>   --theirs::
>   	When checking out paths from the index, check out stage #2
>   	('ours') or #3 ('theirs') for unmerged paths.
> ++
> +Note that during `git rebase` and `git pull --rebase`, 'ours' and
> +'theirs' may appear swapped; `--ours` gives the version from the
> +branch the changes are rebased onto, while `--theirs` gives the
> +version from the branch that holds your work that is being rebased.
> ++
> +This is because `rebase` is used in a workflow that treats the
> +history at the remote as the shared canonical one, and treat the
> +work done on the branch you are rebasing as the third-party work to
> +be integrated, and you are temporarily assuming the role of the
> +keeper of the canonical history during the rebase.  As the keeper of
> +the canonical history, you need to view the history from the remote
> +as `ours` (i.e. "our shared canonical history"), while what you did
> +on your side branch as `theirs` (i.e. "one contributor's work on top
> +of it").
>
>   -b <new_branch>::
>   	Create a new branch named <new_branch> and start it at

I think there is an =E2=80=9Cs=E2=80=9D missing in =E2=80=9C=E2=80=A6 a=
nd treat the work done on the=20
branch =E2=80=A6=E2=80=9D, but not quite sure.

Apart from this, very clear and perfect to me.

Thanks for your effort!
Simon
