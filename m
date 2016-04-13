From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 5/6] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Wed, 13 Apr 2016 02:03:21 -0400
Message-ID: <CAPig+cS17RF6f6fuTLpn-E551_NkWjmNPbXh8EFQ_Sp5L9Xb1A@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb6096f-5d2150af-6595-4d88-85e5-18eaeb699fb7-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 08:03:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqDtf-0006Es-An
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 08:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690AbcDMGDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 02:03:23 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33853 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758411AbcDMGDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 02:03:22 -0400
Received: by mail-ig0-f193.google.com with SMTP id qu10so5258773igc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=IKv8Mz+2FhEsZmXLp0z95tdO77uNnAtvdYnSPeavacc=;
        b=CAEAwTWVhw9OS/jgjkAgBjO3zj1rsK90ZoLd2fkFI/bs9H7Zi6K5R/Pfoq4Rbylx21
         UGVQ4MekvNSsH1uWB9QVNPvz6EF4qZWuGO2y/Nj86sy3/pCxRmUDKqoWbLm6Ift1E/Dj
         tFHlgE5aYyBt8ZSy1xVWYTE7ah9E078lIXKeMPwyOdV2xSpbjyzsjp8A0n/UxyiFFQ5B
         Vy0C4gHLWqJRUprdeGIw6ioH1qtBameGpiaglkb2zhc+XNveubSDAnUPaLSM2VE7JrjV
         NYbemHNLbeTFZ0d+f9SxaZFPQVCtQ5uVRJv0Kbr2EKCP5ZcDdLgncA55w7mHAYS9/L1y
         Akaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IKv8Mz+2FhEsZmXLp0z95tdO77uNnAtvdYnSPeavacc=;
        b=mwBxMueskfJa6/VQ0kQ0u7VIzJuP/xeqsy73EBgt4zKuBgr4DojfBRweqJMNukJUOd
         VbHBIV4WhmvKAvymE4ItqlqeqOxDLUI6lnF7tZ/TW/0Lat6Lpcrs5CEEDsKBVZbYLl+S
         Fhpp8ziXXUlDeX4v4LiBCHU+mTWYC859h78hALknArE3lpUqxJ3cFzkTEpse4feJt+h7
         ttWt1EbDcQ8FlhZwkzWX3PnP2vfm0foT7x3lrnoMS7B2CajXjkzNIOVO8Xa33BXCjDks
         3jc/YThd6RLSf85bEp+GKZRTh2Rfj0T3NUhWt6z3a8/Ifoc3d56nt9GNCOt1m9gEYwpQ
         afkA==
X-Gm-Message-State: AOPr4FWoUJOczzfamTJrDUpZK1Q1Z30vMzxej0/p0OS1tnK65Yg1NdUROUxnVO/szP/62VX2MrwqBRde2MPeEA==
X-Received: by 10.50.97.70 with SMTP id dy6mr7844208igb.73.1460527401369; Tue,
 12 Apr 2016 23:03:21 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Tue, 12 Apr 2016 23:03:21 -0700 (PDT)
In-Reply-To: <010201540cb6096f-5d2150af-6595-4d88-85e5-18eaeb699fb7-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: PrEoee67e_DvGonzljg67sSeADk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291373>

On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Make the fake "editor" store output of grep in a file so that we can
> see how many diffs were contained in the message and use them in
> individual tests where ever it is required. A subsequent commit will
> introduce scenarios where it is important to be able to exactly
> determine how many diffs were present.
>
> Also use write_script() to create the fake "editor".
>
> The fake "editor" is always made to succeed regardless of whether grep
> found diff headers or not so that we don't have to use 'test_must_fail'
> for which 'test_line_count = 0' is an easy substitute and also helps in
> maintaining the consistency.

As mentioned by [1], the change to write_script() is a minor aside; it
is less important than the explanation of how and why the return value
of the fake "editor" changed, thus the order of the 2nd and 3rd
paragraphs should be swapped.

[1]: http://article.gmane.org/gmane.comp.version-control.git/290663

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
