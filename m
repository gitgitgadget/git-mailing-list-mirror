From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: dangling blob which is not dangling at all
Date: Wed, 1 Aug 2007 16:21:39 +0200
Message-ID: <20070801142139.GA16607@raptus.dandreoli.com>
References: <20070801013450.GA16498@raptus.dandreoli.com> <alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org> <20070801063209.GA13511@raptus.dandreoli.com> <7vhcnjbtpt.fsf@assigned-by-dhcp.cox.net> <20070801074237.GA14790@raptus.dandreoli.com> <46B045D3.4070208@midwinter.com> <46B04EB7.80006@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 16:22:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGF5C-0005QJ-Iu
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 16:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764348AbXHAOVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 10:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764315AbXHAOVl
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 10:21:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:51906 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764236AbXHAOVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 10:21:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so58973nfb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 07:21:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MeR0uemYjTyNZt/h036qGhWggoQLOdNKa7a3rExveAcMZ+U8c5CRL+OL8/oHMoWJ1O7bQw0zAPBVW9RI1R8y4/mVHnmdaKZUyn4jMLorD02c5pWwAw7XMzVjmv/B8fWuf/bDMBnGKewV2ZzaqWdg61ywGZ4X4zOsIYz2Bae0IdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=eg5sPJniVKfjLLS8lDBkksQx4YsZmH5BSNYbtzB72DiUkHcZsb/n2WyhtPAg/8sg9rjmjP+uBh/BE3yJ8/jhpsXS+Nm/MUVOMxaZ531Fw3VsAcpuIR1GIcnmREmCKDMIkxTUI/xEyaStqrfDJUKUHTuCAVj7hgML63lvLS58CMk=
Received: by 10.86.100.7 with SMTP id x7mr592199fgb.1185978098321;
        Wed, 01 Aug 2007 07:21:38 -0700 (PDT)
Received: from raptus.dandreoli.com ( [159.149.71.27])
        by mx.google.com with ESMTPS id 22sm1580231fkr.2007.08.01.07.21.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 07:21:37 -0700 (PDT)
Received: by raptus.dandreoli.com (Postfix, from userid 1000)
	id B543484563A; Wed,  1 Aug 2007 16:21:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46B04EB7.80006@dawes.za.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54439>

On Wed, Aug 01, 2007 at 11:13:27AM +0200, Rogan Dawes wrote:
> Steven Grimm wrote:
>> Domenico Andreoli wrote:
>>> What is this reflog thing and why is required?
>>>   
>> It is a log of where each ref pointed at any given time. Or rather, a log 
>> of changes to refs, with timestamps. It is not *required* per se (you can 
>> turn it off and almost all of git will continue to work as before) but 
>> it's handy in that you can say stuff like
>> git checkout -b newbranch master@"{4 days ago}"
>> and git will give you a new branch pointing at the rev that master pointed 
>> to 4 days ago, even if it's a rev that is no longer reachable from any of 
>> the existing heads (e.g., because you did a "git rebase" and the rev in 
>> question was replaced by a new one.) Obviously as soon as you do a "git 
>> gc" you will lose the ability to go back to unreachable revs using the 
>> reflog.
>
> Not strictly true. "git gc" does take the reflogs into account when 
> determining reachability, but it also prunes the reflogs periodically to 
> prevent them from growing without bound (and preventing pruning of 
> otherwise unreachable objects).

so, besides playing with head refs by hand and forcing pushing to
"not strict subset" heads, having dangling commits may be physiologic?

and the only way to leak commits is from heads? on the countary, has
one a severely broken repository?

many thanks,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
