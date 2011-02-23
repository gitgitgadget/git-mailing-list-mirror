From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 22 Feb 2011 19:08:14 -0500
Message-ID: <4D644FEE.5030004@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com>	<20101220213654.GA24628@burratino>	<4D112586.2060904@Freescale.com>	<4D119015.6020207@burntmail.com>	<4D2AB63D.7040803@burntmail.com>	<AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>	<4D2FEF49.8070205@burntmail.com>	<20110114074449.GA11175@burratino>	<7v8vynnokt.fsf@alter.siamese.dyndns.org>	<4D450655.5090501@burntmail.com>	<AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>	<7vhbcb35xk.fsf@alter.siamese.dyndns.org>	<4D5E1116.7040501@burntmail.com>	<7voc69p4xu.fsf@alter.siamese.dyndns.org>	<4D5F6E97.4000402@burntmail.com>	<7vy65bkw72.fsf@alter.siamese.dyndns.org>	<4D61EA4B.3020708@burntmail.com>	<7vtyfxgdz2.fsf@alter.siamese.dyndns.org>	<7vipwbbrcc.fsf@alter.siamese.dyndns.org> <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC
 -32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 01:09:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps2IB-00039M-A4
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 01:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab1BWAJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 19:09:14 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:39992 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab1BWAJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 19:09:13 -0500
Received: from [173.79.61.50] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1Ps2HC-000436-2k; Tue, 22 Feb 2011 18:08:18 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167666>

On 2/22/2011 6:50 PM, Martin Langhoff wrote:
> On Tue, Feb 22, 2011 at 6:08 PM, Junio C Hamano<gitster@pobox.com>  wrote:
>> Even though I don't deeply care about what CVSNT does...
> ..
>> Does anybody know why?  Only to make things incompatible, perhaps? ;-)
>
> A brief googling around shows that it also stores it in the Windows registry.
>
> Should we support that too...? ;-)

One thing at a time, Martin :).  After I get this patch through, I want 
to start working on getting the rest of the Perl script to run under 
Windows.  I was almost there; the biggest issue is that Perl 
implementations (ActiveState, Strawberry) for Windows don't support the 
list form of open.  I converted most of them successfully, but got stuck 
on one so decided to submit this patch first.  Thank goodness I did this 
separately :).

To answer Junio's question, I'm looking at the CVSNT code now 
(GlobalSettings.cpp, if anyone is interested.)  The password is stored 
in a general fashion like any other user-specified value.  So, the 
authors elected to use a properties file format of key=value.  That is 
as valid a format as any other.

-- 
Guy Rouillier
