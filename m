From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 00/32] refs backend
Date: Thu, 25 Feb 2016 11:31:37 -0800
Message-ID: <CAGZ79kaJn5NezgdaskPgNqxA9Gft7tp5gLZ4z3AM60vYrVmv7Q@mail.gmail.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	<CACsJy8DEtmYnmwENws0Hb_2Do_sQkKEaraz=vxgrCyTOV-3FVg@mail.gmail.com>
	<1456428475.18017.38.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:31:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1dX-0007M0-3G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933642AbcBYTbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:31:39 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35371 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933583AbcBYTbi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:31:38 -0500
Received: by mail-io0-f175.google.com with SMTP id g203so99283117iof.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 11:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YIS4KvSckLkiTJLkloRnYQXX25BE+rQdY10ziVuppGQ=;
        b=OTI35LUs2OegN6x7x2s1Lj/TSukDw4AquMbRBpXvK9ZtmgrDEpAodOi/FxzVnkZW4m
         mvHS1lNjH/1MRkJ2v2OByIVyTr1Ci3wRe6AmM0d53N7MsQXKmP32w6KzBeDlEjxWEsmx
         rCsg+Lv8QRwWcmuPalZzonc501NMiRxNotPPuy7fqSF0lBhwQI9BOkcHp810v2Kk7Tgy
         pfK4ad+3kmMacGLrjaVTKWqW1G2aGXjhOh8pgmT538YgUgf55IE964kFckLvNnyu9rua
         8Ww5dSBtU5ACoejADPMGpXQKhcPGNKPivJO6r21WYMGvg0QQ+Gi6DND1QOzsqwkleja1
         IVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YIS4KvSckLkiTJLkloRnYQXX25BE+rQdY10ziVuppGQ=;
        b=mAuoMFD7wV9ntBxs/WETY83e5vIBoTMsWyNcRuDEI1Au5Tvzn303KNFjLFejoxVsPr
         /kmHufUJWRE7dBb9fZXySstKtRy0pcPsZcmCR+XQ7uvm0i9lMaxU7MFA0j7EtA9kE4/Q
         zEXyM4+Gsc+NNFsLrCpxChDZzjYsnsnJ3WR4WaCtXjQxdPFeP7atXDbxAp9IRRf3lADN
         1oCxfhAUzDkWtZlCpLMKDsGu6JWKL1LVgp0zu25ZYgk1QKF1WPbQxZhiO1VB1EoBPDPn
         Vat/r7s0iOIZpL2fWQ8IlRQGADhC7tTIjArxFuMzna380Vi230Fw4SeEPeZMZsDm+DPf
         yEFQ==
X-Gm-Message-State: AG10YOSp3EpiOFIUw9LQrHRTrTlq2AUMv5opBVQmJcTwSHDNdlDKOlWobIRQ81grkMAoyJeKThtECogzdXqb4/cm
X-Received: by 10.107.168.149 with SMTP id e21mr4620333ioj.96.1456428697599;
 Thu, 25 Feb 2016 11:31:37 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 11:31:37 -0800 (PST)
In-Reply-To: <1456428475.18017.38.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287421>

On Thu, Feb 25, 2016 at 11:27 AM, David Turner <dturner@twopensource.com> wrote:
> On Thu, 2016-02-25 at 19:57 +0700, Duy Nguyen wrote:
>> A couple of build warnings I found, haven't really read the code yet.
>> These two can easily be fixed
>>
>> refs/lmdb-backend.c: In function 'lmdb_read_raw_ref':
>> refs/lmdb-backend.c:554:16: warning: unused variable 'err' [-Wunused
>> -variable]
>>   struct strbuf err = STRBUF_INIT;
>>                 ^
>> refs/lmdb-backend.c: In function 'lmdb_do_for_each_ref':
>> refs/lmdb-backend.c:1625:15: warning: unused variable 'c' [-Wunused
>> -variable]
>>    const char *c = resolve_ref_unsafe_submodule(submodule, refname,
>> 0, oid.hash,
>>                ^
>>
>> -Wshadow also gives a bunch of warnings, mostly about "transaction"
>> and "env". Whether you want to fix them is really up to you.
>> --
>> Duy
>
> Will fix these, thanks.  I've now configured my config.mak to do -Wall
> again, but -Wshadow produces a ton of complaints on the rest of git's
> code.   We should probably fix those.

It is a proposal for the GSoC microprojects to fix all -Wshadow problems
in say one file.  Maybe we'll see some activity there :)
