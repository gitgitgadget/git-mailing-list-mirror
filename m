From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record
 base tree info
Date: Wed, 27 Apr 2016 08:45:08 -0700
Message-ID: <CAGZ79kbvdTTLReVrrO8X0jTJn5kDn1n1cAS1Fo+-jWdGK5G1LQ@mail.gmail.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	<xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
	<xmqqd1pcgr3s.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZNV+g3_Rmpynh-WQVc3dW6nuNDsTM=gTxNuJnr3V3Azg@mail.gmail.com>
	<xmqq4maogpsw.fsf@gitster.mtv.corp.google.com>
	<20160427073350.GA30342@yexl-desktop>
	<xmqqr3dray9e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ye Xiaolong <xiaolong.ye@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avReP-0002rO-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbcD0PpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:45:11 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36277 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcD0PpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:45:09 -0400
Received: by mail-io0-f178.google.com with SMTP id u185so58049783iod.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ic8Rdl9qMHpgLwE3UZgsiWzqXdcfzEisxvNyAGoAvKQ=;
        b=mS00SG6wcjbk3AGvhup5U/2RwlIZKKtAkK8IDavCAqFb9V7zRg1HoJlPd80/LD9bie
         8/ir1bw/Q5IXuB0DHUAUv6pXqUAD4pjwEERGX7slUEojYsE/6F84GI9QDfS6TDPhgYZO
         xFpxph0lMp4XWEZ1xuBU7hs1BOY6k+e2DySHRhiroR9ST9ngUjawJmPlTvtIOpv1Y/sr
         frCM3e9Ajg8bCDHdqgannIguRoil3W0sJhE9hZHkQ3QfjZCEtnSwd3cpqefZvmtCHqd5
         ZeS8CzCzcnXmbzOz1NyHFT/EnX6U2GgT89bws4tAxJ6Uut4J+0KOSSLVXe+dxWyT9hoG
         bT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ic8Rdl9qMHpgLwE3UZgsiWzqXdcfzEisxvNyAGoAvKQ=;
        b=hpISd9gtnzv0KrLw89zX+eZmc7R7qGf09Ntds/8sENBi6q7im9ZWYOCMylB3C86gEr
         YNGBPM4A93UEsxebIEirtODushnnL2ctLAgA0mc+BMHd5je2S0jTHKDR7LQcdBGolBJI
         oXMcjVtJ9W42Xxx+OiqTPIpnJapH3hK6YiZWG2jxYyxzYso8lT4yUkIfMcdsb6QAHPg2
         wnwO+n8/+FBZBl/Y+lNv0SpDIVqzWXFPZUc3tFL+x855MjI/xI207IRX52ndo/0FBsTa
         cbDz57uhHHZIgrFVvexBEbHdAADMI5zlWgLzD9ZoMIpOO6yQUYX5SbIaEYrk0SWSILeK
         R4OQ==
X-Gm-Message-State: AOPr4FWG+lnkVXkahf7E1rgen1sbsy9EA2tm/gsjekydUCyIGJcJ/VmijfDOCKkDsakD6GQ9O4SnHr0hz7/uABn5
X-Received: by 10.107.53.200 with SMTP id k69mr11007181ioo.174.1461771908607;
 Wed, 27 Apr 2016 08:45:08 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 08:45:08 -0700 (PDT)
In-Reply-To: <xmqqr3dray9e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292735>

On Wed, Apr 27, 2016 at 8:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ye Xiaolong <xiaolong.ye@intel.com> writes:
>
>> On Tue, Apr 26, 2016 at 11:58:39AM -0700, Junio C Hamano wrote:
>>
>>>Let's hear from folks at Intel ;-) Both of the above sounds like
>>>sensible enhancements to me.
>>
>> Shall I squash these enhancements in this series, or I need to make
>> another patch for them?
>
> The update being discussed is not a "oops, the series without this
> update is embarrassingly flawed" fix, but rather "the series is good
> enough to be used as-is, but here is to potentially make it even
> better", I'd prefer to have it as a separate, follow-up patch that
> applies on top of what has been queued.  That way, if this turns out
> to be not so good idea, removing it alone while preserving what is
> already there will be easier, and also others who will be studying
> the code to further enhance the heuristics of base selection in the
> future will benefit.

I agree. I was just suggesting going the extra mile to make it easier
for the user. :)
