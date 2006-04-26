From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Tue, 25 Apr 2006 23:50:30 -0700
Message-ID: <7vlktssudl.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<7vwtde2q1z.fsf@assigned-by-dhcp.cox.net>
	<444EAE7C.5010402@vilain.net> <e2mv30$k08$1@sea.gmane.org>
	<e2n01t$m8j$1@sea.gmane.org>
	<7vzmi8sxt1.fsf_-_@assigned-by-dhcp.cox.net>
	<e2n4am$1vn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 08:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYdr9-0002kp-Eb
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 08:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWDZGuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 02:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWDZGuc
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 02:50:32 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27813 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750952AbWDZGub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 02:50:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426065031.STXG25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 02:50:31 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2n4am$1vn$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	26 Apr 2006 08:35:32 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19188>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Jakub Narebski wrote:
>>>
>>>> [...] Sam's "prior (3)" example
>>>> link would point to the toplevel project (gathering all subprojects)
>>>> commit, and it would probably be named/noted "toplevel", not "prior".
>>>
>>> Or "master" (like "master document" in DTP).
>> 
>> (Offtopic) isn't "master" in DTP more like template?
>
> Well, in (La)TeX "master document" is a document on it's own rights,
> subdocuments are transcluded using some kind of "include"-like command.

(Offtopic) Ah, the hard-core stuff.  I had something else in
mind ("master page" in "DTP for dummies"), sorry for the
confusion.

(On topic again)

Link from subproject commit back to the toplevel might work for
some kind of subprojects, but it would not work for the
subproject support that frequently comes up on this list.  The
development of an embedded Linux device, where a Linux kernel
source tree is grafted at kernel/ subdirectory of the toplevel
project.  The "prior" link would be placed in the commit that
belong to the kernel subproject, but that would never be merged
to the Linus kernel (why should he care about one particular
embedded device's development history).  The link must go from
the toplevel to generic parts reusable out of the context of the
combined project.
