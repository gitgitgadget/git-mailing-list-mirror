From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 08 Mar 2011 11:25:47 +0100
Message-ID: <4D76042B.70005@drmicha.warpmail.net>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com> <4D75ED72.8030203@drmicha.warpmail.net> <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com> <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com> <4D75FB7B.70403@drmicha.warpmail.net> <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 11:29:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwuAP-0006fL-Vf
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 11:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab1CHK3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 05:29:15 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:46663 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239Ab1CHK3O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 05:29:14 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D0D5720B37;
	Tue,  8 Mar 2011 05:29:13 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 08 Mar 2011 05:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gZYW1T3UMP+UNsZIzmoMiL9ttyw=; b=eSAwx6o7zro6gbUuoI86DiZ6Xe24+KmmLD/xIiB4/cNpIPxQh+QL4wdI+xo+5OelaGncW5xGh4GTkh+k8rQKyWrfT5lLxAX8zrohXlMVMDe1vGPwU7SMkIGLM+vNilxyjsOVCBdAZDEI2I0Dk0UjTCxo3/ObbSH4pYNQ4qR0WhE=
X-Sasl-enc: kMz2cCjGHP60ZEm13RBR+fuEC6eyQYkIJvvflxr6lUhS 1299580153
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5E9764469B4;
	Tue,  8 Mar 2011 05:29:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168654>

Jay Soffian venit, vidit, dixit 08.03.2011 11:11:
> On Tue, Mar 8, 2011 at 4:48 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> You mean shorter than:
>>
>> git rev-list --merges -1 $(git merge-base foo bar)
>>
>> Or maybe I'm misunderstanding "contain".
> 
> Going back to my original picture, I mean commit m:
> 
>   o---o---x---o---...    foo
>    \       \
>     o---o---m---o---...  bar
> 
> merge-base foo bar gives me x; to get m I then need to grep the output
> of rev-list --parents for x.
> 
> j.

Maybe

git rev-list --ancestry-path --merges $(git merge-base foo bar)..bar

or, with the patch in pu

git rev-list --ancestry-path --merges --right-only foo...bar

each piped into tail -1 ?

Michael
