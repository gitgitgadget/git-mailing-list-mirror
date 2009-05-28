From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: RFE: "git bisect reverse"
Date: Thu, 28 May 2009 21:29:26 +0100
Message-ID: <efe2b6d70905281329s1ae5a94coe5875714f341d5a9@mail.gmail.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 
	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 
	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 
	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com> 
	<4A1DC7D8.2050601@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu May 28 22:30:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mEe-0001tL-Sz
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757845AbZE1U3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759091AbZE1U3r
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:29:47 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49725 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbZE1U3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:29:46 -0400
Received: by ewy24 with SMTP id 24so5784898ewy.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Qst6wg4xImE+T8ABQKbng/jZZOHnRU/I9mCA+FHrwIc=;
        b=uiumrUx711LNWux6Bp8/XKG4RL1lSxK4vgaDVHo+f1F3Z6L68BaBe8YTNXaU6Nk78l
         3xTqZDrgeIqsXFTPOhuMFYHtXc9Ldw4Cg9DeFCCJDSKfbgvy/KqCNPvr8lQ2cjfbrG1H
         +gevB/+r0ej8rwVPabO/C9k7AnUYNUWZTFwWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TTNsHoBbQglSZGe6z+oMLMgV7x36xIY8muK57xzeCcP+ykx4/tuXD/gY8paS7NE8Dr
         iO0nKBu8tyUeljjYenaukTOtR8BBgL3408+klExaCIXj+CSJPipa5rRMPiQcPKzg6VhL
         fh5S8BJwt0MDMrPfhbvG5rYwpRfHFDJpoTU38=
Received: by 10.216.11.138 with SMTP id 10mr652386wex.51.1243542586384; Thu, 
	28 May 2009 13:29:46 -0700 (PDT)
In-Reply-To: <4A1DC7D8.2050601@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120224>

On Thu, May 28, 2009 at 12:08 AM, Sam Vilain <sam@vilain.net> wrote:
> Ealdwulf Wuffinga wrote:

>> [some time back] http://github.com/Ealdwulf/bbchop/tree/master

>> For git-bisect, Sam and H Peter are proposing a heuristic to trade off
>> between information gained and likelihood of testing a bad commit. For
>> bbchop, I am already doing calculating the information gain directly,
>> so if I can incorporate the probability that a commit is broken - has
>> to be skipped - then the trade-off will happen automatically.
>> Therefore it would be useful to have some plausible theory as to how
>> the probability of a broken commit should be calculated, given some
>> known-broken and known-not-broken commits.
>>
>
> Sounds like interesting stuff, can you make a patch out of it?

The code as it stands will actually work with an unmodified git.
What it doesn't yet have is a 'git-bisect'-like frontend, which is the only
part which would actually require modifying (or just adding to) git itself.

It does already interface to the git plumbing, so you can try it out if you
don't mind using a slightly ungitlike  interface.

I assume it's not worth doing a patch which would just copy my tree
into the git source tree?

There was also, last time I mentioned this on the list, some question
as to whether it was acceptable to add something written in python to
git.

Ealdwulf
