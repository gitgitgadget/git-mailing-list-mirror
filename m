From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Where did Documentation/perf_counter disappear from linux-2.6-tip.git
 ?
Date: Tue, 22 Dec 2009 19:18:40 +0100
Message-ID: <4B310D80.4010502@gmail.com>
References: <4B3099A5.6040808@gmail.com> <7vmy1a3mrh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:19:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN9KD-0005oJ-NF
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 19:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbZLVSSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 13:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbZLVSSo
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 13:18:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36954 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZLVSSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 13:18:43 -0500
Received: by bwz27 with SMTP id 27so4306249bwz.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=sBi+xkocvIQhhy8s/nwChNmwsT33DZlMZFmK6bnYpfs=;
        b=F9CK3SiTNQ614Dx2pTkY7OH+tEaD9rJqojcW7c4Q3Naa5Fxc1gu325Hm0CctaEy+FO
         yLoWds/wHySuXF0y3uzQi//5zFEfdSvBpbL+PTACePtwJyhzjS/Vfexe3jTE9XmdQgWM
         WCSkIEJAUoLDA5GMKDCDoYYsFUbHjlGu9Lrt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=s1TS3sOlFh0xUbDa6Zl9RCI5lA+bBuPkBlg3vCy5j4g+H5MMWjFE9C+V2oTEdmAmi9
         zN4/r5BH6NpxNVafdouNs3a18WAkRGkdJhjKYTN2SH7lasb/gvr1O+jxIDPHV6XB5czh
         1cR5OC6OjIGXTYuTtbObEqQyaSnvsKiyD/Xbw=
Received: by 10.204.2.211 with SMTP id 19mr378174bkk.6.1261505922409;
        Tue, 22 Dec 2009 10:18:42 -0800 (PST)
Received: from calvin.caurea.org (gw.ptr-62-65-141-13.customer.ch.netstream.com [62.65.141.13])
        by mx.google.com with ESMTPS id 15sm1960672bwz.8.2009.12.22.10.18.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 22 Dec 2009 10:18:41 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.3a1pre) Gecko/20091222 Lightning/1.1a1pre Shredder/3.1a1pre
In-Reply-To: <7vmy1a3mrh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135590>

On 12/22/09 7:08 PM, Junio C Hamano wrote:
> Tomas Carnecky<tomas.carnecky@gmail.com>  writes:
>
>>   $ git --version
>> git version 1.6.6.rc4
>>
>> # Documentation/perf_counter is missing from the master branch, so
>> first let's find
>> # out what the last commit was that touched that subdirectory:
>> $ git log --all -1 -- Documentation/perf_counter
>> commit 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
>> Author: Peter Zijlstra<a.p.zijlstra@chello.nl>
>> Date:   Tue Jun 2 21:02:36 2009 +0200
>> ...
>> M       Documentation/perf_counter/builtin-report.c
>>
>> # Great, let's look in which branch that commit is
>> $ git branch --contains 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
>> * master
>>
>> # So, let's look at the log of master and limit it to that subdirectory:
>> $ git log master -- Documentation/perf_counter
>> $
>
> Add --full-history so that you would get _all_ possible explanation of the
> history, perhaps?
>
> In a history with this shape:
>
>      ---A---B---C---D---E
>              \     /
>               F---G
>
> suppose that
>
>   - commit F introduces a path;
>   - commit G removes the path;
>   - no other commit has the path in question.
>
> Without --full-history, "log E -- path" is asked to give "_one_ possible
> way to explain the current state of path in E" (iow, "why there is nothing
> there right now at E?").
>
> Two explanations are possible even in this vastly simplified toy history.
>
>   - It didn't exist in A, and none of the subsequent commits B, C, D that
>     lead to E did anything to change that.
>
>   - F added it, but G changed mind and removed it.
>
> When "log" encounters a merge commit while traversing the history
> backwards (in this case D) with paths limiter, if there is a commit among
> its parent whose tree matches its tree with respect to the paths, side
> branches leading to all the other parents are culled and only that one
> history is followed to explain the history.  In this case, neither C or D
> has the path, so their trees with respect to the paths limiter match, and
> git doesn't follow the side branch that has F and G without
> --full-history.

I've never used nor seen --full-history before, but it did help in this 
case, git log now correctly sees the commits touching that subdirectory. 
Thanks for the explanation.

tom
