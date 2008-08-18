From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [TopGit PATCH] tg redepend: New command.
Date: Mon, 18 Aug 2008 11:23:28 +0200
Organization: lilypond-design.org
Message-ID: <1219051408.8816.34.camel@heerbeest>
References: <1218808427.25300.2.camel@heerbeest>
	 <Pine.GSO.4.62.0808151241300.17250@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Jan Holesovsky <kendy@suse.cz>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Mon Aug 18 13:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV2dm-0006Vs-LT
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 13:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbYHRLKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 07:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYHRLKJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 07:10:09 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:46427 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYHRLKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 07:10:08 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id D033011E665;
	Mon, 18 Aug 2008 13:10:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 4D804DC0AD;
	Mon, 18 Aug 2008 13:10:06 +0200 (CEST)
In-Reply-To: <Pine.GSO.4.62.0808151241300.17250@harper.uchicago.edu>
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92699>

On vr, 2008-08-15 at 13:20 -0500, Jonathan Nieder wrote:

Hi,

> s/tg/tg redepend/?

Yes.

> Why not move the base-creation code in tg-create.sh to a new
> function in tg.sh to use here?

Yes, that's better.
 
> I know I suggested that code before, but the merge with B' is wasted, so
> perhaps
> 
> 	git checkout P
> 	head=$(git rev-parse --verify HEAD^0)
> 	result_tree=$(git log -1 --pretty=format:%T P')
> 	result_commit=$(git commit-tree "$result_tree" -p P -p B')
> 	git update-ref -m "commit (merge): tg-redepend" HEAD \
> 			"$result_commit" "$head" || ... (fail)
> 	test -x "$GIT_DIR/hooks/post-merge" && $GIT_DIR/hooks/post-merge 0
> 
> I'm not sure.  Is there some more porcelain-ish way to do this (create a
> merge commit when you already know the resulting and parents)?
> 
> But with that change the entire restarted=merge branch would go away,
> so I hope there is a nice way to do it.  I'll think more.

Yes, the user should get a nice chance to resolve any conflicts...

Thanks!
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
