From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 17:11:31 +0200
Message-ID: <200809121711.32448.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, Paolo Bonzini <bonzini@gnu.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAKc-0003p0-Ja
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYILPLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbYILPLq
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:11:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:54493 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYILPLp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:11:45 -0400
Received: by wx-out-0506.google.com with SMTP id h27so436259wxd.4
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uJdBc/xXdaFdxO5KcBWKSG3MrqjlyZkB5cCXqdNovNQ=;
        b=R+eUeUhgwa+45VaJd1vMEhNcpVxGlcxlJd+vuJgw6UClM+5+0urCl1h9JSHwrhzQU2
         L7C4uPcNnsrSproJBuTNNiG5wk11MEcxh6aoU8jY4R1KY2q6L5/NxdBnWvlyHnYNWurL
         4Q+OSPQBWzvjZx6Nr0nDIyJ3TNTZW51x2yiR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PtRFaQrTxcIhix44F0ulbeutR7w5x482CR+xgAF90ZowTgvVyIdkvf0JZihV+tflPv
         UpPUY5p0yHaJCH1D04gAj6CLTHdqZR35Ip8nFZuzhCdytroFfCmgBDM8VjdfApYRNBqF
         Jf23lqudXfc5leGGVYaTVltwsablGo+F2iQ7U=
Received: by 10.86.52.6 with SMTP id z6mr3315898fgz.18.1221232303044;
        Fri, 12 Sep 2008 08:11:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.211.228])
        by mx.google.com with ESMTPS id 3sm11111283fge.3.2008.09.12.08.11.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 08:11:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080912145802.GV5082@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95734>

Theodore Tso wrote:
> On Fri, Sep 12, 2008 at 07:47:39AM +0200, Stephen R. van den Berg wrote:
>>>
>>>You could add it as a 
>>>
>>>	Original-patch-id: <sha1>
>> 
>> That will probably work fine when operating locally on (short) temporary
>> branches.
>> 
>> It would probably become computationally prohibitive to use it between
>> long lived permanent branches.  In that case it would need to be
>> augmented by the sha1 of the originating commit.
> 
> Nope, as Sam suggested in his original message (but which got clipped
> by Linus when he was replying) all you have to do is to have a
> separate local database which ties commits and patch-id's together as
> a cache/index.
> 
> I know you seem to be resistent to caches, but caches are **good**
> because they are local information, which by definition can be
> implementation-dependent; you can always generate the cache from the
> git repository if for some reason you need to extend it. [...]

But it is not true that "you can always generate the cache from the
git repository" in this case; the patch-id that is to be saved is
_original_ patch-id of cherry-picked (or reverted) changeset.

OTOH it is not much different from reflog information, which also
cannot be regenerated from object database.
-- 
Jakub Narebski
Poland
