From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2012, #03; Mon, 5)
Date: Tue, 6 Mar 2012 16:40:11 +0700
Message-ID: <CACsJy8BRQ63hV5e63yoMVykOMZS3u-VrdCQtvgRGBji4Yzpi4A@mail.gmail.com>
References: <7vmx7uurnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 10:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qt1-0006DZ-7F
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 10:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab2CFJkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 04:40:45 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39606 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab2CFJkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 04:40:43 -0500
Received: by wibhm2 with SMTP id hm2so2491275wib.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 01:40:42 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.134.200 as permitted sender) client-ip=10.216.134.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.134.200 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.134.200])
        by 10.216.134.200 with SMTP id s50mr5526321wei.116.1331026842406 (num_hops = 1);
        Tue, 06 Mar 2012 01:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mfK3L6/v6L+VB1k6UgoAMYHU/ZZnb51A4mXf2PfuP/g=;
        b=xUVm/JDQhUX8bW/Ws5QptHZqFzDNMIjkenj5ekVeqT7ZysalcLDFuEREuSTW4t2B2p
         mblZkDoLMkStqG/NZ9yOxsSol5Y135TFly/6hSJcLTtCy/HzHWF45fDasuSqHGmSHH7o
         CC3EddDC3Qfyv0FdjBkQThkqxbX6lc3f2xzxjboWEM5U6e1vi2tMReNFVwdNXRpUlvOt
         x/sMdJVcZQGEk0/ajJo2jRHuVkVTUuWtWURhwfV9gdavJV26/4mOuLdBdq5ar90Itj35
         Csq47Rh7oaup54TE83tKh0h85pXbazf5jB9LkaRLWqioKJveAxAobwKHfGx50qA4Jf1D
         i6sg==
Received: by 10.216.134.200 with SMTP id s50mr4443911wei.116.1331026842299;
 Tue, 06 Mar 2012 01:40:42 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 6 Mar 2012 01:40:11 -0800 (PST)
In-Reply-To: <7vmx7uurnj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192326>

On Tue, Mar 6, 2012 at 2:15 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * nd/stream-more (2012-03-05) 6 commits
> =C2=A0- fsck: use streaming API for writing lost-found blobs
> =C2=A0- show: use streaming API for showing blobs
> =C2=A0- parse_object: avoid putting whole blob in core
> =C2=A0- cat-file: use streaming API to print blobs
> =C2=A0- Add more large blob test cases
> =C2=A0- streaming: make streaming-write-entry to be more reusable
>
> As I do not think changes in the original larger series that touch
> index-pack and unpack-objects will be ready for the upcoming 1.7.10,
> I've picked up only bits that deal with "use streaming API instead
> of reading things in core" and minimally fixed them up. =C2=A0These w=
e
> should be able to polish in time.

11/11 should be safe to go too. It simply reads config files so that
parse_object() respects core.bigfilethreshold.

http://mid.gmane.org/1330919028-6611-12-git-send-email-pclouds@gmail.co=
m

> The "test cases" patch needs to be trimmed to cover only these, I
> would think.

I'd rather leave it as is. All new test cases are test_expect_failure,
they should not interrupt "make test". If I slack off, somebody may be
annoyed enough with those known breakages to give me a little push.
--=20
Duy
