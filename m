From: David Barr <davidbarr@google.com>
Subject: Re: [PATCH] git-am: ignore leading whitespace before patch
Date: Sat, 6 Aug 2011 11:56:53 +1000
Message-ID: <CAFfmPPMY5FP8NbZ5Q15pW-NC_qs=i6FY7v6Pi8jkMAhkURFTmQ@mail.gmail.com>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com>
	<CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 03:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpWAF-0005fF-TA
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 03:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab1HFB44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 21:56:56 -0400
Received: from smtp-out.google.com ([216.239.44.51]:3225 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1HFB4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2011 21:56:55 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p761utBY028718
	for <git@vger.kernel.org>; Fri, 5 Aug 2011 18:56:55 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1312595815; bh=Bce3g0QvUHFqb50xnqtmnhBtOH0=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=NgPVG5BeXWJR/Fsq0QhYGGmVKw6ctRH6hi9KULVPuQLogFsQBLQwgGVh/B/lIaBGi
	 aKH3kbDflASp8Ba5l6xaw==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:
	content-transfer-encoding:x-system-of-record;
	b=i64mNH0ihpxKX1rQoa6eHHC6A6nMAwc/PdPgEaQvLdekDDxOKleXHQr/QKfvpVfpv
	Hy9v4P/PTbOWAhuqgMdmw==
Received: from gxk28 (gxk28.prod.google.com [10.202.11.28])
	by wpaz29.hot.corp.google.com with ESMTP id p761ush9020917
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 5 Aug 2011 18:56:54 -0700
Received: by gxk28 with SMTP id 28so2880163gxk.41
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3ymkpptwTiOkeh5j3oP1FyOxRZsfGFUkrc2T6P9p+3I=;
        b=cEJFe34ikuHOhkdNVczLPYrRR+m6Y0vgNSwzq4iGi/M7DyI8Rd+rE+bvMkKyDT65W1
         WB2I7hIQz6JGEMReuLug==
Received: by 10.100.144.3 with SMTP id r3mr2616548and.25.1312595813987;
        Fri, 05 Aug 2011 18:56:53 -0700 (PDT)
Received: by 10.100.144.3 with SMTP id r3mr2616538and.25.1312595813781; Fri,
 05 Aug 2011 18:56:53 -0700 (PDT)
Received: by 10.100.144.6 with HTTP; Fri, 5 Aug 2011 18:56:53 -0700 (PDT)
In-Reply-To: <CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178819>

Hi Jonathan,

> On Wed, Aug 3, 2011 at 6:20 AM, David Barr <davidbarr@google.com> wro=
te:
>> Some web-based email clients prepend whitespace to raw message
>> transcripts to workaround content-sniffing in some browsers.
>> Adjust the patch format detection logic to ignore leading
>> whitespace.
>>
>> Signed-off-by: David Barr <davidbarr@google.com>

>> diff --git a/git-am.sh b/git-am.sh
>> index 463c741..19b2f0f 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -199,7 +199,11 @@ check_patch_format () {
>>        # otherwise, check the first few lines of the first patch to =
try
>>        # to detect its format
>>        {
>> -               read l1
>> +               # Start from first line containing non-whitespace
>> +               until [ -n "$l1" ]
>> +               do
>> +                       read l1
>> +               done
>>                read l2
>>                read l3
>>                case "$l1" in

On Wed, Aug 3, 2011 at 10:28 PM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> Finally, patches from GMail that play nice with git-am!
>
> =A0Acked-by: Tay Ray Chuan <rctay89@gmail.com>

Do you see any subtle issues in this tiny patch?
I failed to include a test, I'll add at least one to the next version.
I did check that it doesn't break any of the existing git-am tests.

--
David Barr
