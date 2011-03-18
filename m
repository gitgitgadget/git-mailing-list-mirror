From: Raul Dias <raul@dias.com.br>
Subject: Re: same files on different paths on different branches
Date: Fri, 18 Mar 2011 10:12:37 -0300
Message-ID: <4D835A45.4070902@dias.com.br>
References: <4D82A1F4.4060801@dias.com.br> <1300440036.4261.29.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 14:11:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0ZSR-0002eK-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 14:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091Ab1CRNLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 09:11:00 -0400
Received: from rack.swi.com.br ([66.216.97.12]:34315 "EHLO rack.swi.com.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500Ab1CRNK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 09:10:56 -0400
X-Received-SPF: no SPF record found
X-Received-SPF: no SPF record found
Received: from [10.1.1.3] (unknown [187.112.180.199])
	(Authenticated sender: raul@dias.com.br)
	by rack.swi.com.br (Postfix) with ESMTPA id E66C131380C8;
	Fri, 18 Mar 2011 13:10:54 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Lightning/1.0b2 Thunderbird/3.1.8
In-Reply-To: <1300440036.4261.29.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169315>

On 03/18/2011 06:20 AM, Carlos Mart=C3=ADn Nieto wrote:
> On jue, 2011-03-17 at 21:06 -0300, Raul Dias wrote:
>> Hi,
>>
>> I want to know if the following is possible to accomplish with git.
>> (please reply to me too)
>>
>> A project is composed of many sub-modules (not in git sense).
>> These sub-modules are developed independently of the main project.
>> They need to be reattached to the projects' tree.
>>
>> The problems:
>>     1 - a sub-module's tree does not have any projects file.
>>     2 - when a sub-module is re-attached to the main project, its fi=
les
>> are spread in many places (different from the the sub-module layout)=
=2E
>>
>>
>> Ideally the project would understand which files are the same, even =
on
>> different places and apply the changes in the right files.
>> This way a merge/cherry picking would keep the history information.
>>
>> Is it possible to accomplish something similar to this?
>> I understand that this is not how a git super-project works.
>> I don't think it is possible with different git repositories.
>>
>> I tried with a empty branch technique.=20
>> Created an empty branch with no history.
>> Started a sub-module (non git) there and tried to propagate the chan=
ges.
>> Git almost did the right thing.
>> A change in branch submodule's
>>     /foo/a.txt
>> should have gone to branch master's
>>     /bar/foo/a.txt
>> but instead it went to
>>     /bar/somethingelse/a.txt (which is the same as /bar/foo/a.txt)
>  If the problem you are seeing here is that git reports the physical
> path instead of the logical one (compare `pwd -P` and `pwd -l`), then=
 it
> shouldn't really represent a problem, as the data is being written in
> the right places.
>
>> So is it possible to get closer to this with git  in a way or anothe=
r?
>  git uses almost exclusively physical paths internally, which is why =
the
> user sees them. For example, this also happens:
>
>    carlos@bee:~/apps$ mkdir one
>    carlos@bee:~/apps$ ln -s one two
>    carlos@bee:~/apps$ ln -s two three
>    carlos@bee:~/apps$ cd three
>    carlos@bee:~/apps/three$ git init
>    Initialized empty Git repository in /home/carlos/apps/one/.git/
>
>  Notice how git is reporting the "right" path.
>
>  Is this the effect you're seeing? Above it's not clear whether you'r=
e
> using symlinks in your file system or why /bar/somethingelse/a.txt is
> the same as /foo/a.txt.
No they are completely different files that happened to have the same
content at that point.

-rsd
