From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/10] ref-filter: add support to sort by version
Date: Fri, 10 Jul 2015 16:22:35 +0530
Message-ID: <CAOLa=ZRs560_YBVMTpfKBvB1BF6ts+X_JGFTzhp7A_+YsjwqqQ@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-4-git-send-email-karthik.188@gmail.com>
 <vpqfv4x792z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 10 12:53:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDVvc-0002il-RQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 12:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbbGJKxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 06:53:09 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36701 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbbGJKxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 06:53:07 -0400
Received: by obdbs4 with SMTP id bs4so189054547obd.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bClZJDZnxOdOv8Phf9pyznKXQUx5wISFhFgA0YnOhTU=;
        b=WbZDOQWqNe4kW4riuLU8NrYwGC7Yr87hmAwwCBJQmdZFcC85X13JeLGYVAMAp18cjC
         2wfXLKVvUQWOG8VU+JNcehOSfhzlpTVL4t+akSqPLre1vieLshxlty/jBWMyB5S/noPp
         qzSCMEDOVQjJMrdpXdnV2vZmjno4XXgvFLGGI1ctaaQ7filUE7xHVxMh1Y2ZOZKH0qdB
         V57vq+tj+bpPyTA/WXvE9veCK3nrzKVpJ0OlI3XZ2mXaBFjPkon7ITe3UPfnuPUd9mVQ
         GcfvjYvT1GTb4qxhVqpm0/GCnulbocq3mQy+1tnIaxeqtPVpHi7fxxB7iBHbFNLU9b4/
         Qr9A==
X-Received: by 10.60.177.195 with SMTP id cs3mr11551517oec.37.1436525585081;
 Fri, 10 Jul 2015 03:53:05 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 03:52:35 -0700 (PDT)
In-Reply-To: <vpqfv4x792z.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273814>

On Thu, Jul 9, 2015 at 6:59 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add support to sort by version using the "v:refname" and
>> "version:refname" option. This is achieved by using the
>> 'version_cmp()' function as the comparing function for qsort.
>
> You should elaborate on why you need this. Given the context, I can
> guess that you will need this to implement tag, but for example I first
> wondered why you needed both version: and v:, but I guess it comes from
> the fact that 'git tag --sort' can take version:refname or v:refname.
>
> I think this deserves a test and documentation in for-each-ref.txt.

I'll add it to "for-each-ref.txt" documentation.
About the tests, there are already tests for the same in git-tag.txt and
that's the only reason I did not repeat the tests in for-each-ref.

>
> As-is, the code is a bit hard to understand. I first saw you were
> allowing
>
>   git for-each-ref --format '%(version:refname)'
>
> (which you are, but only as a side effect), and then understood that
> this was also allowing
>
>   git for-each-ref --sort version:refname
>
> A test would have shown me this immediately. Some hints in the commit
> message would clearly have helped too.
>

Most of the sorting options have side effects in "--format", but yeah will add
details in the commit message.

-- 
Regards,
Karthik Nayak
