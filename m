From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: re[6]: sparse checkout file with windows line endings doesn't work
Date: Fri, 20 Sep 2013 09:28:39 +0700
Message-ID: <CACsJy8AzrSPqcXhcLV_q6J-+qZaQMPFfO6eq6C=HvdvcXw+eSw@mail.gmail.com>
References: <CACsJy8BeT7ZP+ZQah7FR6ogqRNiiDZYP5SEs8J6J=+gEHU5MUg@mail.gmail.com>
 <SDZYTDk4NyMxKC4hPVQvMjM1MDUxNjg3@IBMLT4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 20 04:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMqT6-00088A-9A
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 04:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab3ITC3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 22:29:12 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:41570 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab3ITC3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 22:29:11 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so10566989obc.20
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 19:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZYTkcAoaaiKdUWcuxcm4sj4dW4ZCNNCJ1PY58NZfe3c=;
        b=GuC36P9qUhMeSee9hxaIztrk4LY2YVUYWEGbdq0p/OuT1MlAgh9+EdMZBK1dBGkWh1
         cwN/NSqr5N8ekqldezjWj/i9NwB1IMRJiPHf+E+OAb1pmuBNNXjC5DdRPyVmsmLLU3Vr
         0RpD+l2u3qY3VWFa22j2PwK9yWZ3xnX2GwJHijkOh+fTyPdscherFry9rR3EPykJEq6D
         HnGiXY/zspVYwqA4hm8Y0tiPrFa9LigY+OInaN89XLxy5a1t4nwtH+XAWILZaxaL01sh
         AaWuXxWnpQii1qsWvLHK/IuUvXyYT6fx1gh3LaDIbKCVr+JUn1/A1pGRUdD0zZYBXWJf
         5azw==
X-Received: by 10.60.51.196 with SMTP id m4mr3809838oeo.1.1379644150264; Thu,
 19 Sep 2013 19:29:10 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Thu, 19 Sep 2013 19:28:39 -0700 (PDT)
In-Reply-To: <SDZYTDk4NyMxKC4hPVQvMjM1MDUxNjg3@IBMLT4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235046>

On Fri, Sep 20, 2013 at 8:52 AM, Martin Gregory
<marting@adelaideinterim.com.au> wrote:
> Something that would help is an easier way to debug sparse-checkout rules.
>
> When something goes wrong, there appears to be no way to understand what
> git thinks it's reading.   I'm not sure if such a way, if it existed, would help with
> trailing spaces, but if you could say
>
> git read-tree -muv HEAD
>
> and it would say
>
> reading '.git\info\sparse-checkout'...
> rule '/CONFIGURATION ' - no matches
>
> that would solve actually two problems:
>
> 1) You can see that it thinks there is a space there
>
> 2) the config file name is sparse-checkout, with a dash, not sparsecheckout...
> a mistake I made that had me scratching my head for some time, since everywhere
> else it doesn't have a dash!

"git check-ignore" is the closet one to this. Remember sparse-checkout
and .gitignore share the same syntax, you could feed sparse-checkout
file to check-ignore. You (or somebody else) may need to improve
check-ignore a bit, though, to show the quotes because I don't think
it does now.
-- 
Duy
