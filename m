From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 07/12] completion: simplify command stuff
Date: Thu, 12 Apr 2012 02:45:44 +0300
Message-ID: <CAMP44s0avJZDZjUUK3TaMDtxRJ2xXo-bELAqDB_gW1cE+LMP9g@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-8-git-send-email-felipe.contreras@gmail.com>
	<20120411221430.GT2289@goldbirke>
	<CAMP44s3hYHxs2HZ59meEO=SU7gXuxU=m489LdxV38=7PDeDFdw@mail.gmail.com>
	<20120411230157.GV2289@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI7Eb-0003qp-E7
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965548Ab2DKXps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 19:45:48 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55310 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965146Ab2DKXpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 19:45:45 -0400
Received: by eekc41 with SMTP id c41so358776eek.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8+iAX/hSanQONQDBvQufM2X8hvhiszP2cdDsMzzntpc=;
        b=OhKLmixuM79ppcg+R6l9uaKK6/hFPkoXXm0yG5UsqKQLMqThE7goGxABTY9jAXtoAA
         aE9OMRwMVS0iQO2vma6jxgSsbKwkyiGoJCJSOJIGdnR3PnKI4AYV+wkCZcqdRo/gUra8
         JqwSFe4Ov96xlhyr3ulQhkEfpmtEa+Y993sUdbrwZXRjWc6jkgUM3mOkaJARiSJEGUp6
         JlvVqVqGVb8E5nXPVmvtHnJpDFvL3cgTj48nfqRKs0HGtZFJ9RtdEhX0X21IRQduyixO
         fD4INtjGW2Q15TynmZb/kJmD9cO6ueExOmTU2P8uPI+h6aa+lMbVt2atMDn+bgmArol8
         CI3Q==
Received: by 10.14.127.129 with SMTP id d1mr38068eei.59.1334187944108; Wed, 11
 Apr 2012 16:45:44 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Wed, 11 Apr 2012 16:45:44 -0700 (PDT)
In-Reply-To: <20120411230157.GV2289@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195283>

2012/4/12 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Thu, Apr 12, 2012 at 01:21:17AM +0300, Felipe Contreras wrote:
>> 2012/4/12 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>> > However, this change "promotes" the command (or cmd) variable from
>> > being just a variable in _git() to a variable that is used in othe=
r
>> > completion functions, too. =C2=A0Why not go one more step further,=
 and
>> > denote this by adding a __git prefix (i.e. renaming the variable t=
o
>> > __git_command)?
>>
>> After thinking more about it, and analyzing the next patches, I don'=
t
>> think it makes sense to have such a variable; it's only used by
>> __git_complete_remote_or_refspec, and it would be easier to make it =
an
>> argument to that function; that would simplify this patch series a
>> lot.
>
> You mean that _git_fetch() would call
>
> =C2=A0__git_complete_remote_or_refspec "fetch"
>
> while _git_pull() and _git_push() will pass "pull" and "push",
> respectively?

Yeap. Then there would not be any need for the foo_wrap () stuff.

--=20
=46elipe Contreras
