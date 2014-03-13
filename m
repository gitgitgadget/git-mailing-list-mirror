From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] entry.c: fix possible buffer overflow in remove_subtree()
Date: Thu, 13 Mar 2014 18:29:14 +0700
Message-ID: <CACsJy8D9FrsZ0FmXZoXGGzqQK7UfE+K39259TjUkTOZp+F5OOA@mail.gmail.com>
References: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu> <1394702348-6433-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:29:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO3pd-0003o5-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 12:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbaCML3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 07:29:46 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:59300 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbaCML3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 07:29:45 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so828749qab.32
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YZR2X8WHYDkmPAj/KdCreHdXTAwze2VMnjI9GSGO3/o=;
        b=SnsBmMTFn7cIVII5EAO30MTjuii1oWO0VZvzL3J7X6LbW7GS6tWfxHUpZ4OUcKnQ4l
         1TD+rT3J2PhgQreou2l6zNB/LxwsCQR1O5uKhF+HaxRDqyxAfWuXBcFSVnh2zZUUbZJU
         Lvxyg9sunT7MdeTGrBH5A9te04RtQ9xhXVLswh7csGyCsvQRAXX3qMhTMFOmLh1hFcwf
         wj6YQ2oLxvN6zGKQP8xZA9Lbtb0leFGl0ogbBJwgXvY6r3VE4lfuvXnR5YwobFZIzt/q
         HDgwFrVHKe+VwBuAhCcrT6Zy74TJyGlRWspCWwIz3eGwGjyJ4mPRB+lkF/6SNwobAG3Y
         M6nQ==
X-Received: by 10.140.93.244 with SMTP id d107mr1389685qge.41.1394710184790;
 Thu, 13 Mar 2014 04:29:44 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Thu, 13 Mar 2014 04:29:14 -0700 (PDT)
In-Reply-To: <1394702348-6433-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244029>

On Thu, Mar 13, 2014 at 4:19 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> remove_subtree() manipulated path in a fixed-size buffer even though
> the length of the input, let alone the length of entries within the
> directory, were not known in advance.  Change the function to take a
> strbuf argument and use that object as its scratch space.

Converting more PATH_MAX to strbuf could be a micro project. Not sure
if we still any more of them though.

The patches look fine btw.
-- 
Duy
