From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 07:54:12 -0500
Message-ID: <CAMP44s2Wf7ZfmQ-7UGy2fNRX3TXaRMDu3WtZzz-WEOHibRAWVA@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
	<CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
	<CALkWK0nT7fySb5um1RcKW2R4v6AE_EQ0gTod8_kNNJOFbwFnWQ@mail.gmail.com>
	<CAMP44s0x62h+n29osEdRvuhBtvDY7bD3m1_jDq4ZDMrgFwP0ow@mail.gmail.com>
	<CALkWK0kwia-OQj_=B7A3k6_DxCJShqoJehNQu8eApgdo=OzQwg@mail.gmail.com>
	<CAMP44s03C2Wi5Bwma2wK5jMisBCyBaOVQ8UXuPaec9f27A0RvQ@mail.gmail.com>
	<CALkWK0m=-ePHCLChrBSgD_cUk=MOSt15aYf-yXhn_LpDro88fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 14:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcxhK-0001cf-QY
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 14:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab3EPMyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 08:54:14 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50779 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab3EPMyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 08:54:14 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so1028821lbi.5
        for <git@vger.kernel.org>; Thu, 16 May 2013 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=z2tldvY1leAb1YC7PIX0H2HF20ILpazYVS87GBazf4M=;
        b=hcdBPnKM+h7fJEuBP67+NQnNI9taxVy+HGZXa2BOq1+MOEfx4+qdN+rQsEQVETXvBk
         BNBK/IRkaGuN3K1FUBOE7n4Yzpe/JLuaxYZkki5J4wPNm9w8S7+0Df48bUWT+wxf8L8j
         bYlVLKtJumyogRgGmjQ7cfMr4j/uVjgPZOPEcaxtac2N/H/GwQEDvE/bkDzIaDtDpl0J
         dp8iHpc5pWJTjM+ezmm1eistPGldvEX7iIi7TkR8C8UdmhzkmvWXRvsjLhAjllm3n7Rz
         NgB2xY7RSr/ijU9tpOe6jvaykn8UMgLfJ9iCvs1tz/rhgCe9vRxGMtxufs6Mt9cDL2kO
         ZSxg==
X-Received: by 10.112.145.72 with SMTP id ss8mr20165902lbb.12.1368708852382;
 Thu, 16 May 2013 05:54:12 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 05:54:12 -0700 (PDT)
In-Reply-To: <CALkWK0m=-ePHCLChrBSgD_cUk=MOSt15aYf-yXhn_LpDro88fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224560>

On Thu, May 16, 2013 at 5:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Answer: because 'git fetch .' doesn't make any sense. So if
>> 'branch.HEAD.remote' is '.' it doesn't make sense to do 'git fetch .'.
>
> I agree that 'git fetch .' is currently not useful (and I am not
> against changing its behavior), but my question pertains to why you
> are replacing it with the hard-coded "origin".

'origin' is already hard-coded.

% git clone git://git.kernel.org/pub/scm/git/git.git

What would be the name of the remote? 'origin'.

% git checkout --no-track -b test
% git fetch

What is the remote that is used? 'origin'.

> What happens when I
> git branch -t -b devel hot-branch where branch.hot-branch.remote = ram
> and not origin?

The same thing that happens when you git branch --no-track -b devel hot-branch.

-- 
Felipe Contreras
