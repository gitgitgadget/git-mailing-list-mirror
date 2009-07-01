From: David Chanters <david.chanters@googlemail.com>
Subject: Re: CVS <--> GIT workflow...
Date: Wed, 1 Jul 2009 22:25:15 +0100
Message-ID: <ac3d41850907011425x966483awe1757e24417d9da4@mail.gmail.com>
References: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>
	 <m3d48kw4uz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 23:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7Iz-0005Lz-NN
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 23:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbZGAVZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2009 17:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753707AbZGAVZO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 17:25:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:48379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbZGAVZN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2009 17:25:13 -0400
Received: by fg-out-1718.google.com with SMTP id e21so360134fga.17
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uGjGOs6nMCHUOXSUME6opnGu1lUHzKdn+651eS7Meo8=;
        b=kF9jJhszISunrTjVKdnZA1cO2rcHCbbaEK2WrYjH16I861N+rWVXOXQmJ9RoKfOhou
         7SWny9R+CV6nmwKBIEuf5qW1rflEIgGHOzGs6TzTr5U6F0auEasO9u6sV4WTyJn0HSQ/
         Kw/vUcYQ9X9zrOUqNcBY914FgDTusPOfYY7PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ubWhV2t9R5eGfEUg1zZ8fqlZtBYKRm/qcDAxgQgMio5wPFW+Dor3QTswFxWWIkxg4P
         xpw2H1rwv1I3lU+zml6efoRHYq1GluJFgdeNVZkbZhCl9QcXrXSIkQ1Y4MD4ZGj0/Hzu
         yjVsdm7H8n4aK4tv7jGvcDdbWNV8ZRb0GDc4w=
Received: by 10.86.90.13 with SMTP id n13mr4752422fgb.45.1246483515161; Wed, 
	01 Jul 2009 14:25:15 -0700 (PDT)
In-Reply-To: <m3d48kw4uz.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122601>

2009/7/1 Jakub Narebski <jnareb@gmail.com>:
> David Chanters <david.chanters@googlemail.com> writes:
>
>> I am wondering if there's any best practises/howtos on using CVS and
>> Git together. =A0I have a project which is currently residing in CVS=
;
>> people actively use it to add changes, etc. =A0Which is fine -- and =
for
>> a variety of reasons we're unable to simply switch away from using C=
VS
>> to Git.
>>
>> So... the question is, can I use Git locally to manage all my work i=
n
>> -- create topic branches, merge them, etc., and then commit that bac=
k
>> out to the CVS repository? =A0 Likewise, I would need to keep my Git
>> repository in synch with any changes to the CVS repository -- is tha=
t
>> possible? =A0Has anyone else done something like this? =A0What I am
>> effectively wanting to do is Git for my entire development on this
>> project and just forget it even uses CVS.
>>
>> I've read up on git-cvsimport which seems to explain how to convert =
a
>> current CVS repo over to Git -- is that right? =A0Any information yo=
u
>> can point me to would be very welcome. =A0I am not adverse to readin=
g,
>> providing it's useful to me. =A0:)
>
> I think from all CVS importers (git-cvsimport, parsecvs, git mode of
> cvs2svn aka. cvs2git) only git-cvsimport has incremental mode.

Excellent.   So git-cvsimport it is then.  That's stage 1.

> As for exporting to CVS there is git-cvsexportcommit and git-cvsserve=
r
> (which functions like cvsserver, but conects to git repository;
> although it has its own limitations).

I wouldn't need connectivity like what git-cvsserver seems to imply.
git-cvsexportcommit sounds about right.

> But you should really hope that your fellow CVS committers use good
> practice; because it is quite easy to create very messy CVS repositor=
y
> (so that for example it would be hard to extract changesets).

They do -- which is about the only guaranteed thing.

So what would I do?  Something like this:

1.  Use git-cvsimport to "convert" a snapshot of the current CVS
project to something Git can understand.
2.  Checkout this git project via git clone in the usual way.
3,  Hack away in this Git clone.
4.  Use git-cvsexportcommit to extract commits?

What about my workflow within the Git repository?  I assume that
"Master" would be the branch I would want to merge *to* if I have
local topic brances I wish to have in to CVS, and then the commits on
Master would be something git-cvsexportcommit would look at?

Indeed, it seems git-cvsexportcommit is somewhat "manual" -- is there
no way of automating that to say something like:  "Take all commits on
branch $FOO in Git, which aren't in CVS, and apply them?"   I might be
missing some understanding here.

Any advice greatly received.  :)

David
