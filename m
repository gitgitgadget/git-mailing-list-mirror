From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 3/3] git: submodule honor -c credential.* from command line
Date: Mon, 29 Feb 2016 14:09:12 -0800
Message-ID: <CA+P7+xrZrVbvh=2dhKqMTGnudy0pCSzGMWHBXyirvsp7hCzaZw@mail.gmail.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
 <1456532000-22971-4-git-send-email-jacob.e.keller@intel.com>
 <xmqqmvqjcr95.fsf@gitster.mtv.corp.google.com> <CA+P7+xoNdsDH0jBz6bcikpeMa-qMR6795U+hKqGDSfu52dJFSw@mail.gmail.com>
 <xmqqa8mj9u3c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 23:09:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaW0Y-0002uy-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbcB2WJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:09:34 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36569 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcB2WJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:09:32 -0500
Received: by mail-ig0-f177.google.com with SMTP id xg9so5251190igb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fLG7Sl66XQ2oBobzy8HRpXiKzvgXSJTABhZZurZ8dWw=;
        b=PqMCCn8quTZiqFXYrECmc49MSccB1iWazDDZZZRMMWQdYH1K4WLW8LjTuiULvNVkxO
         n2c1y9flPtolA7KinTGY/c11cY7WO4YhFZ20eOpIqj/XeXlSOVDervKwPoCIQExtqO6+
         5sHDRO9YRfysL806QjeJSjiHkxn8EBMvAI3V/jiAgDHU/Hfw/Iy76o3Omx44CM1N0xNh
         9HqzCgWVnVAHOOJ6CD2KYCIWaDb3bfZS0z36solFKemLA95nAPiZp81Zm9T0/LdwDW2V
         9Nx0dsZtnFhPauK7JOqmF6HwGuROy2emhpMS7PfEyvRKNOwbgJF0+mjLrOTTCQDNdv0f
         SR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fLG7Sl66XQ2oBobzy8HRpXiKzvgXSJTABhZZurZ8dWw=;
        b=lF05Z1317Muh+fR6W7tUUR0VGiYIsC555U9gpxoDkYyu31fsiVv81zoLVt0EifA2aZ
         BO0qe53XwGpzVX3fGKhRfbfKiLHgjeS0rRHFCa1DNL+cJ/A+oj6YDIIJi8G+3I+FG4TP
         RmOf2vSIj7YjEqkIfVpiepFKzL8Ed10EwNIeTc4d7cIqmhB81H/MNL6xouMz+4i1DVfM
         DU0Tu+tWej3J8C4ltuGuaWpSpKYlmBva/wGsiAin5xTIoTt/2GylvGox5/WzlqX0qtDW
         fPgTmdIlxlTgcjufJyVjl+qfoP6hiiqLY7WuXIBMup9NAecIvrBrmYU8LZPwubZ9ehge
         18BA==
X-Gm-Message-State: AD7BkJLGvjKw0XMpFH4U73EvgzL5HjFQFVLE4bgrwF3NOk3cZgAyMtgrDRUbN7aCNhNmRpAKu2X5JfwTZXfA+w==
X-Received: by 10.50.142.103 with SMTP id rv7mr262760igb.35.1456783771791;
 Mon, 29 Feb 2016 14:09:31 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Mon, 29 Feb 2016 14:09:12 -0800 (PST)
In-Reply-To: <xmqqa8mj9u3c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287920>

On Mon, Feb 29, 2016 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I was talking about the "not even an equal sign" true, i.e.
>
>     $ git -c random.what -c random.false=no -c random.true=yes \
>       config --bool --get-regexp 'random.*'
>     random.what true
>     random.false false
>     random.true true
>
> What would you see for random.what in the above function (if the
> callchain allowed you to pass it through)?

I see 'credential.what=(null)' if I pass it to sanitize-config. That's
probably a bug, and we should instead just output 'credential.what'
instead. I'll rework this.

Thanks,
Jake
