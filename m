From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Thu, 23 Jul 2015 20:02:10 +0530
Message-ID: <CAOLa=ZRZeTqhbFB4JASac+QOFsJEvqWAsGdpx2hbd-myPd1a9g@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437246749-14423-2-git-send-email-Karthik.188@gmail.com> <vpqwpxsnibr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 23 16:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIHYD-0003GQ-OG
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 16:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbbGWOcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 10:32:42 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35564 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbbGWOcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 10:32:41 -0400
Received: by oihq81 with SMTP id q81so166600275oih.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AOAVd9hFMk7x6maxoa5IB4vXllmxR6QRS7pRGb5GreY=;
        b=wgfOHs69OzSjEy8YQ2vXr6H/9zYSWPIxHbzyeTRfP6MD0dA9CU5/wbHYVn8La98pyr
         xb3cglikt5LB6H430G82IrM6fG5iGQPraL9kRVTIYRIXtVulJCiPiSoEPZEupkjubgie
         Z5BFe5huKf2OigVKV7xDNtRZEGLDKwnD2ypq6N0goUd3kI8jhDRJWJlYjtpfAJ+X6NGt
         WRbBTUqSDtrHHoj1itT72I6Y6S5xNwbcptmAULWAyJUM0RSopIqYZKcBjoL2RJNBvOON
         6Iy0U7JXRiBlEl9mmUwtIQcc0heuGSxPx0wahXLzN7N9ET458Uqd1mNHsuQj7kV/x2fB
         rSig==
X-Received: by 10.182.29.68 with SMTP id i4mr8492815obh.57.1437661960182; Thu,
 23 Jul 2015 07:32:40 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 23 Jul 2015 07:32:10 -0700 (PDT)
In-Reply-To: <vpqwpxsnibr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274498>

On Thu, Jul 23, 2015 at 12:14 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +                     strtoul_ui(valp, 10, &ref->align_value);
>> +                     if (ref->align_value < 1)
>> +                             die(_("Value should be greater than zero"));
>
> You're not checking the return value of strtoul_ui, which returns -1
> before assigning align_value if the value can't be parsed. As a result,
> you're testing an undefined value in the 'if' statement in this case.
>
> You should test the return value and issue a distinct error message in
> this case like
>
> if (strtoul_ui(valp, 10, &ref->align_value))
>         die(_("positive integer expected after ':' in align:%u\n",
>             ref_align_value));
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Makes sense, thanks :)

-- 
Regards,
Karthik Nayak
