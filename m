From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: `git log relative_path_to_object` does not respect the
 --work-tree path
Date: Mon, 29 Sep 2014 13:56:12 -0700
Message-ID: <20140929205612.GQ1175@google.com>
References: <CABj5xzc0bVfyzR5PD5K3STSvdvWEOYeMkayB=GTfKbfij+G5Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 22:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYhzc-0007CL-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 22:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbaI2U4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 16:56:18 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:53170 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbaI2U4P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 16:56:15 -0400
Received: by mail-pd0-f173.google.com with SMTP id g10so497837pdj.18
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Et/fIMscBz7ZCKM1/w4VLsYpsJ/Jlcac9uW5GRohvx0=;
        b=gJRT4BqaNv/hXgOxY/S/1IppK/r7kBQDuAuI+qWjnD3wFwkStVQfuM/dntVuOEhptB
         dxyfG5q40krJ72ZN8gwc5qgTzzuWF2RApovn1QoBj+pGcmyl8Op+8Ens2m7pAbWC1/+t
         MFtIsM6/qsnyg+iY78cY+dVpH7nfmJsnUicwLxmujJt5daNlwfGMqtMsGqDiPSUKtv3K
         QlFL7Ywn2MsW/6qz6GsRR4dy1M+84qKtOMzpkOwQrNWyoG1QCBFFNCp9Tik8PQeDAwdR
         scXq9bIhInf06bkXjV+4UOaryFoIsmdNtGmUnZ56CzOJw1ImUDA9X47ePW9UuqpN443d
         tv0Q==
X-Received: by 10.66.141.77 with SMTP id rm13mr52434949pab.91.1412024175052;
        Mon, 29 Sep 2014 13:56:15 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id wi10sm13103875pbc.95.2014.09.29.13.56.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Sep 2014 13:56:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABj5xzc0bVfyzR5PD5K3STSvdvWEOYeMkayB=GTfKbfij+G5Zw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257640>

Hi Roberto,

Roberto Eduardo Decurnex Gorosito wrote:

> When passing objects to the `git log`, by just naming them or using
> the `--objects` option, relative paths are evaluated using the current
> working directory instead of the current working tree path.

Why should they be relative to the worktree root?  When you use
relative paths within a worktree, they are not relative to the
worktree root.  For example, the following works within a clone of
git.git:

	$ cd Documentation
	$ git log git.txt

You might be looking for 'git -C <directory>', which chdirs to the
named directory so paths are relative to there.

Hope that helps,
Jonathan
