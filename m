From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 14:44:27 -0700
Message-ID: <86r6bjmpqc.fsf@blue.stonehenge.com>
References: <20080530095047.GD18781@machine.or.cz>
	<1212179270-26170-1-git-send-email-LeWiemann@gmail.com>
	<20080530210531.GH18781@machine.or.cz>
	<7vd4n3iivt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Lea Wiemann <lewiemann@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:45:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CPg-0001xC-6J
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbYE3Voa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbYE3Voa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:44:30 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:3555 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbYE3Vo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:44:28 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id EF14C1DE211; Fri, 30 May 2008 14:44:27 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.6.14; tzolkin = 2 Ix; haab = 17 Zip
In-Reply-To: <7vd4n3iivt.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri, 30 May 2008 14:25:58 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83343>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Perhaps, but except for the use of nonstandard try...catch.  I have been
Junio> wondering if we can move away from it, with the goal of eventually getting
Junio> rid of the construct altogether.

Junio> Didn't we hear from Randal that the construct is known to be leaky?

It'd be trivial to avoid this try/catch.

eval {
  ... 
};
if ($@) {
  if (UNIVERSAL::isa($@, "That::Class::Which::Should::Be::Ignored")) {
    # ignore it
  } else {
    die $@; # re-throw it
  }
}

No leak there.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
