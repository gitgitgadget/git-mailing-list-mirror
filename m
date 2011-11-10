From: Antoine Bonavita <antoine@stickyadstv.com>
Subject: Re: Problem with git-svn with limited SVN access
Date: Thu, 10 Nov 2011 09:36:29 +0100
Message-ID: <4EBB8D0D.3060004@stickyadstv.com>
References: <4EBA63CA.7000201@stickyadstv.com> <201111092338.26164.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROQ86-00087T-Dc
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508Ab1KJIg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 03:36:58 -0500
Received: from mail.stickyadstv.com ([82.66.240.3]:40401 "EHLO stickyadstv.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755351Ab1KJIg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 03:36:57 -0500
Received: by stickyadstv.com (Postfix, from userid 783)
	id AC636D75B; Thu, 10 Nov 2011 09:35:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on stickyadsserver
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,AWL,
	TVD_PH_SUBJ_META autolearn=no version=3.2.5
Received: from [192.168.0.11] (juv34-7-78-249-50-77.fbx.proxad.net [78.249.50.77])
	(Authenticated sender: antoine)
	by stickyadstv.com (Postfix) with ESMTPSA id 31895D75B;
	Thu, 10 Nov 2011 09:35:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110831 Fedora/3.1.12-2.fc14 Lightning/1.0b3pre Thunderbird/3.1.12
In-Reply-To: <201111092338.26164.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185219>

Thomas,

Thanks a lot for taking the time to look at my problem.

On 11/09/2011 11:38 PM, Thomas Rast wrote:
> Antoine Bonavita wrote:
>> ### If I try to add one of the branches manually:
>> branches =3D branches/XXX:refs/remotes/branches/XXX
>>   >  git svn fetch
>> One '*' is needed in glob: 'branches/XXX'
>
> I think having several fetch specs should do the trick, although I
> cannot easily test with actual permissions.
>
> You can start configuring the repo with
>
>    git init
>    git svn init svn://server/ -T trunk
>
> to get an initial layout.  The .git/config will look like
>
>    [svn-remote "svn"]
>            url =3D svn://server/
>            fetch =3D trunk:refs/remotes/trunk
>
> The clue is that the config says 'fetch', not 'trunk'.  Much like wit=
h
> git remotes, you can add more fetch specs along the lines of
>
>            fetch =3D branches/XXX:refs/remotes/svn/XXX
>
> or whatever layout you prefer.
I did what you suggested. Now my .git/config looks like:
[svn-remote "svn"]
         url =3D svn://server/aaa/AAA
         fetch =3D trunk:refs/remotes/trunk
        fetch =3D branches/XXX:refs/remotes/svn/XXX
  and here is the result:
 > git svn fetch
W: Item is not readable: Item is not readable at=20
/usr/libexec/git-core/git-svn line 1782

Error from SVN, (220001): Item is not readable: Item is not readable

Any other idea ?
Or is there a way to get more debug info from git-svn. May be it would=20
give us some insight on what it is trying to do and failing to.

Thanks,

Antoine.

>
> Please tell us whether that works even in the face of restrictions on
> branches/ itself :-)
>

--=20
Antoine Bonavita (antoine@stickyadstv.com)
Envoy=C3=A9 de mon PC. Moi je suis Fedora.
