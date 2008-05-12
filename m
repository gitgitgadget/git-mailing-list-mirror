From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Mon, 12 May 2008 14:40:11 +0200
Message-ID: <200805121440.12836.jnareb@gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com> <200805121319.37512.jnareb@gmail.com> <bd6139dc0805120449j874e4b8j21b90f79230e45a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon May 12 14:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvXLL-0000EK-Sx
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 14:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbYELMka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 08:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbYELMkY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 08:40:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:29691 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbYELMkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 08:40:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1056229nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=1Rm/pzw/dQCxG6KOgyOlKj2KkFvjfJqFj0Xl0Z9D99Q=;
        b=M7tSGSjphIfnIhAuD9oTFvf1qXqhe9I3UrCORqPm5QKXW9Nd76ibcL4UiMYs7l4eG7FJrNyM+AFW8pzddmIxlNIEGD3Q8m1uHjDqNqbtSEmn/x6Xlqx1Gf+IpkD+kamieqJofiKy5N6tfbsF6QbcxD28Qga0DbRf6hB/58QocAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YsNudOtXleXYLbv+sbxOnSTxl1gHAM8Tht/Ep30cpthKCjsatXafh6HA/s46ueT+9rwBntuKNRd9CTkN36iyPVhWNlNfPkcAEPk2MOyE5N07D6cG3qESj9g/nx2JMHsv+zDLvxXujz+tSP1vSSTnbBsjo/76tqiQ2ic5uWGZ/O0=
Received: by 10.210.46.14 with SMTP id t14mr7071864ebt.129.1210596019152;
        Mon, 12 May 2008 05:40:19 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.115])
        by mx.google.com with ESMTPS id c25sm4054571ika.11.2008.05.12.05.40.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 05:40:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <bd6139dc0805120449j874e4b8j21b90f79230e45a7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81857>

Sverre Rabbelier wrote:
> On Mon, May 12, 2008 at 1:19 PM, Jakub Narebski <jnareb@gmail.com> wrote: 

> >  * Maintainer: how close should I examine provided patch?
> 
> I'm not sure I understand what you mean with this, perhaps related to
> "Name: Finding parts of the content in which a lot of bugs are
> introduced and fixed" (e.g., patches to bug prone areas should be
> examined more closely).

This is, IMHO, the most complex example (at least to do properly).
It begins with: does given author have code touching given subsystem
(i.e. is it for him/her new contribution wrt. subsystem)? How many
commits he/she has affecting given subsystem? How often he/she rewrites
code? How many bugs were introduced?

Details I think need to be provided by maintainer...

> >  * Contributor: what happened with my code?
> 
> Do you mean a "track my code" like feature? Showing the movement of a
> particular piece of code through the code? (Displaying information
> like "moved from foo.c to bar.c in commit 0123456789abcd"?)

I was thinking there about "git blame --reverse".
 
> >  * Searching where to contribute: what are oldest part of code dealing
> >   with error messages (find ancient code)?
> 
> In other words, find the lines with the oldest modification time stamp
> from 'git blame'?

Or find the lines with oldest modification stamp with "die" or "warn",
or find which messages are oldest, even if wrapper have changed.


P.S. I wonder how hard to be to plug-in such SCM statistic system
into something like project management, see
  "Joel On Software: Evidence based scheduling" (of programming tasks)
  http://www.joelonsoftware.com/items/2007/10/26.html

-- 
Jakub Narebski
Poland
