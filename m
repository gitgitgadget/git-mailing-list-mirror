From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local changes
Date: Tue, 06 Apr 2010 22:21:55 -0400
Message-ID: <4BBBEC43.5000100@gmail.com>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com> <20100406233601.GA27533@progeny.tock> <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com> <20100407004353.GA11346@progeny.tock>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 04:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzKuC-0002YS-41
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 04:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab0DGCWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 22:22:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64405 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab0DGCWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 22:22:03 -0400
Received: by gyg13 with SMTP id 13so323476gyg.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 19:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eYYFuCc4bLg9prVoPqz24hwdX+t1h580XCg2voJ68ls=;
        b=L1J7FxTjl/zEQk+uhpTP+RXi+Ov9F9YoVp6ZkfSqREML6tJu9PDTAzcbouoXkXz/WC
         UU/ncUp+8t7RATAN6hfJWjofhX1TOz2r7lIrcPw50soHIPLZ87kOH4vd/bvI74NC60/i
         2W/LagUJCZ0uS8zrAUKK4u1IC0gzzgd1JsY3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=JkiEZmVWtRkdEtN/nrmklmnwn2z7zH+prt5VgTb8p/wu+LSCHdxmgc1bULjJwG6NsL
         bVTClSiBIHYbn6ob/C4zL2vjMI1NM3GVCf83e0QJTeGo71FKa3CotbrCUu440P7iShtE
         +EGHOstTrwGFWw1+47vMaZie3/1255aHsoNw4=
Received: by 10.100.246.17 with SMTP id t17mr7598155anh.90.1270606920620;
        Tue, 06 Apr 2010 19:22:00 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 13sm9280191gxk.4.2010.04.06.19.21.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 19:22:00 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20100407004353.GA11346@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144188>

Jonathan Nieder wrote:
> Most git porcelain silently refreshes stat-dirty index entries.  Teac=
h
> gitk to, too; this will make the behavior easier to understand when a
> person makes a change to a file and then changes mind and restores th=
e
> old version in her editor of choice.
>=20
> This patch does not change the =E2=80=98checkout=E2=80=99 code path, =
since it is
> assumed that the index is already being cleaned in that case.
>=20
> Testing is needed to check if this breaks operation with read-only
> access to a repository.
>=20

NAK - gitk should not modify a repository and/or working dir unless=20
_explicitly_ prompted to by the user.

If you want a new _non-default_ option setting for gitk, that fine also=
=2E
