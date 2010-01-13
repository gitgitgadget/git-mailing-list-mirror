From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: remote to push to local branch: hung up unexpectedly
Date: Wed, 13 Jan 2010 22:49:44 +0800
Message-ID: <be6fef0d1001130649i6a5f4f29j10800f2532d97796@mail.gmail.com>
References: <20100113130843.GA13545@redhat.com>
	 <be6fef0d1001130615k17855680s57952498260ad09d@mail.gmail.com>
	 <20100113142800.GA13901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 15:50:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV4Xn-0004Ti-Bc
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 15:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab0AMOtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 09:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442Ab0AMOtp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 09:49:45 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:61220 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab0AMOtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 09:49:45 -0500
Received: by iwn35 with SMTP id 35so16410468iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AX2RozO82kVZVQ3LsIkHGXnk6fYPA4QR4PHTP9V3ZPE=;
        b=bkO4ugHulfRGbaRRTHfEK7uCe0jRfcY555jDKf7aqA7n1MvnGaAT1y6JylffV9+7BN
         pez0Di1VAcAKDruVphAR004w0HrVFuui0/8BWQEub8JpDmMPshQihCedJnTdxEWXTo6L
         3jvEUzhaOq2TgtRC/9q5PlnHvRhaw0/yz4QVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b8zZIUvbKxiJJG1wq3NpSYAMBT2+pEVP8MasOb/Q9faRD8vcRVLJsHZuG97xSoAi29
         Qj6HqcbJ3bylUPbQjCQ9omCPVYnRwaPYDwGU/6GqxceFfMjFEgL7o7GqYb3VA5o+dY1j
         0I0kQ1wEbbLZt36nWJz3btSNxQ4lmfRc5C7Qs=
Received: by 10.231.123.216 with SMTP id q24mr1378540ibr.43.1263394184561; 
	Wed, 13 Jan 2010 06:49:44 -0800 (PST)
In-Reply-To: <20100113142800.GA13901@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136826>

Hi,

On Wed, Jan 13, 2010 at 10:28 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> On Wed, Jan 13, 2010 at 10:15:38PM +0800, Tay Ray Chuan wrote:
>> Hi,
>>
>> On Wed, Jan 13, 2010 at 9:08 PM, Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>> > with url =3D /scm/qemu =A0 (this is repo path)
>>
>> Are you working in a "normal" git setup with a .git folder and the
>> files checked out? Or are you working with a --bare repo?
>
> It's a normal setup.

I used this script with v1.6.2.5, push was ok.

  #!/bin/bash
  GITZ=3D"/home/rctay/ext01/dev/git/git-1.6.2.5/git \
  --exec-path=3D/home/rctay/ext01/dev/git/git-1.6.2.5/"
  $GITZ --version

  mkdir foo
  cd foo
  $GITZ init

  echo hello > file1
  $GITZ add file1
  $GITZ commit -m "new file"
  $GITZ checkout -b pci

  $GITZ config remote.anthony.url .
  $GITZ config remote.anthony.push +refs/heads/pci:refs/heads/anthony

  $GITZ push anthony

--=20
Cheers,
Ray Chuan
