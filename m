From: Ian Hobson <ian@ianhobson.co.uk>
Subject: Re: Advice/help needed
Date: Mon, 16 Nov 2009 22:46:57 +0000
Message-ID: <4B01D661.2060401@ianhobson.co.uk>
References: <4B017D77.6060505@ianhobson.co.uk> <551f769b0911160840k6ea274e9q33de777fac7cec70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 23:47:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAALt-0000wj-Qo
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 23:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbZKPWrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 17:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754400AbZKPWrF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 17:47:05 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:17757 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754319AbZKPWrE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 17:47:04 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20091116224703.HSPZ17277.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Mon, 16 Nov 2009 22:47:03 +0000
Received: from jupiter.ianhobson.co.uk ([86.12.69.89])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20091116224703.XHME21638.aamtaout02-winn.ispmail.ntl.com@jupiter.ianhobson.co.uk>
          for <git@vger.kernel.org>; Mon, 16 Nov 2009 22:47:03 +0000
Received: (qmail 11072 invoked by uid 453); 16 Nov 2009 22:47:01 -0000
X-Virus-Checked: Checked by ClamAV on ianhobson.co.uk
Received: from bobgriffiths.leda.hcs (HELO [192.168.0.12]) (192.168.0.12)
    by ianhobson.co.uk (qpsmtpd/0.40) with ESMTP; Mon, 16 Nov 2009 22:47:01 +0000
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <551f769b0911160840k6ea274e9q33de777fac7cec70@mail.gmail.com>
X-Cloudmark-Analysis: v=1.0 c=1 a=afb92bhMAAAA:8 a=fDcEKoRxqRmSGcApROIA:9 a=uk2VnGBy9tCNRIoRFJgA:7 a=ZKVE9WoEhJjvq4FDx2hf_PF1SrUA:4 a=0i7Zek3gQpIA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133031>

Yann Simon wrote:
> 2009/11/16 Ian Hobson <ian@ianhobson.co.uk>:
>   
>> My thoughts are to have 4 branches, one for each customer. 99% of all
>> changes will be needed by all (or at least most)
>> of the customers (P,W,S and E). How can I make a change to master and then
>> use git to apply those changes to the four branches, without losing the
>> differences between branches?
>>
>> For example (if this is the best way) go from this
>> O-----O-----A-----B-----C  (master)
>>  \----P
>>  \---W
>>   \--S
>>    \-E
>>
>> to first this, where D is the net effect of A B and C  (this is for ease of
>> reading logs, and commit messages),
>> O-----O-----D  (head)  \----P
>>  \---W
>>   \--S
>>    \-E
>>
>> and then to this, (without editing all the files four times?)
>> O-----O-----D  (head)
>>  \----P-----D'
>>  \---W----D''
>>   \--S-----D'''
>>    \-E-----D''''
>>     
>
> What I would do is:
> - one branch for the common
> - one branch for each customer, which contains the specific
> differences compare to the common branch
>
> You could program on the common branch.
> When you are ready, you can checkout each specific branch and rebase
> on the common branch.
> For example:
> $ git checkout common
> edit, test, commit
> $ git checkout client1
> $ git rebase common
> $ git checkout client2
> $ git rebase common
>
>   
Hi Yann,

I'll use master for common, unless I have a large chunk of development 
to do, and see how it goes.

Many thanks.

Ian
