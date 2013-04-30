From: John Szakmeister <john@szakmeister.net>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Tue, 30 Apr 2013 12:47:36 -0400
Message-ID: <CAEBDL5W8YWu8_TV7o0s3ZZomETz8RPWnr8oOmy0xQ=U8o0xe0Q@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
	<7vli8bu3ne.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
	<7va9ogezzx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDiT-00084f-IS
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761208Ab3D3Qri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:47:38 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:37413 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760923Ab3D3Qrh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 12:47:37 -0400
Received: by mail-wg0-f51.google.com with SMTP id b12so684762wgh.30
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ZELfW7OjJBkRR6d5U453yBFXisWefUuQ9ocjsKhz1t0=;
        b=ocNwMnpEbUM1CTp0dw2ENcRe52DuQD8DIndx55Ujw3S3AEQY2vDJPZB6mlz89ib8di
         oYz42NuYD76B5PJXnrQGTKp1i+iXXv3DtiQexqr5A6NDO8COPpQA3oUcOCYFq5r8hujR
         Q5MF4z/pk0em7X66lQcmk25bm6O8lfvMokMKR2gJARbs35D8tGSvPB9BAiQnWh6d26ek
         pkODzcaSy98Wo6NhkIt7XhZEOOSi6BF616l11NFvdzvHGYwYNkfANUbfwAxeuR48HMSF
         Rz6RAzCKNjTItUjEQ3PBSIRxHBKR6WqcXTJOe4q5RYbyESvugv5DCti7+tbW63iadwBI
         pXTA==
X-Received: by 10.180.37.101 with SMTP id x5mr25905328wij.0.1367340456630;
 Tue, 30 Apr 2013 09:47:36 -0700 (PDT)
Received: by 10.180.108.240 with HTTP; Tue, 30 Apr 2013 09:47:36 -0700 (PDT)
In-Reply-To: <7va9ogezzx.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: qdyqh_LC6fZoH4IlZCPVbDrxLP8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222948>

On Tue, Apr 30, 2013 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Szakmeister <john@szakmeister.net> writes:
>
>>> When I added -c/--cc, I contemplated making -p imply --cc, but
>>> decided against it primarily because it is a change in traditional
>>> behaviour, and it is easy for users to say --cc instead of -p from
>>> the command line.
>>
>> FWIW, security aside, I would've like to have seen that.  I find it
>> confusing that merge commits that introduce code don't have a diff
>> shown when using -p.  And I find it hard to remember --cc.  BTW,
>> what's the mnemonic for it?  -p => patch, --cc => ?
>
> Compact combined.

Thank you.

> By the way, these options are _not_ about "showing merge commits
> that introduce code", and they do not help your kind of "security".
> As I repeatedly said, you would need "-p -m" for that.

I'm sorry, I didn't mean to imply that it's useful for security, just
that it better meets my expectations when -p is turned on.  I realize
there are some edges in the logic, but I'm fine with those edges.

-John
