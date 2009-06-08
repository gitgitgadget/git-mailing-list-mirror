From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Mon, 08 Jun 2009 14:10:18 -0700
Message-ID: <4A2D7E3A.9060701@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	<7vskidcf9s.fsf@alter.siamese.dyndns.org>	<200906070932.36913.chriscool@tuxfamily.org>	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDm7A-0006IP-MN
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbZFHVKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbZFHVKd
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:10:33 -0400
Received: from terminus.zytor.com ([198.137.202.10]:54711 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbZFHVKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:10:33 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n58LAI1K031560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2009 14:10:18 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vzlcixwue.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.94.2/9439/Mon Jun  8 09:12:27 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121110>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> The advantage of that -- and I have to admit I don't know if it will
>> ever matter in practice -- is that using an actual PRNG:
>>
>> a) is less likely to get into pathological capture behaviors.
>> b) doesn't make people think later that there is something magic to the
>>    arbitrary chosen numbers.
> 
> My gut feeling agrees with you that both are likely to be true; these are
> good points.
> 
> Christian, what do you think?

Note: I do believe we should keep the obvious optimization of "if there
are no skip points in the plausible range, use the best point."  We
don't want a 39% increase in bisect time when not using skip.

	-hpa
