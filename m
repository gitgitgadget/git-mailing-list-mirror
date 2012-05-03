From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 11:26:20 -0700
Message-ID: <4FA2CDCC.6020303@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com> <86aa1rmvhb.fsf@red.stonehenge.com> <4FA05E9F.9090709@palm.com> <85ff02fc05e4a52ee0b1f1922f774a8d@ulrik.uio.no> <947c3d6ae263495985543764a57c3fbb-mfwitten@gmail.com> <63c4e1944dcfd03e8c9ff324080ff62f@ulrik.uio.no> <e7c7047452954a4b80f5fd436103cb11-mfwitten@gmail.com> <f66919ac273fd1c90839e5556f126960@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu May 03 20:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ0jT-00026W-2B
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 20:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab2ECS0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 14:26:22 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:38969 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab2ECS0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 14:26:21 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2012 14:26:21 EDT
X-IronPort-AV: E=Sophos;i="4.75,526,1330934400"; 
   d="scan'208";a="13293688"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 03 May 2012 11:26:21 -0700
Received: from fuji.noir.com ([10.100.2.12])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q43IQKtX018018;
	Thu, 3 May 2012 11:26:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <f66919ac273fd1c90839e5556f126960@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196928>

On 5/3/12 09:20 , Hallvard Breien Furuseth wrote:
>   On Thu, 03 May 2012 16:09:15 -0000, Michael Witten wrote:
>> On Thu, 03 May 2012 14:23:59 +0200, Hallvard Furuseth wrote:
>>> I mean 'git clone --bare bar.git foo.git' does not give foo.git
>>> a remote named 'origin' with a branch origin/master.  Not sure
>>> if there is a _simple_ way to do it well either.  init + fetch
>>> above does not try to hardlink objects/packs like clone does.
>>>
>>>> (...)
>>>>    $ git init bar.git; cd bar.git
>>>>    $ echo a>  a; git add a; git commit -m a; cd ..
>>>>    $ git clone --bare bar.git foo.git; cd foo.git
>>>     $ git branch -a
>>>     * master
>>  From `git help clone':
>>
>>    --bare
>>        Make a bare GIT repository. That is, instead of creating
>>        <directory>  and placing the administrative files in
>>        <directory>/.git, make the<directory>  itself the $GIT_DIR.
>>        This obviously implies the -n because there is nowhere to
>>        check out the working tree. Also the branch heads at the
>>        remote are copied directly to corresponding local branch
>>        heads, without mapping them to refs/remotes/origin/. When
>>        this option is used, neither remote-tracking branches nor the
>>        related configuration variables are created.
>   Yes, I know.  I just don't know why.
I do.

It's because creating a string of repositories is a nuisance in git 
because of the remote/foo practice.  You have to manually fetch and 
merge at each location.

In other systems, the branches are tracked identically.  You see master, 
I see master.  The only differences we see are any changes I've created 
that haven't yet been pushed to you or vice verse.  But since git can't 
handle collisions in the repository the way other systems do, it's 
forced to use the geographic branch scheme for non-bare repositories.  
Bare repositories don't have the collision between repository branch and 
working directory copy in git, so with bare repositories, git can use 
the identical branch scheme, (although it still refuses colliding pushes).

If bare repositories used the triangulation approach of non-bare 
repositories, then automation would be considerably more complicated.  
So would repository chaining.

What I don't understand is why git chose this less functional 
architecture over the previously existing practice that doesn't have 
these limitations, although "because that's what BitKeeper did" might be 
the sad answer.

--rich
