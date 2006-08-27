From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path  settings, using formats.
Date: 27 Aug 2006 09:06:32 -0700
Message-ID: <864pvyi2nr.fsf@blue.stonehenge.com>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
	<115637597423-git-send-email-madcoder@debian.org>
	<7vfyfiyaex.fsf@assigned-by-dhcp.cox.net>
	<200608271228.09718.madcoder@debian.org>
	<7v64gexxgl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 18:06:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHN9j-0000tk-MX
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 18:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWH0QGh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 12:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWH0QGg
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 12:06:36 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:9508 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932152AbWH0QGg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 12:06:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 82FF78F599;
	Sun, 27 Aug 2006 09:06:35 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31789-01-16; Sun, 27 Aug 2006 09:06:33 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id F3EE78F591; Sun, 27 Aug 2006 09:06:32 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.10.12; tzolkin = 10 Eb; haab = 5 Mol
In-Reply-To: <7v64gexxgl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26103>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> About vger potentially throwing things away, I use this script
Junio> (called "taboo.perl") to check my messages before sending them
Junio> out.

Junio> Obviously the taboo-word list itself is not attached here, but
Junio> the actual script should have a copy of it after the __DATA__
Junio> marker.

With "Inline::Files" from the CPAN, you could have a switch where the
script updates itself with the new list:

    use Inline::Files;
    if (@ARGV == 1 and $ARGV[0] eq "-update") {
      use LWP::Simple;
      my $list = get "http://example.com/foo/bar.txt";
      open DATA, ">$DATA" or die "cannot write myself: $!";
      print DATA $list;
      close DATA;
      exit 0;
    }

    ... rest of your program here ...
    ... read using <DATA> as before ...

    __DATA__
    the list will magically go here.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
