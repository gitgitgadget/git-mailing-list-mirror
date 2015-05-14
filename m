From: Stefan Beller <sbeller@google.com>
Subject: Re: Problem with rerere forget
Date: Thu, 14 May 2015 11:21:36 -0700
Message-ID: <CAGZ79kZ8Cy1Pp9cf7vExntbfe-YW5KjYx6Fogr3O94wDfwuOXg@mail.gmail.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Coppens <alex@nativetouch.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:21:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsxlQ-0008Az-1x
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933562AbbENSVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:21:39 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37590 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933552AbbENSVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:21:37 -0400
Received: by igbsb11 with SMTP id sb11so80285798igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mINJiXWekXSzdSsiHxWYwazs3IIy9V0YVo4CrWc3z6Q=;
        b=OsV7tWjS8HcdnzyRptLm5hob5PSL0XzSvwL/8V2iVFJGIpfuNjGn93Qnc9WL5g8yyE
         yyjchrLKWRyib+rtZTNG+7GzGbrJZ1EgJ6qyTy7+0Qb2kBaanPy6meJ0sMv0siE7892c
         IdoooAIiBnYTM0N8r8vnCVBYEJJv78jzGnCqy0j1QpX1UBiQv7Vx0gAzGnmVTZtCgbJ3
         bkDPPwLwPIKZCi7T1xtB08dQ2QXRIyqgRFAp7Lsq2YTRalQP5Op5KTiz99mguJj9ZUEG
         7UUpaZfI7ZhLEBIUbdddygoT+DiGXZNURSY/Zh73c3XPIMqY1XTM4xTcQA6tiJx6GJj5
         kvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mINJiXWekXSzdSsiHxWYwazs3IIy9V0YVo4CrWc3z6Q=;
        b=AdUezDfaNgZuNdICM2uxqaly3uiI8IaWxzUut1f7qWD/nmHn8Wv642/1IOznNUbYjR
         55CWQNp1hRicrIgmWT4WKTh0LyEDBbuJHCd46kplpmE9lTEG5xyIaxSA206ZMu7ythsp
         aplOsj5pitAv7DmcP6+r0wyIaodYBu/Fe/BIXbLVOP9mZQdAIpVbPck069Ru/BbivIOY
         aYy+MdItWYgUW8lbVizYZ6f6LUcEQQHrlOcXBsrdtdbaUe8s9Vr8+PpllQi+d2w07+6a
         Y4w4xlj6kc5jTG46CLAqKBeu34phn53BotLvrsa7oZotR701zQXr2a8KaT6CwT594qLf
         25Yg==
X-Gm-Message-State: ALoCoQkamd/0zthgJseoovHEx2q8Pr8T/iPs+ZRTexwPEOyMBFvv7uRvmxar0hWcna2sTojUNhOk
X-Received: by 10.50.143.97 with SMTP id sd1mr1921879igb.10.1431627696852;
 Thu, 14 May 2015 11:21:36 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Thu, 14 May 2015 11:21:36 -0700 (PDT)
In-Reply-To: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269063>

On Thu, May 14, 2015 at 11:05 AM, Alex Coppens <alex@nativetouch.com> wrote:
> Hello there,
>
> So I am trying to make git forget a conflict resolution:

Which version of git do you run?

> _______________
>
>
> git rerere forget path_to_file/file.js
>
> fatal: BUG: attempt to commit unlocked object
>
> _______________
>
> Google doesn't seem to know the answer: No results found for "fatal:
> BUG: attempt to commit unlocked object".

see: https://github.com/git/git/blob/master/lockfile.c#L316
(The "fatal:" will be added by the call to die)

>
>
> I think I am using rerere forget the wrong way. Can someone help?

(I don't think you're doing it wrong.)

The "BUG:" errors are a hint that the internal implementation of git is broken,
which should be fixed, thanks for reporting! We'd need to find out where/how
git broke and fix that. If it's a hard fix, we'd need to have a better
error message
at least.

Can you provide an example repository which reproduces this failure?
Or better yet, can you git bisect git itself to find out when the
error was introduced?

Thanks,
Stefan

>
> Regards,
>
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
