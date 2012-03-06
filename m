From: Arya Irani <arya.irani@gmail.com>
Subject: bug report? fatal: Ambiguous object name: 'xxx' during branch operation
Date: Tue, 6 Mar 2012 18:18:40 -0500
Message-ID: <CAB1hNr8-iPbXD-7eEOxZtrJWO78V8sDmwWWQRMMExvtGtpPrhw@mail.gmail.com>
References: <CAB1hNr8itJV1-pzWxUo1KPsZNivg+KuRq_5jUwLUyCUpk7k=4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 00:18:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S53eY-0002Y6-Fx
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 00:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031568Ab2CFXSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 18:18:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45120 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031454Ab2CFXSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 18:18:41 -0500
Received: by vbbff1 with SMTP id ff1so4989510vbb.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 15:18:40 -0800 (PST)
Received-SPF: pass (google.com: domain of arya.irani@gmail.com designates 10.52.26.65 as permitted sender) client-ip=10.52.26.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of arya.irani@gmail.com designates 10.52.26.65 as permitted sender) smtp.mail=arya.irani@gmail.com; dkim=pass header.i=arya.irani@gmail.com
Received: from mr.google.com ([10.52.26.65])
        by 10.52.26.65 with SMTP id j1mr44936924vdg.113.1331075920978 (num_hops = 1);
        Tue, 06 Mar 2012 15:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=5jqyfM1lpL9qGUjkoG653HstRufH1UDxoY73ghs89Ys=;
        b=QYK51s29C21aWnLnxhz6oiNj8/rUjMxVu0cYzTqINutLLFnP5gJ/tJ/c1nq7GZwLEP
         oQrbCdfq23ZQEDmbVpScyPoTx7y3GItNeA7W2VhMUcgP6vgaSTjGL5w/O2T0XSEH7me9
         gOUg9/yDf250oAegjHvv3Fvt30ryCys14NCjfBT9nopYUJpQua/HWv3wMxoM8erKOiTF
         eVpH0y7DjLquMQ7vOYJcf8V5gz36w6oEWhSepJZphG1rOUGuy8JPltoXs4ntdbQbd1u0
         Wtt8Bi0uz9j7virrOmPkX9Hu/s9rBoXKU1L4vBUe7cKumRwxommyQjfG3RX0TxvNjiDP
         cvBw==
Received: by 10.52.26.65 with SMTP id j1mr38458475vdg.113.1331075920942; Tue,
 06 Mar 2012 15:18:40 -0800 (PST)
Received: by 10.52.67.79 with HTTP; Tue, 6 Mar 2012 15:18:40 -0800 (PST)
In-Reply-To: <CAB1hNr8itJV1-pzWxUo1KPsZNivg+KuRq_5jUwLUyCUpk7k=4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192415>

If the default start-point for a branch is HEAD, then how can it fail
due to ambiguity? =A0Or what the heck is going on here? :-)

$ git branch -a
* 1.1-SNAPSHOT
=A0 master
=A0 remotes/1.1-SNAPSHOT
=A0 remotes/trunk
$

$ git branch getProviders
warning: refname '1.1-SNAPSHOT' is ambiguous.
fatal: Ambiguous object name: '1.1-SNAPSHOT'.
$

$ cat .git/HEAD
ref: refs/heads/1.1-SNAPSHOT
$

$ git branch getProviders refs/heads/1.1-SNAPSHOT
$
success!


[svn-remote "svn"]
url =3D https://host/svn/all
fetch =3D GHIE/maven-projects/hie-util/trunk:refs/remotes/trunk
branches =3D GHIE/maven-projects/hie-util/branches/*:refs/remotes/*
tags =3D GHIE/maven-projects/hie-util/tags/*:refs/remotes/tags/*

Thanks,
Arya

P.S. =A0I'll use --prefix for svn to avoid this in the future!
