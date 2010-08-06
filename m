From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 06 Aug 2010 11:00:29 -0500
Message-ID: <H6efS0hBcmgNGLKlyPGmiuLIrxCvE4xIoIvXe6hvCJ0@cipher.nrlssc.navy.mil>
References: <i372v0$3np$1@dough.gmane.org>	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>	<4C599781.2020603@gmail.com>	<4C5B2F2E.4050709@gmail.com>	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>	<AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com> <AANLkTinXtjn7=9jRNmv4zhhPiy3NVOca0gY9dkYCUhY7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 18:00:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhPLn-0002Pl-57
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 18:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934712Ab0HFQAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 12:00:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50010 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878Ab0HFQAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 12:00:33 -0400
Received: by mail.nrlssc.navy.mil id o76G0UhV019435; Fri, 6 Aug 2010 11:00:30 -0500
In-Reply-To: <AANLkTinXtjn7=9jRNmv4zhhPiy3NVOca0gY9dkYCUhY7@mail.gmail.com>
X-OriginalArrivalTime: 06 Aug 2010 16:00:30.0333 (UTC) FILETIME=[7E6CB2D0:01CB3580]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152793>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Aug 6, 2010 at 15:18, Joel C. Salomon <joelcsalomon@gmail.com=
> wrote:
>> On Thu, Aug 5, 2010 at 5:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
>> <avarab@gmail.com> wrote:
>>> On Thu, Aug 5, 2010 at 21:37, Joel C. Salomon <joelcsalomon@gmail.c=
om> wrote:
>>>> It's up, at <http://github.com/jcsalomon/constitution>, with one c=
ommit.
>>>>
>>>> I'm curious to find out if folks with 64-bit time_t get the correc=
t
>>>> author and commit times.
>>> On 32bit:
>>>
>>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>>> Author: The Philadelphia Convention <>
>>> Date:   Wed Dec 31 19:59:59 1969 -0400
>>>
>>> On 64bit:
>>>
>>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>>> Author: The Philadelphia Convention <>
>>> Date:   Mon Sep 17 13:00:00 1787 -0400
>> Cool, it works!  (The 13:00 should have been 12:00, but there's some
>> DST weirdness at work.)
>>
>> Can you check what git-fsck has to say about the repos, on 32- &
>> 64-bit machines?
>=20
> 32bit says:
>=20
>     error in commit 826a4f7721fe1c3963a733ecbc5422f05925af5d: invalid
> author/committer line
>=20
> 64 bit doesn't give any warning at all.

I don't think you're using the latest git.

I get this on 64 bit:

   error in commit 826a4f7721fe1c3963a733ecbc5422f05925af5d: invalid au=
thor/committer line - bad date

This is triggered by the negative sign '-' in front of the time
field which is not one of 0123456789.  See fsck.c line 244.

-brandon
