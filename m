From: Nikolay Chashnikov <nikolay.chashnikov@jetbrains.com>
Subject: Re: How to have EOL=LF and keep binary files auto-detection?
Date: Tue, 26 Apr 2016 18:31:16 +0300
Message-ID: <CALnWy=-3ncjHZOHuE6aEp-GGhErkccQLed+oGBMYOFu7YcEHqA@mail.gmail.com>
References: <3670335C-4938-4DCD-9B1D-6B4737CBE6C2@jetbrains.com> <4501b117-09e9-d24c-e209-bda28059765a@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:32:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av4y8-0004Ks-QB
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 17:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbcDZPb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 11:31:58 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35193 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbcDZPb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 11:31:57 -0400
Received: by mail-ig0-f182.google.com with SMTP id bi2so100385411igb.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k+HvOdfufze7EKDKzRLD1os3xWM8NDkhkhwbWOxjHmg=;
        b=OM+7/1n1ze/pdmjmkIbtZuTGAqvv0uMlynWspRWHe9xGUI9SyYPK3/3mD2uC+LWUUW
         l65K550fpzA2+nUS1Bfzrq6eBOoeAeTB8/UOTgcH3AXf9xlK2eIYXbQ6/4pN8hs+xKSr
         nYBVrSjATxnpyWvuo6WqgMrlbqXkVsrtKMP+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+HvOdfufze7EKDKzRLD1os3xWM8NDkhkhwbWOxjHmg=;
        b=k3u5X+7znBuKhFNDOmecq33g32vPV1EZd5zxTvOBd0K8mXhPzFI9dXeeEV2fawyB/A
         YVZrfMRNXrSAM49g08R/6h5thycl6l9n0fMj/Xs9uXKIH6vEiAgXkj14BqYrZnPF6t6O
         xUXkdKCF1KZ0tl8MLdbhncBt1an/ZerIBQb7sR9cHHLRqOfZBY4ID1b3xnn+4N4R1fFr
         R1sI3uhItlx87sV1TRjpmdt7VYMDOAcWC2Zg8Mh9OFiMuR9OMGXiXwotXLx8TY1phIV8
         FR7eJ9Z7qw3QyRnIZbR1NMf0hOlvk6W3lPbzQYFYNWqAnNmI93QIGDZJHpXFBrPjEbTH
         cPoA==
X-Gm-Message-State: AOPr4FWoWd/R0RhqiFUg3enI/od6dhKAmArAXGYi2i4YIRDaDhnybjM8VYbxyusQDQdtUqASvVD6wxFpa5W03wpg
X-Received: by 10.50.20.40 with SMTP id k8mr4585090ige.9.1461684715824; Tue,
 26 Apr 2016 08:31:55 -0700 (PDT)
Received: by 10.64.57.75 with HTTP; Tue, 26 Apr 2016 08:31:16 -0700 (PDT)
In-Reply-To: <4501b117-09e9-d24c-e209-bda28059765a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292602>

Thank you for the information.

We create products (IDEs for different programming languages) for the
three major platforms (Window/Linux/Mac OSX). Our products are written
in Java and we want to minimize differences between distributions for
different platforms, so we use LF separators for all resource files.

On Mon, Apr 25, 2016 at 7:46 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 25.04.16 16:11, Kirill Likhodedov wrote:
>> Hi,
>>
>> I wonder if it is possible both to have LFs in all and only text fil=
es in working trees, and keep Git=E2=80=99s binary files auto-detection=
?
>>
>> To be more precise:
>> * we want all text files to be checked out in LF;
>> * we don=E2=80=99t want force people to set =E2=80=9Ccore.autocrlf=E2=
=80=9D to false, preferring to keep this configuration in .gitattribute=
s;
>> * we obviously don=E2=80=99t want binary files to be touched by eol-=
normalization;
>> * we also don=E2=80=99t want to declare all possible patterns of bin=
ary files - Git is good enough in detecting them automatically.
>>
>> However, I=E2=80=99ve found no way to do so.
>>
>> If I declare `* eol=3Dlf` in .gitattributes, it makes Git treat all =
files as text and thus convert CRLF to LF even in binary files. It is c=
onsistent with man, but a bit surprising to have e.g. a zip or png file=
 modified in this way.
>>
>> One could expect `* text=3Dauto eol=3Dlf` to work the way we want, b=
ut unfortunately it doesn=E2=80=99t work either: =E2=80=9Ceol=3Dlf=E2=80=
=9D forces =E2=80=9Ctext=E2=80=9D on all files.
>>
>> Thanks a lot for your help!
>> -- Kirill.
>
> The short answer: Git doesn't currently do that.
> The closest you can get, is to use
> echo "* text=3Dauto" >.gitattributes
> and
> git config core.eol lf
> git config core.autocrlf false.
>
> The longer answer is, that I am working on a patch to allow just
> the combination of "* text=3Dauto eol=3Dlf" to work as you want it.
>
> Which platform do you use ?
> And (out of curiosity, why do you want text files with LF ?)
>
> If you are willing to compile and install Git yourself,
> you can use the branch here:
> https://github.com/tboegi/git/commits/160421_0706_reliable_t0027_allo=
w_TC_combined_ident_CRLF_v7
>
> Feedback is welcome, if it works as expected.
>
>
>
>



--=20
Nikolay Chashnikov
JetBrains
http://www.jetbrains.com
The Drive to Develop
