From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] builtin-remote: make rm operation safer in mirrored 
	repository
Date: Tue, 3 Feb 2009 09:38:55 -0500
Message-ID: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
References: <76718490902020536g6f4bcee2i76ee046a8dc7d46@mail.gmail.com>
	 <1233600014-82346-1-git-send-email-jaysoffian@gmail.com>
	 <20090203072418.GD21367@sigill.intra.peff.net>
	 <7vy6woc5vv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 15:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUMRy-0002oh-Gh
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 15:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbZBCOi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbZBCOi5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 09:38:57 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:27848 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZBCOi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 09:38:56 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2028346rvb.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V5OQocypMa1EVvjB02xDETpOR+teGDT7B8G/bA2Yv1I=;
        b=Z9uOSElt2gX6/ivJ7QP60BxdB/Yhl8MCqHAw66tkqpbR6rGNU14zNXqRnrUBNfjwk6
         TmzNxAMKzLHA5IxtY5puUrdpeS55SIpO9SDCFTeSJ+EsO31vOSrwODoW6QsqSHOnlJYe
         IVV96mmGYHLOtOPps5UTUVYXXianiXutf8Uag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LZ5EOrAUvXixYL0DlJioDezYaYrpwkarWhWeYgOfJyo4GTJjOcoU3D2/wKrN0zv8av
         WJKWDp9xqM6orxMX8flTEEFkvLWzGqWFSIBdb+MtOpgsPOlyUHWHpORaCNLDmd+I7ull
         YM4QO+TwtH0QtvgW4b2VNTOCOp8dnoPQ+apNE=
Received: by 10.141.69.12 with SMTP id w12mr3001070rvk.151.1233671935595; Tue, 
	03 Feb 2009 06:38:55 -0800 (PST)
In-Reply-To: <7vy6woc5vv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108192>

On Tue, Feb 3, 2009 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> However, I have one small nit. The output produces long lines with a lot
>> of repeated text (assuming you have multiple matched branches, which is
>> likely if you have a mirrored setup). So maybe it would be nicer to have
>> something like:
>>
>>   warning: non-remote branches were not removed; you can delete them with:
>>           git branch -d master
>>           git branch -d next
>>           git branch -d topic
>>
>> which is a little more obvious (to me, anyway), and allows you to cut
>> and paste if you really did want to delete them.
>
> Thanks for a review, and I actually shared that exact nit when I first
> read the patch.  It would be a very good change to collect them in a list
> and show a single warning at the end (I do not have particular preference
> about the cut & paste-ability either way myself).

This is a tough crowd. I'll see what I can do.

j.
