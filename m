From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Unable to shrink repository size
Date: Thu, 6 Mar 2014 19:56:32 +0700
Message-ID: <CACsJy8AcQAYVTOr5u-VFJ4VkOGNMuOK39gJc-EPZvK+W0OFYsw@mail.gmail.com>
References: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 13:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLXrJ-0007iG-0m
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 13:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbaCFM5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 07:57:04 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:54176 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaCFM5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 07:57:03 -0500
Received: by mail-qg0-f51.google.com with SMTP id q108so7073203qgd.10
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 04:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=R5M7sXHllRdzNAnBw5NtmLGv8jyjUOMM9kLVcnAGUWo=;
        b=KZ+OCMn3xZuY+7EbxL8vNMx4ADo4SKvB1xmpwi8CmqzS9GXRhLmVtgZJ5IQz4Gzqhr
         309eLmAUpYL0H1neg6oWgZzEqmz3joHdR/30oEZ6liRivrHDOFoMt+7CA2KUezZYtcjo
         q39pFEKa3TrPdCFgvKQFKsaaK5Ds4bvXggCWRgL8li0bVxMk6sKJrFgDHvqBQClZjuck
         bGYFjikhykv+sbDHVD1G8PWqLONg+3dQy8+nz0v/Z0MAQvOW+vQKjC/Izo5F7YaVQD1i
         hTBe6D22aaWyGzNspTWbkItoNJEUQ1lZstfuXPrLsLy7pChD2rXVegmNfrEWaLmXqXXZ
         Fc6g==
X-Received: by 10.140.84.40 with SMTP id k37mr13023261qgd.98.1394110622083;
 Thu, 06 Mar 2014 04:57:02 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Mar 2014 04:56:32 -0800 (PST)
In-Reply-To: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243510>

On Thu, Mar 6, 2014 at 9:55 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> What I'd like to do is somehow hunt down the largest commit (*not*
> blob) in the entire history of the repository to hopefully find out
> where huge directories have been checked in.

Another try

git rev-list --all|while read i;do echo -n "$i "; git ls-tree -lr
$i|awk '{a+=$4;} END {print a;}';done

You may need to feed it to gnuplot or something to see steep slopes.
-- 
Duy
