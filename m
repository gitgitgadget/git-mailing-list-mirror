From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 13/27] t1400: Test that stdin -z update treats empty
 <newvalue> as zeros
Date: Tue, 01 Apr 2014 00:20:52 +0200
Message-ID: <5339EA44.1050006@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-14-git-send-email-mhagger@alum.mit.edu> <xmqqbnwm3uqw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:21:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkZm-000567-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbaCaWU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:20:59 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:49896 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751727AbaCaWUz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 18:20:55 -0400
X-AuditID: 12074412-f79d46d000002e58-d7-5339ea4627df
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.B0.11864.64AE9335; Mon, 31 Mar 2014 18:20:54 -0400 (EDT)
Received: from [192.168.69.148] (p5B156503.dip0.t-ipconnect.de [91.21.101.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2VMKqnT015583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 31 Mar 2014 18:20:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqbnwm3uqw.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqOv2yjLY4NBxHYud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZL749Yyz4zFax7VEXYwPjEdYuRg4OCQETid2f1LsYOYFMMYkL99az
	dTFycQgJXGaUeLZ6PhOEc5ZJYuOUpcwgVbwC2hJ3v95mB2lmEVCV6LtcCRJmE9CVWNTTzARi
	iwoESRzecIoVolxQ4uTMJywgtoiAmsTEtkMsIDOZBVYzSiydMoMNJCEskChx9OI7qGVrGSUO
	HZ0HtoxTwFri5MIXLBCXikv0NAaBhJkFdCTe9T1ghrDlJba/ncM8gVFwFpJ9s5CUzUJStoCR
	eRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSDQI7WBcf1LuEKMAB6MSD69F
	uWWwEGtiWXFl7iFGSQ4mJVHeh4+BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4Y18C5XhTEiur
	UovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHiTQRoFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQREcXwyMYZAUD9Beb7C9xQWJuUBRiNZTjLocG7ataWQSYsnLz0uV
	Euf9+gKoSACkKKM0D24FLPW9YhQH+liYNwtkFA8wbcJNegW0hAloiVuRGciSkkSElFQD45Jt
	q47bFd21d1b/02nwht12Qa5c9uOfmVr8ZTfnxD08mtynmsuUwcR6O9HgPFPP9vQW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245558>

On 03/31/2014 11:48 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This is the (slightly inconsistent) status quo; make sure it doesn't
>> change by accident.
> 
> Interesting.  So "oldvalue" being empty is "we do not care what it
> is" (as opposed to "we know it must not exist yet" aka 0{40}), and
> "newvalue" being empty is the same as "delete it" aka 0{40}.
> 
> That is unfortunate, but I agree it is a good idea to add a test for
> it, so that we will notice when we decide to fix it.

Correct.  This was discussed at some more length here [1].  In v1 of
this patch series I incorrectly changed this behavior, thinking it to
have been an accident.

Michael

[1]
http://thread.gmane.org/gmane.comp.version-control.git/243731/focus=243773

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
