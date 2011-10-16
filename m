From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/4] git-gui: only except numbers in the goto-line input
Date: Sun, 16 Oct 2011 12:32:47 +0200
Message-ID: <CAKPyHN0r9VF9nS35+YZWbMb-DW4Xgt-MzN5JX2DH8eji7SZRpw@mail.gmail.com>
References: <a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
	<1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<fbfb3f3ba4db190f8956eea4f78419a1b81573a6.1318513492.git.bert.wesarg@googlemail.com>
	<87fwitkihn.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Fries <David@fries.net>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 16 12:32:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFO1W-0007AA-7x
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 12:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab1JPKcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 06:32:50 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33092 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1JPKct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 06:32:49 -0400
Received: by vws1 with SMTP id 1so1928491vws.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uBRP6nDTSHmsSPlaTbsyveRJsSFEt+wPZei2B4lzHAA=;
        b=u24NCSS/iYpm2dUCyWBCKzczuqmtkjJQ3GMsPo+uUbAzxK3UGYX2xI91kWk5/IyjD0
         7UeMomb1vqFxTx3bcuZE9tuWzO/E4Ca3SrGYkYXmSMpcs5LM+noX4R1k1/jUOMQjNl/U
         Bgv8m6LAT1gLIj92WV+9LossWrtoa2a8217Iw=
Received: by 10.52.72.196 with SMTP id f4mr15830144vdv.68.1318761167601; Sun,
 16 Oct 2011 03:32:47 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Sun, 16 Oct 2011 03:32:47 -0700 (PDT)
In-Reply-To: <87fwitkihn.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183704>

Hi,

On Sun, Oct 16, 2011 at 00:17, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>---
>> lib/line.tcl | =C2=A0 16 ++++++++++++++--
>> 1 files changed, 14 insertions(+), 2 deletions(-)
>>
>>diff --git a/lib/line.tcl b/lib/line.tcl
>>index 692485a..70785e1 100644
>>--- a/lib/line.tcl
>>+++ b/lib/line.tcl
>>@@ -15,7 +15,11 @@ constructor new {i_w i_text args} {
>>
>> =C2=A0 =C2=A0 =C2=A0 ${NS}::frame =C2=A0$w
>> =C2=A0 =C2=A0 =C2=A0 ${NS}::label =C2=A0$w.l =C2=A0 =C2=A0 =C2=A0 -t=
ext [mc "Goto Line:"]
>>- =C2=A0 =C2=A0 =C2=A0entry =C2=A0$w.ent -textvariable ${__this}::lin=
enum -background lightgreen
>>+ =C2=A0 =C2=A0 =C2=A0entry =C2=A0$w.ent \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-textvariable ${__t=
his}::linenum \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-background lightgr=
een \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-validate key \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-validatecommand [c=
b _validate %P]
>> =C2=A0 =C2=A0 =C2=A0 ${NS}::button $w.bn =C2=A0 =C2=A0 =C2=A0-text [=
mc Go] -command [cb _incrgoto]
>>
>> =C2=A0 =C2=A0 =C2=A0 pack =C2=A0 $w.l =C2=A0 -side left
>>@@ -26,7 +30,7 @@ constructor new {i_w i_text args} {
>> =C2=A0 =C2=A0 =C2=A0 grid remove $w
>>
>> =C2=A0 =C2=A0 =C2=A0 bind $w.ent <Return> [cb _incrgoto]
>>- =C2=A0 =C2=A0 =C2=A0bind $w.ent <Escape> [list linebar::hide $this]
>>+ =C2=A0 =C2=A0 =C2=A0bind $w.ent <Escape> [cb hide]
>>
>> =C2=A0 =C2=A0 =C2=A0 bind $w <Destroy> [list delete_this $this]
>> =C2=A0 =C2=A0 =C2=A0 return $this
>>@@ -55,6 +59,14 @@ method editor {} {
>> =C2=A0 =C2=A0 =C2=A0 return $w.ent
>> }
>>
>>+method _validate {P} {
>>+ =C2=A0 =C2=A0 =C2=A0# only accept numbers as input
>>+ =C2=A0 =C2=A0 =C2=A0if {[regexp {\d*} $P]} {
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1
>>+ =C2=A0 =C2=A0 =C2=A0}
>>+ =C2=A0 =C2=A0 =C2=A0return 0
>>+}
>>+
>> method _incrgoto {} {
>> =C2=A0 =C2=A0 =C2=A0 if {$linenum ne {}} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ctext see $linenum=
=2E0
>
> This one doesn't actually work when I try it it accepts alphanumeric
> input. However, replacing the validate body with
> =C2=A0string is integer $P
> fixes it to operate as intended so I'll replace it with this.

Sorry, the correct regexp would have been {^\d*$}. But your [string is
integer] should completely suffice. Thanks.

> Looks like it needs theming too but that can be a separate patch.

Theming is not my field, sorry.

Bert

> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
