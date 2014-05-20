From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t6006-*.sh: Fix truncation tests
Date: Tue, 20 May 2014 20:02:13 +0400
Message-ID: <20140520160213.GA2947@ashu.dyn1.rarus.ru>
References: <537B5E8C.3070803@ramsay1.demon.co.uk>
 <20140520141936.GA30187@ashu.dyn1.rarus.ru>
 <537B6E42.8040308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 20 18:02:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmmUl-0002iU-Qr
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 18:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbaETQCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 12:02:23 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:57714 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbaETQCW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 12:02:22 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so584987lab.2
        for <git@vger.kernel.org>; Tue, 20 May 2014 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WEFRGkEtrnLQJZQ2jyRf0UAo1JYUJGobNLnYUKh23Rg=;
        b=lJPZ4uyQjgwdIpFHdy1oGZstT+LPHqqpyOcln08Xnm2Q0SK4Uysv8XgG8anz8lMEEK
         RI2MOL+pqm/1AimaJiKROB3Ni1rqXi5NBRPBSSwj6pv1v8KfhxPL/Yfsvyo5SBuy5Rmr
         D0LBsf/VdGjJ3b6SKSozucw2v+XHtch2TFt6ZekFmTZNThTb7Tpn9jqUGn1eHkz+MwdU
         hKWKbZXFBQhDQDR0rJEmpsV2NR/fKiKwwuhx8W8GJnB5HxciZ4hbfeO4iz3xJvkY/h64
         CzAaT7PbP3fxw+h6F4wJYG80VOql9v+paxzMMFdbbiXjqMbgRRYmjZ1bnadGHbAYAtu/
         YSUg==
X-Received: by 10.112.41.227 with SMTP id i3mr30879621lbl.41.1400601741248;
        Tue, 20 May 2014 09:02:21 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id ob4sm21181937lbc.30.2014.05.20.09.02.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 09:02:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537B6E42.8040308@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249696>

On Tue, May 20, 2014 at 04:01:22PM +0100, Ramsay Jones wrote:
> On 20/05/14 15:19, Alexey Shumkin wrote:
> > On Tue, May 20, 2014 at 02:54:20PM +0100, Ramsay Jones wrote:
> >>
> >> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> >> ---
> >>
> >> Hi Alexey,
> >>
> >> If you need to re-roll your 'as/pretty-truncate' branch, could
> >> you please squash the relevant parts of this patch into the
> >> corresponding patches of your patch series. (ie this is a patch
> >> against the head of the current pu branch ...).
> >>
> >> Without this patch I get:
> >>
> >>   $ ./t6006-rev-list-format.sh
> >>   ok 1 - setup
> >>   ok 2 - format percent
> >>   ok 3 - format hash
> >>   ok 4 - format tree
> >>   ok 5 - format parents
> >>   ok 6 - format author
> >>   ok 7 - format committer
> >>   ok 8 - format encoding
> >>   ok 9 - format subject
> >>   ./t6006-rev-list-format.sh: 152: ./t6006-rev-list-format.sh: Syntax error: "(" unexpected
> >>   FATAL: Unexpected exit with code 2
> >>   $ 
> > Ooops, my fault.
> >>
> >> (if you have bash as /bin/sh you get different but related errors).
> >> The additional quoting suppresses the 'command redirection' errors, etc...
> > It's strange but I do have Bash as /bin/sh and unfortunately I have no
> > this error
> 
> Hmm, I see this:
> 
>   $ bash t6006-rev-list-format.sh -i
AFAIK, this is not "running Bash as /bin/sh" :)
Maybe I'm wrong but Bash as /bin/sh is:
  $ ls -l /bin/sh
  lrwxrwxrwx 1 root root 4 May 12 18:35 /bin/sh -> bash

But it does not matter here much, you've noticed my foolish mistake :)
>   ok 1 - setup
>   ok 2 - format percent
>   ok 3 - format hash
>   ok 4 - format tree
>   ok 5 - format parents
>   ok 6 - format author
>   ok 7 - format committer
>   ok 8 - format encoding
>   ok 9 - format subject
>   t6006-rev-list-format.sh: line 152: 20,trunc: command not found
>   not ok 10 - format subject-truncated
>   #	
>   #			git rev-list --pretty=format:'%/dev/fd/63%s' master >output.subject-truncated &&
>   #			test_cmp expect.subject-truncated output.subject-truncated
>   #		
>   $ 
> 
> (Since I'm on Linux Mint, my /bin/sh is dash, which produces the output in my previous mail).
> 
> ATB,
> Ramsay Jones
> 
> 
> 
