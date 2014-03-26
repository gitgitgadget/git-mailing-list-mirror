From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/17] ls-files: add --color to highlight file names
Date: Thu, 27 Mar 2014 06:15:15 +0700
Message-ID: <CACsJy8BjWVJu=_xyey=oBfCgemVBU4p98b+w0PaUQbFk0HG3Hw@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com> <1395841697-11742-7-git-send-email-pclouds@gmail.com>
 <CAPig+cTMRHi2sWQLZzdHZGWT6GBX-3v8exx8B4jpWm0Tgvg6+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 00:16:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSx39-0000cO-4F
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 00:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbaCZXPz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 19:15:55 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:39675 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbaCZXPy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 19:15:54 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so1800483qgd.15
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rbtgC2CxHBDMr6tCTRLV0RpU/HQzmbkpX2XYSYFeJjA=;
        b=zqqgVj15kggVHFVvVo0B+si/xCQ9iEj3mosMKF+oqTSZXp+QgXktSweKsKfhuHF6VK
         tudm3MakOxinSqsnXDo5YU53Kfk4ITvdXTKazN0iJLElElgAVLoFG2IBf0JOlNKloSmC
         eLG94m0Un9eaEhT5+JWdFZNs44eLzKjpU+lxMXZlbORhAivjFnb11A/5wUENi2LW40jy
         ZjA3yDKzOwHYDXid3nCGJXDzTiTK4e74vB5777D/blgacx6sXdzPXh7ruxbxw7eyoT7V
         pCvkoD9mVg1NgYylaRRNolMh1fiKoWM1fxXKJEHwaBpN3uhnQ2bJ8xu7vHEHFXj7Z6VT
         Wvrg==
X-Received: by 10.229.192.7 with SMTP id do7mr93176532qcb.1.1395875745574;
 Wed, 26 Mar 2014 16:15:45 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Wed, 26 Mar 2014 16:15:15 -0700 (PDT)
In-Reply-To: <CAPig+cTMRHi2sWQLZzdHZGWT6GBX-3v8exx8B4jpWm0Tgvg6+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245256>

On Thu, Mar 27, 2014 at 2:13 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Documentation/git-ls-files.txt |  9 +++++++++
>>  builtin/ls-files.c             | 38 +++++++++++++++++++++++++++++++=
++++---
>>  2 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-f=
iles.txt
>> index c0856a6..5c1b7f3 100644
>> --- a/Documentation/git-ls-files.txt
>> +++ b/Documentation/git-ls-files.txt
>> @@ -147,6 +147,15 @@ a space) at the start of each line:
>>         possible for manual inspection; the exact format may change =
at
>>         any time.
>>
>> +--color[=3D<when>]::
>> +       Color file names. The value must be always (default), never,
>> +       or auto.
>
> Here, the default is "always"...

These (.txt changes in other patches as well) are mostly copy and
paste from existing .txt files. You may want to grep through and fix
other places as well, in a separate series.

>
>> +--no-color::
>> +       Turn off coloring, even when the configuration file gives th=
e
>> +       default to color output, same as `--color=3Dnever`. This is =
the
>> +       default.
>
> But, here the default is "never".

What I mean is color is turned off by default for ls-files (in
contrast, ls has color on by default). The default 'always' means that
if you write --color without the <when> part, then it's
--color=3Dalways. How do I phrase to make it clear?
--=20
Duy
