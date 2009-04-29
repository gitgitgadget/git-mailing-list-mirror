From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 29 Apr 2009 10:25:56 +0200
Message-ID: <46a038f90904290125n11476cf3icbacab4f6d8a5f5a@mail.gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
	 <m3r5zdnhqu.fsf@localhost.localdomain>
	 <46a038f90904282355g43bf0cv909905f6028f054f@mail.gmail.com>
	 <200904290952.17789.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 10:26:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz57J-0007Ny-GG
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 10:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbZD2I0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 04:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbZD2IZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 04:25:59 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:63488 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbZD2IZ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 04:25:58 -0400
Received: by bwz7 with SMTP id 7so1013646bwz.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zZRWLXNROsizUZYvV9U/SlsYc2GfiOlSelIy3jhRsJs=;
        b=q6gWtrgjHXG7NzkmxriNmoikVreNomD+LQiU6emD9HxRswcfwHm48wEybjCp1JV4Sp
         /EdFLBvNIVpeV0gGXqTCYWkgwMO7fw3E8ZxeL5dcY8Y2a8NJUeiPNXZUZP40G8Wc633F
         xqSVcxycdMgWnf324YlB34uMkkYyy0DvY0gRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dx+97Ad59t24NUlkks2vUMYuQ8VD18Ll4MUXLVg0H6aKS27qYpwcTKnqLwfb39bkZh
         RiEPi9fKzcod1kiVbF4V+VwhSXMXW79fCDGgIk1Z05pNszHccW43tkSTp8YmIWVlzcwv
         vKGSVTSjGKLKoHrEObb2Ez2gv18ko1EfGJSO4=
Received: by 10.223.115.193 with SMTP id j1mr21921faq.98.1240993556858; Wed, 
	29 Apr 2009 01:25:56 -0700 (PDT)
In-Reply-To: <200904290952.17789.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117868>

On Wed, Apr 29, 2009 at 9:52 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> > =A0 DON'T DO THAT.
>
> What could be proper solution to that, if you do not accept social
> rather than technical restriction?

Let's say strong checks for case sensitivity clashes, leading/trailing
dots, utf-8 encoding maladies, etc switched on by default. And note
that to be user-friendly you want most of those checks at 'add' time.

 If we don't like a particular FS, or we think it is messing up our
utf-8 filenames, say it up-front, at clone and checkout time. For
example, if the checkout has files with interesting utf-8 names, it'd
be reasonable to check for filename mangling.

Some things are hard or impossible to prevent - the utf-8 encoding
maladies of OSX for example. But it may be detectable on checkout.

In short, play on the defensive, for the benefit of users who are not
kernel developers.

It will piss off kernel & git developers and slow some operations
somewhat. It will piss off oldtimers like me. But I'll say git config
--global core.trainingwheels no and life will be good.

It may be - as Jeff King points out - a matter of a polished git
porcelain. We've seen lots of porcelains, but no smooth user-targetted
porcelain yet.

cheers,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
