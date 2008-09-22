From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] prev/next/tsort: commands to explore dependencies
Date: Mon, 22 Sep 2008 19:32:50 +0200
Message-ID: <36ca99e90809221032x3003c1f7q8ef09cb92a0473ad@mail.gmail.com>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080922153614.GO10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhpIN-0003vM-I5
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 19:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYIVRcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 13:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYIVRcy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 13:32:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:15499 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbYIVRcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 13:32:51 -0400
Received: by yw-out-2324.google.com with SMTP id 9so248187ywe.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OhDl5Xm+hg+QE6UNMqLRzBiEplwDC0TokXsplVweU5o=;
        b=bsA8oD87hxCePz4Fvu3WfBfmLpKhfSURIQ9eWSqNecyYrgPf1MKbUKJT3k513mIDNx
         wsIDeGHGwYdM6TjakYVC+7VG+1wNOUXeJsGO61N+daPBY/O9DQbTOOZQ7sP3gIzBPbUV
         ybIaqw+OY1qy2dDLS8gpNFhP6Rlv/AEApU7p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XH3tIH+IhbYFiy1U3ECTuKb6BkFo4xKr0RkIKVy+igZZ+RANkSeZziYDqgAmDmATa5
         1FSb/OrFEi4tT1gbYWPdlndYxViNLXHbYjqliu0LPLAi+eVeyf0FcwCk+/Qg+aw3bGdk
         L83GfWfSf6pj7Xhx+wd5kZBxBWX39GA5ZiUMI=
Received: by 10.151.13.7 with SMTP id q7mr7665835ybi.123.1222104770223;
        Mon, 22 Sep 2008 10:32:50 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Mon, 22 Sep 2008 10:32:50 -0700 (PDT)
In-Reply-To: <20080922153614.GO10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96500>

On Mon, Sep 22, 2008 at 17:36, Petr Baudis <pasky@suse.cz> wrote:
>  Hi,
>
> On Fri, Sep 19, 2008 at 11:55:00AM +0200, Bert Wesarg wrote:
>> I hacked 3 commands to explore the dependencies of TopGit patches:
>
>  thanks, the idea of all three commands is good,
>
>>   I) tg prev [NAME]
>>      outputs the dependencies of NAME
>>
>>  II) tg next [NAME]
>>      outputs patches that depends on NAME
>
>  but I think it would be cleaner to add this functionality to
> tg info...
Right, but 'tg next' is shorter than any 'tg info --next'.

>
>> III) tg tsort [PATTERN]
>>      outputs a topological order of all patches starting with PATTERN
>
> ...and tg summary (overally, to have a tree view of branches).
Maybe something like the graph output from git rev-log --graph?

>> +                                     printf "%s\t%q\n" "${dep_rev}" "${dep}" >&3
>> +                                     printf "%s\t%s\n" "${topic_rev}" "${dep_rev}"
>
> %q?

"and %q causes printf to output the corresponding argument in  a
format that can be reused as shell input."

I thought that this would be needed.

Bert
>
> --
>                                Petr "Pasky" Baudis
