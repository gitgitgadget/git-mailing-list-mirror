From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t7003: Use test_commit instead of custom function
Date: Mon, 13 Sep 2010 12:11:32 +0000
Message-ID: <AANLkTi=1p7tTNfhX7_4vMPFGtRC=F14im3qo009RPJV9@mail.gmail.com>
References: <1284156396-81023-1-git-send-email-brian@gernhardtsoftware.com>
	<214E9A5B-E9CE-4B98-88EC-744DBE1F3C32@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 14:11:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov7sq-0003NE-GY
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 14:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab0IMMLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 08:11:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40766 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab0IMMLd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 08:11:33 -0400
Received: by iwn5 with SMTP id 5so5131488iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=js1FmJ7IwWu3j0u1qk5UQAwFmFA3HjVNFl7eYKcy6R8=;
        b=B1r6uUD3pEUzrmcii6wcqayHO0yonAdJSGC3EbyQdetErMUUiLRM5RC+6BG+whsg1B
         lMLYxC7ARhKW3hK1LrlhCHmWNuUSxNqLmaioYdFimfwsZYtWOHy4HUN0JV4gUUd0a+yC
         K8FacVZ9fSo8CBuYYh0hjdKgM1/gsbaXtvSqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SIDwCIhtQUuGDkHOG4i+n6Bog2HMQGavnhB8X9lbD29HekxanGCvi9ZZqpgEGlWPz0
         sd3TQA21LAQPelGFMP3CB3Z6UCIlGGtKtQZeE7jM1/y3fxMtoMlZ9/ZahJy/NiGRw3YF
         GyT6Rx32/teVjo9c9mdAnntyyDoDNZfh/4YVs=
Received: by 10.231.155.206 with SMTP id t14mr6166295ibw.34.1284379892758;
 Mon, 13 Sep 2010 05:11:32 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 13 Sep 2010 05:11:32 -0700 (PDT)
In-Reply-To: <214E9A5B-E9CE-4B98-88EC-744DBE1F3C32@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156084>

On Mon, Sep 13, 2010 at 04:14, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
>
> On Sep 10, 2010, at 6:06 PM, Brian Gernhardt wrote:
>
>> Not only is this unneeded code duplication, it also was something
>> simply waiting to fail on case-insensitive file systems. =C2=A0So re=
place
>> all uses of make_commit with test_commit.
>
> To be more specific: this causes a failure in next on case-insensitiv=
e HFS+. =C2=A0The commit that finally triggered the problem is 7ec344d:=
 "filter-branch: retire --remap-to-ancestor", by using `git reset --har=
d A` which got confused on if 'A' was 'refs/branches/A' or './a'
>
> However, the patch applies to master or maint.

And you've modified the casing so it passes? Maybe it should skip on
case-insensitive systems instead, or perhaps we should modify it and
test for that elsewhere.
