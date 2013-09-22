From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] build: add default configuration
Date: Sun, 22 Sep 2013 03:52:17 -0500
Message-ID: <5940c6ca-86f4-4a57-bc9e-41a73842cc6d@email.android.com>
References: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com> <523DEC3F.9080807@kdbg.org> <CAMP44s34=HW=C5Fex6xabyQ=Zv4pg7p8RddMEOSVZqudgUkQ_A@mail.gmail.com> <46ebee31-2b4f-48c1-952c-99364aeede98@email.android.com> <523e815966074_547c41e7c16566@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 22 10:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNfP5-0008BR-LL
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 10:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab3IVIw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 04:52:28 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:39305 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab3IVIw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 04:52:26 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so912616yha.16
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=YCLDlNnJOVL5Q2GSCb8reqvmHiCOrFXWEr2uNadGlzI=;
        b=eaMBKlvfhT3JCaq+cuoqy4PFET32IDVKBqrDOKbsU1UyjMwt35GutXmHpGTqpcvXZ8
         f2QS2ntKzulBDekvb/WszEK3hrzr5nsj/hxEekjZVPmJonnoL/S6u9IuB6qIlsJ/RB9/
         u0Z8/ZlYKFCG8A6MByPS74TQ5BYmCMGXxfj2xXfIPYiq0hAoWUWw2zQECi28RiZLskiF
         fMqBho5lSS1MLXZYpNLeWvH8k4RIl02MZGhvqhwFo58AuQ/ps4ZUUvYWOsl/fHUFqWnV
         Gu/9bLofwof5G6NDJzAMe5PZporWH0x1vSlNOiKS0ND9GG1Tfl/X+2Y/9qobX9IqkRDM
         1R2g==
X-Received: by 10.236.87.116 with SMTP id x80mr16868347yhe.34.1379839945758;
        Sun, 22 Sep 2013 01:52:25 -0700 (PDT)
Received: from [10.65.19.245] ([190.63.1.186])
        by mx.google.com with ESMTPSA id t31sm30133633yhp.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 01:52:25 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <523e815966074_547c41e7c16566@nysa.mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235164>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
>David Aguilar wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> >On Sat, Sep 21, 2013 at 1:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> >> Am 21.09.2013 13:47, schrieb Felipe Contreras:
>> >>> diff --git a/Makefile b/Makefile
>> >>> index 3588ca1..18081bf 100644
>> >>> --- a/Makefile
>> >>> +++ b/Makefile
>> >>> @@ -1010,7 +1010,7 @@ ifndef sysconfdir
>> >>>  ifeq ($(prefix),/usr)
>> >>>  sysconfdir = /etc
>> >>>  else
>> >>> -sysconfdir = etc
>> >>> +sysconfdir = $(prefix)/etc
>> >>
>> >> Not good: There is a reason why this is a relative path. Please
>dig
>> >the
>> >> history, it's pretty clear.
>> >
>> >It's pretty clear it's *not* a relative path.
>> >
>> >What is relative about 'sysconfdir = /etc'?
>> 
>> Thanks Johannes. Felipe, the history and this comment from the
>makefile should shed some light on it:
>> 
>> # Among the variables below, these:
>> #   gitexecdir
>> #   template_dir
>> #   sysconfdir
>> # can be specified as a relative path some/where/else;
>> # this is interpreted as relative to $(prefix) and "git" at
>> # runtime figures out where they are based on the path to the
>executable.
>
>They *can* be, but not necessarily so, and in particular sysconfig for
>probably
>99% of the users is not relative, it's /etc.

This makes Git relocatable. MsysGit has many more users then developers, and represents a pretty large chunk of users. 

-- 
David
