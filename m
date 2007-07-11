From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 1/2] Function stripspace now gets a buffer instead file descriptors.
Date: Thu, 12 Jul 2007 01:41:38 +0200
Message-ID: <1b46aba20707111641y615ff82dpf2da4afab2b17d58@mail.gmail.com>
References: <4695267A.7080202@gmail.com>
	 <7vd4yy1svw.fsf@assigned-by-dhcp.cox.net>
	 <18069.26029.224024.66576@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 01:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8loc-0007cr-Uq
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 01:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbXGKXll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbXGKXll
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 19:41:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:10879 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964836AbXGKXlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 19:41:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2514951wah
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 16:41:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QhoITkVbpuu59QQigMFxCGqlgSLWZms8OLt0i2FXz2znkVT9LZmIHDVYDhMOQYSVFbwpugC1RtK872NUJ5EU/1SXV/TQ92m7PKh5Xw8Q2I/Uho0fF/N8aL2Oj++n7jyewSzSc6c98CVwE774waXDhec8ME+ZYaMbHSk5NCdpLX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OnBlHGxuo3YmQBTD6m49pW+PfJj3qs+ntwW3usFPtFzUA989cuMnw5iLYXlodbA1OKsWjk3TOkyq/bwZYHU6aYy78pwquTPlaLnDMI1AN7foOJu68jYePlZ+GxC+wJ6AYFqIC4jUGb04OxvVMFkN51B6EFoN23Rsml0f3zYFQ+8=
Received: by 10.115.90.1 with SMTP id s1mr22419wal.1184197298837;
        Wed, 11 Jul 2007 16:41:38 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Wed, 11 Jul 2007 16:41:38 -0700 (PDT)
In-Reply-To: <18069.26029.224024.66576@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52224>

Now the function cleanup is not removing spaces at all, but only
counting where the line of text ends.

Before, in the previous version, the function cleanup was taking a
string as argument, and then it needed to modify that string.  Now, it
just returns the new length, "not counting" the spaces and newline at
the end of the buffer passed. Its name and comments then could be
different, but I didn't know which ones.
