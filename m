From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: 'git commit' duplicates parents?
Date: Mon, 20 Jun 2005 19:20:37 +0200
Message-ID: <42B6FAE5.6060904@gmail.com>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org> <42B62C85.10701@pobox.com> <Pine.LNX.4.58.0506191958010.2268@ppc970.osdl.org> <42B690EA.2080605@gmail.com> <Pine.LNX.4.58.0506200808090.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 19:16:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkPrt-0003bM-VF
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 19:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFTRVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 13:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVFTRVB
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 13:21:01 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:49899 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261393AbVFTRUo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 13:20:44 -0400
Received: by zproxy.gmail.com with SMTP id 13so847524nzn
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 10:20:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RzfOXqRAo1YXf/o0L8YvOLxRLPlfrsEvUOreV1PYeVbetOeKv5neLhTfEMT8nr9goEkOEv1W1kBmYGPL9Trzxbv61g5i4hW4SlxWAJrTlMi59n4aeLo3RZL8naKbml6byHA8Ze0+PS6e8Q/oScgCja1mLWhL8j2aR7AoIr951YM=
Received: by 10.36.158.4 with SMTP id g4mr542289nze;
        Mon, 20 Jun 2005 10:20:40 -0700 (PDT)
Received: from ?10.0.1.4? ([80.217.78.97])
        by mx.gmail.com with ESMTP id 40sm1617592nzf.2005.06.20.10.20.40;
        Mon, 20 Jun 2005 10:20:40 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506200808090.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 20 Jun 2005, Dan Holmsand wrote:
> 
>>git-resolve-script still seems a bit too eager to write MERGE_HEAD and 
>>ORIG_HEAD - they only make sense if there's actually been any merging 
>>done, don't they?
>>
>>Patch below shows what I mean.
> 
> 
> I considered this, but decided that MERGE_HEAD is potentially very useful
> for some of the other failure exits. There's a few "exit 1"'s in there,
> for example when the "git-read-tree -m"  fails because of a dirty
> workspace.

Yeah, but that was exactly what I was after...

As far as I understand it, the git-read-tree -u -m doesn't actually do
anything when the workspace is dirty - so there's actually no merging 
going on, right?

If you react to the dirty-workspace-warnings in such a failed merge by 
"git commit-ing" (and not noting the MERGE_HEAD warning, which has been 
known to happen), you'll end up with an unwanted parent in the commit.

Or am I just being stupid :-?

/dan
