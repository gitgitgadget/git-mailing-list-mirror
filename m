From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git daemon --access-hook problem
Date: Mon, 3 Jun 2013 16:00:14 -0400
Message-ID: <CAPZPVFaJ0qOhxMYDxhq4+qnWQjjhFRUjzGAemqjwAAoxC8-EDQ@mail.gmail.com>
References: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
	<CALWbr2ypPCoftVLfP9uKeKStg3TWwLDchkUaL1d9s9O3kcuPwA@mail.gmail.com>
	<CAPZPVFYdeuusW3=iBTBC+iPuOeAekvtMx6d_dozB9tsDCg3C8Q@mail.gmail.com>
	<CALWbr2ynF425qfCNr_NGH8z9UiX2G2CRrWiCo2XrgBLBbyPHMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:00:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujavh-000422-81
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758726Ab3FCUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:00:18 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:52914 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab3FCUAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:00:15 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so10060004ied.28
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rwKOegs+JiEqmbXZGXidAis5LlaCXNsLzHyn//UaUBg=;
        b=PhgNv1tp4Jly0pmzyER+Bt9twSruMpM4xXXYsS3Yiwm2ZEPUXtBn06UbHLHTtAXR/W
         Y7TDGkASFDIEpJwSjfUhIjGi3nLYwVKlsXXB74Il/4L0ng+1VDBxgSq7aQ6UrfqgVVz3
         AoqFjS0JJqjKugcoclG5gHwLATxdcDDaqgRvce0S+7DLyoE7FnQhwtAKkllqJxmfH3bm
         jECkFwHMkYx4mjplBaBqOTSjLpS0LhgyOJ/SKZrIGs6nC1c51BWJzswDMkGUcxFDezt8
         L8uit9jRWKM8W5tGY3XU7GsjKxgUhavETWbvmAjroX8YCOLSGb16vfm/5PViL6BcjSse
         X/HA==
X-Received: by 10.50.106.114 with SMTP id gt18mr9011244igb.7.1370289615095;
 Mon, 03 Jun 2013 13:00:15 -0700 (PDT)
Received: by 10.43.85.7 with HTTP; Mon, 3 Jun 2013 13:00:14 -0700 (PDT)
In-Reply-To: <CALWbr2ynF425qfCNr_NGH8z9UiX2G2CRrWiCo2XrgBLBbyPHMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226274>

Right, --informative-errors does make it better;)

Actually the CWD for the access-hook is not where the hook script is,
but inside the .git folder of the target repo. GTK.

and yes, definitely some documentation improvements needed;)

Thanks!

On Mon, Jun 3, 2013 at 3:05 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Mon, Jun 3, 2013 at 8:02 PM, Eugene Sajine <euguess@gmail.com> wrote:
>> Would you be able to advise how this should be done?
>> I don't get the error message (i mean the output of pwd) if i do this:
>>
>> echo `pwd`
>> exit 1
>>
>> What should it be?
>
> Actually, after digging into the code, it looks like you need to call
> git-daemon with "--informative-errors" if you want to allow custom
> errors. Maybe there is place for improvement in the documentation.
>
> Cheers,
