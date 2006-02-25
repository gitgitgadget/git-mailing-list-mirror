From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rm: Fix to properly handle files with spaces, tabs, newlines, etc.
Date: Fri, 24 Feb 2006 22:05:18 -0800
Message-ID: <7vu0ao6kip.fsf@assigned-by-dhcp.cox.net>
References: <87u0ass7tj.wl%cworth@cworth.org> <43FB8F31.9090302@people.pl>
	<87slqcs4y5.wl%cworth@cworth.org> <87r75ws48c.wl%cworth@cworth.org>
	<7vaccjst3x.fsf@assigned-by-dhcp.cox.net>
	<8764n7rl6s.wl%cworth@cworth.org>
	<81b0412b0602240523l1b10c910q6e5d2e3cef82e306@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Carl Worth" <cworth@cworth.org>,
	"Krzysiek Pawlik" <krzysiek.pawlik@people.pl>
X-From: git-owner@vger.kernel.org Sat Feb 25 07:05:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCsYY-0004iW-H4
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 07:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWBYGFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 01:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWBYGFX
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 01:05:23 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5783 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932692AbWBYGFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 01:05:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060225060228.OSXF26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Feb 2006 01:02:28 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16758>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 2/23/06, Carl Worth <cworth@cworth.org> wrote:
>> +# Setup some files to be removed, some with funny characters
>> +touch -- foo bar baz 'space embedded' 'tab     embedded' 'newline
>> +embedded' -q
>> +git-add -- foo bar baz 'space embedded' 'tab   embedded' 'newline
>> +embedded' -q
>> +git-commit -m "add files"
>
> This doesn't work on some exotic filesystems (ntfs and fat):

Sorry to have applied this without thinking.  Yes, we had
disabled a test that uses tab for this exact reason, but I have
forgotten about it.
