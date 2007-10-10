From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 22:44:24 +0200
Message-ID: <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Oct 10 22:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfiQ0-0008RM-Id
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 22:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbXJJUo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbXJJUo0
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 16:44:26 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:18682 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543AbXJJUoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 16:44:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so293681rvb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Vzwp7eR9AU3EzCoj7HeID8qrOhw7eXvkaGTlnBMyCU8=;
        b=S1/TtS8X4fjEK2hSbNQwUA/kMpnLFldRWG+TlGt8LjV8KXoenYF2zvPWMA8WPVqQQ29Bh8Q7mQEtgidbmebpWmanNPSG113UeLPlZjepj9aVycH2z/oRHLINAt6muHHe7JC11RvelqOhRyJ4BpVjtGyQaiooSztPh1SwxsmLyy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cmKfY9S53yNSgEtn8LcsTSv5uary1QbWVdmuMsC/JQ5jJtI5CKrYSOxnFUxQVUcbCYjj6qVl/oI0+SZ80g/FHx1TLHqmHu9kxVQe+iHnenQcZO3EipHgmy9kL6uw7xEXzk8D+aZlSxYSLuVJVHMl8WWERfWkctfG4OTHvgzjLeM=
Received: by 10.114.107.19 with SMTP id f19mr1234323wac.1192049064560;
        Wed, 10 Oct 2007 13:44:24 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 10 Oct 2007 13:44:24 -0700 (PDT)
In-Reply-To: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60540>

On 10/10/07, Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
> I'm seeing very slow performance with 'git-branch'.  Is this the
> canonical way to find out the current branch?

You could also try 'git symbolic-ref HEAD', but see below...

> hanwen@lilypond:/tmp/z$ find .git/refs/remotes | wc -l
> 1856

You probably want to run 'git gc' (which will run 'git pack-refs',
i.e. put all files currently under .git/refs into a single file). This
should speed up 'git branch' (and quite possibly other commands too).

--
larsh
