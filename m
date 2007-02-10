From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 02:40:53 -0800
Message-ID: <7vhctumh1m.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	<Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	<7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	<7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	<7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
	<e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
	<7vps8imnis.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702100029h65d1fd3fke5496da0664642ee@mail.gmail.com>
	<e5bfff550702100046m1c0b1931t11ed0cf95853cda9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 11:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFpf8-0007VQ-Sh
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 11:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbXBJKkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 05:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbXBJKkz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 05:40:55 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59581 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbXBJKky (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 05:40:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210104055.FCJQ21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 05:40:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Mmgt1W00V1kojtg0000000; Sat, 10 Feb 2007 05:40:54 -0500
In-Reply-To: <e5bfff550702100046m1c0b1931t11ed0cf95853cda9@mail.gmail.com>
	(Marco Costalba's message of "Sat, 10 Feb 2007 09:46:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39215>

I suspect that you are dual booting and browsing a git
repository that is on a read-only mounted NTFS filesystem from
the Linux side, and the index was created on Cygwin git?

I (perhaps luckily) am fairly ignorant on the way things done in
Windows environment.  For one thing, I do not know if NTFS has
notion of i-number, file owner uid, and other information that
are used in the index (not that I want to know).

If NTFS does not support the information returned by lstat(2)
fully on disk, I would imagine Cygwin and NTFS filesystem driver
in the Linux kernel need to fake some fields that NTFS does not
natively store, and if the value faked by Cygwin and NTFS driver
in the Linux kernel disagree, then it is not at all surprising
to see if an unmodified path shows up as cache-dirty.
