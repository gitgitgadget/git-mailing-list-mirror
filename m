From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How does git deal with hard links in source code?
Date: Mon, 23 Aug 2010 02:00:56 -0700 (PDT)
Message-ID: <m3fwy5og9p.fsf@localhost.localdomain>
References: <AANLkTik3858Kf6MSPALeNYrE6L=ixf=0s028+_ie_SW_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Kriticos <seth.kriticos@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 11:01:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnStr-0008Nm-78
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 11:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab0HWJBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 05:01:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38697 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab0HWJA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 05:00:59 -0400
Received: by wyb32 with SMTP id 32so6535842wyb.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Jz4V5X5yqEVaGujq5zCwaRj6Ib2QeOTEWWtKpujTM8U=;
        b=B6KnTIJs0Ph3jzVvcX3MzCsJfyHNl17SWehg0OXe5ZToMi2/3NTJEYtzF09Q101J/A
         7BT+IvVYv80hUGF1ATVRhism8OyF7UqjnHLP3Q0IQygwoSR5VY1dXApQWBoo5DKpw32Q
         ztO076UFnV3QifN2uhGfp6engJRR5ljp1tn6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ltisD9Ysi5QrYvOrQudvP44DUmSeSILedkkZgu3SHvrCLdM0/NUkgK3KBKQw9tbiKw
         m52mebdhwk1sCDHAXZ1ry8CXwhjsazOEP8HahP7YP5p7fmkpcNpSv/YsLU8fWRrVdq5p
         M7bLOtcovW1Sc8Bw/lX17hbRaIIoVj50H8G7U=
Received: by 10.227.72.141 with SMTP id m13mr4220775wbj.143.1282554056823;
        Mon, 23 Aug 2010 02:00:56 -0700 (PDT)
Received: from localhost.localdomain (abvo61.neoplus.adsl.tpnet.pl [83.8.212.61])
        by mx.google.com with ESMTPS id k7sm3463618wej.2.2010.08.23.02.00.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 02:00:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7N90YVG030369;
	Mon, 23 Aug 2010 11:00:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7N90Id9030365;
	Mon, 23 Aug 2010 11:00:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTik3858Kf6MSPALeNYrE6L=ixf=0s028+_ie_SW_@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154209>

Seth Kriticos <seth.kriticos@googlemail.com> writes:

> I've got a question my google-fu and the docs were not able
> to answer:
> 
> Is there a way to preserve the hard links that are within
> a git repository checkout (the stuff that is tracked by the
> git repository)?

No, there isn't, and there shouldn't.  Not all filesystems support
hardlinks.
 
> The use-case I have is the following: I want to have two
> different template directories for stuff in the tracked
> sources: a base one and some extended ones. I want to have
> the stuff from the base one hard-linked to the extended one,
> so changes in the base one change all the other depending
> templates too.
> 
> Now for testing I committed and pushed an instance of this
> and then cloned the repository, and it ate my hard links
> (checked out two separate copies of the files).
> 
> Is there a way to convince git not to eat my hard links
> without some complicated scripting magic and checkout hooks?

Make hardlinks on deploy.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
