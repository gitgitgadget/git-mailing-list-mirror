From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 18:36:34 -0800
Message-ID: <20141119023634.GV6527@google.com>
References: <20141118003426.GA6528@glandium.org>
 <20141118014028.GF4336@google.com>
 <20141118023112.GA14034@glandium.org>
 <20141118025131.GH4336@google.com>
 <20141118031147.GA15358@glandium.org>
 <20141119021824.GA9094@glandium.org>
 <20141119022121.GU6527@google.com>
 <20141119022759.GA9818@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:36:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqv8O-0000ka-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbaKSCgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:36:40 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34213 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaKSCgj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:36:39 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so4958305iec.19
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 18:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ahWMl9HZB4CNirEnxBv9EwbFKTunjSaicrMQiJX7gdA=;
        b=FBrW4TRE2B9OvANWrfSSm6VEKMZYILYN7EdAMCPN9z9UjoFU4nxp0obS/s42/d7QsN
         sjzsVtvnPl3dxEHlu8oCeCuooPSViEu3XfXS0DfchUEJ2PUCtdQ8AxjIT2wNtYIrl+Ps
         rgFObmyid0pu5YSv3TilpuQ6fVdnS+mOKZj+W4Tal1k2Q+CE0/2D3JdtNPFzpS+povOZ
         THFRwi16HtRQxsHORFS+yv1iX1Y1y8K92JeTzxjGuLUag5ylZk5eqI0bEjzdrYJ6tyyH
         o9CozKeFD+6S4JdDyC65lOFDorQ9p3aY/PucxvJ1gSos5Mi9PpxuIC7SFS/bX7EPSSsi
         De0w==
X-Received: by 10.50.221.33 with SMTP id qb1mr7681935igc.7.1416364599314;
        Tue, 18 Nov 2014 18:36:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id y9sm156570igp.22.2014.11.18.18.36.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 18:36:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119022759.GA9818@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 11:27:59AM +0900, Mike Hommey wrote:
> On Tue, Nov 18, 2014 at 06:21:22PM -0800, Jonathan Nieder wrote:

>> IIRC then 'M 040000' wants a tree object, not a commit object, so
>> you'd have to do
>>
>> 	ls <commit> ""
>> 	M 040000 <tree> ""
>
> That's what I'm planning to try ; Would doing:
> M 040000 <tree> ""
> M 0644 <blob> some/path
> D other/path
>
> work?

Yes, that should work fine.  That's how contrib/svn-fe/svn-fe.c deals
with 'Node-copyfrom-rev' in Subversion dumpfiles, for what it's worth.
