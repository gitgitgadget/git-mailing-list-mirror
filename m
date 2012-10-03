From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Wed, 03 Oct 2012 15:35:31 +0200
Message-ID: <506C3F23.9000009@web.de>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com> <506A9EA6.9010303@gmail.com> <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com> <CACsJy8CUK0g4FhuJxzJqN7qS2apoO2zYdg_SGvWzEN5dGcHhaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:36:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJP7K-0002bm-MI
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242Ab2JCNfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 09:35:39 -0400
Received: from mout.web.de ([212.227.15.4]:62124 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197Ab2JCNfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 09:35:38 -0400
Received: from [192.168.178.41] ([91.3.173.123]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MOilO-1TNEKf0LNm-0066Tv; Wed, 03 Oct 2012 15:35:36
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CACsJy8CUK0g4FhuJxzJqN7qS2apoO2zYdg_SGvWzEN5dGcHhaA@mail.gmail.com>
X-Provags-ID: V02:K0:CAce1wAoBhuBx7fjf2FlwoY3o+YHRh8VkL+mYVBu+nM
 qJYFVrCRN3Jrnc3K4JFbkD+IjX2ncgX6mPLziXKNT22DWc8q+T
 GCZpRdHWV5fWIKPQxZU4qg8RfaihGzanvmLAOeL3OJDzMfoeJo
 nOu2QvbkxbmzoeRplqPF77Y0ABREfmObxpXwWKZpbtV3iRN0mn
 wz0rL8D3bamWqss3sXuFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206892>

Am 03.10.2012 13:35, schrieb Nguyen Thai Ngoc Duy:
> On Tue, Oct 2, 2012 at 3:24 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> Stefano Lattarini wrote:
>>> On 10/02/2012 09:21 AM, Ramkumar Ramachandra wrote:
>>>> Hi,
>>>>
>>>> I've often found the '**' (extended) shell glob useful for matching
>>>> any string crossing directory boundaries: it's especially useful if
>>>> you only have a toplevel .gitignore, as opposed to a per-directory
>>>> .gitignore.  Unfortunately, .gitignore currently uses fnmatch(3), and
>>>> doesn't recognize '**'.  Would extending the .gitignore format to
>>>> accept this be a useful feature?  Would it involve re-implementing and
>>>> extending fnmatch, or is there some other way?
>>>>
>>> I think there is a topic in flight about this:
>>>
>>>     <http://thread.gmane.org/gmane.comp.version-control.git/206406>
> 
> While I'm behind this series, I have no use cases for it in my
> repositories. It's tested in git test suite but that's about it. Some
> feedback would be nice, especially on the performance side if you do a
> lot of ignores.

I really like it as we do have use cases at my dayjob. Due to our
naming conventions in subdirectories we have stuff like this in our
.gitignore files:

*/foo/bar
*/*/foo/bar
*/*/*/foo/bar

Using "**/foo/bar" instead would be a great improvement (I looked
into adding that myself some time ago, but decided it wasn't a low
hanging fruit).

Maybe I'll find time do do some performance measurements until the
weekend, what numbers are you interested in? Will a hot cache "time
git status" be sufficient or are you interested in other numbers too?
