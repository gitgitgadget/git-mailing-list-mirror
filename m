From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Should branches be objects?
Date: Thu, 19 Jun 2014 16:46:14 -0700
Message-ID: <20140619234614.GY8557@google.com>
References: <CAK3OfOiB0YWf25Hvvvqi+YBwu2V-gE-sjm7XrfE0p2zds4CE2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:46:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxm29-0007IH-Kb
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 01:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966274AbaFSXqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 19:46:18 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39967 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965771AbaFSXqR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 19:46:17 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so2415662pab.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DeONNZgQMPWUI51EbwZ693TJUGayHNJvPxOEESxkhok=;
        b=BygUR0u5d5bj1Pvl0+ssVAAh96t0jfCJ22wC5EAw4RaugjksOUHjT/Pbv+2VUw1N57
         mQ44CrO670VsEqxqjefHp6aYbUtfFjieNIYXM6TUcVrpF4m4y/G1dIQFIcfkDB4pUK1B
         qarJ2fLra1t/8DJG3NHfDEidOEs81IAjUdZm5/xumhrd77Qw4JP5JV9Th5st69Z5WpMp
         flJKDT7tfBctuOQFcPNDjRHzoWIRld+16iDbBtDq6VdqP/+P05N7hRswU1nvsNWCERCx
         z5yLgZ7VIsevcMuUz8W/fv6wfeD7R8AXKOQ0RB7swnjr+582hMf9BOQheJHoEZV1l2+n
         mKJg==
X-Received: by 10.66.146.105 with SMTP id tb9mr82072pab.157.1403221576807;
        Thu, 19 Jun 2014 16:46:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xh10sm33725029pac.24.2014.06.19.16.46.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Jun 2014 16:46:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK3OfOiB0YWf25Hvvvqi+YBwu2V-gE-sjm7XrfE0p2zds4CE2Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252198>

Hi,

Nico Williams wrote:

>  - one could see the history of branches, including

Interesting.  'git log -g' is good for getting that information
locally, but the protocol doesn't have a way to get it from a remote
server so you have to ssh in.  Ronnie (cc-ed) and I were talking
recently about whether it would make sense to update git protocol to
have a way to get at the remote reflogs more easily --- would that be
useful to you?

>  - how commits were grouped when pushed/pulled (push 5 commits, and
> the branch object will record that its head moved by those five
> commits at once)

The reflog on the server (if enabled) records this.

>  - rebase history (git log <branch-object> -> better than git reflog!)

The local reflog ('git log -g <branch>') records this.

>  - object transactional APIs would be used to update branches

Ronnie's recent ref-transaction code does this.

Thanks and hope that helps,
Jonathan
