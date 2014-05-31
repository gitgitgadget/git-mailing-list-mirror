From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: Re: git-multimail: migration: Config is not iterable
Date: Sat, 31 May 2014 19:21:50 +0400
Message-ID: <20140531151931.GJ27473@azat>
References: <20140529142208.GB27005@azat>
 <5389EE61.9060108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat May 31 17:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wql6f-0002zf-Ns
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 17:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbaEaPV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 11:21:58 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:64230 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbaEaPV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 11:21:57 -0400
Received: by mail-la0-f54.google.com with SMTP id pv20so1705461lab.27
        for <git@vger.kernel.org>; Sat, 31 May 2014 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8r7BHYTeNqIveRDsr8CU9gUICInB0t8FidYHLsXePL8=;
        b=xWqCq+MVkYu0bEL+sXG49DwGDjVG9GtlqGCipF2/aVlUQrznCf8RTXmqxiUNo9vskI
         i1UMrbo4Dya53rSVt+iMxxRYz+M62LVV5QcIuTRLu0Y9eexO+1eIp3nMno5BFavT6+KG
         iDWqptSLcBocviiAhlxbe/aLiw0qQ/PYwndDZ/M2loNXQtTHHJjyZcQ7LYVAp9j7t5OP
         4R4oqlOs4wOv6oS5AVBhu74hA4VVpXPd9JN6M8rDLXOdNacBfC/k7VxFXfgV5Gi9wU7w
         T/de18VjNV+NQxXkhA7mlIfzipOQsO0XBezgK25702FWF6f5jT4AIbmLQKXP1Zsgaq5v
         /HqA==
X-Received: by 10.152.4.39 with SMTP id h7mr19103892lah.12.1401549716197;
        Sat, 31 May 2014 08:21:56 -0700 (PDT)
Received: from localhost ([188.134.22.24])
        by mx.google.com with ESMTPSA id s10sm6072637lal.22.2014.05.31.08.21.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 May 2014 08:21:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5389EE61.9060108@alum.mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250512>

On Sat, May 31, 2014 at 04:59:45PM +0200, Michael Haggerty wrote:
> On 05/29/2014 04:22 PM, Azat Khuzhin wrote:
> > Using the latest version of git-multimail there is an issue with
> > migration:
> > 
> > $ ~azat/git-multimail/git-multimail/migrate-mailhook-config --overwrite
> > Traceback (most recent call last):
> >   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 271, in <module>
> >     main(sys.argv[1:])
> >   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 268, in main
> >     migrate_config(strict=options.strict, retain=options.retain, overwrite=options.overwrite)
> >   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 159, in migrate_config
> >     if not _check_old_config_exists(old):
> >   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 66, in _check_old_config_exists
> >     if name in old:
> > TypeError: argument of type 'Config' is not iterable
> > 
> > Tested on 2.6 and 2.7 python versions.
> > 
> > If you revert 09d0d5b92203f019763e43cef1e57f76f117d2b4 ("Get Python files to
> > pass pep8's tests.") there issue goes away. I understand that this is not the
> > right solution and I'm not the guru of python, so just let you know.
> 
> Thanks for the bug report and for narrowing it down to the broken
> commit.  I just pushed a fix to GitHub.  Let me know if it works for you
> now.

Yeah, it works, thanks!

-- 
Respectfully
Azat Khuzhin
