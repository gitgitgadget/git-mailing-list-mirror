From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/3] gitweb: add patches view
Date: Thu, 18 Dec 2008 18:28:10 +0100
Message-ID: <200812181828.11815.jnareb@gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com> <200812181033.57360.jnareb@gmail.com> <cb7bb73a0812180823y5249abcakd419d4fee9942d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 18:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDMhf-00085c-Lu
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 18:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbYLRR22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 12:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbYLRR22
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 12:28:28 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:33415 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYLRR20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 12:28:26 -0500
Received: by bwz14 with SMTP id 14so2041985bwz.13
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3gjjYlehnK++5PpS3hIq71+G7VIZSHJ5YVptRuQK0uk=;
        b=c0DbD3bsR97KzwySFYB/OWLdZ3Eivk1fVm6Ptb0lmWaBmqB34p3jN4+Jv5j5DSEaXe
         /CqLAgfGSSdH7ZYZXWnGh3ngzRCH291uZMOf5LnIHJ7y/NVGV0mjOXxpTCCGl9MxPEhu
         xwlKv67G5vwnFDl+jGvg2sP4brCZCJdNH2pvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=B+KxSxlaGbqcc4bbCa/CjsP67/O62pMcCgQEVfnp/DpkTmx6dGTPS+Ud98hozNJ2X+
         x+aUrb2nl5RRXoVPniOBvQxVzTW954bXxIbNYFMBMq0k4IP1bq3BDcIrLK94CdO8Wujk
         URADD2Fyl5SuKNRulDkcXtcjkQ8cNNHoNPKEc=
Received: by 10.223.104.68 with SMTP id n4mr1952789fao.4.1229621304424;
        Thu, 18 Dec 2008 09:28:24 -0800 (PST)
Received: from ?192.168.1.11? (abwk173.neoplus.adsl.tpnet.pl [83.8.234.173])
        by mx.google.com with ESMTPS id b17sm11572686fka.17.2008.12.18.09.28.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Dec 2008 09:28:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812180823y5249abcakd419d4fee9942d84@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103475>

On Thu, Dec 18, 2008, Giuseppe Bilotta wrote:
> On Thu, Dec 18, 2008, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 18 Dec 2008, Junio C Hamano wrote:

>>> [...] wouldn't it make more sense to also do this?
>>>
>>>       git_commitdiff(--format => 'patch', --single => 1);
>>>       git_commitdiff(--format => 'html');
>>
>> The first argument (format) is _required_, second is _optional_;
>> I'd rather use named parameters trick only for optional parameters.
>> Because with more than one optional parameter function call begins
>> to be cryptic; also flag (boolean) parameters are more readable
>> when used as named parameters.
> 
> I have mixed feelings about this: on the one hand we have href() (say)
> that takes all its params from a has, but on the other hand we have
> esc_html() (say) that takes only additional options from a hash. [...]

It is not "on one hand".  href() is a bit special case. It has _all_
parameters optional, especially now that -replay=>1 was introduced.
It has no required parameters. Therefore all parameters are named.

Beside, href() mimics a bit CGI interface...

-- 
Jakub Narebski
Poland
