From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Problem with a push
Date: Tue, 12 Jun 2007 10:07:15 +0100
Message-ID: <200706121007.17044.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com> <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, plexq@plexq.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 11:07:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy2Lb-0000IK-Gu
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 11:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbXFLJHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbXFLJHY
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 05:07:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25447 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbXFLJHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 05:07:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so116043ugf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 02:07:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P9oLk7alYyZPE52bmNxBS2pBlkWwLzsKf5PL66NHggU1jG+XsN5PhMXcq+iNPa4FKlda0fj/eJRsUdpCe8Bci+3r+WDvv9+AM3V8kusXZHIFEypB8Wy/rC61lw1U7PkDNv+G7uC5twvK1EH0ULVCQxFIdbM5drBn7wQ6YbdMNP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kYIICEj1AhCamzAHJIAuhF2bfZhjLxATUmkKaUTib7mt4mOXoVVW7tF9IyGGHK3Z0E1fkkiR56TvrWOfdGO+WlKTIEpbxNwvV7STttTXgLqoCksaQ77f9agHUee5IBeKUhg4Wu/On8ia+v6EybY/4PNhOZqpAODbGHE2ALiUJn0=
Received: by 10.66.249.16 with SMTP id w16mr377398ugh.1181639241593;
        Tue, 12 Jun 2007 02:07:21 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z37sm15634484ikz.2007.06.12.02.07.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2007 02:07:20 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49938>

On Tuesday 2007 June 12, Linus Torvalds wrote:

> Ok, pushing out remote branches is a bit odd in the first place. As in
> "you probably shouldn't do that". The "remote" branches are really local
> to each repo, and updating them by pushing is really quite suspect.

I agree its odd, but is it really true that one (I) shouldn't be doing it?

Can I tell you what I'm doing, and check that it's not crazy...

I have my laptop and my desktop computer; I use both for development.  I've 
set them so that they are symmetric...

laptop:.git/config
 [remote "desktop"]
   url = ssh://blah blah blah
   fetch = refs/heads/*:refs/remotes/desktop/*
   push = refs/heads/*:refs/remotes/laptop/*

desktop:.git/config
 [remote "laptop"]
   url = ssh://blah blah blah
   fetch = refs/heads/*:refs/remotes/laptop/*
   push = refs/heads/*:refs/remotes/desktop/*

This is very handy, as git-push on one does the same as git-fetch on the 
other.  Have I made a glaring mistake by pushing to a remote ref?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
