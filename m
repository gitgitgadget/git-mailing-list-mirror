From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 06/15] index-helper: add --detach
Date: Mon, 25 Apr 2016 16:53:06 -0400
Organization: Twitter
Message-ID: <1461617586.24444.4.camel@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
	 <1461108489-29376-7-git-send-email-dturner@twopensource.com>
	 <CACsJy8Bcb=-V0wc8En2SCSz8jPefEL4qibxJsLsTB-c94x9y3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:53:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunVQ-0004N6-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 22:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbcDYUxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 16:53:11 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35904 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964963AbcDYUxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 16:53:09 -0400
Received: by mail-qg0-f48.google.com with SMTP id d90so55137141qgd.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=OzI1C1YTzdO0mklHyK1xJH4sAnZ3PKE15JD9SDRjXDc=;
        b=eWQgj6dI4SOj1Q4/m2Vhql1fV9lLZSQTJplxz34Qii06AmNu42JLOWhLsin+E4+jA9
         0iiIGC5CYDHYsmqSVmf8tpSvmdYmGzVMCmb3IKGU7kG+m+k8YETtf9eoDv74cOOsGFp/
         w0qeXaY99b9h0rCMphNVk3IEijvKmNuJWyYeibHc9bWSqChdD7Au8zq4LME2WW/l7Tpw
         hoiFXytQiWDeOQxSA6BXppIG6VKZi3Ikt8WiYlAWmMFnNKQtMFjnOtolzuZpRiMduK4o
         F6x68OVBns8xOOOblHLCPatYDh/xUo8voIro5hbZWqNwPwWAJZRH9vyUGK5v4q8jdpSF
         RUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=OzI1C1YTzdO0mklHyK1xJH4sAnZ3PKE15JD9SDRjXDc=;
        b=aSX9m4vdxgBOwMlQr/P7hOYiXChC613NLjGTyMAdsNZZ1np5feP6BYGTmpnC78cnB7
         ErP049nQeI8bB0JOjqNEyDiKs2g1EE2h0fVizKSscJiEH1psQDhb8OByNpP2eFaEEQuU
         EUl1EAAKqU6Y8ivCyosErGnLhXCKMVqFXVu1bMxGjmiJP+M25q1AfEhrofAVAhQHEJ05
         HRPgYQNmLTkG9BJmtMAAJUC3CZYqreRHa79osJ24HfB3UnHIKz/UOGAWMNBSZK2jsDbQ
         rwhyYNNUmuipAxyGZKWBfkWw9jhU22LRAjMS19T3EaR/B/ckT0ah+b2eAqaRHbA6TMqF
         RFRA==
X-Gm-Message-State: AOPr4FWEuoZYjszV1qfqX8o/B980/6lYQXZVOwbjLagjecYav8/y89rWIGbD0aEoqW6L1g==
X-Received: by 10.140.29.246 with SMTP id b109mr36354398qgb.2.1461617588545;
        Mon, 25 Apr 2016 13:53:08 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id z141sm7759233qhd.1.2016.04.25.13.53.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 13:53:07 -0700 (PDT)
In-Reply-To: <CACsJy8Bcb=-V0wc8En2SCSz8jPefEL4qibxJsLsTB-c94x9y3Q@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292554>

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

On reflection, I decided not to do a complicated system for replaying
warnings.  Here are my reasons why:

1. A user will not be expecting to see warnings from previous git
commands.  

2. It's not super-important that users see most of these warnings.  GC
is different because it's critical to the health of a repository so it
really matters that users learn about issues.  

3. It involves many complications to the (presently very simple)
protocol. We would need to distinguish between messages, warnings, and
previous-session warnings.

4. There are only a few cases where errors will happen, and none seem
to be exciting to clients.

Instead, I'll just log errors.
