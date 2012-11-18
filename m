From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Sun, 18 Nov 2012 16:12:06 +0530
Message-ID: <CAMK1S_hCk3QdDn8XnXVisL1i2V0iPCZBYN989JmZ3JYr7ckRrA@mail.gmail.com>
References: <50A622A9.4040709@drmicha.warpmail.net>
	<ccb8680a-97ad-4cf8-95d0-5e21f60494f4@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Javier Domingo <javierdo1@gmail.com>, git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sun Nov 18 11:42:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2Kd-0007Cn-7U
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab2KRKmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:42:09 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:62972 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2KRKmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:42:08 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so480433lag.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0baCGVktpecSiIuw+ht3KILv6TOE2NxA9T8/yKeCo1A=;
        b=tgg+cDZkJEueuVHFE6V5/UnUOamQF+RaPW/LusqfWs0A8i2ZfRjV6c9hkzskiF7V6P
         KdSnCx/MFaN+EYAbun6/TaAUjxgXdySpkiGeaT3OZlOR2EfAwHg7A2a6EeBQ10NI6QbV
         fwca8iiUlFzlI78xARDGYaaYO8xwYyYxcfNqyJXQmIgwlSlE3GB3Qk+7HZLaeVxR7GM/
         eJV/0dTUH9mFteErrLOEzjclEC5pr6Rvb60mC0YdsLFqsYbPJFx5Kmo1MN69/mue1Djb
         zhIRAzGBk7a6466qS031vxHwOJXVgWxcKpEZmpi3IqcU0ckcAgz6dCdZvRUKCDSY2rQT
         zpRg==
Received: by 10.152.110.42 with SMTP id hx10mr8907301lab.0.1353235326994; Sun,
 18 Nov 2012 02:42:06 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Sun, 18 Nov 2012 02:42:06 -0800 (PST)
In-Reply-To: <ccb8680a-97ad-4cf8-95d0-5e21f60494f4@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210004>

On Fri, Nov 16, 2012 at 11:34 PM, Enrico Weigelt <enrico.weigelt@vnc.biz> wrote:
>
>> Provide one "main" clone which is bare, pulls automatically, and is
>> there to stay (no pruning), so that all others can use that as a
>> reliable alternates source.
>
> The problem here, IMHO, is the assumption, that the main repo will
> never be cleaned up. But what to do if you dont wanna let it grow
> forever ?

That's not the only problem.  I believe you only get the savings when
the main repo gets the commits first.  Which is probably ok most of
the time but it's worth mentioning.

>
> hmm, distributed GC is a tricky problem.

Except for one little issue (see other thread, subject line "cloning a
namespace downloads all the objects"), namespaces appear to do
everything we want in terms of the typical use cases for alternates,
and/or 'git clone -l', at least on the server side.
