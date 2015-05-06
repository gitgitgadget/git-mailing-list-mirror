From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Wed, 6 May 2015 16:49:59 -0400
Message-ID: <CAPig+cTztwF-pYGjEpjDzxTJSXQBJFcp_F924htx5fHT01mcKQ@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<CAPig+cT9X-nXhQyjDtzLzm-A2LWLaCDThR9_xh=G049SqKHccw@mail.gmail.com>
	<554A78EE.1040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:50:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq6Gc-00046J-LD
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbbEFUuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 16:50:01 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35062 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbEFUuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2015 16:50:00 -0400
Received: by ieczm2 with SMTP id zm2so24323520iec.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=RvSxs5kWpuKijfRzPEQH9G0cDMf0g5zJrOxLr0aZvSw=;
        b=XN5aMBR9olf9iCyprgUV4IOYPe3JhPX/wuLP+cKo1Wsu86xJUk1Q2iKnREd+RqWrxV
         2hxv5F9dpaIZBDfCzHl7pP26zpmq6TjsEwW57It+swRLuJBmlvPKDhl/RLLWqS9Kl0aE
         YFPZoehXkShY+l8lEIrkcF6e6GtKFULEGh0hlyHugG/RIBPDPLzeGMSJhsWL6fq+Svt3
         1B1ovHgR9NGsLbs/MWDH1uJunuJ/gtl+rUKd9X8BvHS6nyB/O6TWVfCXCfPdXnypf7Go
         hFRR/C9VnoubJuAzviffZLZfFAF2jEgzBGIVc5GwUyIqRlpwvMSgoQUTdJDbV3LTh1gO
         enKw==
X-Received: by 10.50.43.227 with SMTP id z3mr10643655igl.22.1430945399503;
 Wed, 06 May 2015 13:49:59 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 6 May 2015 13:49:59 -0700 (PDT)
In-Reply-To: <554A78EE.1040002@gmail.com>
X-Google-Sender-Auth: anl2BiLbt8Dbs3EbY6aGWcMjqYY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268497>

On Wed, May 6, 2015 at 4:26 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/06/2015 05:08 AM, Eric Sunshine wrote:
>> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
>> <sebastien.guimmara@gmail.com> wrote:
>>> - Add a [groups] block containing names and description for groups:
>>>
>>>     [groups]
>>>     init                   starting a working area
>>>
>>> - Add a [commands] header on top of the known command list, and
>>>    group names as a third column.
>>>
>>>     [commands]
>>>     git-add            mainporcelain                common-worktree
>>
>> Thanks, this version is looking better. I, personally, still find th=
e
>> redundant "command-" prefix ugly and would just as soon see it go
>> away. I'll make some suggestions about that when reviewing patch 2/3=
=2E
>
> Indeed, I'm a bit annoyed by this prefix. We could do two things:
> - either drop the [deprecated] options, since it's never used.
> - or keep it, but make it exclusive with [common]. It makes sense aft=
er
>   all that if a command is deprecated, we don't want to consider it
>   common anymore.
>
> In both cases, we end up with only three columns, the third being
> optional.
>
> The common- prefix can then be removed in favor of the group ID alone=
=2E

Sorry for not yet reviewing patch 2/3. I'm trying to find time to
review it and make the promised suggestions, however, Real Life keeps
getting in the way. If 'deprecated' has never been used and if it is
not likely to be used in the future, then dropping that column may
indeed be an easy way forward toward the goal of eliminating the
"common-" prefix. A possible shortcoming of this columnar approach,
however, is that if someone someday comes up with some new type of
attribute to assign in a new column, then you still end up in the same
boat where not all entries use all columns, and you have difficulty
figuring out to which column an attribute belongs.

Instead, as mentioned originally, I had envisioned a solution in which
any command tagged with an attribute mentioned in [groups] would be
considered common, without having to resort to a prefix or fixed
columns. This should be more flexible in the long run, but may be
overkill for present day. I think that awk should be able to handle
this easily, but haven't had the time to actually sit down and flesh
it out (which I wanted to do while reviewing 2/3).

And, any solution is likely going to have to take into account the two
Makefiles Junio mentioned.
