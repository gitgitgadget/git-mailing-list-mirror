From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC] git-gui: disable (un)staging for files with
 typechange flags
Date: Mon, 6 Dec 2010 22:28:12 +0100
Message-ID: <AANLkTik9ZSSQ5pXs6wpU6dXGmVTJ=LTY6CQn79Pup9o1@mail.gmail.com>
References: <50fc511f363e8b13b9b1a27db71136d262c95f0d.1291155371.git.bert.wesarg@googlemail.com>
	<AANLkTimz-XZQzTygKxQDJ+E6ZJm1+8aZNuKfZ6-AwQh3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPiba-0001jn-Oz
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796Ab0LFV2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 16:28:14 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:56568 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0LFV2N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 16:28:13 -0500
Received: by gxk19 with SMTP id 19so7013985gxk.11
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 13:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ex3ytHrXBDRp/1dPdnc43hf4F3+wNPCVumg/I54ppKQ=;
        b=gb1va26hVGPUyzcdDQU0dpQNfzYy1/g0nEg2Iwb3iXzzOav+mHoucg+sgyQX8xDZ8B
         uCQmaDuqFUUDGpHGoyg7z6gSsl6mobJvzwsjqy0nG5NmYZi7eyeCXanxhTZDnnF6jstl
         rpxObfmM23pI6Q82iXcjBq+ZDSZlZE6lTZoMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x/EL6pR9n+D0noEIP9JJAvov9B4GAzFKzL2T6kXzFdetAsuCKr2UA50+O3cDUwCu+w
         1rZS6DgCixvu+pN8MumFNU+pVm5vKDI02PWBvSVvSBRE7fG5xAmqidLi2vUzDsP2lHsi
         WtDwT/b4ohw6vslH2WT0/P3jJQVQc2/LGVkCg=
Received: by 10.42.218.134 with SMTP id hq6mr1604780icb.492.1291670892824;
 Mon, 06 Dec 2010 13:28:12 -0800 (PST)
Received: by 10.42.172.193 with HTTP; Mon, 6 Dec 2010 13:28:12 -0800 (PST)
In-Reply-To: <AANLkTimz-XZQzTygKxQDJ+E6ZJm1+8aZNuKfZ6-AwQh3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163027>

On Fri, Dec 3, 2010 at 14:34, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> [ Adding Gustaf Hendeby, the author of the first patch to support typ=
e changes ]
>
> On Tue, Nov 30, 2010 at 23:21, Bert Wesarg <bert.wesarg@googlemail.co=
m> wrote:
>> This covers also the case for newly added files in the index. Like t=
his:
>>
>> =C2=A0 =C2=A0echo bar >foo
>> =C2=A0 =C2=A0git add foo
>> =C2=A0 =C2=A0rm foo
>> =C2=A0 =C2=A0ln -s bar foo
>>
>> This will result in an state of AT. And for cases where the type cha=
nge is
>> staged, and the new type was modified after the staging. Like this (=
cont.):
>>
>> =C2=A0 =C2=A0git add foo
>> =C2=A0 =C2=A0git commit -mfoo
>> =C2=A0 =C2=A0rm foo
>> =C2=A0 =C2=A0echo bar >foo
>> =C2=A0 =C2=A0git add foo
>> =C2=A0 =C2=A0echo baz >foo
>>
>> Will result in an state of TM for foo.

This patch is incomplete. There are more places where the new AT and
TM states needs to be handled. Please wait for a re-roll.

Bert
