From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: [PATCH] staging: brcm80211: SDIO/MMC cleanups
Date: Fri, 6 May 2011 10:25:42 +0200
Message-ID: <4DC3B086.90802@broadcom.com>
References: <20110504165947.40EED208186@grundler.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Grant Grundler" <grundler@chromium.org>,
	"Greg Kroah-Hartman" <greg@kroah.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"Dowan Kim" <dowan@broadcom.com>,
	"Henry Ptasinski" <henryp@broadcom.com>,
	"Venkat Rao" <vrao@broadcom.com>, git@vger.kernel.org
To: "Grant@google.com" <Grant@google.com>,
	"\"Grundler <grundler\"@chromium.org <Grundler" 
	<grundler@chromium.org>
X-From: git-owner@vger.kernel.org Fri May 06 10:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIGMU-0005uH-0l
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 10:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab1EFI0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 04:26:02 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:2573 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198Ab1EFIZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 04:25:57 -0400
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Fri, 06 May 2011 01:29:29 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 6 May 2011 01:25:45 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 0E55C74D03; Fri, 6 May 2011 01:25:46 -0700 (PDT)
Received: from [10.176.68.140] (unknown [10.176.68.140]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 2F21E20501; Fri, 6
 May 2011 01:25:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <20110504165947.40EED208186@grundler.mtv.corp.google.com>
X-WSS-ID: 61DD6EE31IC1479574-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172956>

On 05/04/2011 06:59 PM, Grant Grundler wrote:
> misc coding style cleanups to dhd_sdio/sdmmc
>
> o replace PKTFREE2 macro with static dhdsdio_pktfree2()
> o drop "delta" local var
> o drop GSPI_PR55150_BAILOUT
> o reformat some of the comments (white space changes)
> o drop dhd_bcmsdh_recv_buf wrapper and directly call bcmsdh_recv_buf
>
> Signed-off-by: Grant Grundler<grundler@chromium.org>
>
> ---
>
> diff --git a/drivers/staging/brcm80211/brcmfmac/dhd_sdio.c b/drivers/staging/brcm80211/brcmfmac/dhd_sdio.c
> index 0c248aa..4bfd8d8 100644

I am having difficulties applying a patch and want to turn it into a 
learning experience for me. I tried to apply this patch using the 
following steps:
1. save the email to grundler.eml
2. checkout staging-next branch (HEAD 7cc8243)
3. run 'git am grundler.eml'
Applying: staging: brcm80211: SDIO/MMC cleanups
error: patch failed: drivers/staging/brcm80211/brcmfmac/dhd_sdio.c:135
error: drivers/staging/brcm80211/brcmfmac/dhd_sdio.c: patch does not apply
Patch failed at 0001 staging: brcm80211: SDIO/MMC cleanups
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

The git documentation on the git am command is not very elaborate. I 
investigated the issue and checked following:
1. line 135 in dhd_sdio.c in the patch does match line 135 in my checked 
out branch.
2. did 'git hash-object'
     $ git hash-object drivers/staging/brcm80211/brcmfmac/dhd_sdio.c
     0c248aa43a37cfd1701f97988ec7cf4ff76a2789

What could be the problem?
