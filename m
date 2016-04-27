From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 3/6] t0040-parse-options: improve test coverage
Date: Wed, 27 Apr 2016 13:55:36 -0400
Message-ID: <CAPig+cQJok5HnFYqqhvDxAKnoEjiwrzGuc04EWrnYBYcUfQpLA@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
	<CAPig+cTB=bYNxR8yN2CGvkmtCZKomnbdNnZon9HA5uE9aivW=Q@mail.gmail.com>
	<CAFZEwPMU5KSoBJ0kHGnnPCq0zsoj8ROAXhJ9HFn66fqDehvWGw@mail.gmail.com>
	<CAPig+cSvvAJT6yb2h6B1S5LDr8H03t-b66rmbKWpo88Fw-ehmg@mail.gmail.com>
	<CAFZEwPMsmay+tv48p=zh3r4L1d38tNU0Z6zyn3Op_pd-nsv3Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:55:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avTgd-0005sZ-75
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 19:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbcD0Rzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 13:55:39 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35178 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbcD0Rzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 13:55:38 -0400
Received: by mail-ig0-f196.google.com with SMTP id fn8so8138681igb.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=UuIAcPU23v7UT6CIss66obkIFfCLSBVVs9blyiCCioc=;
        b=nPXoy4ZPTxUcris5O3TmmaYfxdHa5OoMCcSLad3OB8rtkSHPqoa+cOTdy4/Xw4oE13
         jr6uwsgKhhyf7H6N/NnMc+XZoMUnCQcNvuMgQ3KyKXOwS3Q6Mh511FH/NavT0i9x/UAq
         3KS9Aked+RvQOEQFKFLV559NPI6iCz+TTk3XalndMDW+n2TasKOJh5xbpJ0augXGb30I
         lx8gxCAiTne7mui5FhyHDiYB38fraqYt2Rb5D/okZu5y3SSJ2R6OgQ4X+8kSBgHS2JXE
         AoGcfbAh3yXNbirgIXnK6f+eGikjFmCiAD6w7j74LHUybpvK8E0Hed7fsf2T8HDXl06A
         r+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UuIAcPU23v7UT6CIss66obkIFfCLSBVVs9blyiCCioc=;
        b=WELwf3/Lc19u/D4fKamaKi2oYV5AH3u1268noalVNnhYl9I4DJuDpB8XDKx3BrPJTo
         QW/ZggPb+WS93J79ZNAylpXLsinuEwk6YdokfrEdQD84qjazo/sgBllnZmd4uV+jwaH/
         lPtVS3DsThXMgRHfS72DDenY4eapd2Qk6tyMEFCmWFfuQ5MtWhsD8KEi8fvxNzScTky+
         nbGE9a0f+2F9SEF/xoyonk0hGbwxVgUjQkLDoDYHNgOQ4Oic9bG9NvmDdAuksF2qh2eM
         G2RqQphjLBdoDFCnsKP8ST3xWokxbmFtr+nMl8MhnTGRiQMS6vXfappMnHAnf8P7xgyJ
         Gfjw==
X-Gm-Message-State: AOPr4FWrIwrBEAwbrh0snNGVQrY+AFFcLpHKNx4wmA4L+OTt1cZfCLefEdcD07LnmUxsAqKYkya2RywRKCuZ+g==
X-Received: by 10.50.49.15 with SMTP id q15mr11820388ign.73.1461779736672;
 Wed, 27 Apr 2016 10:55:36 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 27 Apr 2016 10:55:36 -0700 (PDT)
In-Reply-To: <CAFZEwPMsmay+tv48p=zh3r4L1d38tNU0Z6zyn3Op_pd-nsv3Aw@mail.gmail.com>
X-Google-Sender-Auth: iVrwHUuoWrokfrKCd967zao_9oU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292776>

On Mon, Apr 25, 2016 at 2:40 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Apr 13, 2016 at 10:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Each of these patches should have a single conceptual purpose. It
>> seems, from the above explanation, that you're mixing and mismatching
>> bits of such changes between patches.
>>
>> * The two new tests for --no-verbose and --no-quiet should be together
>> and check that they correctly reverse --verbose and --quiet,
>> respectively.
>>
>> * The test you describe above which ensures that --no-quiet leaves
>> 'quiet' at 0 should be bundled with the change that might break that
>> behavior, namely, the OPT__COUNTUP() change.
>
> I am planning to re-roll this.
> So, I am just confirming whether I understood properly.
>
>  * I will add the tests for check for '-q --no-quiet' instead of just
> '--no-quiet' sets to 0 and '-v --no-verbose' sets to 0 in the patch
> which improves test coverage which will be before the OPT_COUNTUP()
> change.

These tests would be even a bit more interesting if you tested "-q -q
--no-quiet" and "-v -v --no-verbose", respectively, to ensure that the
"no" options actually reset to 0 rather than merely decrementing by 1.

I recall also suggesting adding a new test checking that "-q -q"
increments the quiet count to 2 (which could be done in the patch
which makes 'quiet' print as a number instead of a boolean or in the
same "improve test coverage" patch).

>  * I will then add the test for '--no-quiet' sets to 0 in the separate
> patch after OPT_COUNTUP() change.

No, this and "--no-verbose sets to 0" are logically related to the
OPT__COUNTUP() change, thus would be incorporated into that patch.
Alternately, these two tests could just be part of "improve test
coverage" patch, establishing base behavior which the OPT__COUNTUP()
patch shouldn't break.
