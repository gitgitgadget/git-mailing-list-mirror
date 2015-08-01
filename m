From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 03/11] ref-filter: add option to pad atoms to the right
Date: Sat, 1 Aug 2015 11:33:59 +0530
Message-ID: <CAOLa=ZSXM3CmtVvVFRvQ340fKAKPHvPo64r41CSvoXrFz+wm9w@mail.gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
 <1438271332-10615-1-git-send-email-Karthik.188@gmail.com> <1438271332-10615-3-git-send-email-Karthik.188@gmail.com>
 <CAPig+cR709U7zy3+F4eoiyUBhA=c2ZCxPc9uUoDQLOuooFxvzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 08:04:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLPuM-0006WO-8J
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 08:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbbHAGEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 02:04:30 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36400 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbHAGE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 02:04:29 -0400
Received: by oibn4 with SMTP id n4so48522652oib.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a+y9+PdWrZGutQ7KYm8m5GzM5I5gdaXlC91AYWNKU8U=;
        b=Tos9OMaR13QMxR9ozah8TsjOjVl6f1O/abU7hEfFzieLfft49N3+1be8kos1EH0Rn4
         4S8RR74Ak80MXa9TdDJd5LWZdaVywatDISASSsXPVv1GlrsjvCKe94lDzWMA6W6il4PZ
         JpDgtVpHnt1Nr/jaNXab7Iy2mLXbd2IPWafeDFkktU+9bvbshcZXuYHjVI+ZJA56FNGH
         h5DU0gCM4s6v4sU4K0T32oMpcLJn9MCzNShui8NiEiw2LT6nh8QusxATG41buvD6bO7L
         rEgiXZItZLRLEvhexvlDzm/JHk44miOsfkG7CcuxnHlzRUKYCmgX1mMnT0G5jeqpkMsS
         2kaw==
X-Received: by 10.202.92.6 with SMTP id q6mr6808928oib.11.1438409069242; Fri,
 31 Jul 2015 23:04:29 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 31 Jul 2015 23:03:59 -0700 (PDT)
In-Reply-To: <CAPig+cR709U7zy3+F4eoiyUBhA=c2ZCxPc9uUoDQLOuooFxvzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275108>

On Thu, Jul 30, 2015 at 11:26 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> In an earlier review, Matthieu pointed out that this test failed to
> ensure that the 'padright' value did not leak into the next atom. In a
> subsequent version, you fixed the test to check that condition, but
> now you've somewhat lost it again, at least visually. That is, because
> whitespace is "invisible" and because 'padright' now also affects
> literal strings, someone reading this test can't tell if those
> trailing |'s in the expected output are padded or not. You could use a
> different format string to prove that the 'padright' value doesn't
> leak. For instance:
>
>     %(padright:10)%(refname:short)|%(padright:5)|%(refname:short)
>
> This way, as long as the two |'s are side-by-side, then you've proved
> that the first one wasn't affected by the preceding 'padright:10'. You
> could also add back the %(refname:short) at the front of the pattern,
> as you currently have it, if you want to prove that padding is not
> enabled at the start of format.

Thanks Eric. This seems like a better improvement over my test.
Will implement this :)

-- 
Regards,
Karthik Nayak
