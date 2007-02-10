From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 12:25:54 +0100
Message-ID: <e5bfff550702100325v5ce9ba1fx4b9b7adcc5040948@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	 <7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	 <7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	 <7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
	 <e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
	 <7vps8imnis.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702100029h65d1fd3fke5496da0664642ee@mail.gmail.com>
	 <e5bfff550702100046m1c0b1931t11ed0cf95853cda9@mail.gmail.com>
	 <7vhctumh1m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 12:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFqMv-0004Fc-8F
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 12:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXBJL0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 06:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbXBJL0F
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 06:26:05 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:36820 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbXBJL0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 06:26:04 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1179781wri
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 03:25:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TPNq1PkUWL0NH1gRKuh6ckkQ1etfxduUHrmxIFCjIiycVijrVBRxHsVq14O8z43JtdkzFOSbBHqJCQspTRlSm17ERy7sOEoXKxsENFJRZFmQAK8GPVT3HCO48KIOZzR/fvqgve5BnLrgSSnujYLE/FVTyPkb/Eg7U4BPpWVM5oQ=
Received: by 10.114.185.8 with SMTP id i8mr6422901waf.1171106754119;
        Sat, 10 Feb 2007 03:25:54 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 03:25:54 -0800 (PST)
In-Reply-To: <7vhctumh1m.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39216>

On 2/10/07, Junio C Hamano <junkio@cox.net> wrote:
> I suspect that you are dual booting and browsing a git
> repository that is on a read-only mounted NTFS filesystem from
> the Linux side, and the index was created on Cygwin git?
>

Yes. That's it.

> I (perhaps luckily) am fairly ignorant on the way things done in
> Windows environment.  For one thing, I do not know if NTFS has
> notion of i-number, file owner uid, and other information that
> are used in the index (not that I want to know).
>
> If NTFS does not support the information returned by lstat(2)
> fully on disk, I would imagine Cygwin and NTFS filesystem driver
> in the Linux kernel need to fake some fields that NTFS does not
> natively store, and if the value faked by Cygwin and NTFS driver
> in the Linux kernel disagree, then it is not at all surprising
> to see if an unmodified path shows up as cache-dirty.
>

So in this case your patch that introduce '--refresh' option in 'git
runstatus' is not just a shortcut for 'git update-index' + 'git
runstatus' but adds some real value.

One more reason for asking you to add it before 1.5 release ;-)
