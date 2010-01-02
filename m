From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH RFC 1/2] Smart-http tests: Break test t5560-http-backend 
	into pieces
Date: Sat, 2 Jan 2010 12:44:35 -0800
Message-ID: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com>
References: <1262037899-16786-1-git-send-email-tarmigan+git@gmail.com> 
	<7veimc2vq0.fsf@alter.siamese.dyndns.org> <905315640912301009x491f957al839f66de7aba56ed@mail.gmail.com> 
	<7viqbmo173.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 21:45:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRAqL-00015D-2P
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 21:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0ABUo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jan 2010 15:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375Ab0ABUo5
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 15:44:57 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:60077 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0ABUo4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jan 2010 15:44:56 -0500
Received: by yxe17 with SMTP id 17so12875831yxe.33
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=9YxtoFvJTkrZoEzC+sjczYN6IxCkW9vlb1tuHxlaXhk=;
        b=OC7I8mAb9SIXXPyjINWzTrsi5UeKNJNR9y6hmYn6x1mupd8LdYi6NPJgpGqndi2rPy
         CLKhhAOSonBC04ELeaiqFabb9cwCeXrqcwevyoEQSbtR+uRh14ip2weZmoGc0hOYHIkU
         22QmBM1C+q2ZmsGgYOxCJLXiyFcVfLlI2A2kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=AsBFYN4lqaoJA+WIZ6T23QldZf6yxIgWhFQhzcmegrbwz4ZD69JpDLaIfB+1NQzTwW
         SvrMrcZbC0Y9pS5Whw44kSxlj/z1Eu9/dkKx3FAdz1netLGhN/Y2HcZkLYIO3vAb37HX
         +KutUR03rFHnku+5aq8SB576M8IlWuV8+5XMg=
Received: by 10.150.28.27 with SMTP id b27mr4202884ybb.59.1262465095387; Sat, 
	02 Jan 2010 12:44:55 -0800 (PST)
In-Reply-To: <7viqbmo173.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 8e8faa808b4d2e56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136045>

On Thu, Dec 31, 2009 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tarmigan <tarmigan+git@gmail.com> writes:
>
>> One reason it's labeled RFC is that I'm not very confident in my
>> ability to write portable shell script. =A0It works for me with bash=
,
>> but I'm not completely confident that is would work on ksh or dash.
>> So it would be nice if you could specifically take a look at the new
>> POST() and GET() and see if you notice anything obviously wrong ther=
e.
>
> Looked Ok to me from a cursory reading, even though I wonder what the
> first argument to run_backend function is good for...

Thanks for looking.  I used the run_backend that was introduced in
34b6cb8bb, but looking more closely, it seems that the "http-backend
blocks bad PATH_INFO" test wasn't actually checking anything.  It
seems the path_info function was intended to be used, but never
actually was.  I'm embarrassed to say that I was so focused on "no
changes to existing tests" that I wasn't thinking about the bigger
picture.

I have made a patch to address this, and have made it the first in the
series.  I would like to have Shawn's ack on at least that first
patch, as I was trying to guess at his original intention with that
test.

Thanks,
Tarmigan
