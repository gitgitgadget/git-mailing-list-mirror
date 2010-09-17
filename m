From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] commit: add message options for rebase --autosquash
Date: Fri, 17 Sep 2010 10:07:52 -0700
Message-ID: <AANLkTimBnzWQYy8z1duQw=4UL4YCaeyiMugXG1O-Q8yq@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com>
 <1284687596-236-2-git-send-email-patnotz@gmail.com> <4C93288B.7000908@gmail.com>
 <4C9393CB.4010107@shatow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Notz <patnotz@gmail.com>, git@vger.kernel.org
To: Bryan Drewery <bryan@shatow.net>
X-From: git-owner@vger.kernel.org Fri Sep 17 19:08:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OweQ5-0002S0-JY
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 19:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab0IQRIJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 13:08:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48502 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab0IQRII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 13:08:08 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2585964wyf.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=69aA4ec094aRXN0qWSKMgy3EumQj3rj1rYrjM8uSAIs=;
        b=XrK++JRejYNAOVu9JxjVuftwKVcCp3sOJcsm7f4cPJ5o5UXYn7WFxdJ4ksUTipC3lU
         XFbQ/6+983nCw/IsqDLG5/0QA11i4RIcjXU+BSEaRoPAq1xhBiaEm6qMjwmkllO6tlCe
         yYKN+qSTtLNX7PJ/xX2o3eKDqq5UQHIEMyaxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jjw1HcidvOPs7W/1q7vIdH6UHsBOYR7pnoGGSwWw+UHm8f26wvzM8Tw6JUlJrvSVUJ
         nNuULZybNdGCuGmDdR2tAoNP51YvJdQfPBUM2vSJggwoctsuy5BsSOLE2ItCoMlzK6x8
         N3MOMAMfog42Q4nigT9951rShyOMu/o2KfLPU=
Received: by 10.227.127.193 with SMTP id h1mr4455690wbs.139.1284743287867;
 Fri, 17 Sep 2010 10:08:07 -0700 (PDT)
Received: by 10.227.143.15 with HTTP; Fri, 17 Sep 2010 10:07:52 -0700 (PDT)
In-Reply-To: <4C9393CB.4010107@shatow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156400>

On Fri, Sep 17, 2010 at 9:14 AM, Bryan Drewery <bryan@shatow.net> wrote=
:
> Stephen Boyd wrote:
>>
>> On 09/16/2010 06:39 PM, Pat Notz wrote:
>>
>>>
>>> These options make it convenient to construct commit messages for u=
se
>>> with 'rebase --autosquash'. =C2=A0The resulting commit message will=
 be
>>> "fixup! ..." or "squash! ..." where "..." is the subject line of th=
e
>>> specified commit message.
>>>
>>> Example usage:
>>> =C2=A0$ git commit --fixup HEAD~2
>>> =C2=A0$ git commit --squash HEAD~5
>>>
>>> Signed-off-by: Pat Notz <patnotz@gmail.com>
>>> ---
>>>
>>
>> So far I've been using an alias for these, but I suppose making them
>> real features of git could be worthwhile. What are the benefits with
>> this approach vs. an alias?
>>
>>
>
> I keep wanting to do these at commit time.
>
> What are the alternative aliases?
>

`git fixup' is aliased to `!f() { git commit -m "$(git show -s
--pretty=3D'format:fixup! %s%n%nFixup for %h%n' "$1")" $2; }; f'
`git squash' is aliased to `!f() { git commit -m "$(git show -s
--pretty=3D'format:squash! %s%n%n' "$1")" -e $2; }; f'
