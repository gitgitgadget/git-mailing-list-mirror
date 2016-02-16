From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Tue, 16 Feb 2016 10:51:50 +0100
Message-ID: <51832840-B879-4650-9DC5-E15EAA9919B9@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <1455531466-16617-4-git-send-email-larsxschneider@gmail.com> <56C244D7.1030503@ramsayjones.plus.com> <20160215214049.GA10094@sigill.intra.peff.net> <56C253B8.1070702@ramsayjones.plus.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sschuberth@gmail.com, sunshine@sunshineco.com, hvoigt@hvoigt.net,
	sbeller@google.com, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:52:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcIb-0000db-Qh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbcBPJv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:51:57 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38633 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbcBPJvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:51:54 -0500
Received: by mail-wm0-f41.google.com with SMTP id a4so91118884wme.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPZyTqTuZDmJWBjwra9bKMxT5KtRiKg1NDEEptgt4ec=;
        b=JajC1FC+wdM51KnzXawBQZx+AdY0jbBunYrBmCXuhsqb/MlmLBfn+gcQiK+dt+9Wsh
         y+gquv1/qmx2EVAATJ4GS5kHaMC4eZbhR1kPqS8j6+yXAqq8AHKIS6oatv6asHf4LIOa
         Zbv6x84nioeLxgs7q/aRt6DdVMNEMJJ9b9eddwboIjUdUW2UQpsiI/u5xCquq4VTUXgd
         jTgtp+M/XoyseqSimYGDV4dLqqKRcNQxFPwcuwz2E+87nUYvWWfrGiMrET59cnF2r8h5
         1micVGvyHDsydo/bONRAotp7lZX7T60Tc235Eq7+uvlsFCfd0fwDOlIDBIzg+NBKwdc6
         6y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=IPZyTqTuZDmJWBjwra9bKMxT5KtRiKg1NDEEptgt4ec=;
        b=FznQO/XM6l1fEKUC1KpGppbBDTIRdBjfsMZB+N0w52I6XZMocGAQVbAawfl3HqwUo0
         wW6xH3m23V9woEHvdO//34GxDgjyf88DDkX0jA8nOccwNyAzDhdpGq0WXfKmHMsBVJ4h
         5qkdgB0pKMuRFuL6uJ2VMhRsUt1ly25J3P+ZoDpD4RGNALM+D4H6hGCMffDgs6RVJfYj
         /VbaE55BoqST+DHXPkch0H/sDUPMBTNPOUx8Zut0Gy+xCsBDqAcrNFBf9Unrirg0VQci
         nLhqYPJZx/yvNXuTmP0yyDiCECYLkswQG94d775qRYifHlTahMa0Jl4weiLk2LGx0BQl
         d9GA==
X-Gm-Message-State: AG10YOT4SsuruYz1KEuFapB95pRbWci1+20TQdVFebUCDdBaFMOXChpzCMHeS+nvK9W54w==
X-Received: by 10.194.94.138 with SMTP id dc10mr25020042wjb.37.1455616313309;
        Tue, 16 Feb 2016 01:51:53 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB43DD.dip0.t-ipconnect.de. [93.219.67.221])
        by smtp.gmail.com with ESMTPSA id os7sm29481322wjc.18.2016.02.16.01.51.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 01:51:52 -0800 (PST)
In-Reply-To: <56C253B8.1070702@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286337>


On 15 Feb 2016, at 23:39, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

> 
> 
> On 15/02/16 21:40, Jeff King wrote:
>> On Mon, Feb 15, 2016 at 09:36:23PM +0000, Ramsay Jones wrote:
>> 
>>>> +test_expect_success '--show-origin stdin' '
>>>> +	cat >expect <<-\EOF &&
>>>> +		stdin:	user.custom=true
>>> 
>>> So, as with the previous patch, I think this should be:
>>> 		file:<stdin>	user.custom=true
>> 
>> That's ambiguous with a file named "<stdin>", which was the point of
>> having the two separate prefixes in the first place.
>> 
>> I think in practice we _could_ get by with an ambiguous output (it's not
>> like "<stdin>" is a common filename), but that was discussed earlier in
>> the thread, and Lars decided to go for something unambiguous.
> 
> sure, I just don't think it would cause a problem in practice.
> How about using '-' for <stdin>? Hmm, you can actually create
> such a file in the filesystem! Oh well, I guess its not a big deal.
> 
>> 
>> That doesn't necessarily have to bleed over into the error messages,
>> though (which could continue to use "<stdin>" if we want to put in a
>> little extra code to covering the cases separately.
> 
> Yep.
OK, I am happy to add the extra code. However, out of curiosity, can
you explain in what cases you actually use configs from stdin? I wasn't
aware of this feature before working on this patch and I still wonder
when I would use it. If it is only a seldom used feature then I am not
sure if adding the extra code to restore the existing error message
is worth the effort?

Thanks,
Lars
