From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Wed, 02 Mar 2011 22:51:17 -0500
Message-ID: <4D6F1035.1040902@cisco.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTim2HmBEQv=buRG7-87+c99FnsxXUTQzKy__azfM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 04:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuzZV-0002YD-I1
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 04:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab1CCDvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 22:51:20 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:26489 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1CCDvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 22:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1078; q=dns/txt;
  s=iport; t=1299124279; x=1300333879;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=hgvp/KYuJAtcxTMMHunuJzg+0YqQ4pNQA3xHSqCtnrQ=;
  b=EIT1X5bZfCJuB0zPuJ0BJ7yFHtIEh4Udi4TYXY6PME0J7ojs/r4LPEIr
   r+Uct/LBvelnMbysMTakT1ld0xcNQHyqvAepitwpGzmDkctB1t9q5pAmN
   FsLFJcueXRmbYnQTq0czifK3szEozSY5JvFFKrxo4X2pAEq8hTsVqmvGi
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAHuebk2rR7Hu/2dsb2JhbACEKKJKdKJ4iwqQdoEng0R2BIUXhw+DQA
X-IronPort-AV: E=Sophos;i="4.62,257,1297036800"; 
   d="scan'208";a="268519809"
Received: from sj-core-5.cisco.com ([171.71.177.238])
  by sj-iport-4.cisco.com with ESMTP; 03 Mar 2011 03:51:19 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id p233pIfJ028855;
	Thu, 3 Mar 2011 03:51:18 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTim2HmBEQv=buRG7-87+c99FnsxXUTQzKy__azfM@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168372>

On 03/01/2011 07:12 PM, Nguyen Thai Ngoc Duy wrote:
> On Tue, Mar 1, 2011 at 6:16 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 12:13:
>>> If you are going to turn pathspecs into something more complex,
>>> reserve room for future extension. I have negative pathspecs that can
>>> utilize it.
>>>
>>> I take it, from now on people must refer file name ':foo' as './:foo'
>>> with your patch?
>> That is up for discussion, of course. When discussing a new approach for
>> file mode dependent attributes, I was hoping to get through with
>> symlink:path, and did not. But it was decided that something like
>> :symlink:path would be good enough, in the sense of avoiding enough
>> possible conflicts. That made me hope that :path would be, too.
> Good morning! I'm saner now. How about :/path? That would reserve
> anything next to ':' except '/'.

I like this.  The only 'failure' that comes to mind is something like

     git log -- */*.c

when there's a subdirectory named ':'. 

Phil
