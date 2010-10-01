From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git .lock file error
Date: Fri, 1 Oct 2010 03:59:48 +0200
Message-ID: <AANLkTi=ZFb4T+RwT+kkccX0jtyQZxs71eJajSX7KQb+h@mail.gmail.com>
References: <AANLkTikjwW8jJ3qGCAM=8F_GBxsz9_KoSW0KDGPKhXGQ@mail.gmail.com>
 <AANLkTin+MRkYv7vL7eY+mdWG1vTg-E9pVpU4_QujoxdZ@mail.gmail.com>
 <AANLkTim2sFCx8qZ-6o4tiugX3a-EBN9T8wuCSWXb5L12@mail.gmail.com>
 <AANLkTik364t7WEHOsZcB7FE4Y2gJQNxkXsRvW5guUWCi@mail.gmail.com>
 <7vbp7fhtt0.fsf@alter.siamese.dyndns.org> <AANLkTinFJ5rSA7Om0ZxhuqzQiqEDvJ+JoEQFpz=NDvxE@mail.gmail.com>
 <AANLkTikV=f1ncAxQ1LWzntnOwiBKMfw_D8Mcuh+wCO3+@mail.gmail.com> <AANLkTik2HtyVGz6xFb_VmCh1gSAA_vwpUXhytHFzgCwa@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 04:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1UvD-0006i5-Ec
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 04:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab0JACAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 22:00:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65022 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab0JACAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 22:00:09 -0400
Received: by qwh6 with SMTP id 6so1174792qwh.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 19:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=KRz3ShcJm/R/yzXRVZECrrNc52eDVO3FsLwkbqJ7Ihs=;
        b=QzE9yIB8i2AG3jH1a4DJ5ohjloJyNeqJ618QBhnWw8H/Otd5ndSGS7HMW/VrLEhJ7j
         cKIhLy1pzXrdFKcF/gJ+WAsxPa8rz1VcSgdGpn1karOZv360+dd8uzrvitx6b4u5C8AS
         z1MpyR4pPARjcN4hNd03Et6mP0I7sybupOFhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=PCyJZq9h4q1Br0Pq8F4gSXzNOxFssXx/b61McrPxHh83FKzT8wjFUfcX7hY9RhJ5el
         +i74g2bmLUPq1TfDdN+IRDAdKaVYITcJY29s+Owx/KDH6aawT20ivh86p6fr2lpFlfIZ
         sKcNoBUsIbIX9Tz/omUHB7VQEQRrBuwHG4hkU=
Received: by 10.220.125.23 with SMTP id w23mr1206716vcr.136.1285898408257;
 Thu, 30 Sep 2010 19:00:08 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Thu, 30 Sep 2010 18:59:48 -0700 (PDT)
In-Reply-To: <AANLkTik2HtyVGz6xFb_VmCh1gSAA_vwpUXhytHFzgCwa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157728>

On Fri, Oct 1, 2010 at 2:54 AM, Nate Parsons <parsons.nate@gmail.com> wrote:
> On Thu, Sep 30, 2010 at 7:45 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>
>> Are you running some anti-virus, or from a Dropbox-folder (or
>> something similar)? If so, these applications tend to open files for a
>> short while and then release the file handle. This can some times
>> cause race conditions with other software, like Git.
>>
>> I haven't looked into this particular code-path for what kind of
>> hazards might be, but this sounds very much like one such case to me.
>
> Any of these things are possible. As much as I'd like to find the root cause
> of this problem, isn't making Git more robust a good thing in general?
> Finding every program that could conflict with Git and
> disabling/uninstalling it isn't really a good long term solution, I think.

While making Git more robust is certainly a worthwhile goal, adding
retry-loops around any timing-sensitive code without finding out
exactly what went wrong is just cargo-cult programming.

I don't think I've ever seen such a breakage with open(..., O_CREAT)
before, so I'm sceptical.
