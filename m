From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Saving space/network on common repos
Date: Mon, 22 Dec 2014 17:33:47 -0800
Message-ID: <20141223013347.GV29365@google.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
 <20141217223215.GO29365@google.com>
 <CAGXKyzEqTik3p=A8NZJ6kUscFjw_Dh1mBPT-ciwq9L8kNKDDig@mail.gmail.com>
 <20141218000723.GP29365@google.com>
 <CAGXKyzGnnt6bBEPoy4nvNn=zX0hdRHpgvsAe263apaDsVxv0dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 02:33:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3EMF-0008Mh-DA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 02:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbaLWBdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 20:33:51 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:51327 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbaLWBdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 20:33:50 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so5113233ieb.7
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 17:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DdU657QymQorVkop3I3ILARXX0fEBq7fgSw0bCm3LD0=;
        b=hqmYeBuASbz9HGc9vP96EVooigRi9KoK2/WFkh4t3ao7vhgb8nMdC8p7rzB+z7TR3Q
         iZznnr/r3phuAm6N/pdoqqK3sazWvxSPghBW93ybAgbxtrDJc1SgyaTvJO0m1H5nl9Zz
         SgfncNUQySbEiVdDMc5YEYRzgH+flcWJ6pdGY3SU+/etrgLbUs+C4y9GYMXOIo5LVChL
         rVbxZFb62XC8oyBbmi6QEXahn4yutD6pZXR4/bJ2qsw3um14qQAnxQ//v8QfIZ+34tY3
         ju/I1S9CFYC3GX3ljv7cqYd41CsfZYJe3k4a8+x2+RvXDRZu9j7Mfd0lb4squx70f6pB
         ay9Q==
X-Received: by 10.107.149.13 with SMTP id x13mr22655066iod.35.1419298430118;
        Mon, 22 Dec 2014 17:33:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d0f3:eebb:4e13:baf])
        by mx.google.com with ESMTPSA id lp4sm1567600igb.6.2014.12.22.17.33.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Dec 2014 17:33:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGXKyzGnnt6bBEPoy4nvNn=zX0hdRHpgvsAe263apaDsVxv0dA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261707>

Craig Silverstein wrote:

> btw, just FYI, the scheme you lay out here doesn't actually work
> as-is.  The problem is the config file, which has an entry like:
>            worktree = ../../../mysubmodule
> This depends on the config file living in
> ./git/modules/mysubmodule/config.  But the proposed scheme moves the
> config file to mysubmodule/.git/config, and the relative path is
> broken.

*puzzled* Can you give a transcript illustrating this happening?

Submodules with .git directory within their worktree or under
.git/modules/ are both supposed to work.  And in either case, having
refs/ and objects/ as symlinks should work fine.  When git new-workdir
creates a new workdir, it has its own new and separate config file, so
I don't think that is the source of trouble.

Thanks,
Jonathan
