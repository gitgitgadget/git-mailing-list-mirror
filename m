From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 12:02:36 -0600
Message-ID: <20101207180236.GC21483@burratino>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <20101207162358.GT355@fearengine.rdu.redhat.com>
 <20101207174520.GB21483@burratino>
 <20101207175418.GU355@fearengine.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:02:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ1sL-00029P-Gb
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab0LGSCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:02:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35681 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab0LGSCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:02:47 -0500
Received: by vws16 with SMTP id 16so191654vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0eHdseI7RBhGmqCsGX32uBd39ZT1Uwv/NPs9E97EF9M=;
        b=uUtT15y/fQ/edxMuyGp28F9d39LfTDhBoYvAjoFf7VYBrTEm4BfSdTE2EYJ5EvV0RO
         PpeB1Il7Yqn9VeBjHktvhVnrhbmXEYQNcp19lab8esz97Ieu6w7uYyMIHcsaJK6+shKg
         p2vkHMtb9h2j7HQbisJ4eq6l/f2hqxEKTTCdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n8cBlr9Rcb+Doah0gZ5smUncC3Yj/HupChHJqX58aE4Io+JTT+2PX5pnfacCJTPKsd
         0ws0n8MNcvclERaGYbD383KT7kyj9YpZkpuLuBdY7UswixgwRAk8LW5J8jDyQo8yh1NW
         tDsCIegKyyTV9+OW2bVJELce0JSINjUtaSB60=
Received: by 10.220.176.77 with SMTP id bd13mr1042667vcb.16.1291744965958;
        Tue, 07 Dec 2010 10:02:45 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id g27sm2330736vby.14.2010.12.07.10.02.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 10:02:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207175418.GU355@fearengine.rdu.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163098>

Casey Dahlin wrote:
> On Tue, Dec 07, 2010 at 11:45:20AM -0600, Jonathan Nieder wrote:
>> Casey Dahlin wrote:

>>> Could commits made onto a detached head also show up here? Or is that
>>> better thwarted with another mechanism?
>>
>> I think that's better thwarted with the HEAD reflog:
>> 
>> 	$ git log -g HEAD
>
> I was more worried about changes that were made onto a detached head,
> and then the head was reattached, leaving the new commits dangling.

But isn't that exactly what a detached HEAD is for?  If one wants
the experiments one does on detached HEAD to be kept around "just
in case", wouldn't it make more sense to give them a (branch) name so
they can be separated from one another?

In other words, I do not see the connection yet.  Maybe it would be
best to propose another patch on top to do that?  (Patches often come
with documentation, which means clear explanation of use cases, which
would address my worry here.)
