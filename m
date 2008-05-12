From: Justin Leung <jleung@redback.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Mon, 12 May 2008 12:02:06 -0700
Message-ID: <4828942E.2060803@redback.com>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop>	 <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>	 <B03D1DC3-7088-41AF-BB8B-9A696E7C5B8E@sb.org>	 <83EE186A7AF140179C6C73B367471EC7@justinuTop> <56b7f5510805112257u13252c71kda880fb3f3e43485@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	justin0927@hotmail.com
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 21:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdIt-0004gB-De
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 21:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbYELTCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 15:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756644AbYELTCJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 15:02:09 -0400
Received: from prattle.redback.com ([155.53.12.9]:43168 "EHLO
	prattle.redback.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbYELTCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 15:02:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id A0AC053E7BB;
	Mon, 12 May 2008 12:02:06 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28657-07; Mon, 12 May 2008 12:02:06 -0700 (PDT)
Received: from [155.53.72.61] (havant.redback.com [155.53.72.61])
	by prattle.redback.com (Postfix) with ESMTP id 6CB2853E7B9;
	Mon, 12 May 2008 12:02:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <56b7f5510805112257u13252c71kda880fb3f3e43485@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at redback.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81909>


Hi Dana,

 My best wishes to your family . having 6 surgeries is no joke.
I wish you have all recovered well .

Thanks for letting me know that I am not the crazy one to try to 
implement git in asia :)

I believe that this tool is full of potential in our community.
All it takes would be just a minor tweak to fit our methodology .

in the mean time, while my team is still happy with cvs ,
due to the design habits (good or bads.. but they are used to the way it 
is ) ,
probably svn and p4 are still the only logical choose ;
not that I m happy with these chooses though.

git will get there but i think no big hardware firm would like to be the 
first to adopt to it ..
especially my managements would like to minimize risks .


 Justin


Dana How wrote:
> Hi Justin,
>
> I was originally drawn to git for the exact reasons you identified in
> your 2nd email.
> Namely,  it is extremely difficult in a p4-based environment to share
> intermediate work within a design team without pushing the work out to
> be visible by the entire team.  "Inter-user design sync'ing" is exactly what
> I wanted.  In its absence,  we have made all references between files
> relative.  This means you can flip over to someone else's netlist by changing
> one path (say to the top-level design file) to point into someone's private
> repository.  That top-level file then includes everything else using paths
> relative to its own location,  so you get the correct stuff automatically.
> Of course,  you get tripped up all the time by stuff implicitly used and not
> named in the top-level file and its children...
>
> Now,  it would be far better for this to be a lightweight branch in git,  and
> then having people checkout this branch and use it.  (Because,  for example,
> while one person is pointing into another's tree,  the latter can't change.)
> But p4 (and cvs) has trained everyone to think of branches as painful and
> for wizards only.  Plus I am not personally interested in investing any time
> writing scripts on top of p4;  the ideas I outlined in the previous paragraph
> were easier and almost as good as anything (easily) doable in p4
> (but not as good as lightweight branching).
>
> I agree with other responses to your email that you may want to think
> about writing simple wrapper scripts that add tags to checkins with some
> simple incrementing numeric part to keep your back-end people happy.  Yet
> other responses were distracted by the linearity of your centralized/shared
> checkins:  the inter-design sync'ing you want,  and the lightweight branching
> it may imply,  aren't necessarily incompatible with the linear main
> public history
> that most design teams expect (and which is unavoidable in design work
> containing lots of unmergeable files,  such as layout design).
> So I don't necessarily think you would be happy with Subversion
> (I'm certainly not happy with p4).
>
> There are two other issues you may want to keep in mind.  In our
> chip design activities,  we have a lot of very large files (100MB to ~3GB),
> and the p4 repository has grown beyond 3TB.  Now,  this is simply
> a data set size region which is not used by the git developers.  I think
> the git data model is fine for large projects and files (Linus mused otherwise
> a few weeks ago,  but it seems fine to me),  but due to lack of use,
> various details when handling large files/projects remain to be worked out
> and/or optimized as much as the rest of git.  It is true since I
> started watching
> there have been a lot of important improvements in this area.
>
> Secondly,  you may also want to discuss with your IT people (or whoever
> is responsible for back-up) how git packs/repacks repositories.  Ours were
> very uncomfortable with the idea that the _entire_ repository has to get
> re-arranged frequently.  I think they would have been much happier
> with an approach more similar to how Unix systems were backed up in the
> 80s: have a level-0 repack which repacks everything, a level-1 which repacks
> only stuff added since the last level-0,  level-2 since level-1,  etc.
> To do this would be a pretty straightforward change to git-repack.sh,
> probably using .keep files.  In each level it is clear what needs to
> be backed up.
>
> Anyway,  good luck!  Many of the things you touched on,  or which I
> mentioned above,  have been (partially) implemented or at least
> discussed before,
> so your requests aren't crazy.  Unfortunately,  in my case,  having 6 surgeries
> in my family in the last year has kept me from doing that much useful
> for git along these lines and thus I remain stuck with p4 for now.
>   
