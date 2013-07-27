From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 18:48:38 +0700
Message-ID: <CACsJy8B24FL8OriirWnxDb7rGJorn357rnqf709rOUDTdfUGCw@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 13:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V32zq-000584-KQ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 13:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab3G0LtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 07:49:11 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37594 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab3G0LtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 07:49:09 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so9615640oag.19
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LYggWm582O9bbKUA57hz9tipoCGCf4G8+3tNznV5dMs=;
        b=XOcXVjtWPZC1COccR0iDGfuokcOTF7uNeWFr9LbqG9pCYHRV75O16ZPh9hOCqTFXdg
         QK+SD2vddqOPSQdafLY8duQKcg+PbWwGlIzNUZnjmu1aiflIYF8KF/eSGTH0R+yQ8Zg7
         bhWG+FXW1T5rLjBurG9yI6R6v6NBBHdfNjJe5CLpGe0+nEl5cOXFZwAh/UGkNMZTM7eX
         5nr4CNSZ/yruLRhbDhf8YSjYk8tF86iedbu2lcJkV3Euwc/4Ls8gNmBaRU/EXRwosbI+
         wJwEkZYP9YCEOfEDOyYmlOO/pi/S3W8UmBipRd3teig7h+At3yH8dD58wDLTsg7HVitf
         d3Gw==
X-Received: by 10.60.78.228 with SMTP id e4mr14656774oex.89.1374925748377;
 Sat, 27 Jul 2013 04:49:08 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Sat, 27 Jul 2013 04:48:38 -0700 (PDT)
In-Reply-To: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231238>

On Sat, Jul 27, 2013 at 6:10 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> I tried looking through the logs to see what has changed in
> path.c/environment.c, but have come up with nothing so far.  I think
> I'll have to resort to using a hammer like bisect now.
>
> *scratches head*

Try bisect with GIT_TRACE_SETUP=2 and watch "setup: git_dir: " line.
Although $GIT_DIR can be relative and so can git_path(), there may be
something else that leads to wrong result path.
-- 
Duy
