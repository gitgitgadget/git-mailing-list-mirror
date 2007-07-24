From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Re: [PATCH] gitweb: More detailed error messages for snapshot format
Date: Tue, 24 Jul 2007 17:50:29 -0400
Message-ID: <3bbc18d20707241450y48ef0485i2809c632ac2e643@mail.gmail.com>
References: <11853108372532-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDSH7-0002cC-PR
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbXGXVud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbXGXVud
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:50:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:13530 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbXGXVuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 17:50:32 -0400
Received: by wr-out-0506.google.com with SMTP id i30so1359291wra
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 14:50:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rOzYMBQ+R3eLZyzdnZpV6D/b7W8fSNnDnvjfDlqDFk5gJz2Iu1yapvNyB+kCsS0KwOGoPppEb9aoTF8bzyMgByyhsEMV9cENI/4WqqUzDL3O87JNZxZEMn1y58idiIazDYnuhl6rsyKxiDoYsLukr3dEqtWHK6gtn2NOltrnJYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=knVw/g4+96avRyqb+ER07Na+TmR7PtevC+Odcf4rjH4EvfsDVpO/uBOZ9yLTgOiGfCxS92YKegEUtGWs/137/C3UtNxc49I2AZjZS8zI6s7dnTcTCbYRSzOA611H+vo28fiOe6sRZEdPxDszFYVd4GiL3o2AQtbyyx3ZOHiV5W4=
Received: by 10.142.191.2 with SMTP id o2mr358439wff.1185313829815;
        Tue, 24 Jul 2007 14:50:29 -0700 (PDT)
Received: by 10.143.30.9 with HTTP; Tue, 24 Jul 2007 14:50:29 -0700 (PDT)
In-Reply-To: <11853108372532-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53652>

On 7/24/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Improve error messages for snapshot format in git_snapshot:
> distinguish between situation where snapshots are turned off, where
> snapshot format ('sf') parameter is invalid, where given snapshot
> format does not exist in %known_snapshot_formats hash, and where
> gitweb was given unsupported snapshot format.
>
> While at it, use first from all supported snapshots format as default,
> if no snapshot format was provided.

I tested the patch and it worked properly: the errors appeared at the
appropriate times and the first supported format was used as the
default.

I also noticed that the check for an "invalid" format requires that it
contain at least one good character, not that it contain no bad
characters, which was what I originally meant.  It would be nice to
fix the check, or the check could even be removed altogether since
gitweb refuses any format that isn't in %known_snapshot_formats .  (I
think I was misguidedly paranoid to add it in the first place.)
