From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix few 'use of undefined value' warnings
Date: Wed, 16 May 2007 21:05:06 -0700
Message-ID: <7vabw4ccy5.fsf@assigned-by-dhcp.cox.net>
References: <20070427164352.396.54191.stgit@rover>
	<20070517013209.GJ4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 06:05:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoXEo-0007bD-PA
	for gcvg-git@gmane.org; Thu, 17 May 2007 06:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758571AbXEQEFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 00:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758856AbXEQEFJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 00:05:09 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60666 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758571AbXEQEFI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 00:05:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517040507.WMCR6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 00:05:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 04571X0061kojtg0000000; Thu, 17 May 2007 00:05:07 -0400
In-Reply-To: <20070517013209.GJ4489@pasky.or.cz> (Petr Baudis's message of
	"Thu, 17 May 2007 03:32:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47493>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, Apr 27, 2007 at 06:43:53PM CEST, Petr Baudis wrote:
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index b67ce41..b51103e 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1057,6 +1058,7 @@ sub git_get_project_description {
>>  	open my $fd, "$projectroot/$path/description" or return undef;
>>  	my $descr = <$fd>;
>>  	close $fd;
>> +	$descr or return undef;
>>  	chomp $descr;
>>  	return $descr;
>>  }
>
> It looks like this hunk has been skipped...?

It is more like the whole messages was missed, and then 198a2a8a
and others tried to do the same thing but missed this one.
