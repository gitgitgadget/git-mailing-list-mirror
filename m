From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 6/9] ref-filter: introduce format_ref_array_item()
Date: Wed, 7 Oct 2015 00:46:09 +0530
Message-ID: <CAOLa=ZSr19+0OVoyACdN_YfSFeWugtS40WNu0GB9=uZFEu8N5A@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-7-git-send-email-Karthik.188@gmail.com> <vpqoagg9n2l.fsf@grenoble-inp.fr>
 <CAOLa=ZTMf9i=+9Rgi9oO==vr_JGtG3J9DvQWk18Zx-yd5_35XA@mail.gmail.com> <vpq1td9zolv.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 06 21:17:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjXji-0004on-12
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 21:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbbJFTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 15:16:55 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36015 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbbJFTQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 15:16:39 -0400
Received: by vkfp126 with SMTP id p126so123823943vkf.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YUlPH0gQIf3HlxvfF2xMNWMj7UFatExE5TWexKT2iWk=;
        b=Kah3wmqMDDYRCGQexmaTWWKfufR/abZuGz8gY5aeDk0D4fNcKAboqAmhaRbibQi4/9
         L7K4YFeG96phnYs2cQYatJ/5PQqDjYctFZBi8LEixbBg4+RKWwITpaj4mBeORnIwVnRi
         6Gx0BrcW3Z/Alb2DhDvZACvoUXVD0MhQna1LzugbhhHLEq3Hunb01zQuIWGsIp88DTT9
         48ektONi16LZS+zAwN5c8JzZYggiUbj4UtVPG9ayTTxR/LgLXgVrGQmVtu+Z5M+Dn3fE
         yHWhH4IKzQP5/pcz1V9RZydR5+MlPi1c3uQdnHESv6BoYAKWKng3mjqYkuR3CKpVWg/d
         SeAg==
X-Received: by 10.31.161.142 with SMTP id k136mr25287064vke.17.1444158998442;
 Tue, 06 Oct 2015 12:16:38 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 6 Oct 2015 12:16:09 -0700 (PDT)
In-Reply-To: <vpq1td9zolv.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279160>

On Mon, Oct 5, 2015 at 2:19 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>> which does not play well with the implementation of --column as done
>> in tag.c. Where, If I'm not wrong the --column option captures all
>> output, formats it and then prints it to stdout. Hence when using
>> colors, we're told that the printing isn't done to a tty which
>> supports colors, hence we lose out on colors.
>
> What I don't understand is how --column is different from --no-column
> wrt colors.
>
> In any case, this should be explained better in comments.

Well, If we use column the way we do in tag.c then it'll replace the tty
and color will not print color because it will assume the output tty doesn't
support colors.

I hope that's what you're asking

-- 
Regards,
Karthik Nayak
