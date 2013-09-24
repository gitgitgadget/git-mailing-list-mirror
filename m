From: Benoit Person <benoit.person@gmail.com>
Subject: Re: [PATCH v2] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Tue, 24 Sep 2013 10:05:34 +0200
Message-ID: <CAETqRCjo3_nr0+Jh_0XTPZysfzhtGaeFMGswog--Era31jQo1Q@mail.gmail.com>
References: <1379957175-8606-1-git-send-email-benoit.person@gmail.fr>
	<CAPig+cSVeJX2wHo7TTJe2oa+_pD7EPdmMo_BGO_Bj-ZKgRD6wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 24 10:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VONct-0006gk-3u
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 10:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab3IXIFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 04:05:37 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38722 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab3IXIFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 04:05:35 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so3429988wib.12
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QLFlnAiPPiuxkR4FG0xV74q0x6A/AopKKHS+EnH5AY8=;
        b=REZZkXPc3x82jTioa44id2I89vDjDJ8jgBJzDI/tCgwJFya7ENG7ABAESl+cR9NmOa
         dOHU8QtKT+vQ6QObv1+l8hXpy9OQXW6p5bwRPKL2lxTTvk0KGPxGitsFvOeO0mGmkrCJ
         F+xTRKfTfnQypLfYabCCFghbsjZa2L+ht3WEvI1g1UNTaqwW1BFcH/Li6nWcef9eE/iC
         b7yLnGtwV6jGYf7HkjsfF/KEp0R2eT+Pm9QV7gkVRL6ai90y8fP7rE4BkL5N4ORVGtHG
         pdnoCaQXYfX6Lxg3m9QG/NhtQdvdusO5D9VZNHHW6CeqrlLompnFjqiQjKryDizf9fXY
         wi2w==
X-Received: by 10.180.187.2 with SMTP id fo2mr16810966wic.65.1380009934127;
 Tue, 24 Sep 2013 01:05:34 -0700 (PDT)
Received: by 10.216.245.195 with HTTP; Tue, 24 Sep 2013 01:05:34 -0700 (PDT)
In-Reply-To: <CAPig+cSVeJX2wHo7TTJe2oa+_pD7EPdmMo_BGO_Bj-ZKgRD6wA@mail.gmail.com>
X-Google-Sender-Auth: 0ntBHsDm3UwjWTbkbGu13MI5F0s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235284>

On 23 September 2013 19:58, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> I'd rather have the comments say "# API version < X" and "# API version
>>= X". Next time the API change, "new" Vs "old" will become meaningless.
done, thanks


On 23 September 2013 20:26, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Some distros (e.g., Debian) occasionally do run the testsuite
> automatically, but it is still fine since they have a timeout that
> varies by platform to detect if the test has stalled.  I suppose
> ideally git's test harness could learn to do the same thing some day,
> but for now it's easier one level above since an appropriate timeout
> depends on the speed on the platform, what else is creating load on
> the test machine, and other factors that are probably not easy for us
> to guess.
great explanation, thanks


On 23 September 2013 22:17, Eric Sunshine <sunshine@sunshineco.com> wrote:
> s/seq/test_seq/
done, thanks

> d17cf5f3a32f07bf (tests: Introduce test_seq;  2012-08-03)
>
>> +       do
>> +               echo "creating revision $i"
>
> Do you want to end this line with '&&'?
The way it's intended is that it's more a debug information to see how
it's going on (creating >500 revs is *quite* long). If I understand it
correctly, using '&&' would mean that the return value of the echo
statement will be tested for success ? Anyway, I am not sure it makes
sense to fail on a "debug echo" ?

-- 
Benoit Person
