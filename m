From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH] git-imap-send.txt: remove the use of sslverify=false in
 GMail example
Date: Thu, 11 Apr 2013 17:26:17 +0200
Message-ID: <20130411152617.GA14264@ruderich.org>
References: <51657E59.7030001@gmail.com>
 <7vmwt6mdjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 17:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQJOL-0004ug-FL
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 17:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936295Ab3DKP0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 11:26:21 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:46338 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936173Ab3DKP0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 11:26:20 -0400
Received: from localhost (pD9F541D7.dip.t-dialin.net [::ffff:217.245.65.215])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Thu, 11 Apr 2013 17:26:18 +0200
  id 0000000000000035.000000005166D61A.00003F42
Content-Disposition: inline
In-Reply-To: <7vmwt6mdjg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220882>

On Wed, Apr 10, 2013 at 11:44:03AM -0700, Junio C Hamano wrote:
> The reason why we can run with sslverify=true against gmail is
> because we know imap.gmail.com gives a validly signed certificate
> that leads all the way to a root CA the user's OpenSSL installation
> is likely to trust (if your hand-rolled imap-over-ssl server uses a
> snakeoil certificate, even though the server may be "SSL capable",
> you may not be able to successfully connect to it without sslverify
> turned off).

Maybe imap-send should learn imap.sslCAInfo and imap.sslCAPath
like http.* to handle custom certificates.

>> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
>> index 875d283..b15dffe 100644
>> --- a/Documentation/git-imap-send.txt
>> +++ b/Documentation/git-imap-send.txt
>> @@ -123,7 +123,6 @@ to specify your account settings:
>>  	host = imaps://imap.gmail.com
>>  	user = user@gmail.com
>>  	port = 993
>> -	sslverify = false
>>  ---------
>>   You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error

I think we should remove sslverify = false from the other example
as well. "Recommending" sslverify = false is IMHO a bad idea as
SSL provides no protection without verification.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
