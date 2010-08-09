From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv3 1/2] t5520-pull: Add testcases showing spurious 
	conflicts from git pull --rebase
Date: Mon, 9 Aug 2010 20:35:58 +0000
Message-ID: <AANLkTinDK4GZ2GamqZHvx6+Cu5eVD1EncizKVxMONuek@mail.gmail.com>
References: <1281300917-5610-1-git-send-email-newren@gmail.com>
	<1281300917-5610-2-git-send-email-newren@gmail.com>
	<7vfwyn61td.fsf@alter.siamese.dyndns.org>
	<AANLkTin0xvK8H8RvaXtmaNHJh1dStn0AN1Mqed7JGvuO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	santi@agolina.net, Johannes.Schindelin@gmx.de
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 22:36:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZ4n-0004j8-4c
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622Ab0HIUgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 16:36:00 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38893 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab0HIUf7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 16:35:59 -0400
Received: by yxg6 with SMTP id 6so3561384yxg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u7Cj1NlxesUW1L7mBY0X3sohWxWzEKZUFBaQdNlZ2Ow=;
        b=gzv9eiv7IMp0NyAIFm0ioxKn5sTvnwErRR7Aaplz7NEem1lxHU1VBilu5J78pRNQDn
         7TPnF+aHMOdq+iN8u4nrveCbWxlBcNA52Z6AqLAn+1QVTvaz4/FwreU8tfZvtJErRP9O
         U1KV1REUskQ1iYK1eOfvQaEAbptkasysbTkgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BtpqeovFXDho56rY0IC8k4/z73DXBhHBfLcnWP7gzuZhCxh/WsFrKhKJyBGttVXktp
         GnoS8QkJcO881pFeRW2QmTNIci/q1lHSJBEgXd5puU2wcUb+mCd/R1SI6Bm4PcprT44X
         r7JT3pwiW81Pk6Ko448/A89nTsDtKBqmiwBEk=
Received: by 10.231.146.129 with SMTP id h1mr18914868ibv.181.1281386158526; 
	Mon, 09 Aug 2010 13:35:58 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 9 Aug 2010 13:35:58 -0700 (PDT)
In-Reply-To: <AANLkTin0xvK8H8RvaXtmaNHJh1dStn0AN1Mqed7JGvuO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153018>

On Mon, Aug 9, 2010 at 19:22, Elijah Newren <newren@gmail.com> wrote:
> On Mon, Aug 9, 2010 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Elijah Newren <newren@gmail.com> writes:
> <snip>
>>> +modify () {
>>> + =C2=A0 =C2=A0 sed -e "$1" < "$2" > "$2".x &&
>>> + =C2=A0 =C2=A0 mv "$2".x "$2"
>>> +}
>>
>> Just a style thing but I'd prefer to see the above written like this=
:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0modify () {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "$1" <=
"$2" >"$2.x" &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mv "$2.x" "$2=
"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> I copied this function verbatim from t/t4127-apply-same-fn.sh. =C2=A0=
Would
> you like me to fix that one too?

Rather than copy-paste this around we should just turn it into a
utility function.

It'd be very useful (if you're up to it) to just use sed in this
patch, then submit another patch to include the modify() function in
the test-lib.sh (and document it in t/README).

These could also use a modify():

    cd t && grep -A1 sed  *sh | grep -B1 mv | less
