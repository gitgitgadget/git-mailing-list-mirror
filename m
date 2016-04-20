From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 06/15] index-helper: add --detach
Date: Tue, 19 Apr 2016 21:04:27 -0400
Organization: Twitter
Message-ID: <1461114267.5540.161.camel@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
	 <1461108489-29376-7-git-send-email-dturner@twopensource.com>
	 <CACsJy8Bcb=-V0wc8En2SCSz8jPefEL4qibxJsLsTB-c94x9y3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 03:04:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asgZG-0007DF-7y
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 03:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbcDTBEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 21:04:30 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34510 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbcDTBE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 21:04:29 -0400
Received: by mail-qk0-f178.google.com with SMTP id r184so10185588qkc.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=GqKHu3I8/fgtPpqAV3Y9O8D2WJsKZ6m83M/TW3iFMqs=;
        b=bpu0w58eapgNKdaM/xaZZ61JkhIEoVe9bMFUnpI+bBxXkic2/Fg6JGqCOeEh7+StyP
         X9VKjRGDzUw4UV+f4lG/kgavPkB/V1ylMoQnj07Sz0De+APp4H+5FMLt1Zsf2wV8NnlJ
         I7JhQwdlHtPAU/ruo4zq30qzTbukIU8ZcoHpX5eYd1lrZg9R09/EQy1NFof/2HpnhmMI
         KpPKrB4WB07JBas6AIdz94/JCGRsk4/x5M10f4LxWkndcryms8D358y2g2RIbTSjWpBR
         aW6dlKjOABR53rGvKRrsD+X3bxpf5bhSkkWmxnAKecqD90ym2O1DaBSSCgko9BtlYPgo
         3/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=GqKHu3I8/fgtPpqAV3Y9O8D2WJsKZ6m83M/TW3iFMqs=;
        b=ThSCLSm75xHr4+tp7B5wPZ9Q08MxoJHi6lxCUH8CaFvGsZw8/Ll4m84cT+pbw9bOPN
         pQJL/cEYPIsEn64Ue907YLd9kj6/AfnDWivJrYyXYcYoEHnK6Y4fBlEAxwyVYcv1BC/X
         oQ+tYsMzCoSiyUlQp3CBpCWoTbUOetUSqPU+4U3sSbPb3JErer26bdTk6BcXowBUqZdS
         ggUF/vgq6VhLYgOuOGDKmFc0paj44ZYD9Xvkjv+RQPdpD6ipO19iqWKXSJnsMaJme+vB
         9N4HYRw5AfQAONhYxJxZgxOFu23WjVBYW2YQ2Ca3k20qQBgZ96/FJvKmhXrdDfybd6ur
         pFSQ==
X-Gm-Message-State: AOPr4FU3e4MMPVzhl41pGj2+xNb5t6j0YUcgc+7Ve8BPjP+NXERTNChMJSaAL8+38OrT1Q==
X-Received: by 10.55.75.14 with SMTP id y14mr7863658qka.33.1461114268968;
        Tue, 19 Apr 2016 18:04:28 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w188sm21453874qhb.9.2016.04.19.18.04.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 18:04:28 -0700 (PDT)
In-Reply-To: <CACsJy8Bcb=-V0wc8En2SCSz8jPefEL4qibxJsLsTB-c94x9y3Q@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291976>

On Wed, 2016-04-20 at 06:50 +0700, Duy Nguyen wrote:
> On Wed, Apr 20, 2016 at 6:28 AM, David Turner <
> dturner@twopensource.com> wrote:
> > @@ -317,6 +320,8 @@ int main(int argc, char **argv)
> >         if (fd < 0)
> >                 die_errno(_("could not set up index-helper
> > socket"));
> > 
> > +       if (detach && daemonize(&daemonized))
> > +               die_errno(_("unable to detach"));
> 
> At the least, I think we need to redirect both stdout and stderr to a
> file, so we can catch errors. The watchman patch uses warning() to
> report errors, for example. And there is always a chance of die().
> 
> Then we need to report the errors back. I faced the same problem with
> daemonizing git-gc, but I'm not sure if we can do exactly the same
> here like in commit 329e6e8 (gc: save log from daemonized gc --auto
> and print it next time - 2015-09-19)

I'll add in code to log errors.  I'm not sure where it would make sense
to report the errors.  Generally, for errors during a client operation,
we would like to report them to the client, but the client might have
already disconnected.  I guess in that case it's OK if they just go to
the log?  The client could warn on a timeout while waiting for index
-helper and direct people to the log.
