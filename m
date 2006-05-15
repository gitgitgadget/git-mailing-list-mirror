From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 02:47:31 -0700
Message-ID: <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
	<7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
	<20060515092704.GB6855@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 11:47:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfZfs-00029O-Jt
	for gcvg-git@gmane.org; Mon, 15 May 2006 11:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWEOJrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 05:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWEOJrd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 05:47:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11221 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932348AbWEOJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 05:47:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515094732.QGKP15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 05:47:32 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060515092704.GB6855@localdomain> (Eric Wong's message of "Mon,
	15 May 2006 02:27:04 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20039>

Eric Wong <normalperson@yhbt.net> writes:

> I believe this is what Martin wanted.  I think it's a good idea since
> sendmail binaries tend to be more flexible, but I'm ok with it either
> way.

I am not opposed to have an option to run a local submission
agent binary (I said I like that if(){}else{} there, didn't I?).
The ability to do so is a good thing.  I am not however sure
about changing the default when no option is specified on the
command line.

>> > +	if ($smtp_server =~ m#^/#) {
>> 
>> I like this if(){}else{} here, but have a feeling that the
>> logging part should be placed outside it to be shared.
>
> Cleaned that up a bit, patch coming.  Also removed the Port: printout
> completely, as it's rather redundant (see below).
>
>> While we are at it, we might want to enhance $smtp_server parsing
>> to take host:port notation so that people can use message
>> submission port 587/tcp (RFC 4409) instead.
>
> This already works, IO::Socket::INET (behind Net::SMTP) takes care of
> it :)

Thanks.  Maybe the next option would be delivery to a file (or
even SMTP batch)? ;-)
