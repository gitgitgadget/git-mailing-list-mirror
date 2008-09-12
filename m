From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 20:03:20 -0400
Message-ID: <48C9B1C8.9070007@gmail.com>
References: <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <48C90F06.4000309@gmail.com> <20080911123902.GB2056@cuci.nl>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 02:04:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdw9N-0005n4-GK
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 02:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbYILAD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 20:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbYILAD3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 20:03:29 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:46956 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbYILAD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 20:03:27 -0400
Received: by gxk9 with SMTP id 9so17913743gxk.13
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 17:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=b0nxQJWXt7F7wT7HvpF6VdXKo6cpQIiK05RvVJ1iF/4=;
        b=mr+qGRPyquYU1N7kmcwFdJEfm9Py4k/H/nk77tyValWHPPZAV12+LsMV2N+12dlfXV
         kmiaPRtFhW7MU+w/C/+3hfejTxtxav+Ivg0HsGSpk5jLo4w1umwWyxS5G9r2j9pBhknI
         5+lUqidKlGK1VuCvyv4/Brg0GWNW+dAyHFhhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=nT/jxvJxzXiz3Q7baHdXxs0JpFAVozfvkKLoPE3bN7AIWGRnzfCfbyGn126Qk0VeKI
         ne9Tl9EPbYq/CdBUsAqvfTqekl/RGrZKR9OWFJWOUt24rvvBR0Xui8w7hU3rKwZnH7o3
         iKHkp9kVxInb9iiUjMLb06aYmH62IBscIvIcg=
Received: by 10.100.178.7 with SMTP id a7mr4396249anf.94.1221177806439;
        Thu, 11 Sep 2008 17:03:26 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id d29sm17658650and.12.2008.09.11.17.03.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 17:03:25 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20080911123902.GB2056@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95674>

Stephen R. van den Berg wrote:
> A Large Angry SCM wrote:
>> Stephen R. van den Berg wrote:
>>> If you fetch just branches A, B and C, but not D, the origin link from A
>>> to D is dangling. 
> 
>> I do not understand how this can be considered an acceptable behavior. 
>> If an object ID is referenced in an object header, particularly commit 
>> objects, fetch must gather those objects also because to do otherwise 
>> breaks the cryptographic authentication in git.
> 
> No it does not.
> The cryptographic seal is calculated over the content of the commit,
> which includes the hashes of all referenced objects, but doesn't include
> the objects themselves.
> The content of the commit is not violated.

The fetch MUST gather the referenced objects ALWAYS or I can't verify 
the history. To do otherwise means that ID strings on the origin lines 
are nothing more than an arbitrary text tag and not pointer to a 
specific history.

> 
> Do not forget though:
> - origin links are a rare occurrence.
> - When they occur, they usually were made to point into other (deemed)
>   important public branches.
> - Due to the fact that the branches they are pointing into are important
>   and public, in most cases the origin links *will* point to objects you
>   actually already have (even if you fetched from someone else).
> - The only time you're going to have dangling origin links is when
>   they were pointing at someone's private branches, in which case it was
>   not very prudent of the committer to actually record the link in the
>   first place.  But nothing breaks if you don't have his private branch
>   locally.

How do I verify (think git-fsck) that what the origin lines refer to 
are, in fact, commits with the proper relationships? Either they HAVE to 
be in the repository or the references do not belong in the header.
