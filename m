From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Git, Builds, and Filesystem Type
Date: Thu, 9 Feb 2012 17:11:12 -0800
Message-ID: <CAE1pOi0=Sf7K=FaHW--z6AHSTKsmBWe-f75gXcdZivW_4T6g4Q@mail.gmail.com>
References: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com>
	<CAE5ih7_NkyJ6vGbyoKvQy65LFK3-zkXi79Xd6+3Si8DyUi47JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 02:11:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvf1C-0003hw-Un
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 02:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758324Ab2BJBLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 20:11:14 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44185 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729Ab2BJBLN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 20:11:13 -0500
Received: by ghrr11 with SMTP id r11so1257496ghr.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 17:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4tcWI/L282c6qm5tyw23zO5dxCU0mVm7vfgBnSrMLgU=;
        b=KilOnI/nnCy9YC0tqklyMmjc9mFuW9dLfg7yggb/WMyiJnsL+eFX4eBcAFnkH+1bZ0
         TCdx3oq/+WY8yTZVH50FFKNuG3MW6gfw5cSYJilrv+u+EDQcv2ghgaMQ54tngAD/HFsH
         DDTKHTf0UJOHMuOSb5Ptk5nQB6I+6emmHDu4Y=
Received: by 10.236.156.67 with SMTP id l43mr6058166yhk.73.1328836272691; Thu,
 09 Feb 2012 17:11:12 -0800 (PST)
Received: by 10.236.73.130 with HTTP; Thu, 9 Feb 2012 17:11:12 -0800 (PST)
In-Reply-To: <CAE5ih7_NkyJ6vGbyoKvQy65LFK3-zkXi79Xd6+3Si8DyUi47JQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190361>

On 9 February 2012 15:24, Luke Diamand <luke@diamand.org> wrote:
> On Thu, Feb 9, 2012 at 9:23 PM, Hilco Wijbenga <hilco.wijbenga@gmail.com>
> wrote:
>>
>> Hi all,
>>
>> I'm thinking about trying out different filesystems over the weekend
>> to see if, say, BTRFS or XFS is faster when using Git and running our
>> build.
>>
>> Currently, I'm using ReiserFS and it's not like it's not working. I'm
>> very pleased with ReiserFS but after seeing talks about BTRFS and XFS
>> I'm curious if another (newer) FS is better suited to our specific
>> environment. Anything to make the build a little faster. :-)
>>
>> For the record, our (Java) project is quite small. It's 43MB (source
>> and images) and the entire directory tree after building is about
>> 1.6GB (this includes all JARs downloaded by Maven). So we're not
>> talking TBs of data.
>>
>> Any thoughts on which FSs to include in my tests? Or simply which FS
>> might be more appropriate?
>
>
> Do people still use reiserfs? I thought development on that pretty much
> stopped years ago. And reiser4 never made it into the kernel. Read the wiki
> page for why.

As I said, reiserfs works fine so I see no need to replace it. I'm not
a big fan of ext3 (I've run out of inodes too many times) and I simply
haven't tried ext4. Apparently, it has some architectural problems but
I'm no expert.

> ext4, FTW!
>
> But whatever you use, you might find that the core.preloadindex config
> option helps. It certainly does for NFS.

I would like to think that my local hard drive has no latency issues?
Would this really be worthwhile even if I do not use some sort of
distributed FS?
