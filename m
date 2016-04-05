From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v4 5/6] tag: use pgp_verify_function in tag -v call
Date: Mon, 4 Apr 2016 21:43:55 -0400
Message-ID: <20160405014354.GA12006@LykOS>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
 <1459808535-8895-6-git-send-email-santiago@nyu.edu>
 <CAPig+cQkqaYd2Vpgpd5jB8ZUD41VvjryB8tYc9JNEydNaKrr=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 03:49:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anG74-0002t9-SG
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 03:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbcDEBoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:44:21 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34666 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbcDEBoR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:44:17 -0400
Received: by mail-qg0-f45.google.com with SMTP id c6so39068490qga.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HaZU/UVb0T82bej+OXlOsjQXuTrmXtOo3o+GwgA4naM=;
        b=DGTRLKocwVIynCwvJkyidaG7JkKJRA6+TwbHw5XfTX/2wg/nIGlW3X3HWt8fg2YVNz
         DeefkrpPFX9TRjKg7g0SLNlNqnPva28N+WpPOnJL4q0vDH7N1fWOjhzPP2zvWcGaWPvS
         1I4UM/VoKF15cd7+XeRydyQ4o2/psMAd1mtEs6t/LTo5HkUg/6DOsGiZjlqwp2NmBoKh
         fCin7s1IljelcE9XLMX0pTqJuARhdIzUg1YwMoSSiEGinhp8MjowF8HbkmjdTb48gdC/
         l0BOsc/xMzxe3EI8HIwFj/87effA0+P7VeI+gDHe+TWZYe0gz2acE2qDjLv04dVieeBn
         IVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HaZU/UVb0T82bej+OXlOsjQXuTrmXtOo3o+GwgA4naM=;
        b=DttMiPUQObpeZHC30GG8EavBTtptcJUDZZmPe/DLVAwerxLmDIpp6TlT3DnycvIWdd
         H66gH+1Hd1bQitb250bwlUGAdkKhyXAL9KE+F9UjE7DQ46Ekz0jRj8yLCQ2QOut+6FZ9
         ReSVEWMO/U4UEdAWjXoATlqcBLRYdk0iRkUS5PdP77I4jjn0XXvMeDbH5kvAP6RUQS6Q
         iHNXOA+PzCojd529uZkQnrQHIYUYn5xTuhgvYd9OwLxLgOXzxrf7D9DhwfLc9bFeE+Qs
         RRHjb7VX4yzkDJfYYEpz1goXEDKLtakn7Jb6XWmaUUb3L0rkDiwmjOyiW/gXQhfL1gcR
         8lyw==
X-Gm-Message-State: AD7BkJJ5MBtHhHyEoa4ygYgeddhpF8igLahqjIPTOflEXJFeR1dG8YmzQvqyealyOzXa65Sd
X-Received: by 10.140.19.98 with SMTP id 89mr13650122qgg.71.1459820640658;
        Mon, 04 Apr 2016 18:44:00 -0700 (PDT)
Received: from LykOS ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id w67sm6162265qha.14.2016.04.04.18.43.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2016 18:44:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQkqaYd2Vpgpd5jB8ZUD41VvjryB8tYc9JNEydNaKrr=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290749>

On Mon, Apr 04, 2016 at 09:39:29PM -0400, Eric Sunshine wrote:
> On Mon, Apr 4, 2016 at 6:22 PM,  <santiago@nyu.edu> wrote:
> > Instead of running the verify-tag plumbing command, we use the
> > pgp_verify_tag(). This avoids the usage of an extra fork call. To do
> > this, we extend the number of parameters that tag.c takes, and
> > verify-tag passes. Redundant calls done in the pgp_verify_tag function
> > are removed.
> 
> I'm confused about everything following "an extra fork call" since
> those subsequent sentences don't seem to pertain to this patch. Is
> that leftover gunk from the previous version of this series?

Yes, I thought I had taken this part of the commit message away. 
I'll take it out right away. Apologies for this.

-Santiago.
