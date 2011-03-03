From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Wed, 02 Mar 2011 22:44:09 -0500
Message-ID: <4D6F0E89.4020200@cisco.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net> <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com> <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com> <4D6E4246.5080407@drmicha.warpmail.net> <7vhbblcvl7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 04:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuzSc-0000AP-Gp
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 04:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774Ab1CCDoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 22:44:12 -0500
Received: from sj-iport-2.cisco.com ([171.71.176.71]:16480 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1CCDoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 22:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1130; q=dns/txt;
  s=iport; t=1299123851; x=1300333451;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=zKgkAx9dQAfpGbtnavqjco/PqPdKFP12o1fsdWfE644=;
  b=TVwzjbh2XwSXdFD1wAD2h/ho3/VRPmxPV79Q5785SKpvcmj6GpYf9HkY
   3LG/dIjG+Len/AIXR6a2ywB2E1/32K5sZu6/tllc3KZ45Z5g4GLwXcDwW
   +BDPRJXT5DXyS1NvvzI8SQUijPPvO57HNkk+LXaMg0ct7QUfZXR3OQgwg
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAE+dbk2rR7H+/2dsb2JhbACmcnSidJwAhWEEhReHD4NA
X-IronPort-AV: E=Sophos;i="4.62,257,1297036800"; 
   d="scan'208";a="316706420"
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by sj-iport-2.cisco.com with ESMTP; 03 Mar 2011 03:44:11 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by sj-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id p233iAl3014313;
	Thu, 3 Mar 2011 03:44:10 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vhbblcvl7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168369>

On 03/02/2011 11:53 AM, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> [*] I keep forgetting that some people may have files whose names begin
>> with ":". They are ambiguous now already with "treeish pathspec"
>> commands, but not with "pathspec" commands. The latter would change.
> Just to make sure I understand that they have easy workarounds:
>
>  - If you have a path foo/:bar, you can say
>
>    git log master -- foo/:bar
>
>    because ':' signals the magic and gets stripped only when it is at the
>    beginning (i.e. not affecting foo/:bar); and
>
>  - For :boz at the root level, you can say
>
>    git log master -- '\:boz'
>
>    because the backslash in '\:boz' makes the colon not at the beginning and
>    the glob match sees '\:boz' and then matches '\:' with literal ':' at the
>    beginning of the pathname ":boz".

Easy workaround, maybe, but still a potential problem for unsuspecting
scripts.

  - I think this fails in a directory with :foo.c

    git log master -- *.c


  - Would this work, though?

    git log master -- "*.c"

Phil
