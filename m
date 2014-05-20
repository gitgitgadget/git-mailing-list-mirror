From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests
Date: Tue, 20 May 2014 15:44:27 -0700
Message-ID: <20140520224427.GU12314@google.com>
References: <537BC8A2.9060009@ramsay1.demon.co.uk>
 <20140520214006.GT12314@google.com>
 <537BD514.4040708@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed May 21 00:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmslw-0003hA-7E
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 00:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbaETWob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 18:44:31 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:51000 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbaETWob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 18:44:31 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so742951pbc.24
        for <git@vger.kernel.org>; Tue, 20 May 2014 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8Z73Rf6UsdZezB2oo7EARgz8FyKBA2ttLxd/Ak34d7I=;
        b=fjVWD4bTe7q0QX4w4ZfUorGj463I8K3qs751+1INocDcf9uI+E3ELxZsGUHh/CLUgz
         S5sy18sMYVoMVHs78j6Rjl1WHA8LgnEmnNMZZgy13jQirFSKTtqDUlcz3glgE1epEkrJ
         fbRUnwu1yf7kVeBDytPGxP3kTgrPnVWyH3H6N+Zx6AstKZY9Rwc2ZVGfV63f9hNXloAk
         GPJFa/UKjO35tYO43TdDISkv2aSsGxA8YyxGbwM2VRCMpBEzlIk7hqhkOXkyHclm3kiC
         tM/Lki7PxdMGKxNzZGS/6yMgZjgmtK4t0kTAcQ6VRHXHPKArbe3HT336j9IVxs8EaBHx
         lqsw==
X-Received: by 10.68.189.68 with SMTP id gg4mr54085833pbc.42.1400625870591;
        Tue, 20 May 2014 15:44:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id it4sm4855068pbc.39.2014.05.20.15.44.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 15:44:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537BD514.4040708@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249756>

Hi,

Ramsay Jones wrote:
> On 20/05/14 22:40, Jonathan Nieder wrote:

>> What should happen if I have set GIT_SKIP_TESTS explicitly to run
>> only some of the tests in t0000-basic?
>
> A quick test (with the above patch applied) shows that
> it works as I would expect:
>
>   $  GIT_SKIP_TESTS=t0000.1[2-6] ./t0000-basic.sh
>   ...
>   ok 11 - test --verbose
>   ok 12 # skip test --verbose-only (GIT_SKIP_TESTS)
>   ok 13 # skip GIT_SKIP_TESTS (GIT_SKIP_TESTS)
>   ok 14 # skip GIT_SKIP_TESTS several tests (GIT_SKIP_TESTS)
>   ok 15 # skip GIT_SKIP_TESTS sh pattern (GIT_SKIP_TESTS)
>   ok 16 # skip --run basic (GIT_SKIP_TESTS)
>   ok 17 - --run with a range

Try GIT_SKIP_TESTS=t0000.17 ./t0000-basic.sh:

 ok 13 - GIT_SKIP_TESTS
 ok 14 - GIT_SKIP_TESTS several tests
 ok 15 - GIT_SKIP_TESTS sh pattern
 ok 16 - --run basic
 ok 17 - --run with a range

Thanks,
Jonathan
