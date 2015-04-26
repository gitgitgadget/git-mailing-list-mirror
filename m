From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Sun, 26 Apr 2015 14:36:00 -0400
Message-ID: <CAPig+cT3rpEFVerjxA9vCXh0wFdmwBhDEnvgk1hBumsSAtDcVw@mail.gmail.com>
References: <553CD3DA.9090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	"johannes.schindelin@gmx.de >> Johannes Schindelin" 
	<johannes.schindelin@gmx.de>, kasal@ucw.cz,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 26 20:36:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmRPZ-00080g-9a
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 20:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbbDZSgC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 14:36:02 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33729 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbbDZSgB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 14:36:01 -0400
Received: by igbpi8 with SMTP id pi8so56695166igb.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2015 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4X47WwA7+Yv8bWVWLOuTopN6anO0dh8W+r5DQRfwJnw=;
        b=iYyVFYtAG0qWpRyGc4Q261ro5utTwoixq2qVgn+BxakT/lPQm2dtKw/DV1i1DcC7s+
         bmbZ5+GYADDiJFoYIx+GMwut5fM9h8gpMBOy20ArGTdbvIMM8RIkywRo0H2p86+OMYmB
         tqRhzdvvmK8IMlMZV15Kox0eaa7sffYgYO3uvL+MGn5qRCbJl3wXpT7I0ijmeAKadeK6
         v9BZQN/DdsJX0Pat9tQVaYD9y1xQ8RSMw0dIASZSGWa6OrXpuJJtgNJDM5lbZQIMuZUT
         ESIe8/mUShvSULuV3jdCpTc81L7JMwUBvseOgEOITe8ZWVfGFXUf0Bcm/ull/TmbCHFx
         urvw==
X-Received: by 10.50.27.67 with SMTP id r3mr9043750igg.15.1430073360741; Sun,
 26 Apr 2015 11:36:00 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 26 Apr 2015 11:36:00 -0700 (PDT)
In-Reply-To: <553CD3DA.9090700@web.de>
X-Google-Sender-Auth: MBiYfp1j-tcXPu9fzFYsi8pL-yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267831>

On Sun, Apr 26, 2015 at 8:02 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> A typicall setup under Windows:

s/typicall/typical/

> core.eol is CRLF and a file is marked as "text" in .gitattributes.
>
> After 4d4813a5 "git blame" no longer works as expected,
> every line is annotated as "Not Committed Yet",
> even though the working directory is clean.
>
> commit 4d4813a5 removed the conversion in blame.c for all files,
> with or without CRLF in the repo.
>
> Having files with CRLF in the repo and core.autocrlf=3Dinput is a tem=
porary
> situation, the files should be normalized in the repo.
> Blaming them with "Not Committed Yet" is OK.
>
> The solution is to revert commit 4d4813a5.
>
> Reported-By: Stepan Kasal <kasal@ucw.cz>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
