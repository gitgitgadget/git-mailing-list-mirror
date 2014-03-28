From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/17] ls-files: add --color to highlight file names
Date: Thu, 27 Mar 2014 20:49:55 -0400
Message-ID: <CAPig+cQ_mXQwYyy8naiSxH8=P5Mj2eqJ7jfQsAS9O2--5VyaJA@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-7-git-send-email-pclouds@gmail.com>
	<CAPig+cTMRHi2sWQLZzdHZGWT6GBX-3v8exx8B4jpWm0Tgvg6+Q@mail.gmail.com>
	<CACsJy8BjWVJu=_xyey=oBfCgemVBU4p98b+w0PaUQbFk0HG3Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 01:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTKzi-0003vN-HV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 01:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbaC1At5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2014 20:49:57 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36012 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794AbaC1At4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 20:49:56 -0400
Received: by mail-yk0-f179.google.com with SMTP id 9so183587ykp.24
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=3ixyWXI0UQxTd2tqFmuhyvbB6KUO+XKzmIEan/AGaNY=;
        b=A68UQjTA31EHN788p+K5qiVjH8MV1G5vYtrforwXnelUMdvcJXh7ha6Xs0MvP9iVxe
         t5TnJfgW2q3VJo9LlTvVscMVKSFoV3TIaoI87odyiYiOyigLqqJfluKUzcowuhemlZc4
         GL9ZCwTNuaEPCJMEYd/Q1v9fJ0YmGeqFzvzSGZVDBsk/rOZZaUvkWJBsBsDvF6oU4hRV
         IjPmc8DoMFJP5Cn7jU/TRLPHYfZjPrC/BhftoTfi5IRbc5g0/4ecMBKeba3MmH4E5yCm
         rjVFYyqXsw7n4y/Id4i63pLN8uYmVWA20W3aore54ds8el89lL6IsMOTv1bqSXsQSJUz
         krmA==
X-Received: by 10.236.139.70 with SMTP id b46mr6908332yhj.63.1395967795540;
 Thu, 27 Mar 2014 17:49:55 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 17:49:55 -0700 (PDT)
In-Reply-To: <CACsJy8BjWVJu=_xyey=oBfCgemVBU4p98b+w0PaUQbFk0HG3Hw@mail.gmail.com>
X-Google-Sender-Auth: FhU_Rl2WnTOIyUueSczUrPU3CQk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245345>

On Wed, Mar 26, 2014 at 7:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 27, 2014 at 2:13 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  Documentation/git-ls-files.txt |  9 +++++++++
>>>  builtin/ls-files.c             | 38 ++++++++++++++++++++++++++++++=
+++++---
>>>  2 files changed, 44 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-=
files.txt
>>> index c0856a6..5c1b7f3 100644
>>> --- a/Documentation/git-ls-files.txt
>>> +++ b/Documentation/git-ls-files.txt
>>> @@ -147,6 +147,15 @@ a space) at the start of each line:
>>>         possible for manual inspection; the exact format may change=
 at
>>>         any time.
>>>
>>> +--color[=3D<when>]::
>>> +       Color file names. The value must be always (default), never=
,
>>> +       or auto.
>>
>> Here, the default is "always"...
>
> These (.txt changes in other patches as well) are mostly copy and
> paste from existing .txt files. You may want to grep through and fix
> other places as well, in a separate series.
>
>>
>>> +--no-color::
>>> +       Turn off coloring, even when the configuration file gives t=
he
>>> +       default to color output, same as `--color=3Dnever`. This is=
 the
>>> +       default.
>>
>> But, here the default is "never".
>
> What I mean is color is turned off by default for ls-files (in
> contrast, ls has color on by default). The default 'always' means tha=
t
> if you write --color without the <when> part, then it's
> --color=3Dalways. How do I phrase to make it clear?

Perhaps:

    Color file names. The value must be always, never, or auto.
    `--color` by itself is the same as `--color=3Dalways`.

> --
> Duy
