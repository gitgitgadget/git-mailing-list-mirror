From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: PATH_MAX (Re: [PATCH] system_path: use a static buffer)
Date: Mon, 21 Mar 2011 13:37:20 +0100
Message-ID: <AANLkTinh4K0Crhs39wuZpKhmxcZkSGhKdZNarmHoimoH@mail.gmail.com>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
	<1300371853-8965-1-git-send-email-cmn@elego.de>
	<AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
	<20110318113818.GA6049@elie>
	<1300700875.2583.8.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 13:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1eMT-0001uV-4N
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 13:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab1CUMhY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 08:37:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52834 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833Ab1CUMhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 08:37:22 -0400
Received: by bwz15 with SMTP id 15so4968283bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=xm9CQShGTmim/+WQpWlAHj9zr/XDpJL2aVBgf2zzirE=;
        b=iYstxjaUL5pkrPIKMy04hywcfVT7fp4To2uq6jxBmwBJMNMFenNtJrP20Stf3Tgc7e
         e53qONIxyYUEbMdf3O5OTeihHLb1s4u9wbbO6XjAmnFhBVzbbEifuoicvClrQZwEqlLI
         pN12Dz/xYtgs5KlF/qup0YHkLG63P4DLWjeCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=FaGvQUHyINl0ap6axCih8yXFuj3NxkB5BQJqbl25//hwUC3oeNf2XVtZ3F0F9Way41
         zMXtqL5coiTJuQYFuknLzxNSRKXa+IxsvkTUtYr5iHiC6HHBBPiFEhRH9bMNfcDAFMe9
         iPMm7/hAOoCG7Ol4fQLNvvJkCyXHwL4L5jpOc=
Received: by 10.204.154.74 with SMTP id n10mr3566117bkw.33.1300711040802; Mon,
 21 Mar 2011 05:37:20 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Mon, 21 Mar 2011 05:37:20 -0700 (PDT)
In-Reply-To: <1300700875.2583.8.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169591>

On 21 March 2011 10:47, Carlos Mart=EDn Nieto <cmn@elego.de> wrote:
> On vie, 2011-03-18 at 06:38 -0500, Jonathan Nieder wrote:
>> Hi,
>>
>> Nguyen Thai Ngoc Duy wrote:
>>
>> > It was pointed out elsewhere [1] that PATH_MAX only specifies max
>> > length of a path element, not full path. I think we'd need to stay
>> > away from preallocated PATH_MAX-sized arrays.
>>
>> No, PATH_MAX is actually the maximum length of a path, and when you
>> use, say, open(2), it will fail if your path is longer than that. =A0=
The
>> maximum length of a path component on most filesytems is 255 or 256;
>> PATH_MAX on Linux is 4096.
>>
>> It is indeed possible to have paths with length longer than that. =A0=
The
>> way to support that is to use relative paths wherever possible, whic=
h
>
> =A0So what PATH_MAX describes is the maximum length of a string
> representing a path, but not necessarily the length of the path itsel=
f.

According to this at least, PATH_MAX is bogus:
http://insanecoding.blogspot.com/2007/11/pathmax-simply-isnt.html

I think the sane thing would be to never rely on a fixed max path lengt=
h.

--
/Lasse
