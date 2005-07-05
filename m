From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tags
Date: Tue, 05 Jul 2005 12:22:42 -0700
Message-ID: <7vy88ldpml.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0507051155580.30848-100000@iabervon.org>
	<m1br5hywde.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507051132530.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 21:41:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpt3w-0008Pi-3j
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 21:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVGETZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGETZS
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 15:25:18 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61322 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261520AbVGETWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 15:22:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050705192242.SVBA23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 5 Jul 2005 15:22:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507051132530.3570@g5.osdl.org> (Linus Torvalds's message of "Tue, 5 Jul 2005 11:33:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Tue, 5 Jul 2005, Eric W. Biederman wrote:
>> 
>> True but if you can you will get multiple tags with the
>> same suggested name.  So you need so way to find the one you
>> care about.

LT> I do agree that it would make sense to have a "tagger" field with the same 
LT> semantics as the "committer" in a commit (including all the same fields: 
LT> real name, email, and date).

While we are talking about changing tag object format/fields,
I've wondered if we would want to be able to associate more than
one objects with a single tag (i.e. have more than one "object"
lines just like commits can have more than one "parent" lines).
I admit that it would not be a "tag" anymore, rather, it would
be a "bag".

I wanted to have something like this in the past for some reason
I do not exactly remember anymore, but basically it was to
record "here is the list of related objects."

I could fake it with a multi-parent commit with a commit message
if all I want to include are commits with a single blob, but
that is (1) abusing the commit to record something that is not
even a merge, and (2) the tree associated with that commit would
not mean anything.
