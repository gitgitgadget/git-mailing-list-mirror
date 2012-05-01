From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 11:59:03 -0700
Message-ID: <4FA03277.7040006@palm.com>
References: <4F9F128C.5020304@palm.com> <4F9F21B8.9070506@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue May 01 20:59:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPII5-0004EO-0g
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab2EAS7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 14:59:07 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:4488 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab2EAS7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 14:59:06 -0400
X-IronPort-AV: E=Sophos;i="4.75,512,1330934400"; 
   d="scan'208";a="13246399"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 11:59:05 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q41Ix3L3001304;
	Tue, 1 May 2012 11:59:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4F9F21B8.9070506@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196728>

On 4/30/12 16:35 , Jan Kr=FCger wrote:
> Hi Rich,
>
> On 05/01/2012 12:30 AM, Rich Pixley wrote:
>> I'm trying to do what seems like a simple thing in darcs, monotone,
>> mecurial, gnu arch, etc, but seems nearly impossible in git.  There'=
s a
>> central repository, a long ways away on the other side of the intern=
et.
>> So I want a local repository cache.  I'm going to be working on a nu=
mber
>> of different features and different machines all simultaneously so I
>> really don't want them all to be pulling from the central repository=
=2E
>>
>> In other systems, this is a simple star network.  Clone a repository=
,
>> use, push, pull, etc.  But with git, I can't push unless the cache
>> repository is bare, but if the cache repository is bare, then a chan=
ge
>> to the central repository will cause the two to become wedged since
>> neither can push or fetch the other.
> If the 'cache repository' is set up using "git clone --mirror" and yo=
u
> push to the primary repository only, that makes the cache repo a
> definite slave, so you can always run "git fetch" on it without any
> trouble. You can even enforce this by denying all pushes to the cache
> repo, thus eliminating any chance of accidental misuse.
>
> Conveniently, git allows you to specify a different URL for fetch and
> push in your local working repositories.
Thank you.

=46or completeness, Michael Witten posted details for a comparable=20
architecture where the data flow is in the other direction.  Leaf=20
repositories push/pull to/from the cache, pull from the central=20
repository in order to merge changes, then push to the cache to share=20
locally.  Eventually, some leaf repository will push to the central.

Michael's approach has the advantage that the cache repository can be=20
unattended and that my changes can be circulated locally before becomin=
g=20
visible to the wider, central repository audience.

Both approaches cleverly avoid potential collisions in the cache=20
repository by working around them.  And, of course, some combinations o=
f=20
the two will work too.

--rich
