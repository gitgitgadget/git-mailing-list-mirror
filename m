From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 15:00:19 -0400
Message-ID: <0FC64949-689C-43A4-B656-9618E808962B@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net> <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com> <20090424181539.GB11360@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 21:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxQes-0006c6-7q
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 21:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbZDXTAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 15:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZDXTAX
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 15:00:23 -0400
Received: from boost-consulting.com ([206.71.190.141]:49364 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbZDXTAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 15:00:22 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 2311B1CC1E;
	Fri, 24 Apr 2009 11:57:50 -0700 (PDT)
In-Reply-To: <20090424181539.GB11360@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117481>


On Apr 24, 2009, at 2:15 PM, Jeff King wrote:

> On Fri, Apr 24, 2009 at 01:28:35PM -0400, David Abrahams wrote:
>
>>> I think this is a bit better than it used to be. Plumbing commands  
>>> are
>>> mostly hidden outside of the user's PATH.
>>
>> Huh?
>>
>> git hash-object
>> git cat-file -t ...
>> git ls-tree
>> git rev-parse
>> git write-tree
>> git commit-tree
>
> How did you find out about them?

The first time?

  $ man git

> They are not in your PATH, so shell
> completion doesn't find them.

Huh?  `which git` works.  ls-tree is an argument to git as far as I  
know.

Yes, I know there are aliases like git-ls-tree somewhere, but that  
only adds to the sense that all commands are equal.

> They are not in the programmable bash
> completion. They are not in the short command list git gives you when
> you type "git help" or "git" without arguments.
>
> So you must have read about them somewhere..

   $ man git

which makes no distinction.

   $ xxx [--]help

is usually OK if I already know xxx pretty well and just want a  
refresher.  If know I'll need a little more than that, I use man  
straight away.

>> These are just some of the ones I learned about by reading John  
>> Wiegley's
>> "Git From the Bottom Up."
>
> ...like here.

That's where I learned *what they do*.

> So if that document gave you the impression that those are
> part of an everyday git workflow, then I think the document is at  
> fault,
> not git itself.

It didn't.

> I admit I haven't read "Git From the Bottom Up" carefully, but I think
> what Michael is proposing would probably start a little higher from  
> the
> bottom than that document.

Yes, please.  "Git for Computer Scientists" is a great foundation.   
 From there add more information about naming things so I know what  
things like remotes/origin/master mean when I see them in gitk, and  
I'm off to the races.

> You can give the concepts of the object
> types, show them in pretty-printed form with "git show", and not worry
> about telling the user "this is how 'git commit' could be  
> implemented in
> terms of primitive operations". And then you can avoid most of the
> low-level commands entirely.

Yes, that's fine.  Although I think there may be some things in GFTBU  
that are good fundamental concepts.  There's a nice list of terms with  
definitions early in the document.

>> Maybe I'm wrong about rev-parse, but for the most part, having all  
>> these
>> low-level commands available through the same executable that's  
>> used for
>> "git add," "git merge," "git commit," et. al. makes the whole  
>> shebang hard
>> to approach.  It would be better for users if the low-level stuff was
>> accessed some other way.
>
> Perhaps. The general approach is to make those commands accessible as
> "git foo", but not to _advertise_ them in the same way as the  
> porcelain
> commands.

What is "porcelain," please?  This is one among many examples of  
jargon used only (or encountered by me for the first time) in the Git  
community.

> The idea was to give a uniform calling convention without
> unnecessarily confusing users by presenting a large number of
> infrequently-used commands.

It's not working, I'm sorry to say.

> At any rate, it is too late to change the calling convention for
> plumbing.

I disagree.  You can leave the old functionality there in a  
"deprecated" state and change the way you advertise it.  It would even  
help a lot if the plumbing were all spelled "git-xxx" and the high  
level stuff were "git xxx."

> The whole point of them is to be a stable interface for
> scripting. Changing them to "git low-level rev-parse" (if it was even
> something that we wanted to do, which I don't think it is) would break
> everyone's scripts.

See above.

>> [excuse me, but what the #@&*! is "porcelainish" supposed to mean?
>> (http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html)]
>
> Heh. That one is particularly egregious, because it rests on several
> layers of git jargon. The low-level tools are plumbing, like pipes and
> valves.

? I use the valves on my kitchen sink all the time.

> The high-level commands intended for end users are porcelain,
> like sinks and toilets. The -ish suffix is often used in git to  
> refer to
> a type, or something we can convert into a type (like a "tree-ish"  
> could
> be a tree object, or a commit object which points to a tree, or a tag
> object which points to a commit which points to a tree). So I think by
> saying "porcelain-ish" here, the author meant "not just porcelain, but
> other things which take revisions and behave sort of like porcelain".

bah. humbug.

> Which is a truly horrible thing to throw at a new user who just  
> wants to
> see how to specify a revision.

yeeeeah.

> So yeah, if you are saying that could be worded better, I absolutely
> agree. There are a lot of spots like that. They are getting fixed  
> slowly
> over time. I'm not sure if that is enough, or if somebody  
> knowledgeable
> really needs to take a sledge hammer to the existing documentation and
> just reorganize and rewrite a lot of it.


I'm thinking the latter.

--
David Abrahams
BoostPro Computing
http://boostpro.com
