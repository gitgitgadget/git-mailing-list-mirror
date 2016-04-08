From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] format-patch: allow --no-patch to disable patch output
Date: Fri, 8 Apr 2016 11:17:48 -0700
Message-ID: <CA+P7+xoUi5H19zOCAiiwQZ0-j8yNZS9-2DzgoMmLSVOrC8Nbpw@mail.gmail.com>
References: <1460047599-9267-1-git-send-email-jacob.e.keller@intel.com> <CAPig+cRNCwFmGW-Zo+osjceA6nb=6t3+rJ2uEbnyYxGfSWQ-Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:18:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoaz2-0004C6-24
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 20:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbcDHSSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 14:18:10 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33156 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbcDHSSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 14:18:09 -0400
Received: by mail-ig0-f171.google.com with SMTP id kb1so41805124igb.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+4dV8RVPq+yyrjJQElmKonGQnqFKLKhf1UTaq6U/IrA=;
        b=Ebp8Mj5z4CpOXokbFf1ZpRuOIrfzhLg2/4NN5dczXbEFpU2fXWEIfM9lF8mHEDFHU6
         /9yQwdaVQ8e7rhZcO8uh68nUc6ku90smcVUOv7tc/mofN1yvx4zk4l0RIfJFV1ZWiVkI
         DluFaMVbVu3uzB6ayP3uMIixgQtrdBp/cdlJS2DwrKokY17hxDIjN2s2t4dgChSMZ/5o
         3YZP4YInACAjTp5zqaZNjicoJH4ani5VQ45W9Inu6mXZOoNdTeibmvJlb5j4n4pX8xxs
         +wazgnQzaM4bx3zigDgEbI/lQ910k22EsNxfNa3bhwC4/13ZvsWifacgUJec3PXthjXz
         RSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+4dV8RVPq+yyrjJQElmKonGQnqFKLKhf1UTaq6U/IrA=;
        b=lbdgGlNwtx6aJHsFfX1kmm71AhtwoxVAzz84IwGQ8KU/JX4AEP/aiDySuobrpEmsOM
         Okxb+w9/wNCpNUWkbb3xWXGD6mH7q2RGvInZ+ctX4IamFj02UJ/Qjrfz+OgxwliAGJN7
         mqaVs9SA2A8RzKMMGUDbNrmpZp9eOfP74jsvTjHorbbQUwFFB3lo1FEkjbsZtQaYGm4/
         k9P+yNiziPp+YXV2y2banyjr/76OqtAbCg/3xkVf+b0g+hzv03OxE3etnqwvk1/GLPeL
         6dyb6qS7dXdQxjY0jknrPK4V+hgNuBUWv4EffJOlJ3awbwIx/F/h2M5zbcqFA461aFng
         vZmQ==
X-Gm-Message-State: AD7BkJL4ohMcFO9SXgn/UH3hbiIbs8AIY2Ngsy5us7o6tr+BTz+ldhCDMRr+21L2jl+8v3iTgU6+M5nY05OnUQ==
X-Received: by 10.50.97.70 with SMTP id dy6mr5033494igb.73.1460139487955; Fri,
 08 Apr 2016 11:18:07 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 8 Apr 2016 11:17:48 -0700 (PDT)
In-Reply-To: <CAPig+cRNCwFmGW-Zo+osjceA6nb=6t3+rJ2uEbnyYxGfSWQ-Uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291048>

On Thu, Apr 7, 2016 at 2:30 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Apr 7, 2016 at 12:46 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> The documentation for format-patch indicates that --no-patch wilL
>> suppress patch output. It also incorrectly mentions that -s will also
>> suppress the patch output, but this is incorrect because -s is used to
>> add the sign-off line first. Fix the documentation to remove the
>> indication about -s. Fix builtin format-patch to prevent always adding
>> the patch incase --no-patch is given. An alternative approach would be
>> to remove --no-patch from the documentation for git-format-patch, and
>> add an error check to indicate that --no-patch is not supported.
>
> See [1] and [2].
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/290023
> [2]: b73a1bc (git-format-patch.txt: don't show -s as shorthand for
> multiple options, 2016-03-27)
>
>> Add a test for --no-patch to ensure it functions as expected.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

So if I want to get the summary of a patch out of a commit without the
actual diff what would you suggest?

Basically, I have a process where we have post processed code, and I
want to be able to generate a "patch" that shows the diff only of the
post-processed code, ie:

checkout commit^ to get the parent commit, process the code, then
checkout the commit and process that code, and run a diff between,
then spit out the equivalent of "git format-patch commit --no-patch" +
the diff between the post processed code.

I think maybe git show --pretty=email might work?

Thanks,
Jake
