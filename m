From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] gc: remove broken symrefs
Date: Tue, 06 Oct 2015 15:59:48 +0200
Organization: gmx
Message-ID: <0fff9005109d99176ae99b7bfde6c576@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 16:00:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSmc-00049u-7e
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbbJFN7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:59:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:49297 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbbJFN7x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:59:53 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0McmS9-1a0iW40rcv-00HyIw; Tue, 06 Oct 2015 15:59:49
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:kyyXM1Ur+YYa36ZhsZbhi9AHs3QFL9noQ3cdoi50Nm8VDByMXYb
 d//CSLtROH8aF7GbIuKeMDMRS7steRqlxIoOHItyWNxTbFpmfQ1GgzRduIT27Jx/Jc1L60B
 EAXXTP+1CalbtMg1mSMWvaMNDhfnc/kUwffnpIVHc4dsbZ8tpqUyr1WKFBgBOXUCm++HHWe
 zg0Ppv8kRzg4p1UKQe71Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pA30LSfuf1Y=:6LU0uXnWXQrlcetWA9lCRh
 x0oX9q4dOs09/myq6UBivZiBRUjgG6RmAy+qOy/GCELiFII+s7BJlE3Lq4rPWBheADqz7Kaik
 UjGBlbVB5sYjERrXpV01yHKRVh4x9xDzzRA1riNxvGIm084TsU49zRzU5WYsvBk1N8qDep/S9
 rKY7OrfSFHg2cAwH33wVKZJDnFdaJ7h69YBw8tyR9fbf1it+tXNoqO4An3RNmSTcy6pnE0mKW
 rfNyfP5de5ukzN3z6qg7ehdVpw+sejSipeyU4ycJhck6FoeMtIDlJVhL66T5GJNPY7yJm5I+/
 u/8VE+AtTa/OLzKxmGW3G9h5yzkK+rAmgCtscX/C3xgkhgJ22IN+lxVguWkjgLhskMIIJXPGK
 exRaoaKb+phJGywZGS2C+sehV8LpAEPDTHga/8XNYqUvf27q3POa7F4jLWFzekK0vTOl1GVKS
 0eKT78cikhSPohBYy7mvOA2CR7/xYEKnBYjTYk0zRgGjQSenxaka0RTKsLddDUT0T+R/tilbg
 SXxWORtp0cI+KCCAgO8oDRHUJ51vq9w9STuVb5M7U11XjdsVCaS+8zRtfU+GgJX0GJXoMfzqX
 C7GjnhxAloSgQD7Sj13t3NZdS99fnVBk3DCI/5Sa6Lqmx/I2JDD6re9W8sQam8rJGBwxC9vSK
 sjEJMb5r5ZXc9V2OyYOOjay2UWkgnICuVhzCE9SgwUxwlABFoB4trf/x/qaMbfdTO7YhwlPOt
 V5mlnK8ntXbxaPq55ck652U1k19JDA7Htyufo3gBIFbIiNBa8X7lEvCVxbwYRS6b4orreQmq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279146>

Hi Junio,

On 2015-10-06 00:06, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Oh, I appreciate your feedback. I am actually not all *that* certain
>> that removing the broken symref is the correct thing. It is this sort
>> of fruitful exchange that allows me to throw out an idea and be
>> relatively certain that something better will come out of v3 or v8 of
>> the patch series than what I had in mind.
>>
>> To be honest, the most important outcome is probably 2/4 -- which
>> should be enough to fix the issue reported by the Git for Windows
>> user. I could adjust the test so that it no longer insists that
>> origin/HEAD` be deleted, but still requires that `git gc` succeeds.
>>
>> I would have no problem to let this sit for a couple of days until
>> the final verdict.
> 
> ... and a few days have passed.  I am tempted to do the easy bits
> first, discarding the parts that both of us feel iffy for now
> without prejudice, keeping the first two commits with a bit of
> tweak.

I agree. And I just sent out v3 of the patch series.

Thanks,
Dscho
