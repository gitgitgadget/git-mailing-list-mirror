From: Johan Herland <johan@herland.net>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 15:47:19 +0200
Message-ID: <CALKQrgfLxcNAcSg7QB7h4RVwqdE3+XojKwJ9zfcUrpJ6xnV+5g@mail.gmail.com>
References: <20130627124656.GA2620@zuhnb712>
	<CALKQrgdiRg--A4-cp7Y0c3-rc-gDX+QVgPxKDpmW5Exx_HeWHg@mail.gmail.com>
	<20130627134156.GB5047@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsCXo-0006O2-OX
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab3F0NrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 09:47:25 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:51361 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3F0NrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 09:47:24 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UsCXi-000Ljp-RQ
	for git@vger.kernel.org; Thu, 27 Jun 2013 15:47:22 +0200
Received: from mail-oa0-f42.google.com ([209.85.219.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UsBN8-000MMN-NM
	for git@vger.kernel.org; Thu, 27 Jun 2013 14:32:22 +0200
Received: by mail-oa0-f42.google.com with SMTP id j6so867251oag.29
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UOMjyycScSZfWk7gO0RcRbOMrfAKTiCPIkYbILFrj64=;
        b=RKQ2bi2teZ1URM5UNAkiSuuwwK6jA3ytvNBkhCjpcyA8PTIfR/qD54Z3X/XHINcm0b
         GbC+hgS61m4Nrz+dVzraGCI0BzbL5YrCDyn3JxQQFm8hXEoXcEU4oOsL3NqvwPQBD2Bm
         4k+d5vVRrOlhHWiVzon1uAj8+4Kel0hpUlLOID5ohh+EhSFbtVKpebMZvaWtD5Q/V+m5
         ZmPWnpQFUv4kkov/4+LbCAQTbo195xh4kvacMXFtQBZ6b5EqurLlEIH2quBOLG9j2lmX
         nPeG12Na6SDCp0DYsLM4Fn5UVnefF6WFVdy/nvsGQjkYNZNMgD5joReb/HiYUvteMU5y
         Of+A==
X-Received: by 10.60.16.225 with SMTP id j1mr2846636oed.97.1372340839130; Thu,
 27 Jun 2013 06:47:19 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Thu, 27 Jun 2013 06:47:19 -0700 (PDT)
In-Reply-To: <20130627134156.GB5047@zuhnb712>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229105>

On Thu, Jun 27, 2013 at 3:41 PM, Woody Wu <narkewoody@gmail.com> wrote:
> On Thu, Jun 27, 2013 at 03:14:05PM +0200, Johan Herland wrote:
>> On Thu, Jun 27, 2013 at 2:46 PM, Woody Wu <narkewoody@gmail.com> wro=
te:
>> > I have a colleague who has to left our office for three month, but=
 still
>> > need to work on the project which is hosted on our in-office git
>> > repository. Problem is that our company has firewall, it's not pos=
sible
>> > or not allowed to access the company LAN outside the building.  So=
 I
>> > want to ask you expert, can you suggest a best practice of git wor=
kflow
>> > that suitable to my situation?
>>
>> If he can set up an SSH server on his machine (outside the company
>> network), then he can set up a mirror repo on his machine, where you
>> can push changes from the office to him, and pull changes from him
>> back into the office. Of course, you will probably need to synchroni=
ze
>> this with him, especially if he's travelling and frequently offline =
or
>> changing IP addresses. Also you need to be able to make outbound SSH
>> connections through the company firewall, but AFAICS that is usually
>> allowed.
>
> Outbound ssh to me is not a problem, but inbound ssh to him may be a =
big
> problem. You know hotel firewall or some home ADSL don't allow that.

In that case, you will need either:

A) A third machine, accessible from both you and him (preferably over
SSH), where you can store the repo. I don't know what your company
infrastructure looks like, but maybe it's possible to setup a server
in the DMZ outside your company firewall?

B) Use a more manual mechanism like emailing bundles (as explained by
Jean-No=C3=ABl).


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
