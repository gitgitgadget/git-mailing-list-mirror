From: Matt Graham <mdg149@gmail.com>
Subject: Re: how to diff versions of a file
Date: Tue, 3 Feb 2009 08:48:46 -0500
Message-ID: <1c5969370902030548g284e8ae2i7dc3a866c4337a5f@mail.gmail.com>
References: <1c5969370902022100h7c03bbb6h2d9f443f877d89ec@mail.gmail.com>
	 <alpine.DEB.1.10.0902022206060.28633@asgard.lang.hm>
	 <7vk588do5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 14:51:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LULfL-0000eL-V0
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 14:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbZBCNsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 08:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbZBCNsu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 08:48:50 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:4723 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZBCNst (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 08:48:49 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1619168fkf.5
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 05:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QJe/QZAMTmTWjlBOkk0PxXthvFSRj8XXRJvztpGYO6s=;
        b=FK78yBqayAmS1Qv2UJK3FKWR6utdGwymf/csHC9qPM2QjIaqrNlc1cOnH1WKuJuUyu
         djTXcV/YZTmodRE9rrcGuyjQSGV920XankX8/D5O19lPPhc3kWW4sN1mynA50aNa3CQV
         O59B2bwGkS/3Wzj31nxr5wkp1EchZFouzFDHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D0B0tZn8pVGXsZf+xzoYTJ8DrzXryHfOYx2E2GcLqEbWeuX4jXud8X3ywI92Bzph/w
         Hx733zePWSsaKP05xUpFaj9OX6ereljuiHHyuOYvhv1ZgoAjN5faG1K3tZ1qlMgjy5M3
         6vHLwlWNn7IoSFb5bPGi5+yLq/eLa74etaSb4=
Received: by 10.223.122.15 with SMTP id j15mr197072far.10.1233668926325; Tue, 
	03 Feb 2009 05:48:46 -0800 (PST)
In-Reply-To: <7vk588do5q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108190>

On Tue, Feb 3, 2009 at 01:34, Junio C Hamano <gitster@pobox.com> wrote:
> david@lang.hm writes:
>
>> I don't think it's trivial
>
> I think you meant to say it _is_ trivial.
>
>> If you just wanted three commits ago you could do
>>
>> git diff HEAD..HEAD^^^ tree.c
>
> That would give you a reverse diff; I think you probably meant the other
> way around, "git diff HEAD~3 HEAD tree.c".
>
>> but three changes to tree.c ago I think you need to do multiple
>> iterations of git blame to find out what commit was three edits ago.
>
> git diff $(git rev-list -3 HEAD -- tree.c | sed -n -e '$p') HEAD -- tree.c
>
> This assumes that the history is linear but your statement "three edits
> ago" already assumes that, so...

Thanks Junio, this is exactly what I was asking for.

And thanks for the tip about it depending on the history being linear.
