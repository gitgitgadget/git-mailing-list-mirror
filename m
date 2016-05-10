From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t6302: simplify non-gpg cases
Date: Mon, 9 May 2016 22:49:06 -0400
Message-ID: <CAPig+cTa-7-cneOaFgtUnXPFbMZZA3b5m-3kJK2=qB5ASRmCqg@mail.gmail.com>
References: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
	<20160509160725.GA11861@sigill.intra.peff.net>
	<CAPig+cQ2kSVzy0K303J3Guhk3-NzcReb5V7ohqOy2pPL_5GrSA@mail.gmail.com>
	<20160509164859.GA8231@sigill.intra.peff.net>
	<CAPig+cQPbwM0+6yruK0VKKq2ujFLoCLogS7eQNN7WWgRjG5V0w@mail.gmail.com>
	<20160510024032.GA16965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 04:49:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azxjV-0008HO-9e
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 04:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbcEJCtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 22:49:09 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36083 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbcEJCtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 22:49:07 -0400
Received: by mail-ig0-f177.google.com with SMTP id u10so121839477igr.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Vbvr7uDD+Jyh7xLpDU51mzexcZU6IedKLzVuSmcIR7Y=;
        b=Uv3TEXMbeB+J0A2CGRsMY2JwU0QvFwtKw7AQRy79RQHtcPMql5tCpIP5z982YZhJPJ
         JGohLpxp+l/uZcDxjI0Mw2Ep9LnGjU4Ij6C2EAFc1C49DlAqthd1bCae49jKwPEfXPaX
         L8wKEBhsn6vl2qsVHa3uisaxQswNSNwW6Oq9lN0tSrGSDt9hlDKaLtRuDxM9IftFr1uK
         4d7ME0xrQ8HIr8kL1p6UH7wcRoTMCvJo9H9KVSWb8+IFAWZeYT/hzF7gWLeAHme1YteG
         4vvYGON3EmNzT3+PktQTuGHvrmqtGH562Mwf0nkj4IgrHJguJThMsdeymZowUhp7hmyj
         JAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Vbvr7uDD+Jyh7xLpDU51mzexcZU6IedKLzVuSmcIR7Y=;
        b=lBFlovr33rGj4oCKLc0EjAMV6qG92DGGLK1lwkeJARpUk9Yi91gzQW25ILfExQhj0z
         i3DH9hTHcqLWSASLuWPsJMz1Qh6SGU1HPwYMw3h6TY/j47uiPLVLQn+GjlArUH5ZSobK
         2PsS3X69H/AbzQwVLN8GV+W5vpHv2R79LSdf2c139Ve92zRflkog69qayoNsQ2/EAqT7
         c9vk71uQCnpLQVyAEVhm8N8U573vDKvT5DMkkomG5ch9hkgdVArc9dX4JAIkeI/J49yW
         A/mV49mqKsvAj+8JcYv9L2o/h0Wj5T8zjbW+2xMVHa8r5m/HqPdVXNIgvx9ZYYfhDidS
         M4eA==
X-Gm-Message-State: AOPr4FUwJzAVj5OCaIFnWaikHujEAR8sLMm1OFO4thxob4l188iy/jkR4sZfMCzuT3TsKyWoaulDHrIUDAgrvg==
X-Received: by 10.50.6.15 with SMTP id w15mr15118076igw.91.1462848546781; Mon,
 09 May 2016 19:49:06 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 19:49:06 -0700 (PDT)
In-Reply-To: <20160510024032.GA16965@sigill.intra.peff.net>
X-Google-Sender-Auth: UCX2e3wtK3o8nhARK7TCwxAdNWk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294086>

On Mon, May 9, 2016 at 10:40 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2016 at 01:47:35PM -0400, Eric Sunshine wrote:
>> > -       test_prepare_expect <<-\EOF | sed -e "s/Z$//" >expect &&
>> > +       cat <<-\EOF | sed -e "s/Z$//" >expect &&
>>
>> To make this as close to a reversion as possible, this could be
>> restored to the original (sans 'cat'):
>>
>>     sed -e "s/Z$//" >expect <<-\EOF &&
>
> Thanks, I did the reversion with s/test_prepare_expect/cat/ rather than
> reverting 618310a, but I agree dropping this useless-use-of-cat is worth
> doing. Here's v2 with that change and your reviewed-by.

Looks good, thanks.
