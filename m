From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Thu, 12 Apr 2012 15:41:06 -0000
Message-ID: <fd7f09d9f7ad4ce2a32e850c0f21cc4c-mfwitten@gmail.com>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
            <7vobr4236g.fsf@alter.siamese.dyndns.org>
            <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:42:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIM9r-0000Wn-Df
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933796Ab2DLPl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:41:58 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58033 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab2DLPl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:41:58 -0400
Received: by eekc41 with SMTP id c41so547868eek.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=YSk4bJJ/un05emJnt2r2e0YxY6LjGf2JrgNeaP+b+bM=;
        b=ZWNyNbsUSTCYuQ6GCG9j+QaZOFiDFezXkQqknB+TlQb5I6nJfHQ9DgX5XmCVHwilyV
         RGPoJMu/ZZF66gZ9T4Nf/xnnc+6gfGbvCeKHVhQ4pMtW82iKvDFm78THoQ4Xvt7yq3Jq
         rfbQJTPdvrIsLxORvSJ8C+bOT/3b+aI2BjkBYoZHDCrNN7SzGeatsFWdTsONc5XxA7gK
         0CaGUAs65X6QTU7MjfamjZ5hzGUijKHOGYJKSWD+6Lwmz9UDj/MbJjaSMWQRt0Kd21Ce
         yMWKEBxKkMUhng2QROyaLYE6FRIugx0hE9cU7Q22aNaXGS1hHBZv3tQJUrugzNdHUEqs
         CrMA==
Received: by 10.14.50.74 with SMTP id y50mr425865eeb.107.1334245316837;
        Thu, 12 Apr 2012 08:41:56 -0700 (PDT)
Received: from gmail.com (rainbowwarrior.torservers.net. [77.247.181.164])
        by mx.google.com with ESMTPS id q45sm29361989eem.7.2012.04.12.08.41.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 08:41:55 -0700 (PDT)
In-Reply-To: <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195338>

On Fri, 6 Apr 2012 22:42:16 +0300, Felipe Contreras wrote:

> On Fri, Apr 6, 2012 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Some mail servers (Microsoft Exchange) mangle the 'From' header, so
>>> while applying the patches, the author has to be fixed manually.
>>>
>>> This option allows to always specify the author of the commit in the
>>> body of the message, even if the committer is the author.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>
>> I wouldn't say that the existing option names to send-email are great, but
>> I have to say that the one added by this is simply horrible ;-)
>>
>> The first paragraph of the proposed commit log message states the problem
>> it tries to address very clearly, which is good, but is "From: " the only
>> thing that needs this? I am wondering if this should be named and behave
>> more like "--duplicate-header" or "--in-body-header".
>
> I have never seen any other 'in-body-header' other than From, and I
> don't see how that would be useful. Anybody else?

I sometimes like to set an explicit in-body `Date' header. However, Junio
has disagreed vocally about this practice:

  Subject: Dates in Commits and other issues of style
           (Re: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL)
  Message-ID: <811b01a9-f10e-4444-9e5e-581adaf059c2-mfwitten@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/171936

Sincerely,
Michael Witten
