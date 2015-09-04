From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Fri, 4 Sep 2015 18:05:36 +0530
Message-ID: <CAOLa=ZT8uAWp=janWUX5iBKZZ7cj-j2Z7OynYxhJ+v4THZJZXw@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-8-git-send-email-Karthik.188@gmail.com> <CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
 <CAPig+cS9mBNhCm2Ea9jkAK7ME9U1QJ=xYgF_zWzThTVsZCHmdQ@mail.gmail.com> <xmqqpp1zlb79.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXqE2-0008Q7-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 14:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758866AbbIDMgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 08:36:10 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36855 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872AbbIDMgG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 08:36:06 -0400
Received: by oibi136 with SMTP id i136so10930631oib.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H/6ItR459FZ6BkvoGM+WCrEjBvKT0dFOwNugXvan8gI=;
        b=CgpF2P2cSn5poFosPMBLnPdPKG7zlNA1W1Xbzt9EAOasBhzgkOmNgFFZe6NoNBIiq1
         hI8hSmFFv0sLB0qy4A/lhbM2iaJgdQ8wlOg0a2wW8hnYAJrsmdJr1QKeGSMsrh+Hh5mv
         ocS8wxj7lBmUV1+ub4zb3IqkOpADEjZEagOg5nA8yeB8bWTU/4ynBvdh2TnQ1SxObEu+
         XJYt+9+f/kpK+GaiM0NxYPcEarQzcWPFjPArf4zfpwIubYJpHTEYpcsPyuwjfojYsaQi
         IFEWwrKnRwtHJv4rGUfRI72ti0YVABLBdW7LW3NSV7+xG8l8VnMet+Cwfuh66Cqab7II
         Iv2g==
X-Received: by 10.202.105.133 with SMTP id e127mr2801640oic.60.1441370165896;
 Fri, 04 Sep 2015 05:36:05 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Fri, 4 Sep 2015 05:35:36 -0700 (PDT)
In-Reply-To: <xmqqpp1zlb79.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277301>

On Thu, Sep 3, 2015 at 9:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Also, if 'buf' is indeed unconditionally NUL-terminated, then the (sp
>> <= buf + size) check is wasted code since the result of strstr() will
>> always be either NULL or pointing somewhere within the NUL-terminated
>> string.
>
> A caller can give a buf that is NUL terminated but specify that the
> only early part of the buffer to be used by giving you a shorter
> size, no?  In such a case, strstr() is safe in the sense that it is
> guaranteed not to go on forever, but you need to verify the location
> of the string it found is within the bounds.

That was the idea behind this, but will stick to Matthieu's suggestion.

-- 
Regards,
Karthik Nayak
