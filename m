From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 6/6] zlib: zlib can only process 4GB at a time
Date: Sun, 12 Jun 2011 22:43:42 +0200
Message-ID: <BANLkTikmLDZj2qdkmF-kBUkB33o9EjtBpg@mail.gmail.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com> <1307736948-16956-7-git-send-email-gitster@pobox.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 22:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVrWU-0004bJ-FB
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 22:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab1FLUod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 16:44:33 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:63547 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab1FLUoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 16:44:22 -0400
Received: by pxi2 with SMTP id 2so2566209pxi.10
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rR47Vy7OTybE3r22aG3XI4dPow8XTQroSZUIdqIwtfc=;
        b=r0G06co5KnYApYtiNJPsh0mGnbsYClbUk8lEo8tJyYLsVAOf75+0K9nBwTGlx/Q8Ul
         fmbfQpq0xXlbbOwoz1YxrThsBiQ/ugTAJtYPNt6RDlR1qY1ZMqHQKxGEpxX2HNcI1ma2
         zIVOk94R8aTnnhSpFNJe2V9F5DM3v3jZfNoHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=eSpVJC0dulTFwC3kR5VhRpYfIhO4yUgR/+32mAuTjwrrLrkf35iTCGKCYzceZEAFEI
         7cCz7dvvc2MiV1dqaRJ9MlyCCHEbZTv8FTL0F1NFJxbZYVOfplZgdHphXZJIDMdYywLq
         ciFFzFoeMN9PkHahk2XhdDQ61tAbKfRbu3+RU=
Received: by 10.68.40.72 with SMTP id v8mr1790878pbk.517.1307911462146; Sun,
 12 Jun 2011 13:44:22 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Sun, 12 Jun 2011 13:43:42 -0700 (PDT)
In-Reply-To: <1307736948-16956-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175665>

On Fri, Jun 10, 2011 at 10:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The size of objects we read from the repository and data we try to put
> into the repository are represented in "unsigned long", so that on larger
> architectures we can handle objects that weigh more than 4GB.

shouldn't this be "size_t" instead of "unsigned long"? "unsigned long"
is 32bit on Win64, whereas size_t is 64bit:

http://msdn.microsoft.com/en-us/library/s3f49ktz(v=vs.80).aspx
http://msdn.microsoft.com/en-us/library/aa384083(VS.85).aspx
