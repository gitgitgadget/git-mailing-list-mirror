From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Mon, 08 Dec 2008 20:04:25 +0100
Message-ID: <493D6FB9.3060706@tuffmail.com>
References: <493A6CEC.4060601@tuffmail.com> <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com> <493C1F36.7050504@tuffmail.com> <20081208161049.GB31551@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 20:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9lQX-0000ah-SA
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 20:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYLHTEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 14:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYLHTEa
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 14:04:30 -0500
Received: from mxout-03.mxes.net ([216.86.168.178]:4999 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYLHTE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 14:04:29 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id 1B8B723E3FC;
	Mon,  8 Dec 2008 14:04:26 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
In-Reply-To: <20081208161049.GB31551@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102574>

Shawn O. Pearce pisze:
> ASF probably has issues similar to that of the Android project.
> 
> In Android we built Gerrit[1] to handle this validation of identity
> for us, and to keep track of the contributor agreements each
> individual and corporation has signed.  Changes aren't accepted
> into Gerrit unless the user has an accepted CLA in the data store.
> 
> *1* http://review.source.android.com/

I'm not an expert on legal issues at Apache but in general you might be right that ASF and Android
project have similar issues to tackle. I've brought this point because it was previously brought in
ASF discussion on Git. so I try to act more like a bridge between two parties.

> Gerrit 2 is actively under development and is being ported off of
> Google App Engine, into a pure Java webapp.  I'm running it under
> Jetty, but it should work just as well under Tomcat.  :-)

Is there any documentation outlining Gerrit's features and status of Gerrit 2 development?

> If the ASF becomes more committed to supporting Git, Gerrit may be
> a good way to answer some of the questions you are having about
> validating identity of changes.  Plus its a handy source code
> review tool.

I guess it's rather long run before Apache Infrastructure team *officially* starts supporting Git.
This is my personal view and it's not official voice of ASF by any means. SVN to Git transition
(entirely) is complicated process for such a big organization like ASF.

Another option would be to let particular projects choose which SCM they prefer but that would mean
that our infra team has to support two different SCMs. This means some new folks interested in
supporting Git at ASF would have to join infra.

At this point, we chose to let people experiment with Git (so we are allowed to perform rather
expensive clone operations) in order to gain some experience and work out work-flow that suits ASF
model of development. This thread is part of described process.

On the other hand, if we find Gerrit useful for us we might try to set up it somewhere unofficially
and let people play with it.

>> Does it mean that with current Git design it's the best to not use advanced features of Git like
>> tree merging but simply go with posting e-mails with patches instead if contributors cannot be trusted?
> 
> Most Git projects rely on patches sent to an email list, with
> a single maintainer applying them to to his/her repository, and
> publishing the result.  The maintainer is thus forced to keep track
> of the CLAs (if the project uses such things) and just trust the
> From address of the message.

It's rather important to keep in mind that at ASF we don't how practice of single maintainer so we
need solution that works for many committers that push to the same repo but I know Git supports this
rather easily.

> CLAs in the kernel and in git itself are less enforced than say
> what ASF or Android requires.
> 
> Some Git projects give write access to the master repository to
> multiple trusted parties; SAMBA and X.org are good examples of this
> sort of strategy.  But I think in these cases those who have write
> access are also very long standing members of the development
> community who have known each other in person for many years,
> perhaps far longer than a DVCS concept has existed.  So trust
> between those with direct write access is slightly less of an
> issue for these projects.

That is a case for Apache to some extent. Someone is being nominated to become a committer after
some period of cooperation in terms of providing patch, participating in discussions etc. After such
period existing committers can rather reliably judge if they trust particular person or not.

Yet still signed CLA is required but we check this before someone is being granted write access so
this can be done by hand.

> So long story short, I think Gerrit may be worth the ASF's time,
> if Git is a serious consideration for replacing SVN.  But while a
> project is based in SVN I think the best you can do with Git is
> publish an automatically updated git-svn mirror and permit only
> use of "git svn dcommit" to upload back into the SVN repository.

As I said, I don't think ASF will switch to Git any time soon due to many different reasons
including technical (IDE support), social (there are different opinions on DVCS in general) and
other. All of them have to be addressed but in order to have any meaningful discussion we need to
gather some experience.

Thanks for helping me with going through this process!

-- 
Best regards,
Grzegorz Kossakowski
