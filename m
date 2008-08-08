From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: linearising TopGit forests into patch series (was: [ANNOUNCE] TopGit - A different patch queue manager)
Date: Fri, 8 Aug 2008 19:14:49 +0200
Message-ID: <36ca99e90808081014j2c48a71bgbff3afae90259e74@mail.gmail.com>
References: <20080803031424.GV32184@machine.or.cz>
	 <20080807175623.GA16833@lapse.rw.madduck.net>
	 <36ca99e90808071258h62b65981s20a5b053d9bc5754@mail.gmail.com>
	 <20080808170658.GA16055@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org,
	"vcs distro packaging discussion list" 
	<vcs-pkg-discuss@lists.alioth.debian.org>
To: "martin f krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 19:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRVZC-0006O6-06
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 19:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYHHROv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 13:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYHHROv
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 13:14:51 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:24282 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYHHROv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 13:14:51 -0400
Received: by an-out-0708.google.com with SMTP id d40so175375and.103
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NR5P3kL8Q78Pq4viJ5AfEaxP+pQDZ9euPHTnu0IWTMc=;
        b=jt2UKld2V69lJxJ00jHbaeRVM0ztH73w62XtlTiBKX+tTeNzYZM9nR26BYDwA3CoQ1
         lOI4ak0FzQmfkl4qGXsvqx+hJxbiZg9p7E3KiaeO8ztRKir/elx00zYpr4Z5Eua+4zpp
         egx+Xy/zVp2uQ/NTZXxMJJJpWrgsGWlau78N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=itY+Qq/RFbl6XUm98CdyUOA3liZB+mofUGvhxXo4oWHCLTBdBRHthwCMIdS4mtiDxW
         9nnQn1XXiz7aSO7bx9JuigtA7NWzlLsVe0TYmakT8lFzok+3+r2whOgSzqrE50l5OyYl
         heiEDFozCyss5NC99qWl6ldP/qTYA8SppwSko=
Received: by 10.100.228.17 with SMTP id a17mr7140439anh.75.1218215689962;
        Fri, 08 Aug 2008 10:14:49 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Fri, 8 Aug 2008 10:14:49 -0700 (PDT)
In-Reply-To: <20080808170658.GA16055@lapse.rw.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91698>

On Fri, Aug 8, 2008 at 19:06, martin f krafft <madduck@debian.org> wrote:
> also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.08.07.1658 -0300]:
>> Should be doable, I think. At least you can get a topological sorted
>> list of the TopGit branches (with git show-branch --topo-order <list
>> of TopGit-branches>). But than it get complicated, because you don't
>> need the diff from branch-base to branch-head, this would only work
>> for a single dependent list of topic branches.
>
> Hm, I am not entirely following. I understand that I can get
> a topological list of branches, but why don't I need the diff from
> branch-base to branch-head?
branch-base is a merge of all dependent branches, and if there are
more than one you need probably other diffs to get to this merged
branch, than the simple base..head of these branches.

>
> Also, what happens if branches cross-merge?
