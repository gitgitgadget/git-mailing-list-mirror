From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] dir: test_one_path: fix inconsistent behavior due to
 missing '/'
Date: Sat, 24 Aug 2013 23:00:45 -0700
Message-ID: <20130825060045.GP2882@elie.Belkin>
References: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
 <1377232155-7300-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 08:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDTNe-0004aS-J3
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 08:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab3HYGAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 02:00:51 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64088 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab3HYGAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 02:00:50 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so2201550pbc.22
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8So4sNeScOZ4f5BYgkKP1NhB3NyDZkejnnpW7drqGrg=;
        b=tN3Hvsi1nEFEUUrjVNKJj9ERkdu1zKIHb/K3JqYjeX0cfG56NkJepcy86psAiUeezx
         /bZAE4wPODY5yN9+7a7mDqkOvqd4RyV15TdWneWWyQQ6CK8BoSDq6m694mRhBRJVJGfs
         IAMZ0Z8WeTAKUkshuoG+GsR/lfMhZJXps19qjkEGE3bEaeD76B9pU8XIDRzv/X/seIl0
         GCldRub9YHFwW8wXfAZJPciIyqP/TZQcsoHAI10jnMj0R+RgoGNP6zGYqNZdOW9HRUMz
         quzdvTLLCZzfA10Svfe7JlWLTGO9W5tYNDDZZJ6gTb8K1gPT5wYJqnqLWB6AWj9NH67H
         xBFA==
X-Received: by 10.68.164.33 with SMTP id yn1mr8448048pbb.102.1377410450049;
        Sat, 24 Aug 2013 23:00:50 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id om2sm9970763pbb.34.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 23:00:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377232155-7300-3-git-send-email-sunshine@sunshineco.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232927>

Eric Sunshine wrote:

> Although undocumented, directory_exists_in_index_icase(dirname,len)
> unconditionally assumes the presence of a '/' at dirname[len] (despite
> being past the end-of-string). Callers are expected to respect
[...]
>                                                Fix this problem.

So, does this fix the problem by changing
directory_exists_in_index_icase() to be more liberal in what it
accepts, or callers to be more conservative in what they pass in?

Please forgive my laziness.  I ask in order to save future readers the
time of digging into the code.

Thanks,
Jonathan
