From: Stefan Beller <sbeller@google.com>
Subject: Re: Probably a bug with "~" symbol in filenames on Windows 7 x64 in
 git 1.9.5
Date: Wed, 7 Jan 2015 15:35:14 -0800
Message-ID: <CAGZ79kbZr+2U-NpAHKvSLkj0D6ZXwoOcjghcdmdtfOkdkVBr9A@mail.gmail.com>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Bykov <pvrt74@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 00:35:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y908I-0006Nf-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 00:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbbAGXfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 18:35:16 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64162 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbbAGXfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 18:35:15 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so6755098iec.5
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 15:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pMUUBQ6wEe1Rm3IPXAsHu9mea7EntCgQPh5ERNWglE4=;
        b=guok6cz/DVcRe01sx42YFeyL88Iw+tKt0V8EoZTZjN7O+IDSCVogIsWNkwJ8fuxpmt
         dIePJZh2eNca/ZvgUgd1wH3sLRDDjXhfocvFf8/KInGt9qGmgvXHwKWvrPN5BIj/+MHR
         GWCCvVp7ozcNhVVMF8MJRNmw2lnXyjz2t3Jc0Czn6Bn4DsbMBqpFpVRc1aSdtr+K/0nE
         w7ZYr1hh8zpy45TBMLZrT7fCFHBtM6NyyhkAr7WGiG6ORW7Bifbc2oOSwQqQ8vGywJWi
         P7/e/byn45k1eM5BPUXPObXBWdwXu+9Jh6FGpq81M5NQt7uBLgPUzkBBaZFstUzHqbdz
         4d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pMUUBQ6wEe1Rm3IPXAsHu9mea7EntCgQPh5ERNWglE4=;
        b=bWsjaESDXij5a9SKPzWbWUNejwOEbx4EA4g/lJtDkkHvyOiGeeg8kLfXQRwPVZ2IAk
         cejdPpI4vP/mMlgXHegUUNdGDiaoO0quSLxWupwdiBGgBjnm7BFDH3IJ9QZ+YnboD0OS
         M9/UhiyEvGWvtfX8JICj7Hl6Yer7Xalt1wxyfDn22ibnD1f37XYRIdH6MLNKmZL6mKVF
         jcfYt8UByfXLc5pVDnZY02SF/jSMv+YMLKb3xAPShdxFaGb+S5RqUE3nlA0xRspHLuGD
         FUB4jkokHj7qf8NDk8RuqvA5t37pICYbeMnI8jY/mv/yHu7g+PEfA6fdao8iHd1crq9G
         s+Gw==
X-Gm-Message-State: ALoCoQm2SYjRdCaH+ipsyRUR2njgvHoy9qwqXH7CluL1e3rOG6ghTs2NqfgqlQ6bk+6ULNUcRsvt
X-Received: by 10.50.80.36 with SMTP id o4mr24815410igx.37.1420673714752; Wed,
 07 Jan 2015 15:35:14 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Wed, 7 Jan 2015 15:35:14 -0800 (PST)
In-Reply-To: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262167>

On Wed, Jan 7, 2015 at 3:26 PM, Dmitry Bykov <pvrt74@gmail.com> wrote:
> Hello,
>
> Recently I installed 1.9.5 git version and faced the problem that one
> of the files in my cloned repository with a name ICON~714.PNG is
> marked as deleted even repository was freshly cloned. Trying to do
> anything with that file resulted in constant "Invalid Path" errors.
> Reverting back to 1.9.4. fixed that problem.
>
> Thanks,
> Dmitry

Git had a security issue with filenames which look similar to the .git
repository.
Please see the announcement at
http://article.gmane.org/gmane.linux.kernel/1853266
(That also updated 1.9.4 -> 1.9.5)

I'm not sure if I can advice though.
