From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: [PATCH] builtin-branch.c: optimize --merged and --no-merged
Date: Thu, 24 Jul 2008 12:03:25 +0200
Message-ID: <8c5c35580807240303o21596dbbrfca9b9fd0991d91a@mail.gmail.com>
References: <7vtzeg9rhh.fsf_-_@gitster.siamese.dyndns.org>
	 <20080724172929.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nanako Shiraishi" <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 12:04:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLxgY-0001hi-4R
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 12:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYGXKD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 06:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbYGXKD1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 06:03:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:44144 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbYGXKD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 06:03:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2798936rvb.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=lxSy4vdk2NAfbLSgo1K06MtJZ4p8EjvRpX8+JCGXc28=;
        b=wIAXZcdh27QEuF/TFRTxIScy9pEbM7BHUwoDbP44NeWF9OYcZmJJj4tnaut0hzvfij
         6Ou71CHl2LLnodzXOLS6j5lE85hhKeo2q6P0ITYIw+U2BnkEm6/5+FreHukAQPqjZvtB
         p5mqvOFF61uzD4T1BuN5tHUZ/if/9peX2C+mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=CWwfVh8NkLUamvXW2+US0i6cuedv0EzHxsOTA4BSfhOlPDofhfCU1L90DHm/T0wbZX
         DBsfhXSiE6YzSgPdAuMw34DjwF9tqPc91Moo4SKufBoJKFhgSLI79MYIW60hHaKpnyrW
         zYgpHP/x0+jvQb7BEgBRcmyOw5kF6FOXkiE38=
Received: by 10.141.86.14 with SMTP id o14mr23285rvl.227.1216893805642;
        Thu, 24 Jul 2008 03:03:25 -0700 (PDT)
Received: by 10.141.172.11 with HTTP; Thu, 24 Jul 2008 03:03:25 -0700 (PDT)
In-Reply-To: <20080724172929.6117@nanako3.lavabit.com>
Content-Disposition: inline
X-Google-Sender-Auth: d265de50afb72015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89860>

On Thu, Jul 24, 2008 at 10:29 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> How is --merged different from --contains?

--merged only shows the branches which are contained by (reachable
from) a specific commit
--contains only shows the branches which contains (descends from) a
specific commit

And finally, --no-merged only shows the branches which are not
contained by a specific commit

--
larsh
