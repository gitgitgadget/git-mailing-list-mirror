From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/5] transport: optionally honor DNS SRV records
Date: Fri, 9 Mar 2012 02:00:22 -0600
Message-ID: <20120309080003.GA2229@burratino>
References: <20120308124857.GA7666@burratino>
 <20120308132155.GG9426@burratino>
 <CABPQNSYpRGfu7Ew+KstCFsG4YDSx+i-jzHS1Bw0BA4S2hoz4SA@mail.gmail.com>
 <20120308213545.GB9497@burratino>
 <4F59AC1C.1000406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 09:00:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ul1-0004mF-Ck
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 09:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab2CIIAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 03:00:31 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:38516 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752010Ab2CIIAa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 03:00:30 -0500
Received: by obbuo6 with SMTP id uo6so1802867obb.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 00:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xMB8JcEdH9Pt/aYkdzXbh7bLAbj7Sj4t7dIyONRThrY=;
        b=ZvPRGYZjLd5s3y7d68pcrxueF3kYwMifCxboCoQNGzWhbmuyzDlmOFZpB/LtQ2BFsY
         j+eoj9cMQT4G6fErCMEmSCeJOyr6poUgfbadRu4owyv6UYjPDaNZp6TShtNkPvOndBhl
         uer0jnzdoys6wHU7GcbBdB2V12ocyoMtrJJ3U/Wzejal68bdh8J8ryWyx69+U1V6K9Bt
         AlgGM5zwf7AKiebB9rPkfti7HBUO9i2nzTo5+5ygZaZV9nxCub5d+Yz33S3r2wgmH4+D
         mXZ9XemQqJWVcjEaK2hZMTnV46cu3f2AYfnv/i6OLA+HpzrC3M9rAzVi5i+YpUaETWff
         oxkw==
Received: by 10.182.124.41 with SMTP id mf9mr487801obb.65.1331280030134;
        Fri, 09 Mar 2012 00:00:30 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g4sm2388316oeg.5.2012.03.09.00.00.29
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 00:00:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F59AC1C.1000406@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192689>

Hi,

Johannes Sixt wrote:
> Am 3/8/2012 22:35, schrieb Jonathan Nieder:

>> (By the way, what platforms don't support BIND and a random number
>> generator?)
>
> MinGW, for example:

The ISC seems to provide BIND source code[*] and binaries for Windows,
though I'm not sure how well they could fit into a typical development
environment for git's MinGW port.  A good approach for drand48 is
harder to imagine, mostly because there are too many choices for a
free PRNG to use to replace it.  Not a bad problem to have. ;-)

Though all of that would only come up once someone wants to use
features requiring these facilities on Windows.  Thanks for the
hints and sorry for the distraction.

Ciao,
Jonathan

[*] http://www.isc.org/software/bind
