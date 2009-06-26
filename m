From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 3/8] gitweb: right-align date cell in shortlog
Date: Fri, 26 Jun 2009 20:06:57 +0200
Message-ID: <cb7bb73a0906261106n5e12948dydd02bd8d1b19a5e6@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906261133.47326.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 20:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKFpK-0000D1-Nt
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 20:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760489AbZFZSG5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760181AbZFZSG4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 14:06:56 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42173 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbZFZSGz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 14:06:55 -0400
Received: by fxm9 with SMTP id 9so2257955fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zrutTmIWHb2RtGgQG9fmp6FSqJPnlByIsU0PU1FDi4c=;
        b=xNfeR1H0BBVlprgJoJhryhKVIV2yXUYXkPu5qLn96B50oknEDqwd7GtHImP9Xj1oaV
         b2yQzVJfH1xxfnntwZRtUxXoxftoIcNI5r6yRyub58OIUsAC4+Vg15gVOFp9dlZi5OZ1
         4bUruH7UwKRjKIjnL5Y7bVnIrtWcwTdPyGlGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xbkXXt+JKSy1VqYsHSl6fvW6VL3M2MV/2qDy27kocymgY8LeFLsGbjk/FZ0zTtKnDE
         bFzY05LJkmXV1bghrziQ8S4nSiShmQpzvqv2K0ueHfFwbkhJF0SuTNnOQ1NvOw4xCyP4
         kfbmzrJAbWcOCklcaPSEWpburahPUd3FVazIE=
Received: by 10.204.70.135 with SMTP id d7mr3924692bkj.87.1246039617575; Fri, 
	26 Jun 2009 11:06:57 -0700 (PDT)
In-Reply-To: <200906261133.47326.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122313>

2009/6/26 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 25 June 2009, Giuseppe Bilotta wrote:
>
>> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
>> index 68b22ff..7240ed7 100644
>> --- a/gitweb/gitweb.css
>> +++ b/gitweb/gitweb.css
>> @@ -180,6 +180,10 @@ table {
>
>> +table.shortlog td:first-child{
>> + =A0 =A0 text-align: right;
>> +}
>
> First, there is no space between ':first-child' pseudo-class selector
> and opening '{'. =A0It should be "td:first-child {".

Right.

> Second, I'd rather avoid more advanced CSS constructs; not all web
> browsers support ':first-child' selector. =A0On the other hand adding
> class attribute to handle this would make page slightly larger.

IIRC :first-child is supported from IE7 onwards. There are hacks to
make it work on IE6, but I think they are definitely not worth it.

> Last, and most important: I don't agree with this change. =A0In my
> opinion it does not improve layout (and you didn't provide support
> for this change). =A0Right-align justification should be sparingly,
> as it is not natural in left-to-right languages.

Of course, in my opinion it does improve layout.

The effect is to right-laign the first column of shortlog view, i.e.
the one holding the date. For dates that are presented as yyyy-mm-dd
it makes not difference, but when the phrasing is 'X days ago' it
provides the benefit of aligning the 'days ago' part instead of having
it ragged. See it live at

http://git.oblomov.eu/git/shortlog

and judge for yourselves.

--=20
Giuseppe "Oblomov" Bilotta
