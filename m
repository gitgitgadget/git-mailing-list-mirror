From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Fri, 21 Mar 2014 08:51:18 +0700
Message-ID: <CACsJy8AYs0-rmGZz2_KEkT2ibW-sTpm=Q9FxFhNGRYd2b6R+sA@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
 <532AF304.7040301@gmail.com> <CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 02:51:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQock-0001Y2-SO
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 02:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933906AbaCUBvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 21:51:50 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:43784 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422AbaCUBvt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 21:51:49 -0400
Received: by mail-qg0-f49.google.com with SMTP id z60so5163494qgd.8
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rrkJv2ffEKk4JAdWjTvyFGdhEi3RKcPij2AoHbgrDko=;
        b=RUKW/cWLkS0RyLhA+HimMs3VZqzwHN/WHjllg+ri5h8K+f6wpZdkEgpHhgrmmNJ0ts
         f7QJZmaLwxKODXLoGl0Fz7pygvmywOu/f2kctNPGpLu1Izrl7vLUkWrokmcCpWm52hId
         Jyl6uLu55vkd7jdxLu1Cedzudg15+md+HMZko6FzxyIxGR2Kt4X3YRffHHTOuL/XLuVx
         yAPJeo+jNzwp7AYc907NSdZIJHCIuyGUrvfDcSyuMSAr+KqI/19d89NhIIDJydmqBGFS
         itH3KZm43tSLM02wnlEw95XNUVWF8JZuK+aubRH7ZKuG6DN/B9v3e5RFfGMR9VhCuJob
         5aMQ==
X-Received: by 10.140.41.134 with SMTP id z6mr62815qgz.112.1395366708942; Thu,
 20 Mar 2014 18:51:48 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Thu, 20 Mar 2014 18:51:18 -0700 (PDT)
In-Reply-To: <CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244628>

On Thu, Mar 20, 2014 at 11:08 PM, Stefan Zager <szager@chromium.org> wrote:
> Duy, would you like to re-post your patch without the new pread implementation?

I will but let me try out the sliding window idea first. My quick
tests on git.git show me we may only need 21k mmap instead of 177k
pread. That hints some potential performance improvement.
-- 
Duy
