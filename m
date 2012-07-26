From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 09:54:26 -0500
Message-ID: <20120726145426.GB3058@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <358E6F1E-8BAD-4F82-B270-0233AB86EF66@gmail.com>
 <20120726114039.GA6712@burratino>
 <1486896.KW3TvzfC56@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Michalske <smichalske@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:54:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuPSX-0002ku-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 16:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab2GZOyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 10:54:32 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46850 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab2GZOyb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 10:54:31 -0400
Received: by gglu4 with SMTP id u4so2028825ggl.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vIMfODph64WAEdRdaWQtamv4taQ/taED43H5W42cwSw=;
        b=MTz6cI2oiHikTvfVKevT4nO4Rqn+Jh7bVzl8Ae1UtswHaUm2D2GKSNnjZwa7ig4p0+
         X3lUkajhzyyGUZpcQ5AXFAtM20w2WaQF1jF8D2/HofqVBE7ZftLhPHJAiDGZKCltOYsF
         MUQyZ1x0Uhp4MnIqK5Q9qhCBg98y1xJQ3MRED3JBWyqDMLHacGXGjBm44cpa/XqTT1ih
         g3A25KeUVxXow/diMwA1/UpBpqOYdgq3GFOMa5A8p4OsYIZttqVNp6va4OgielmNr0Fd
         5dIo3WYwQKefUjnSPZT7lKZh9GhWlKQ+ySB7Qb+5UVGCyBrnXg8IRjoxBt2cmMKgZPhd
         OiHQ==
Received: by 10.50.187.226 with SMTP id fv2mr1882873igc.47.1343314470381;
        Thu, 26 Jul 2012 07:54:30 -0700 (PDT)
Received: from burratino (guardian2.ccc.edu. [216.125.49.252])
        by mx.google.com with ESMTPS id ch4sm3563689igb.2.2012.07.26.07.54.29
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 07:54:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1486896.KW3TvzfC56@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202270>

(cc-ing Ram since he's also knowledgeable about remote-helper protocol)
Florian Achleitner wrote:
> On Thursday 26 July 2012 06:40:39 Jonathan Nieder wrote:

>>                                                     Though I still
>> think the way forward is to keep using plain pipes internally for now
>> and to make the bidirectional communication optional, since it
>> wouldn't close any doors to whatever is most convenient on each
>> platform.  Hopefully I'll hear more from Florian about this in time.
>
> Would you like to see a new pipe patch?

Since the svn remote helper relies on this, it seems worth working on,
yeah.  As for how to spend your time (and whether to beg someone else
to work on it instead :)): I'm not sure what's on your plate or where
you are with respect to the original plan for the summer at the
moment, so it would be hard for me to give useful advice about how to
balance things.

What did you think of the suggestion of adding a new bidi-import
capability and command to the remote helper protocol?  I think this
would be clean and avoid causing a regression on Windows, but it's
easily possible I am missing something fundamental.

Thanks,
Jonathan
