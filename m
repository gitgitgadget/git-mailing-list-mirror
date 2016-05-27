From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: dynamic "auto" date formats
Date: Thu, 26 May 2016 23:57:11 -0700
Message-ID: <CAPc5daVQEnehW311wi5U2Fs0cdYKzW_jqwpQ8M3c6ZqNGXuLsA@mail.gmail.com>
References: <CA+55aFzWEf2sN647v0mfiPOFE=KindQpweoHwdPmDshUb0YVsA@mail.gmail.com>
 <xmqq1t4ot418.fsf@gitster.mtv.corp.google.com> <CA+55aFwhUJ2g9690yMBR3inZmVXRupmgjbePmm4GC5kEcx2XLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 27 08:57:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6BiB-00005V-P3
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 08:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbcE0G5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 02:57:32 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36628 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcE0G5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 02:57:31 -0400
Received: by mail-yw0-f182.google.com with SMTP id x189so98123028ywe.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SFvv8vizIRjiv3x1ZREUsgkDNAbXZPkSmHwRSZ4OwFQ=;
        b=zy+K/9P7QYXEYumH1rlpxOfUrelGIZxAeeV1M+8SiPNBldSkhz2ha5qMIq7ZHwuywO
         FOEkgumXdBwJ5QrLMJCRmQe87+wGxHlY62WtRY8scp+adSL536hHcqCpLPuFUtFCSeOT
         85kwOumTNErNKaiKisXB5RoAUWGQJdEKjC5UVODhnqQM9OAsLhQtjoFxYi4lkElprTzc
         yVUiAtwWH/mhOSWI8HLe2JgaI598PwMq/Ln/znFuunZAiCMeqLEUneOmE/NA/dtAM6Oz
         N5TTZ5QQXGjFUfMePSYZHbFrG2V0SXSrxXmQc88/v22/xDZ8xB0gHdMxit/qltreBJ9W
         b0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SFvv8vizIRjiv3x1ZREUsgkDNAbXZPkSmHwRSZ4OwFQ=;
        b=FaGL/w7B1xaqHfFJCX9x/bycPO2aVt9IOPQnv3MTVWESqbx3VNWBPcGa7zFlgtiy+D
         edDZM3y8KPACoWOwD66e2bGcOL/oJBsg/OEIVsXv03ScLVxywrXwpdP/doEW2QYtRO7E
         TMh1kk7bADUSLm6/ZwejODIaOYOfJSzUOt5eiAXFnbpd7IRFTCoXjcMBfoDJLa6lQpS3
         SWKwjf+lduIOnaiN+nWIqVR5kG0pw6cZIk1EARuw3GFZMGpuCeFKWKr1hO3NbDY1mHr+
         Metrv1nPWWNUO2XzI6+5jwCfAcTy/TGALu8/vCnv5ZMf5q9FSDRi8UWmLkE31NiGto7U
         rHPg==
X-Gm-Message-State: ALyK8tJeoDxEGty03pemg3ejxgo2w7XHRIoCetRU4Nm9kkio8rkLqRy1EN5Id1ryH7xf7HfeIuSM1Trwt/MjUA==
X-Received: by 10.129.80.139 with SMTP id e133mr8474954ywb.197.1464332250952;
 Thu, 26 May 2016 23:57:30 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Thu, 26 May 2016 23:57:11 -0700 (PDT)
In-Reply-To: <CA+55aFwhUJ2g9690yMBR3inZmVXRupmgjbePmm4GC5kEcx2XLA@mail.gmail.com>
X-Google-Sender-Auth: 6GN-dF4BtvBmmWOQ3A5iZWqjp8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295739>

On Thu, May 26, 2016 at 11:53 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think what I really would like to see is more like a reverse
> "approxidate" that gives the date in human terms.

Yeah, "human" was the word I was looking for while composing my response.

I am sure somebody will write the reverse approxidate that utters "tea
time" when
it is appropriate, if only just for fun. I can't wait ;-)
