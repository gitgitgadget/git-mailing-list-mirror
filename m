From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: charset problem
Date: Mon, 24 Oct 2005 15:39:56 -0700
Message-ID: <7vwtk2k08z.fsf@assigned-by-dhcp.cox.net>
References: <200510241356.j9ODuAHn005060@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.64.0510241743280.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 00:41:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUAz3-00053G-3y
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 00:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVJXWj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 18:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVJXWj6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 18:39:58 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51138 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751366AbVJXWj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 18:39:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024223918.CUQ2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 18:39:18 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510241743280.25300@iabervon.org> (Daniel
	Barkalow's message of "Mon, 24 Oct 2005 17:55:30 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10566>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 24 Oct 2005, Horst von Brand wrote:
>
>> I believe the Emperor Penguin decreed messages have to be
>> ASCII, or else UTF-8. Please don't add to the mess by using
>> non-portable encodings!
>
> Should we possibly reject non-UTF-8 input to commits?

Please, don't.

> IIRC, we actually define that to be UTF-8, unlike most of the
> other stuff, for which we don't actually insist on a policy.

No, we do not define nor insist on a particluar policy as far as
I know.  We suggest the use of UTF-8 merely from common sense to
help interoperability, and make UTF-8 slightly easier to use
than other encodings by giving specific support for it in some
tools, namely -u flag in git-mailinfo.

It is perfectly reasonable if a company internal project that
works in Russia to standardize on KOI, or in Japan on EUC-JP.
We simply allow it without encouraging nor discouraging it.  If
gitweb can take a configuration mechanism to override the
built-in UTF-8 header, that is perfectly a valid thing to do to
help such an environment.

However, we suggest UTF-8 if the project does not have a
compelling reason to do otherwise [*1*].  If you want to be
prepared for the day your project might have wider participants
than you originally envisioned, that is the most sensible thing
to do.  This is especially true because the commit logs cannot
be re-encoded after the fact.

[Footnote]

*1* For example, I've never made GNU emacs to work well with
Japanese in UTF-8 , so if people in my company internal project
wanted to use Japanese in commit logs, I would probably
standardize on EUC-JP for such a project.  Luckily so far I have
not been forced to make that decision.
