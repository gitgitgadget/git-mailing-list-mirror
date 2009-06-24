From: James Pickens <jepicken@gmail.com>
Subject: Re: Troubles when directory is replaced by symlink
Date: Wed, 24 Jun 2009 15:07:47 -0700
Message-ID: <885649360906241507r6ac78495s802f8b7758bcabf9@mail.gmail.com>
References: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
	 <c6c947f60906090118n78d3c40fq11d1390f8776c2c0@mail.gmail.com>
	 <20090611114846.GC4409@coredump.intra.peff.net>
	 <861vpmkhob.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Alexander Gladysh <agladysh@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 00:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJadt-0003C3-8Z
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 00:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZFXWHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 18:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbZFXWHv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 18:07:51 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:61378 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZFXWHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 18:07:50 -0400
Received: by gxk10 with SMTP id 10so1943621gxk.13
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SDV64XcHvrrpUhgPRuXV19/76YZ+BSn6rAuXsk1Z5u0=;
        b=YPT2xPM4kIDm7NJYeiV6wsCaGtI6jF7cQ1vjkNgfCXlYJyFTgUGqkUMofCirSmu5qu
         DHd245OUR+VTZg1+VHNBGoOXpn25UY4EZCOKHn9a+HfynKny2SZrqApMq9U/896vdzrh
         UyFwWG9neKUdQl4sZ6huZ+QimpfuqQZy1KVAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IyJXZw6zGMUct4lcSs47mXvkHrTWBoTQVUXcGZW1thaLT2S1G5X7UEqXh+32s4RKwC
         46UMsEmI8aCr5IYswu1RpXyLFRSqKdHnlod1rgFPC/xJE73L/e4kURmxYowZBjWgLhq3
         kfRSGcVeBphw7+iT32uYC5ukuyw9qnfkPJeh0=
Received: by 10.90.100.11 with SMTP id x11mr1431975agb.85.1245881267305; Wed, 
	24 Jun 2009 15:07:47 -0700 (PDT)
In-Reply-To: <861vpmkhob.fsf@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122163>

On Sun, Jun 14, 2009, Kjetil Barvik<barvik@broadpark.no> wrote:
> From: Kjetil Barvik <barvik@broadpark.no>
> Date: Sun, 14 Jun 2009 15:08:28 +0200
> Subject: [PATCH] lstat_cache: guard against full match of length of 'name' parameter

My project ran into this bug today, and I can confirm that this patch
fixes it.  I think it's an important bug; it hasn't been mentioned yet,
but this can result in lost work if the user had modified, but not added,
one of the files that Git wrongly deleted.

So, what's the status of this patch?

James
