From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git and multiple cores
Date: Tue, 2 Jun 2009 18:55:22 -0400
Message-ID: <eaa105840906021555w22e62341l61f250455cf8c23b@mail.gmail.com>
References: <4A25AA4C.9070600@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 00:55:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBctK-0007Cr-0W
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 00:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZFBWzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 18:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbZFBWzY
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 18:55:24 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:35199 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbZFBWzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 18:55:23 -0400
Received: by ewy24 with SMTP id 24so9175707ewy.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=D1N/+kMo0cbH3LxDxUkfpUBomT+Tju4qdggHBgldAEA=;
        b=bP3d/kX9zKxVK21uP7mmg9Z6vmgUuKLiIuJ/f/SSONvde7z8F+07/duxTACIP5cazm
         NIIKECDjNOVlu9P56QETfHbscPMps3al8VPpgmGwDpRj0oTguE6wKznTSIc6YgRTnQS9
         d72yfcZC5XouTQnboQY6dri9hHR9wf7ApqlbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ih5n33a5MetvZ8gAZ8gb6DZWZ0uYXLk0pbi0hGFu9K8tNxE995VkvWqhoPzKlvvO7s
         2TvOwO+dkRwsWNOysvfJKc72NxSOl4EL4k58XMz7c6LeD+CNtILPrCsjDyV70yJe/U9B
         S8uCRGpJA8sNxI7tXqqB7CKsPuXh8k71apHYA=
Received: by 10.210.119.5 with SMTP id r5mr4788756ebc.1.1243983322216; Tue, 02 
	Jun 2009 15:55:22 -0700 (PDT)
In-Reply-To: <4A25AA4C.9070600@nortel.com>
X-Google-Sender-Auth: 20d1de3e31968955
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120555>

On Tue, Jun 2, 2009 at 6:40 PM, Chris Friesen wrote:
>
> I'm using git 1.6.1.3 and it seems to be limited to a single core.
> Given that I've seen cases where the cpu has been basically pinned for
> minutes on end (initial clone of a repository, for instance) has there
> been any discussion of taking advantage of multiple cores?

Sounds like you're mostly concerned about packing.

The good news is, your version of git already has a threaded packer.
You just need to enable it. See "pack.threads" in "git help config".

1.6.2 and newer use multiple threads by default.

Peter Harris
