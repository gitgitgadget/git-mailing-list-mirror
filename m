From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 17:05:39 -0400
Message-ID: <32541b130908151405j661cde8fh9783e91cebf1e398@mail.gmail.com>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain> 
	<200908152119.56606.trast@student.ethz.ch> <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain> 
	<7viqgoestz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0908151324380.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 15 23:06:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McQS0-0002Qm-BC
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 23:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbZHOVF6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Aug 2009 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbZHOVF6
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 17:05:58 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:60581 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZHOVF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 17:05:58 -0400
Received: by yxe5 with SMTP id 5so2743824yxe.33
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=u1EcjJW3gCGloUdbsL3RSU/qIKx66+uBQyjCRem9st4=;
        b=q/49sLXLdLR6hL59RC+XcrlaQlP/seeZXtNlpdq/zxZrusWWW7WpC9kZBfW0BHiFqr
         32LfrkAGQ1eXjPVKLe3+xf+1+uBkv9Jd1BfareHGYL3FpoDzH9ccsroTza9vUqNuLziq
         zyneRxHw75gZm7PJb3wvdhCeXi6s7c0RTHR2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V+WnH9eSaRCcHHA8Qn2qJ9qckm22vcAgIV5WYiqn3Vg6Q5deuCELDoH6VG+vk50Uvl
         4wzeU4ddjuUHiA9F56dITDQmGJu78Bt8NbrspuheLfNlC37h8c50a1K2F6D7z3Axr2zM
         XCO9thtLDCKdiAfHd9OFQjt7PoCikh8Js6IC0=
Received: by 10.150.43.14 with SMTP id q14mr3820404ybq.241.1250370359083; Sat, 
	15 Aug 2009 14:05:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0908151324380.3162@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126029>

On Sat, Aug 15, 2009 at 4:36 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
> On Sat, 15 Aug 2009, Junio C Hamano wrote:
>> If you try that without --stat, i.e.
>>
>> =A0 =A0 $ git log -4 --pretty=3Dformat:%s | cat -e
>> =A0 =A0 $ git log -4 --pretty=3Dtformat:%s | cat -e
>>
>> I suspect you may then find that --pretty=3Dformat (not --pretty=3Dt=
format) is
>> broken.
>
> I disagree. The real brokenness is that we don't have any way to say =
"I
> want no newline at all after the format", and then having this mixup =
with
> the whole "terminator" thing - sometimes it's "between commits" (whic=
h is
> _correct_ any time you have stat info or something), and sometimes it=
's
> "after header" (which is almost always incorrect).

I'm guessing that "after header" was just an implementation error.  It
was presumably intended to be "after commit", so that the only
difference between format and tformat is the presence or absence of
the very last terminator.

Maybe the correct fix is just to make tformat not broken?

Avery
