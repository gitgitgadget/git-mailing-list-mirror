From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [IRC/patches] Failed octopus merge does not clean up
Date: Wed, 17 Sep 2008 10:11:02 +0200
Message-ID: <200809171011.06714.jnareb@gmail.com>
References: <200809160048.31443.trast@student.ethz.ch> <200809170053.15341.jnareb@gmail.com> <48D0A776.1000009@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 17 10:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfs9C-0000D4-OO
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 10:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYIQILS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 04:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbYIQILS
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 04:11:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:51016 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbYIQILQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 04:11:16 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1712036nfc.21
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QmdEwPVvXwQBF5a6qx35P0m1q5CVo0jJFshi00PFeAc=;
        b=K55rqEDK2p3wWXrXT3qsyjrnWzLVdEjxpusb2rYJS0tjP83F0Y7U3kk2EuvCUy6Hp3
         xqOsO+SxMH0W3DqLYwPtRK3HKONy4ZEFmbCG+zHQilnovpBt8fandGjHrhmTeRn6oxGu
         6b9DHUc4aRQpKHte9tIIFV8kmBtQFOdvhuSdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=k0eyN386r05uIXVKVjHtHPzxdLAyTle5zXTn4IKznNjbbNYau9I+tYEBWSUwuspSx5
         2mURMqvPe8hoZ5shRiVXma4tecZaD4bj4XPEJU6S7Z6/Hv9c0D33rc6rEGLhRyaKC5Z3
         oKUJpfMpUdzSsx7R+JrDD8O80dXj93JSA56yE=
Received: by 10.86.58.3 with SMTP id g3mr1648252fga.58.1221639074367;
        Wed, 17 Sep 2008 01:11:14 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.173])
        by mx.google.com with ESMTPS id l19sm17856537fgb.7.2008.09.17.01.11.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 01:11:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48D0A776.1000009@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96073>

Andreas Ericsson wrote:
> Jakub Narebski wrote:
> > Junio C Hamano wrote:

>>>  (1) while it merges other heads one-by-one, it gets conflicts on an
>>>      earlier one, before it even attempts to merge all of them.  Recording
>>>      the heads that it so far attempted to merge in MERGE_HEAD is wrong
>>>      (the result won't be an Octopus the end user wanted to carete), and
>>>      recording all the heads the user gave in MERGE_HEAD is even more
>>>      wrong (it hasn't even looked at the later heads yet, so there is no
>>>      way for the index or work tree to contain anything from them).
>>>
>>>      The above is hitting this case.
[...] 
 
>> BTW. does it mean that "git merge a b" might be not the same as
>> "git merge b a"?
>> 
> 
> No. Git merges all the sub-things together and then merges the result
> of that jumble into the branch you're on.
> 
> Someone might have to correct me on that, but that's as far as I've
> understood it.

>From what I understand from above explanation, and from thread on git
mailing list about better implementation of and documenting finding
merge bases for multiple heads, I think octopus merge is done by merging
[reduced] heads one by one into given branch.

This means that "git merge a b" does internally "git merge a; git merge b"
as I understand it.
-- 
Jakub Narebski
Poland
