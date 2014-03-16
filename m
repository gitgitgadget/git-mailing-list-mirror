From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git sending messages to stderr on MacOS 10.8
Date: Sun, 16 Mar 2014 16:51:28 +0700
Message-ID: <CACsJy8BWG7qwKX0v0tOEoEFrGAXb_PJWzvgQsXxXhsvVypudsA@mail.gmail.com>
References: <CAGMHX_2pdQPbHEkpbtSxnFS+GRn1Uiy8CCK6CPWqhidbE4aSmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Robitaille <thomas.robitaille@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 10:52:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP7jg-0005y3-UM
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 10:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbaCPJwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 05:52:00 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:53854 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaCPJv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 05:51:59 -0400
Received: by mail-qa0-f52.google.com with SMTP id m5so4206913qaj.39
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Lje07mnYDbu+QwPdRds6Czh1ADRSzWtJY9DRhIC/VSQ=;
        b=LCmFLOFsz0dau7/rVChp7EyND3naXzw01xXI6hg9Fxusq25Tl2bwAab2ZDosEyAEy8
         U126wuklUSjCWRgN59fCP8HpZRo3gZdgUyxNjZphFH8OvtmSeRZ9ocq3DRUlaEaYfxMv
         4zlYD3EkvURt++HiqES8BtAfbP9n+834n9Z5jte/huTIVcayFpHM+b7PL3ZGzFggZy7P
         EkV3ukSAQPX+Z6bgg1ZmuBvBhGW+OTvtjaQb4m6e5LFWDcXAGBztszQef21Tub/62yy7
         uWzGDZdCb375efZgtOXRhlptf/pmwkDc/RV7SrZFNK3RPuudr/vltczOVeCTzrnbKIzn
         lBPw==
X-Received: by 10.229.176.72 with SMTP id bd8mr21391016qcb.12.1394963518760;
 Sun, 16 Mar 2014 02:51:58 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Sun, 16 Mar 2014 02:51:28 -0700 (PDT)
In-Reply-To: <CAGMHX_2pdQPbHEkpbtSxnFS+GRn1Uiy8CCK6CPWqhidbE4aSmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244184>

On Sun, Mar 16, 2014 at 4:15 PM, Thomas Robitaille
<thomas.robitaille@gmail.com> wrote:
> I am using git version 1.8.4.2 installed on Mac using MacPorts. When
> e.g. cloning a repository, the cloning message is being sent to
> stderr, but I think it should be sent to stdout:
>
>     In [8]: p = subprocess.Popen('git clone
> git://github.com/embray/astropy'.split(), stdout=subprocess.PIPE,
> stderr=subprocess.PIPE)
>
>     In [9]: p.stdout.read()
>     Out[9]: ''
>
>     In [10]: p.stderr.read()
>     Out[10]: "Cloning into 'astropy'...\n"
>
> Is this expected behavior, or a bug?

It's expected behavior. See 68b939b (clone: send diagnostic messages
to stderr - 2013-09-18) for details.
-- 
Duy
