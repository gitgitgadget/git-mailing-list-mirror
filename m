From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 17:17:56 +0700
Message-ID: <CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
 <17E04501C9474282B87758C7998A1F5B@PhilipOakley> <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 12:18:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aycq8-0005Rf-6X
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 12:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbcEFKS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 06:18:28 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35352 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbcEFKS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 06:18:27 -0400
Received: by mail-lf0-f43.google.com with SMTP id j8so125870239lfd.2
        for <git@vger.kernel.org>; Fri, 06 May 2016 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Ggpn4bUvpC3Ygf1+0DZhhX/Kn38GjB/bIN0gm86D2E=;
        b=XTapvlfC2C577/ij6WsMOPyH286lGnp2cvTOfQ3ZlOd4kqrELI6wRBEmqC5QeD8pE5
         ieAcFNULypIbrQ/gtnNg/tISCT7jsPr5zmanPnCSCkEcRKOBmb/JEeYwCI6hv+JfML2S
         ASBuA/W1ktN7pkvn+EwBCapwLLSpNirJqdU9PyXIx3rlOaiatVyx5svbo0Hoz+MUEC4K
         o82PTU32YWuD8qvFNlJSnbEdH3NbPbtamN8XEklIEAA3CkSP1clJd8xWFi1wiKCnBm7n
         RfvwBSMBXg23NuJmPMGe6m3hwXudUl2jtpqNqZvONitRzp2I8FpSrL6aHL7E+g5ZvdCv
         3vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Ggpn4bUvpC3Ygf1+0DZhhX/Kn38GjB/bIN0gm86D2E=;
        b=bLrFAJY2swHXcWnsgukNDfuce0rBcuaaaB/DWeSIjWqkhEZBo2aUw8hpK6tnJiFLd+
         L6MdCSR1PEINCDly75OtTvjeOIrwB17DHkJy7vwT7h++O82n0h1yO2aAEwo3p0Y7fLIY
         tjvGYvqghh4p23LG/rh0frDVP7/yuzqj+l/EAyCuXqIx8yUCCTSYjJ11I/lvDfcfSwak
         TBsQrjLPPW51plONyF0eBrL9s0ynHOkRUJB8nE3SiHOdDgPR9k1Xx8FuRhsmkQ+xilTI
         xd816HU0UH+tFMx/QkJks5X13tcAKCd/Xy6F0KMulm2TfmuI1u6Ru3XMFtiVm4esK+7k
         2IlA==
X-Gm-Message-State: AOPr4FW4/+GBGKZ1zGhmn7L59Bn1VSJlcam02A8QGnoKoFvw88nD+rG3epwFjCFmXNpiH4utW0VNDX0KcjQhlA==
X-Received: by 10.25.23.155 with SMTP id 27mr7998726lfx.3.1462529905798; Fri,
 06 May 2016 03:18:25 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 6 May 2016 03:17:56 -0700 (PDT)
In-Reply-To: <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293755>

On Fri, May 6, 2016 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>     int saved_namelen = saved_namelen; /* compiler workaround */
>>
>> Which then becomes an MSVC compile warning C4700: uninitialized local
>> variable.
>>
>> I'm wondering what was the compiler workaround being referred to? i.e. why
>> does it need that tweak? There's no mention of the reason in the commit
>> message.
>
> That was a fairly well-known workaround for GCC that issues a false
> warning that variable is used before initialized.  I thought we
> stopped using it several years ago in new code after doing a bulk
> sanitizing

I guess that's 803a777 (cat-file: Fix an gcc -Wuninitialized warning -
2013-03-26) and more commits around that time. The split-index commit
is in 2014. I must have missed the trend.

> (I think the new recommended workaround was to initialise
> such a variable to the nil value like '0' for integers).

Yep. First Jeff removed the " = xxx" part from "xxx = xxx" then Ramsay
added the " = NULL" back. So we probably just do "int saved_namelen =
0;" in this case.
-- 
Duy
