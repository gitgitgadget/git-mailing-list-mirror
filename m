From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] Add Gitweb support for XZ compressed snapshots
Date: Fri, 31 Jul 2009 11:48:29 -0700 (PDT)
Message-ID: <m34osssn7o.fsf@localhost.localdomain>
References: <828BD9FC-1238-4B2E-858D-248977F04D31@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWx9l-0007QR-CZ
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 20:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbZGaSsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 14:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZGaSsb
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 14:48:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:19400 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbZGaSsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 14:48:30 -0400
Received: by ey-out-2122.google.com with SMTP id 9so615846eyd.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kdYvL/oQzEgnP+UcTPMKkNjtVEnxQuAC6OD59IWDVyw=;
        b=VPSSIdpRND5ABHjLe9+MNlWvYQG2425qt1oEccEP8iIIPN+SZO5/3GG3MrSySYXumK
         6K4cxGe6G0A9GernRYiKM9yRBrJscNV5BlACoeQWTTcZZnrrV+qfrOk2p/zCJfg2mtA0
         nKwL7wizPz40QamTFiZ5X0LYsRboOU76Kz+0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=XI1AFUElpmhkKXJKYEuP8iTVSJpuEUfzBm3fnrRQFoQTSyyN1u6KjSIifu24it/ZxF
         PZKYlZ94lWRj41VXCoST1E75NyqQ5uQSJaHVJ0YstVxpHpb4YU2PkBnIQBYmru1m8iio
         WQg9B5PAmu6T+uwHwG40/Ix9R6ByN+zBFTROk=
Received: by 10.210.143.17 with SMTP id q17mr3501732ebd.97.1249066110246;
        Fri, 31 Jul 2009 11:48:30 -0700 (PDT)
Received: from localhost.localdomain (abvt17.neoplus.adsl.tpnet.pl [83.8.217.17])
        by mx.google.com with ESMTPS id 28sm2876970eye.34.2009.07.31.11.48.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 11:48:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6VImSxZ029598;
	Fri, 31 Jul 2009 20:48:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6VImRKY029595;
	Fri, 31 Jul 2009 20:48:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <828BD9FC-1238-4B2E-858D-248977F04D31@uwaterloo.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124592>

Mark A Rada <marada@uwaterloo.ca> writes:

> Ok, so I got a good nights sleep now, and reviewed the results of my
> benchmarks to make sure they were consistent (turns out I had the
> archive sizes in the wrong order for the XZ repository tests).
> 
> I also reworded a number of things and added a conclusion to the
> benchmarks.
> 
> Let me know what you think.

Well separated change.  Very detailed commit message; that's good!.

[...]
> Linux 2.6 series (f5886c7f96f2542382d3a983c5f13e03d7fc5259) 	349M
> gzip 	23.70s user    	0.47s system  	99% cpu  24.227 total 	76M
> gunzip 	3.74s user     	0.74s system  	94% cpu  4.741 total
> bzip2 	130.96s user   	0.53s system  	99% cpu  2:11.97 total 	59M
> bunzip2 31.05s user    	1.02s system  	99% cpu  32.355 total
> xz 	448.78s user 	0.91s system  	99% cpu  7:31.28 total 	51M
> unxz 	7.67s user     	0.80s system  	98% cpu  8.607 total
> 
> Git (0a53e9ddeaddad63ad106860237bbf53411d11a7) 			11M
> gzip 	0.77s user 	0.03s system 	99% cpu  0.792 total 	2.5M
> gunzip 	0.12s user 	0.02s system 	98% cpu  0.142 total
> bzip2 	3.42s user 	0.02s system 	99% cpu  3.454 total 	2.1M
> bunzip2 0.95s user 	0.03s system 	99% cpu  0.984 total
> xz 	12.88s user 	0.14s system 	98% cpu  13.239 total 	1.9M
> unxz 	0.27s user 	0.03s system 	99% cpu  0.298 total
> 
> XZ (669413bb2db954bbfde3c4542fddbbab53891eb4) 			1.8M
> gzip  	0.12s user 	0.00s system 	95% cpu  0.132 total 	442K
> gunzip 	0.02s user 	0.00s system 	97% cpu  0.027 total
> bzip2  	1.28s user 	0.01s system 	99% cpu  1.298 total 	363K
> bunzip2 0.15s user 	0.01s system 	100% cpu 0.157 total
> xz 	1.62s user 	0.03s system 	99% cpu  1.652 total 	347K
> unxz   	0.05s user 	0.00s system 	99% cpu  0.058 total

Note that for me the above results are not aligned in table.
This is a cosmetic issue.

> Purely from a time and memory perspective, nothing compares to GZip in
> each of the three tests. Though, if you have an average upload speed of
> 20KB/s, it would take ~400 seconds longer to transfer the kernel
> snapshot
> that was BZip2 compressed than it would the XZ compressed snapshot, the
> transfer time difference is even greater when compared to the GZip
> compressed snapshot. The wall clock time savings are relatively the same
> for all test cases, but less dramatic for the smaller repositories.
> 
> The obvious downside for XZ compressed snapshots is the large CPU and
> memory load put on the server to actualy generate the snapshot. Though
> XZ
> will eventually have good threading support, and I suspect then that the
> wall clock time for making an XZ compressed snapshot would go down
> considerably if the server had a beefy multi-core CPU.
> 
> I have not enabled XZ compression by default because the current default
> is GZip, and XZ is only really competitive with BZip2. Also, the XZ
> format
> is still fairly new (the format was declared stable about 6 months ago),
> and there have been no "stable" releases of the utils yet.

Those above three paragraphs are strangely wrapped, with single word
for a whole line ('snapshot', 'XZ', 'format').  This is a cosmetic issue.

> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

-- 
Jakub Narebski
Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
