From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Set core.ignorecase globally
Date: Fri, 02 Nov 2012 21:05:16 +0100
Message-ID: <5094277C.4060207@web.de>
References: <6DB2AD2A-6531-497E-B87E-0E884C4BCFBE@jetbrains.com> <20121102190337.66a08366de41d29e745b0e4c@domain007.com> <20121102191516.e8b7d448ff76b45990e14b1d@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:05:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUNUi-0001Ga-As
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 21:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab2KBUFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 16:05:19 -0400
Received: from mout.web.de ([212.227.15.3]:63025 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab2KBUFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 16:05:18 -0400
Received: from [10.1.101.73] ([212.51.26.5]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Ls8xf-1TNfzq1A3L-013NJw; Fri, 02 Nov 2012 21:05:13
 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <20121102191516.e8b7d448ff76b45990e14b1d@domain007.com>
X-Provags-ID: V02:K0:wBrwZEy+4nP61CItdpt7e7Prp90+7uCrJW9jdT3W0sV
 lzzmoSylp5LCEDs/r3rWeMCdq8Di/dOxA6LKhEZfkBe74KS5on
 J1UqTj6W+NY5pEHlCCBkk3J6xDwDEBbSzTIxRVMFmCEAjic963
 bKRv5FGh+l8rEuCTG6/WiJq+rMk/GqVFr4m4eiQfx45jOVktDO
 PSI9JTYKOx87jGo6J5TBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208970>

Am 2012-11-02 16:15, schrieb Konstantin Khomoutov:
> On Fri, 2 Nov 2012 19:03:37 +0400
> Konstantin Khomoutov <flatworm@users.sourceforge.net> wrote:
>
>>> Currently, core.ignorecase is set to true on case insensitive system
>>> like Windows or Mac on `git init` and `git clone`, and this setting
>>> is local to the created/cloned repository.
>> [...]
>>> I suggest to set this globally by default when Git is installed,
>>> because there is little sense to have this option false on case
>>> insensitive systems (it will lead to confusions when renaming a file
>>> by changing only the case of letters).
>>
>> Case sensitivity is a property of a file system, not the OS.
>> What if I mount a device with ext3 file system via ext2fsd driver in
>> on my Windows workstation?  extN have POSIX semantics so it's
>> pointless to enforce case insensitivity on them.  The same possibly
>> applies to NFS mounts.
>>
>> Also note that NTFS (at least by default) is case insensitive but is
>> case preserving, observe:
> [...]
>
> On the other hand, on NTFS, if I unset core.ignorecase or set it to
> false locally, `git mv foo Foo` fails to rename a tracked file "foo"
> with the "destination file exists" error.  I would say I would expect it
> to work under the conditions I've just described.  Not sure if this
> thould be considered a bug in Git for Windows or not -- would be great
> to hear opinions of the msysgit port developers.

I once made a patch for git and we concluded that is is not worth
to put that into main git because you always can do:

git mv foo tmp && git mv tmp Foo
or
git mv -f foo Foo

(But use the -f option with care)
/Torsten
