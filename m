From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: fix hg sharedpath when git clone is moved
Date: Sat, 23 Nov 2013 17:35:29 +0100
Message-ID: <CALWbr2wE=6yR70tdBqf6dcdSv6mXE9vaPxg32OEGtL89+Kc_fA@mail.gmail.com>
References: <1385210302-25518-1-git-send-email-apelisse@gmail.com>
	<CAMP44s2=b+7cFbRK-NFPU-myT8JtaSsrKut4AbvjOAQe0OCxDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 23 17:35:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkGBD-0006rN-2K
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 17:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab3KWQfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 11:35:31 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:41028 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab3KWQfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 11:35:30 -0500
Received: by mail-lb0-f169.google.com with SMTP id y6so2023781lbh.0
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UNocUSuso54X1gtafzBm2NS7SKGh96NgQwq5OfHHn38=;
        b=RbJw92pilhnelbwSEVb8l39AC/4b8Qqh+mZo14++jBIad19qAREQJ9hUSxw21dLLqA
         96SvfaEEFZ1U958K+jkmZ6QG2toRR5+dTupaMu58kZnbbUOsHgxl840hiRgE1xm4Mt00
         lYo8KeU4vrnO1SUsMXH1KcLCIrQrSf1EenRLMCacNP/lUseHnEbK0T6bSWdK5PMXJrAi
         Y1zkclAlNTEnSBE6QcD7q4xJIqj8gRUrNNPVpPN2Hbcxb3bAXqJ6G7dWdpLFvMSInwR3
         8imbt6aIgWJd7Yecvj77wxlJTZHY5rH4a5ai10xpN4IKVYuyhKvRPUGxI5hOh5AlkGCA
         z/Dw==
X-Received: by 10.112.92.112 with SMTP id cl16mr1597010lbb.33.1385224529556;
 Sat, 23 Nov 2013 08:35:29 -0800 (PST)
Received: by 10.112.202.102 with HTTP; Sat, 23 Nov 2013 08:35:29 -0800 (PST)
In-Reply-To: <CAMP44s2=b+7cFbRK-NFPU-myT8JtaSsrKut4AbvjOAQe0OCxDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238240>

On Sat, Nov 23, 2013 at 5:32 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 23, 2013 at 6:38 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> remote-hg is using a mercurial shared clone to store all remotes objects
>> in one place. Unfortunately, the sharedpath is stored as an absolute
>> path by mercurial, creating a dependency on the location of the git
>> repository. Whenever the git repository is moved, the sharedpath must
>> be updated to reflect the new absolute path.
>>
>> Check mercurial sharedpath file when getting the local hg repository,
>> and update it manually with the new path if necessary.
>>
>> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>
> https://github.com/felipec/git/commit/270e7ff91a4a34e8bc27edb6bd7d7473b886f568

Or that, indeed :-)
