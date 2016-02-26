From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 23:32:56 -0800
Message-ID: <CA+P7+xqUZeSCqXGB_E-P5NkQaqYEdF0vXmzQSTNo64R3GRHdoQ@mail.gmail.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <1456426632-23257-2-git-send-email-jacob.e.keller@intel.com>
 <20160226015510.GA5347@flurp.local> <CA+P7+xqyTUh60BOmY03JHE6HyVqY7iidVkUf3ji95_s3uE32cg@mail.gmail.com>
 <CAPig+cRM_1JLfBiOqo+-EdKbXp--4VUbddKN_zpSCSLK8PT09w@mail.gmail.com> <20160226060743.GB24517@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:33:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZCtt-0004BD-Pm
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 08:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbcBZHdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 02:33:17 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36078 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbcBZHdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 02:33:16 -0500
Received: by mail-ig0-f180.google.com with SMTP id xg9so29622933igb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 23:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RTtTFycMscn8GAKXH34TwRPQWDeVMM3bnYdy5BrJjio=;
        b=iLrA2PRnXjLu/VFncvEBmdSf/hCkCIKaDBOUR8pj/9g0LY/zBxdGev+5awQnSRB07b
         ulUiEciEToCdI3L8dImhcKadHMb57oEqXMG9NNMzAA1SLQe5ZyCHMAt+yO3a9u8WWhyF
         6dNreYMv/xOCsXJUrKwFjeqG4P1MilvgCKYZ60nJkgYh6HY+siJXtgj3qOWSllZlvezW
         klBVSv4yQRZoZImaHInvH9ZZAnGpIhnThvOAXu7ZEL7G0uaw3D6yqsznjHV40H39kt0l
         Fp9UDRsy+rrF9itTDo5TgMd5bs8B50VNq1eiN0S3I7Ilt/FOONaQAAcbWiKl1l7wf6eY
         uq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RTtTFycMscn8GAKXH34TwRPQWDeVMM3bnYdy5BrJjio=;
        b=H+ei979d1nUgdRYA5WVcSR+ymscIzT+d0E2LMon/Khc+cba2AawbZUZgQMX+UR6VyE
         9UkJuGpDvtyaozEbLjoOQtzaRtjJmfF+2gKz9LJXVzVA7IO5jHUxaDooJ5lwfndVMtAM
         lJ7sqU6sZ4+lr4oVakqZBHhCyrU1au4HSUBtL7Wek+PNqCp5fa33X2ngsns7CCHfl7Dh
         J+9Y4LH4dC8yzNxH4Ji8g9ZCh+A+Ut64bvhf3Bqt1jI6N3nRnTHiH4OQeVDoiM/ph54K
         CC3OYYURx3kgpKilM4nqWtXTinceWB4jBCPzWNI60iuv1hZOQ8dqrXTwGfss7f4ZdY4z
         KFag==
X-Gm-Message-State: AD7BkJJhm+zwLrSvzUK6Z3E6PDMjte9FHOkAfgcivBkKkamQ59CqwhYuDzravSrliZgKkw8CjJfTZ6mbt77g8A==
X-Received: by 10.50.137.35 with SMTP id qf3mr1483710igb.92.1456471996068;
 Thu, 25 Feb 2016 23:33:16 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 23:32:56 -0800 (PST)
In-Reply-To: <20160226060743.GB24517@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287541>

On Thu, Feb 25, 2016 at 10:07 PM, Jeff King <peff@peff.net> wrote:
> Of the two you suggested, I think I like the here-doc better, as it does
> not leave any question to a reader that there is other interpolation
> going on.
>
> -Peff

Agreed. Since I forgot the parts about argc checking, I will do a
reroll with the heredoc rolled in as well.

Thanks,
Jake
