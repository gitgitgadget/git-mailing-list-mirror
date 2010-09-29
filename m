From: Andreas Ericsson <ae@op5.se>
Subject: Re: Another way to compare tools: is it possible to transfer full
 history?
Date: Wed, 29 Sep 2010 15:28:03 +0200
Message-ID: <4CA33EE3.3090202@op5.se>
References: <loom.20100928T153519-936@post.gmane.org> <4CA20169.2040606@dbservice.com> <loom.20100929T130008-795@post.gmane.org> <4CA320C3.6090006@op5.se> <loom.20100929T145158-59@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuomo <tuo.tie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 15:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0wht-0007iJ-Gc
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab0I2N2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 09:28:11 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49750 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752218Ab0I2N2K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 09:28:10 -0400
Received: from source ([209.85.215.52]) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTKM+526W76UZ1SIa2iX49txy++bslmtH@postini.com; Wed, 29 Sep 2010 06:28:08 PDT
Received: by ewy20 with SMTP id 20so241850ewy.39
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:28:06 -0700 (PDT)
Received: by 10.213.42.7 with SMTP id q7mr1385039ebe.4.1285766886703;
        Wed, 29 Sep 2010 06:28:06 -0700 (PDT)
Received: from clix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id v59sm12395498eeh.4.2010.09.29.06.28.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 06:28:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <loom.20100929T145158-59@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157566>

On 09/29/2010 03:03 PM, Tuomo wrote:
> Andreas Ericsson<ae<at>  op5.se>  writes:
> 
>>
>> So now we get to a proper use-case. You want to convert a Synergy repository to
>> something else, and you've been looking at mercurial and git.
> 
> Nah, I am not working with Synergy. I referred to an earlier encounter with it.
> 
> Right now, I am stuck with ClearCase. Most of the projects have been using base
> ClearCase, not UCM, and it means that there is no realistic way to transfer the
> histories anywhere. It can be tried, sure, but who would really want to do it?
> What I am looking for is tools that I can recommend to the projects, tools
> that are available to them, and will not pose a threat in being non-convertible,
> tools that would allow the projects to later make another decision, and not get
> stuck with the tool they choose now.
> 

In general, it's easier if they decide to change to a distributed version control
system such as git, mercurial or bazaar, since those generally have a much better
data model than centralized systems where you can get away with ugly workarounds
much easier.

Workable conversions are possible between very nearly every scm out there and
whatever you want. It's not necessarily possible to convert back in a way that
makes it look as if you'd used the original scm all the time, but it's (almost)
always possible to create a new repository that is obviously functional and
contains all or most of the relevant history. Such conversions generally take
quite a while for projects with a large history though, so it's not something
you'd ponder doing twice a week.

Most larger projects that have switched have done so with the intention of
using the switched-to system for at least the foreseeable future and have thus
done proper research into what that system has to offer and then made the
decision based on featureset, data model and usability of the available
systems. If you make the decision based on how easy it is to switch away
from the system you choose, you're bound to end up having to do just that
sooner or later.

Either way, very nearly every project in the world who in the past 3 years
have gone looking for a better version control system has gone with one
of the two major distributed systems, git and mercurial. Conversion between
those two is relatively quick and painless and produces working repositories
in both directions, even if git -> hg -> git doesn't necessarily produce a
repository identical to the one you started out with.

>> So let me ask you a question; What have you done so far to find out the answer
>> to the questions you're looking for, apart from asking here how a theoretical
>> scenario would pan out?
> 
> Fair enough. I am looking for documentation, and advice on how to find worthy
> sources, before delving into trying out something for no good reason.
> But, at the same time, I wish to have a look-see on what the general status
> is right now. If there is no summary of it available, then apparently I have to
> make it myself. But I would hate to find out afterward that someone had in fact
> done it already. Tomas Carnecky's list is a good start.
> 

You're looking at the wrong criteria for switching vcs. If the main goal is to
be able to convert the target repository back into the original one, you're up
for disappointment in what you'll find. None of the conversion tools destroy
the original repository though, so you can experiment with any one you like.

Some general truths that might aid you though:
git has the best fast-{import,export} support. Not surprising since the format
was engineered by the brilliant minds we're fortunate to have on the git list.

Conversion between git and other distributed version control systems produce
working repositories in a quick and painfree fashion.

It is usually impossible to convert from one repository format to the other
and back again in such a fashion that the resulting repository is identical
to the one you started with.

It is almost always possible to create a working repository of any kind from
a repository type that has a fast-export tool.

Writing a fast-import tool is not exactly rocket science, although it could
get timeconsuming if the target vcs is limited in capabilities and many
workarounds are necessary.

Most people don't switch to a vcs with fewer capabilities than the one they're
already using, so the previous point is mostly academic.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
