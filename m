From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [RFC/PATCH git] http: avoid empty error messages for some curl
 errors
Date: Tue, 6 Sep 2011 20:00:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1109061957120.29735@tvnag.unkk.fr>
References: <20110905222202.GA32071@elie> <alpine.DEB.2.00.1109061023010.3841@tvnag.unkk.fr> <7v62l5a9ke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 20:01:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0zxR-0003Dm-DC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 20:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab1IFSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 14:01:06 -0400
Received: from giant.haxx.se ([80.67.6.50]:40724 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617Ab1IFSBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 14:01:04 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p86I0qE5009970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Sep 2011 20:00:52 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id p86I0p3g009963;
	Tue, 6 Sep 2011 20:00:51 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <7v62l5a9ke.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.8 (giant.haxx.se [127.0.0.1]); Tue, 06 Sep 2011 20:00:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180819>

On Tue, 6 Sep 2011, Junio C Hamano wrote:

>>
>> For the record, in libcurl we work on providing "extra" information in
>> the error buffer when there is additional info to provide that would
>> help. In some cases we deem there isn't (or we just to provide any)
>> and then the generic error message is good enough and could indeed be
>> used like this...
>
> Sorry if I am a bit slow but are you saying:
>
> (1) we provide "extra" but your patch is not using it which is bad?
> (2) the above is Ok but there are better ways to do it?
> (3) something else?

Sorry for being unclear.

I was trying to explain why the proposed patch makes sense and that it will 
continue to make sense even if in future libcurl versions it would start 
returning error messages for errors where currently it returns none.

Thus, I am in favour of the general idea of the patch - I have no comment for 
the exact implementation as I haven't checked the details.

-- 

  / daniel.haxx.se
