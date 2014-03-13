From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] checkout_entry(): use the strbuf throughout the function
Date: Thu, 13 Mar 2014 18:22:31 +0700
Message-ID: <CACsJy8AG5T4sA6j0AGtkX2uhVNDvppT=tnNrQNuZ1rhHKArP0w@mail.gmail.com>
References: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu> <1394702348-6433-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:23:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO3jA-0005eo-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 12:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbaCMLXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 07:23:03 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:51878 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbaCMLXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 07:23:02 -0400
Received: by mail-qa0-f42.google.com with SMTP id k15so839248qaq.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oMonaLOwWdQMGXRUDOlTo0SkxasLqCg/Gsqhi8hHNtI=;
        b=LnWExA0JU52dcIaiKx9gvLb0gKSONTGlm2k/sT+MRmhkWsaT7qXYqLH2QqSPAO5CQl
         RkIwQjRSSJDnpH6fiRKefRrhvLNO0DM2NHrqtTJSXX+XCiAhSfasa9LJ25zS9EuOka+k
         uvS7WLRZe2th6uBqdEg2X+yFXlYs7wdQ1oxpGzspE4aksApGLDsurFNuosGQDzIhQMGd
         Jlm6xLicVBj1DJDf2NNwTISOSEvRo8BcYdgfDSK9AGkq39/MA9bgOrqKAxCsiQBGJdlU
         iyH/t2EbygVWyt4ZLYjOhYGECsOww9qeX24oNHQOxQ8cB0+xaDcsn0wcgnqNmgsUoZ1J
         LEug==
X-Received: by 10.229.176.72 with SMTP id bd8mr1578797qcb.12.1394709781540;
 Thu, 13 Mar 2014 04:23:01 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Thu, 13 Mar 2014 04:22:31 -0700 (PDT)
In-Reply-To: <1394702348-6433-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244028>

On Thu, Mar 13, 2014 at 4:19 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> There is no need to break out the "buf" and "len" members into
> separate temporary variables.  Rename path_buf to path and use
> path.buf and path.len directly.  This makes it easier to reason about
> the data flow in the function.

I wanted to keep changes to minimum when I did that. But I guess it
has its downside as you found out.
-- 
Duy
