From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without any extra flags
Date: Mon, 9 Jul 2012 23:44:03 +0200
Message-ID: <84D9664E-3249-4D80-980A-C01B02DF5E43@quendi.de>
References: <1341529386-11589-1-git-send-email-max@quendi.de> <7vk3ydkmzq.fsf@alter.siamese.dyndns.org> <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de> <7vy5mskewg.fsf@alter.siamese.dyndns.org> <35825CE5-4411-4C75-830A-6D704ACA1410@quendi.de> <7vtxxgkac0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1280)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 23:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoLkc-0002dZ-9s
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 23:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab2GIVoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 17:44:09 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48455 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754154Ab2GIVoI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2012 17:44:08 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1SoLkS-0004A5-0u; Mon, 09 Jul 2012 23:44:04 +0200
In-Reply-To: <7vtxxgkac0.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1280)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341870247;01f2619e;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201226>


On 09.07.2012, at 21:23, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>>> would it be feasible for the purpose of
>>> the check to tweak the definition of "works" used in the loop so that
>>> it considers the warning as "not working"?
>> 
>> That would be possible, and probably a good idea. But it is also
>> completely orthogonal to my patch. Indeed, if done without my
>> patch,...
> 
> No, I was suggesting it as a possible way to make the addition of ""
> order independent (which you said is impossible in your initial
> reply).

This would make things "order independent" for the specific subset of pthread implementations git supports right now. But there are systems where e.g. both -lpthreads and -lpthread work (link correctly, produce no warnings), but only one provides a POSIX compliant pthread implementation. For such systems, order will play a role, no matter what. Granted, git does not yet support such systems (with regards to pthreads, at least) at all. 

But all in all, I don't understand why this order independence seems to be so important? To me it seems merely an illusion anyway, not worth the extra effort.
