From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] Documentation/SubmittingPatches: Explain the
 rationale of git notes
Date: Mon, 29 Dec 2014 09:36:59 -0800
Message-ID: <CAGZ79kYuivGwayvJ+D8vOBP4yHN64Cx6UdxrSn430GyJ3K6ywg@mail.gmail.com>
References: <xmqq1tnx961q.fsf@gitster.dls.corp.google.com>
	<1418864895-18583-1-git-send-email-sbeller@google.com>
	<xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 18:37:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5eFi-0007ri-6V
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 18:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbaL2RhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 12:37:03 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:42422 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbaL2RhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 12:37:00 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so11620243igd.13
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 09:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nToUcmDLm4gJvXEVXmEfTxV5ZyJSXI0CKCmQxAjM/iA=;
        b=BMr6w5s6Ue/En6YLNyOvVBghoe0nEy96F/9CEG8wtkeQY5ZJ4lS21ngq0ZSgK8uIjo
         INyL+ToPqxKA28UOu/8VKcyQGKbIAAbDLI63tsGsw7koS2SCQME8nI+T6C6L2NU01IIx
         o55itCiph0WdMzYWSEKN2j8+2yrl3wYywfx6zYKVGDngxKpFbof7UN2aVRpd+pwtYSSP
         n8qFTced2NUswiTzTj3hILQE+qFwlZtRfpr3hQLmv9J/tnZ9pTpv6pyoQ0hS5JhqpHTl
         Z7y9MQBrb9fTbdJgMIBArX/TfoUTtJZ8mfH9danBbL6RnHRv+dVqbH0u5XYMqEDVtT6C
         oO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nToUcmDLm4gJvXEVXmEfTxV5ZyJSXI0CKCmQxAjM/iA=;
        b=Z2jub7/NQgDRuSLGXSxZgIi1eZoBq0GtY3/XJq89dkKb+ItF+wQhju/cJ0GfsgRJ2u
         RrG/vLwFXZOeXWwHOiB2pQtl8KfzRhhW84KTa8M5rK+siJfTfSlA/SA01TB82O1yiszp
         i/GLyMdWnO7qek+MFEXAOnrNwK96SsSc5/3rXX5OgD5+xDep92rL1PkrJ1xwb1qioIf9
         UY3XVWuwHs/6tdcVbsgz+dBWEHodkGrUoSqdD+KShBTZiAvgvjjJywZvHLt7gJXWZKaM
         pUrmvZfDZfHnuqlwTSHb2T888ki7inp8/QvZCzWgM+XCPkSDdNkY4yel6ZQcwkoUydWr
         y6mA==
X-Gm-Message-State: ALoCoQkTTvVlejmhw3wpx4cMls/y1kOy7y+7G4lwlG/Z4NnCrLKT0F2ZQ2rFLBImmrN2fn1pf0/R
X-Received: by 10.43.154.196 with SMTP id lf4mr42779514icc.95.1419874619902;
 Mon, 29 Dec 2014 09:36:59 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 29 Dec 2014 09:36:59 -0800 (PST)
In-Reply-To: <xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261865>

On Mon, Dec 22, 2014 at 9:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This adds an explanation of why you want to have the --notes option
>> given to git format-patch.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     > with optionally update Documentation/SubmittingPatches
>>     > to point at the file.
>>
>>     That file actually talks about notes already.  I am sending
>>     two patches touching that file, one of them explaining
>>     the --notes workflow rationale and one of them just changing
>>     white spaces.
>>
>>     A few weeks ago I wanted to patch format-patch to remove
>>     change ids. This is not needed any more for the git workflow
>>     as I disabled them and do not upload any patches to an optional
>>     Gerrit code review server anymore.
>>
>>     I do like the workflow using --notes as well from a developers
>>     perspective as I take literally notes for my own sanity.
>>     I wonder if I should add a config format.notes = [default-off,
>>     always, on-if-non-empty] so I don't need always add --notes
>>     manually to the command line.
>>
>>     Thanks,
>>     Stefan
>>
>>  Documentation/SubmittingPatches | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index fa71b5f..16b5d65 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -176,7 +176,11 @@ message starts, you can put a "From: " line to name that person.
>>  You often want to add additional explanation about the patch,
>>  other than the commit message itself.  Place such "cover letter"
>>  material between the three dash lines and the diffstat. Git-notes
>> -can also be inserted using the `--notes` option.
>> +can also be inserted using the `--notes` option. If you are one
>
> Because the previous sentence is talking about the cover letter to
> describe the overall series, it probably is a good idea to add
> "after the three-dashes of each patch" after "... using the notes
> option" for clarity, perhaps?

The previous sentence is talking about additional information,
which should not go into the commit message. (very similar to
the cover letter but just for one patch). It already mentions the place
"between the three dash lines and the diffstat."

>
>> +of those developers who cannot write perfect code the first time
>> +and need multiple iterations of review and discussion, you are
>> +encouraged to use the notes to describe the changes between the
>> +different versions of a patch.
>
> Perhaps s/you are encouraged to/you may want to/?  It might be
> better to be even more explicit, e.g. "you may want to keep track of
> the changes between the versions using the notes and then use
> `--notes` when preparing the series for submission"?

I did reword it to make it more obvious.

>
>>  Do not attach the patch as a MIME attachment, compressed or not.
>>  Do not let your e-mail client send quoted-printable.  Do not let
>
> Thanks.

A paragraph before that change we have

    "git format-patch" command follows the best current practice to
    format the body of an e-mail message.

which makes me wonder if the notes are a best practice or may be
becoming a best practice. So maybe we want to default to add the notes
in format-patch instead of explicitly asking for it. But that's just an idea
suited for another patch.

Thanks
