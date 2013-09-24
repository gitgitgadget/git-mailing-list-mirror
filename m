From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Tue, 24 Sep 2013 19:16:10 +0800
Message-ID: <CALUzUxqX=zgkQg84jYQABKa=Lq=7BUee6824H+Xfye4XBnUZqA@mail.gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 13:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOQbh-0003cx-2t
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 13:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab3IXLQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 07:16:31 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:58561 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab3IXLQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 07:16:30 -0400
Received: by mail-ie0-f176.google.com with SMTP id as1so8637842iec.21
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=40Rjhzdt2i/FUjbyjj9Tv9aBEQ/bQwJdkiveDy4SU5w=;
        b=LHv9h/qEy13HbMKSkvvrJucyRheTaDCFh+pNhPHVoUhGw++XPmqGMTenY9Jdc7kbm9
         iuOYuOQ8Kfst1+xx5vOH6qdk+YQL+k4cooaJibwERevx1r4s9yiqz8jvF9f63xgnJTv+
         cTrVsrE+ipbNlLYfJdUFp+xVkEAejbL39fAD/NONd4UYgRsuFy6zwmC8utL2Z6SEYHJG
         4Q+/3S1SYMD71MwX51ZFCGa01siRDHFh1ZMkwv3x2lU5ewWT2P/7noCukavGlpG6Nf4x
         L3cnSFs6ldR6jnAW7xLtMlP0dgtWUk66l8+UpL4sKhDwxD4TeYfv1XlosXEgwXT9Vaws
         k5gw==
X-Received: by 10.43.106.198 with SMTP id dv6mr9023788icc.51.1380021390204;
 Tue, 24 Sep 2013 04:16:30 -0700 (PDT)
Received: by 10.64.93.34 with HTTP; Tue, 24 Sep 2013 04:16:10 -0700 (PDT)
In-Reply-To: <52416058.90008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235301>

Hi Karsten,

On Tue, Sep 24, 2013 at 5:50 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>
>         |       add        |  get 100% hits  |    get 10% hits
>         |  hash  | hashmap | hash  | hashmap |  hash   | hashmap
> --------+--------+---------+-------+---------+---------+--------
> FNV     | 14.815 |   2.345 | 3.059 |   1.642 |   4.085 |   0.976
> FNV  x2 | 14.409 |   2.706 | 2.888 |   1.959 |   3.905 |   1.393
> i       |  7.432 |   1.593 | 1.364 |   1.142 | 413.023 |   0.589
> i    x2 |  9.169 |   1.866 | 1.427 |   1.163 |   0.757 |   0.670
> i/10    |  1.800 |   1.555 | 5.365 |   6.465 |  32.918 |   1.052
> i/10 x2 |  1.892 |   1.555 | 5.386 |   6.474 |   1.123 |   1.206
>
> Tests can be reproduced with 'time echo "perfhash[map] <method> 1000" | ./test-hashmap', see test-hashmap.c for definition of method flags.

I'm not sure if I'm reading the numbers right, but they look impressive!

If it's not too much trouble, could you put together an API document,
along the lines of Documentation/technical/api-hash.txt? I could give
a stab at replacing patience and histogram diff's hash implementation
with yours.

-- 
Cheers,
Ray Chuan
