From: Andreas Ericsson <ae@op5.se>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 11:14:08 +0100
Message-ID: <50B5E3F0.4050703@op5.se>
References: <20121127204828.577264065F@snark.thyrsus.com> <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com> <7vzk22lmz9.fsf@alter.siamese.dyndns.org> <20121127230419.GA26080@thyrsus.com> <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com> <20121128001231.GA27971@thyrsus.com> <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com> <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com> <20121128011750.GA23498@sigill.intra.peff.net> <7v7gp6i3rx.fsf@alter.siamese.dyndns.org> <20121128075807.GA9912@thyrsus.com> <CAJDDKr6n2KSZz5zPHeWiYHAP7Zr02Ti-e24AX1yR_XAXAKhscg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: esr@thyrsus.com, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 11:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdef7-0001Au-UD
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 11:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab2K1KOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 05:14:16 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63205 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab2K1KON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 05:14:13 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so5372498wib.1
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 02:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=A+ZKFiI21McU9GIxZBp7DFMoHdf91by5FuIoRYW7ohU=;
        b=lFhLUqwIVUPR/qrrSY0d8UXxidp6I8wWhyKz5JY7y662kYXqdUcq6DF1ZFYfg+D3IK
         cjD62+bhkNrhH56iybITIAcEmPYjY3QTU3mMRhm7DiMhbXn39CfxMq1d+2UAbVw2oTUE
         dD4r28AIrXvQJVxxPUx8lHqja+EDHVaAdjN58ejQ4kTEapGGqrvch3rREJu85XWj9Ino
         7SZqVM59HL/17dPFQE9yrN4/jbsmoroj/b7K0Z+6uohLu7LRU78hAPeXu5+BJrictFQA
         4tgDjb+iGypm4A2N9djGztk0Bz19GA3xoG5CVX6lvE0PY0+3tZnpNRROo43m5Rr9xp1c
         8a1g==
Received: by 10.216.70.81 with SMTP id o59mr6793002wed.100.1354097652210;
        Wed, 28 Nov 2012 02:14:12 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id bd7sm7182403wib.8.2012.11.28.02.14.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 02:14:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <CAJDDKr6n2KSZz5zPHeWiYHAP7Zr02Ti-e24AX1yR_XAXAKhscg@mail.gmail.com>
X-Gm-Message-State: ALoCoQnjTSAz6EYiZlt5oF4deyXBYQOFBYnJ3FUnrtNYtVaI2gJhwZ3YHCb1ksL2qIYihps9EYwV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210726>

On 11/28/2012 09:04 AM, David Aguilar wrote:
> On Tue, Nov 27, 2012 at 11:58 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
>> Junio C Hamano <gitster@pobox.com>:
>>> Roundtrip conversions may benefit from sub-second timestamps, but
>>> personally I think negative timestamps are more interesting and of
>>> practical use.
>>
>> You mean, as in times before the Unix epoch 1970-01-01T00:00:00Z?
>>
>> Interesting.  I hadn't thought of that.  I've never seen a software
>> project under version control with bits that old, which is significant
>> because I've probably done more digging into ancient software than
>> anybody other than a specialist historian or two.
> 
> One example I've heard is someone wanting to throw the history
> of a country's laws into git so they can diff them.
> 

That'll get tricky if you try it in Sweden. Our oldest written law
dates back to 1281. Quite fun reading. Apparently it was against the
law to shoot your slaves with stone arrows back then.

See my other proposal for how this could be done, which would only
affect the output layer (and some care would have to be taken with
the input, naturally).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
