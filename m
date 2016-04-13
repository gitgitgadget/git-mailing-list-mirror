From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v14 5/6] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Wed, 13 Apr 2016 14:30:33 +0530
Message-ID: <CAFZEwPMiYCd1Ase5r1XtOo4k3cONvryp_Kw-wpm1SVsBs37=BQ@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb6096f-5d2150af-6595-4d88-85e5-18eaeb699fb7-000000@eu-west-1.amazonses.com>
	<CAPig+cS17RF6f6fuTLpn-E551_NkWjmNPbXh8EFQ_Sp5L9Xb1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 11:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqGf9-0007EK-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 11:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759550AbcDMJAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 05:00:35 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34917 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304AbcDMJAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 05:00:34 -0400
Received: by mail-yw0-f193.google.com with SMTP id k197so5735902ywe.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kBHaYFz2fVgT+HqSFQVu14T+JHibAZBS0+jNdndnpmc=;
        b=YgOfwm077IFLx2FuAnjzvK0vYOckRNeEcTQyzOMP803XfDKOrQ4y9TyS3U3F4jSXeh
         EI3qB8UfoCYU2jJ2nt2tMavcYwpoOhRYw4KBEHrEeT9mDFAYlN2T0uipeLX4KVffQucS
         UXva2arHBaovFv7/pbajHleiKbQA4Oh/6aVgohwEAxtMQxGgd2FFb6jCCC70+Og8ye5I
         hNeIqjw3VuUEwtF7nBy7qgd590nNv9k6afuvFTVXL+rili/VitrpNfqQq8k431EhJUqK
         0CkK1NLNIKQco8TCreucIShYiNDDQ5fA83P5q+1UV7LjigEC9blNaOGi9AIrFmSgupCz
         7cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kBHaYFz2fVgT+HqSFQVu14T+JHibAZBS0+jNdndnpmc=;
        b=a88pklByLih0szC/02umns86QAtLg3f9XRfHNYgqzhYUkUkIO7E7DNyYZcxL+Q2b11
         QUFDSd3FZQyS2nImexFkB6UWordSSg7mP8+YCfH0ofU7uWWD6I1GV6xC+jV2neT9KI4H
         f2e0NkBW7us/3VCRZJljmVFl4I9RP9UDznQ24hBTCNf9C9DVWhlq6MOCVaFuKphyRc4a
         /Uwx/f+WQUAT2VaJ+VOf+dkggBXO4KxugmkghoUY69Nbdhcf7n/t0v3JyETOpmkGJRiw
         i8CqxOU6Kst8XoCDG4Tol6m/uxGZRHcnk2Zp6dOcaDYNQDfkCn6JDbex3j93bxk9Nywl
         IkEA==
X-Gm-Message-State: AOPr4FX1RPIpJw7oNGA+3R17icF6JFr63r/FXqj5FHIcA3e8crZqIQ4/1V/Gz6b/BptJp9xQ+9zEHyDupKI0Ng==
X-Received: by 10.37.207.141 with SMTP id f135mr4163535ybg.154.1460538033234;
 Wed, 13 Apr 2016 02:00:33 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Wed, 13 Apr 2016 02:00:33 -0700 (PDT)
In-Reply-To: <CAPig+cS17RF6f6fuTLpn-E551_NkWjmNPbXh8EFQ_Sp5L9Xb1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291382>

On Wed, Apr 13, 2016 at 11:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Make the fake "editor" store output of grep in a file so that we can
>> see how many diffs were contained in the message and use them in
>> individual tests where ever it is required. A subsequent commit will
>> introduce scenarios where it is important to be able to exactly
>> determine how many diffs were present.
>>
>> Also use write_script() to create the fake "editor".
>>
>> The fake "editor" is always made to succeed regardless of whether grep
>> found diff headers or not so that we don't have to use 'test_must_fail'
>> for which 'test_line_count = 0' is an easy substitute and also helps in
>> maintaining the consistency.
>
> As mentioned by [1], the change to write_script() is a minor aside; it
> is less important than the explanation of how and why the return value
> of the fake "editor" changed, thus the order of the 2nd and 3rd
> paragraphs should be swapped.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/290663

I will include this if I do a re-roll
>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
