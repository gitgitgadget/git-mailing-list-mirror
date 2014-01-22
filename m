From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: libz and RHEL 5.9 compile of Git
Date: Wed, 22 Jan 2014 08:30:07 -0800
Message-ID: <20140122163007.GK18964@google.com>
References: <1390406392415-7602374.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: salmansheikh <salmanisheikh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 17:30:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W60h2-0001KO-6G
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 17:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbaAVQaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 11:30:15 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:36158 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbaAVQaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 11:30:14 -0500
Received: by mail-yh0-f49.google.com with SMTP id b6so211963yha.22
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y9mTufBFIdLCVtEPx7GX/ekj9TcOSiVwWUbj7/naW8U=;
        b=Niriirl0psrWksOUyYh+Gl6aF5BxK0zk5I7CDQ0QTI65x8PTdpV9M3gx2GOGL5Bwi3
         +npQtcl+VzF0YIk3x2ZCGSnMdVBviBsyoa//ppt5XE3bPzyr+oHKYhsXRQwDbVLJTbwA
         ssChJI9nqzLNmWbU4w4Bv3FnQ5eIKpXxgv9kExa+5UAZ3szhZ8Zm2aGVf1tVcLTZFP60
         HlncRrrZYa4iK+5qo4RXFlQncVW0rMF53ZO7034/kONTrQXH0/TVWMKlEaaTX+boOhcQ
         ru0FoDV9yjpIUcxdW8AuvQ0vDLPo2Bxqeijg57e0hxeWK9sYeHwrIpdjhjaIQ7IVF1CW
         n1Ig==
X-Received: by 10.236.204.74 with SMTP id g50mr2109113yho.127.1390408212895;
        Wed, 22 Jan 2014 08:30:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 23sm25655531yhj.5.2014.01.22.08.30.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 08:30:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390406392415-7602374.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240838>

Hi,

salmansheikh wrote:

>                                                                     I
> downloaded and installed the latest libz (1.2.8) but i installed it under a
> local directory under my user name (i.e. /home/ssheikh/local). The problem
> is that git only looks in the locations below. I even have that directory in
> my $LD_LIBRARY_PATH.

Confusingly, LD_LIBRARY_PATH is only used a run-time.  The build time
library path is just called LIBRARY_PATH.

You may also need to add your libz's include/ dir to CPATH.  See
http://gcc.gnu.org/onlinedocs/gcc/Environment-Variables.html for more
details.

Hope that helps,
Jonathan
