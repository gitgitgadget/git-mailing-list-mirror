From: Woody Wu <narkewoody@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 07:41:33 +0000 (UTC)
Message-ID: <slrnkctj37.mmj.narkewoody@zuhnb712.local.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
 <CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
 <slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
 <CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
 <1355722245-ner-6603@calvin> <slrnkctgqh.mmj.narkewoody@zuhnb712.local.com>
 <1355728904-ner-4851@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 08:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkVKz-0008DD-4v
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530Ab2LQHlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:41:52 -0500
Received: from plane.gmane.org ([80.91.229.3]:39656 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab2LQHlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:41:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TkVKr-00087R-L3
	for git@vger.kernel.org; Mon, 17 Dec 2012 08:42:01 +0100
Received: from 59.37.26.98 ([59.37.26.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 08:42:01 +0100
Received: from narkewoody by 59.37.26.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 08:42:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.37.26.98
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211654>

On 2012-12-17, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
> On Mon, 17 Dec 2012 07:02:46 +0000, Woody Wu <narkewoody@gmail.com> wrote:
>> On 2012-12-17, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
>> > 'git checkout foo' has special meaning if a local branch with that
>> > name doesn't exist but there is a remote branch with that name. In
>> > that case it's equivalent to: git checkout -t -b foo origin/foo.
>> > Because that's what people usually want.
>> 
>> I think this is what exactly happened to me in the first time I got the
>> 'foo'.  One new thing to me is the '-t'.  I am not sure wether the '-t'
>> was used or not in the background.  How do I check the 'upstream'
>> relationships?  Is there any file under .git recoreded that kind of
>> information?
>
> Yes, that information is recorded in a file somewhere in .git. However, for
> most users it's irrelevant which file it is. Git has commands to access this
> information. Try one of these:
>
>   git branch -vv

Run this on my local linux tree, I got:
  lgf2410-2.6.16.4         7af1fda - added a ignore rule in .gitignore
  (*~)
  * lgf2410-2.6.34.13        50d3f9d ax88796b verbose debug output
    lgf2410-2.6.34.13-16C554 3ec82e0 more debug on 16C554
      master                   9489e9d [origin/master] Linux 3.7-rc7

Does this mean, I only have local branch master tracked to remote?


>   git remote show origin
Running this I got,

    ...
    linux-3.1.y    tracked
    linux-3.2.y    tracked
    linux-3.3.y    tracked
    linux-3.4.y    tracked
    linux-3.5.y    tracked
    linux-3.6.y    tracked
    linux-3.7.y    new (next fetch will store in remotes/origin)
    master         tracked
  Local branch configured for 'git pull':
    master rebases onto remote master
  Local ref configured for 'git push':
    master pushes to master (local out of date)

I am curious to know how the last 4 lines were printed by git.

  -----
  Local branch configured for 'git pull':
    master rebases onto remote master
  -----

If I have addtional branch other than master that also track to some
remote branch, will it also be listed under this 'git pull' line?

  ----
  Local ref configured for 'git push':
    master pushes to master (local out of date)
  ---

This I totally don't understand, what it mean? I think I did not do a
modification on the local 'master'.

Thanks!

-- 
woody
I can't go back to yesterday - because I was a different person then.
