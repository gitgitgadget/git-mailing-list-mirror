From: Junio C Hamano <gitster@pobox.com>
Subject: Re: post-update script to update wc - version 2
Date: Wed, 27 Jun 2007 03:09:58 -0700
Message-ID: <7vved9pv2h.fsf@assigned-by-dhcp.pobox.com>
References: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
	<4681C640.6060408@vilain.net>
	<81b0412b0706270221y40bac0a7gf6b73eda9f1e4bb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Sam Vilain" <sam@vilain.net>, "Sam Vilain" <samv@utsl.gen.nz>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 12:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3UU0-00005t-8A
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 12:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbXF0KKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 06:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755593AbXF0KKA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 06:10:00 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52502 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406AbXF0KJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 06:09:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627100959.YAPF1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Jun 2007 06:09:59 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ga9y1X0021kojtg0000000; Wed, 27 Jun 2007 06:09:58 -0400
In-Reply-To: <81b0412b0706270221y40bac0a7gf6b73eda9f1e4bb0@mail.gmail.com>
	(Alex Riesen's message of "Wed, 27 Jun 2007 11:21:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51029>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 6/27/07, Sam Vilain <sam@vilain.net> wrote:
>> Sam Vilain wrote:
>> >         this_tree=`git-cat-file commit $commit | awk '/^tree/ { print $2; exit }'`
>>
>> Of course on newer git, `git-rev-parse $commit:` will do that.
>
> Are you sure? Maybe you mean git-rev-parse "$commit"^{tree}?

I had the same "Huh?"  moment as you had, but what Sam said is
correct.  He is being too clever to confuse us ;-).

When "$commit" is a tree-ish,

	$commit:$path

is the name of the tree or blob object at that $path, and as 
very strange special case, an empty $path is the whole tree.

It's been this way since early this year (before v1.5.0-rc1),
thanks to Jeff King.
