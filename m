From: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Subject: Re: Crashes while trying to show tag objects with bad timestamps
Date: Sat, 23 Feb 2013 01:14:40 +0200
Message-ID: <CAPWNY8UMkxvLPk2TxCz+BAat1sNXitjhv=yqcdY0yZ1OLjgd0w@mail.gmail.com>
References: <kg8ri2$vjb$1@ger.gmane.org> <20130222224655.GB21579@sigill.intra.peff.net>
 <7vy5egark3.fsf@alter.siamese.dyndns.org> <20130222230418.GC21579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91pq-0007ZY-6c
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab3BVXO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 18:14:57 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:40534 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab3BVXO4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2013 18:14:56 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so926230lbb.22
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=hrKfSqLaEic096zI8DVhbZWFVbvEHsv2o5ss8NGi8zg=;
        b=VGjQpKmUOn6Hv/kNbBMdlRwNCX0DggAzkB8VTsJ7jk++viduq0lY7qHah/Qstz9vb7
         A7y/O6aOeqbP8J8uiGLYZK9b+vQTJMrvkTC9lzY2G7llRhoD1DVOI1stjCwfgQdy5/ft
         wvoQaB7fO+c+ASOLIKIl5Jxo8F/zCbhl+iAfGP5ziYzjZWyCGmi2ADe9juLHLf6IBG1j
         JZtpVsfSI3Qzl+PZYM91noXeaEAgUk/nSG1U0JhK3oS6aFKjjSPeD1XKJuPcSkGv8p2g
         NqsDa2MzAaGZXwhq8vEYIerje0tvHKVDgCk6kgJO/eTl5aSAVi2NwTSaRa7g18dYsUXp
         tgwA==
X-Received: by 10.152.47.97 with SMTP id c1mr3265870lan.6.1361574895254; Fri,
 22 Feb 2013 15:14:55 -0800 (PST)
Received: by 10.112.17.47 with HTTP; Fri, 22 Feb 2013 15:14:40 -0800 (PST)
In-Reply-To: <20130222230418.GC21579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216880>

On Sat, Feb 23, 2013 at 1:04 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 22, 2013 at 02:53:48PM -0800, Junio C Hamano wrote:
>> and no for disappointing.  IIRC, in the very early implementations
>> allowed tag object without dates.
>>
>> I _think_ we can start tightening fsck, though.
>
> Then I think it would make sense to allow the very specific no-date t=
ag,
> but not allow arbitrary crud. I wonder if there's an example in the
> kernel or in git.git.

I couldn't find any such examples. However, I did find several tags
with no "tagger" line at all: git.git has "v0.99" and linux.git has
many such tags starting with "v2.6.11" ending with "v2.6.13-rc3".

It seems that `git cat-file -p` doesn't like such tags too =E2=80=93 if=
 there
is no "tagger", it doesn't display *any* header lines. More bugs?

--
Mantas Mikul=C4=97nas
