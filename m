From: Ben Tebulin <tebulin@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
 (gitml: message 5 of 20) (gitml: message 6 of 20)
Date: Thu, 08 Aug 2013 16:53:52 +0200
Message-ID: <5203B100.30008@gmail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr> <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>
To: "Thomas Rast - trast@inf.ethz.ch" 
	<gitml.jexpert.04d2cd352a.trast#inf.ethz.ch@ob.0sg.net>
X-From: git-owner@vger.kernel.org Thu Aug 08 16:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7RbJ-0002gh-AE
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 16:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965538Ab3HHOx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 10:53:59 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:54313 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965097Ab3HHOx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 10:53:56 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so2726694wgg.16
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mR0Ksdlxc+bFLvLJAjzG0UQHEgv/Pd8B8JlWvwilcF8=;
        b=lsAYg9aiVylu1csLuyFswc3ka4JJPev0XB10G5XoXA59uMvlLo1ziu7wl20jS29gAZ
         xCP4ZsfwBY/+l5yRFZ7sk2vQ3pHtmf0Jij9pdah6dQGWdR3HrEJgblBWRuAPkCD2IwXw
         XGFDI1Eg/KZj9UNT6waCVMX2Ld8n8Aoip+bqjEGX/+kirhg9wEeZRWX59LOBk0cXxq8c
         nRyxPdAncEnLbLwJlf3McP/grsayVf7orwuWEi4d2MWc4nmDFL9CzWklzICRnO7JxH9q
         fq25ftLOh8JX79cdwQIxpsux8stbEmpo+yqVsKYk+Bh6+/8+xJBk9MlQsEe0HLN2Chgi
         DzfQ==
X-Received: by 10.194.201.168 with SMTP id kb8mr3616808wjc.63.1375973635079;
        Thu, 08 Aug 2013 07:53:55 -0700 (PDT)
Received: from [127.0.0.1] (ulmg-5d845c5c.pool.mediaWays.net. [93.132.92.92])
        by mx.google.com with ESMTPSA id v9sm18373935wiw.8.2013.08.08.07.53.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 07:53:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231891>


Am 08.08.2013 16:20, schrieb Thomas Rast - trast@inf.ethz.ch:
> Can you try to reproduce with a version older than v1.8.3?
> E.g. v1.8.2.3.
> I'm asking because the above points at packed_object_info(), which I
> recently rewrote to be nonrecursive.

It seems to run 'much better' 
  v1.8.2.3 : 3/10 runs do fail
  fb56570  : 9/10 runs do fail

They always fail on a big blob (39MB) as I wrote in my first e-mail:

ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a351f3366008615d2cf8d03ca943978 | wc -c
error: sha1 mismatch 49cdd0b21a351f3366008615d2cf8d03ca943978
fatal: bad object 49cdd0b21a351f3366008615d2cf8d03ca943978
0
ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a351f3366008615d2cf8d03ca943978 | wc -c
39517156


> Also, can you please stop losing the Cc list?  
I'm _very_ sorry for this. I was trying to hide my e-mail 
address from spam robots using spamgourmet.com as remailer.
Unfortunately it breaks CC.  Switching e-mail now.
