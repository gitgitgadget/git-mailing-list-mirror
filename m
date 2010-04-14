From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: Re: Add repos but not as normal files, not submodule
Date: Wed, 14 Apr 2010 23:02:42 +1200
Message-ID: <7118B4DB-A95F-424F-87EF-035B36E578FB@gmail.com>
References: <BFCA0C1E-FBE0-4CE6-8018-704BC5E0ACA6@gmail.com> <20100414093603.GA29065@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, illegalargument@googlegroups.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 13:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O20Mx-0006Ua-0K
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 13:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab0DNLCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 07:02:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60062 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab0DNLCs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 07:02:48 -0400
Received: by pwj9 with SMTP id 9so6131643pwj.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=OjS1g4RyF2KDvB+yOkykb6YeVN1tLR37Gz4T3H0SDRM=;
        b=ZnWLxjWBQwFgNKKZlsfaBi4zijvIT81aJps0LObdnqmc/cD0k5+lmZgM+KdXwG8nrP
         rhQhGeOyVMp9sYb1y3qdlLXLUP1KxDZNTJnWRfh10z1IidrOuWP0T6kW5VQIKPkkkDPV
         zwVlzV4lBKLstgmvlBoWqNfRz41KpdyBXgYO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=OB5+NRlXbHbsZ0YNoE9n0n2IZz4cFlLXGtKUjTgduwwmH2pcF0nLuTHmzW81nmZzsR
         LeT3Rkx5ZwlzZKGtUp85hzf8+fki4pDAzpsUNlidUyDpUbWt3cQZgKiEwlotFLA1g9T7
         nJ0oHsVAyYx4BMf0TfFYA121OCrKSgVY3l6Zk=
Received: by 10.115.38.6 with SMTP id q6mr1105102waj.207.1271242966855;
        Wed, 14 Apr 2010 04:02:46 -0700 (PDT)
Received: from [192.168.1.20] ([210.55.232.26])
        by mx.google.com with ESMTPS id 21sm206949pzk.8.2010.04.14.04.02.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 04:02:45 -0700 (PDT)
In-Reply-To: <20100414093603.GA29065@progeny.tock>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144864>

> In other words, if bar is itself a git repository with a valid HEAD,
> then =91git add bar=92 will register it in the index as a submodule.

That was the behavior I was seeing...

> If you can rely on build systems to have git installed, I=92d suggest
> writing a simple script to build the test repository from scratch.

Yup - will probably go down this route.

> You can also try using repositories not named .git if you are careful=
=2E
> I don=92t really encourage this.

Didn't realize this was possible. Any pointers? Links?

>> The reason I don't want to do submodules is that I don't want to
>> have the submodules as serperate projects as such, because they're
>> not. they're "test data" so to speak.
>=20
> Yes, makes sense to me.
>=20
> Hope that helps,
> Jonathan


Cheers for the deep dig! I started looking around the C code, but was f=
ollowing the wrong trail (verify_path) - I like your demo - very nice.

I suppose this problem only stems from them wanting git add to "nicely"=
 automatically recognize .git sub dirs as submodules, thinking no one w=
ould ever in their right mind actually want to *track* a sub .git dir ;=
)

Cheers!