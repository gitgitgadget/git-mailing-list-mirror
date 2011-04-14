From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 23:07:41 +0200
Message-ID: <BANLkTi=Oq_jNYb+CSa9nwtoWtEdbF_QcgA@mail.gmail.com>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com> <20110414175212.GB23342@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:08:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATlo-0007WE-J2
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab1DNVID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 17:08:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51125 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab1DNVIB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 17:08:01 -0400
Received: by pvg12 with SMTP id 12so751380pvg.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aRbykYcGZuDGIWMhnk7YievVTHLKnXnxDu7UeqPee5o=;
        b=dK69M+IA0LQbqBmjvEddNb9+IT2PVdTRF2LW9blzbWBEl6POwIwJfQWZDeGpfdayqn
         YzHlinqz6G2G5AFEoS9SdhJrRTmKR7hs6TYD0nT3D9pE5NO9tYcnOkHRb+a01bTLHkcX
         gCsiqeZR+tATfvrU3dldntEBze3uRs66DuQbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Y/HZTt/e90tmBMP5dpKz9Y4PXwDJvQ4PYSi3ZYl5b87U2E/reEDO0xylYuS2Qt3WC0
         H76SEaBsDvcfRz2m6X9+z+KulVDrvXWKCexSxlqzOYpI2ED8rCG+xUc08PWbyk5RFfjW
         yLYW3nSRpVAUT3MdO3IF7tgY4MaTEsYIBRAbg=
Received: by 10.68.29.69 with SMTP id i5mr843373pbh.62.1302815281178; Thu, 14
 Apr 2011 14:08:01 -0700 (PDT)
Received: by 10.68.56.105 with HTTP; Thu, 14 Apr 2011 14:07:41 -0700 (PDT)
In-Reply-To: <20110414175212.GB23342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171555>

On Thu, Apr 14, 2011 at 7:52 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 14, 2011 at 07:01:41PM +0200, Erik Faye-Lund wrote:
>
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index 9c66367..a4b8b59 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -793,4 +793,19 @@ test_expect_success 'format-patch wraps extreme=
ly
>> long headers (rfc2047)' '
>
> Speaking of wrapping, your MUA seems to have mangled the patch.
>

Hehe, yes. How ironic :)

What can I say, silly GMail? :P

>> +M8=3D"foo_bar_"
>> +M64=3D$M8$M8$M8$M8$M8$M8$M8$M8
>> +cat >expect <<'EOF'
>> +From: foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_bar_foo_b=
ar
>> + <foobar@foo.bar>
>> +EOF
>
> Your expect data is missing the trailing "_". You could probably just
> do:
>
> =A0cat >expect <<EOF
> =A0From: $M64
> =A0 <foobar@foo.bar>
> =A0EOF
>
> which is even simpler.
>

Yes. Much better, thanks.
