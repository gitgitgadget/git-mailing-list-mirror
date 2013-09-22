From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] build: add default configuration
Date: Sun, 22 Sep 2013 00:19:46 -0500
Message-ID: <46ebee31-2b4f-48c1-952c-99364aeede98@email.android.com>
References: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com> <523DEC3F.9080807@kdbg.org> <CAMP44s34=HW=C5Fex6xabyQ=Zv4pg7p8RddMEOSVZqudgUkQ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 22 07:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNc5o-0002sh-Sy
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 07:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab3IVFT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 01:19:58 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:50316 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab3IVFT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 01:19:57 -0400
Received: by mail-yh0-f53.google.com with SMTP id b20so877735yha.12
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=Sc4jVom/Um9UgkrM66iv3oPtlYfO9qrsq6atWSavXWE=;
        b=uAcfpQ0KeEojNMGJzN0VBkH3g8l8tFcQAQf8vUrQERAbGZVuQdFhFGDuYTXE1KpKaC
         QNc3904C1IWxXzXk0ikp2bm79HE2SS4qqlPEofAaDSOWJEOmmvZGdNNc7tDTwiKH21vg
         bHypO2kUeq3+akIoCLh3F9Y9le+5LYEEt/Vs3H2hfGrTQxwub2rwOX4llB4iRS+gM2E3
         Wvz6jNoooAjE6EsTy1qSFGRG+ez1dCyeOVDwwdGCF4/yeTpHO5wmtygNIUEJ7Ft3tcHC
         3uGnqntjaV04bysfZiEc6ED8R+EfJluLygs6Cmbs+2fnkFjM5kT/oFO79pYjyeFe6qTt
         WoIQ==
X-Received: by 10.236.4.72 with SMTP id 48mr16007998yhi.43.1379827197098;
        Sat, 21 Sep 2013 22:19:57 -0700 (PDT)
Received: from [10.65.19.245] ([190.63.1.186])
        by mx.google.com with ESMTPSA id s20sm29489513yhi.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 22:19:56 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMP44s34=HW=C5Fex6xabyQ=Zv4pg7p8RddMEOSVZqudgUkQ_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235157>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
>On Sat, Sep 21, 2013 at 1:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 21.09.2013 13:47, schrieb Felipe Contreras:
>>> diff --git a/Makefile b/Makefile
>>> index 3588ca1..18081bf 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1010,7 +1010,7 @@ ifndef sysconfdir
>>>  ifeq ($(prefix),/usr)
>>>  sysconfdir = /etc
>>>  else
>>> -sysconfdir = etc
>>> +sysconfdir = $(prefix)/etc
>>
>> Not good: There is a reason why this is a relative path. Please dig
>the
>> history, it's pretty clear.
>
>It's pretty clear it's *not* a relative path.
>
>What is relative about 'sysconfdir = /etc'?

Thanks Johannes. Felipe, the history and this comment from the makefile should shed some light on it:

# Among the variables below, these:
#   gitexecdir
#   template_dir
#   sysconfdir
# can be specified as a relative path some/where/else;
# this is interpreted as relative to $(prefix) and "git" at
# runtime figures out where they are based on the path to the executable.
...
So it'll probably need another makefile variable to do this cleanly.

I hope that helps.
Cheers,


-- 
David
