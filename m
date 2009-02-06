From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 2/6] gitweb: feed generator metadata
Date: Fri, 6 Feb 2009 12:21:38 +0100
Message-ID: <200902061221.39607.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <200902050015.20170.jnareb@gmail.com> <cb7bb73a0902060301s2a2f81e2t1762377177fb550e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:23:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOni-00076s-A6
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbZBFLVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbZBFLVr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:21:47 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:55071 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZBFLVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:21:46 -0500
Received: by fg-out-1718.google.com with SMTP id 16so461028fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 03:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ro65SFJ6KSDfXSuMB+K67dyMyNS+ysqjHWeibVIX1hw=;
        b=V7hIWyjJ6bqyJFl81we2J0Oi9NV7HL1THvThYHC62ab2WJUfd8OtzuWc19FuUlxkjC
         +E3qq2eG1dyer+ZkpyftONrFQZq/FT/y0+gQZcaz+c2VFnnxaAVJJA9OvACFlw9AJdHm
         qG/sL1Xevp4w0r9f+rv9NYInexGmeVgYMMgZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=huOFnONlrLQ0QS8Cp0kFcNB9uebRH9NLT0r9vnj5MuDsXSfMBt+9w4Y6TaalmOykWq
         0qBSp6hUwu2Wy5XyQHBMA7vPsJ0caZN9h1236Z2JFs6R6ZwjPe8S92mIhmSCRU3PAtxO
         BH51C1xaq5C6mLBT7IdwYRX71kkhJyC1uaJR4=
Received: by 10.86.95.20 with SMTP id s20mr61616fgb.4.1233919304612;
        Fri, 06 Feb 2009 03:21:44 -0800 (PST)
Received: from ?192.168.1.13? (abuz248.neoplus.adsl.tpnet.pl [83.8.197.248])
        by mx.google.com with ESMTPS id d6sm2871619fga.49.2009.02.06.03.21.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 03:21:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0902060301s2a2f81e2t1762377177fb550e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108687>

On Fri, 6 Feb 2009, Giuseppe Bilotta wrote:
> On Thu, Feb 5, 2009 at 12:15 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>>
>>> Add <generator> tag to RSS and Atom feed. Versioning info (gitweb/git
>>> core versions, separated by a literal slash) is stored in the
>>> appropriate attribute for the Atom feed, and in the tag content for the
>>> RSS feed.
>>
>> Very good idea. I haven't examined either specification, so I don't
>> know what conventions are used, though... and what conventions _should_
>> be used.
>>
>> By the way, gitweb uses in HTML header the following (see
>> git_header_html subroutine):
>>
>>  <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
>>
>> which tries to follow convention how _web servers_ like Apache return
>> version information in the 'Server:' HTTP response header (product
>> tokens). Because it was used on only one place, it was not put into
>> separate subroutine; should it now?
> 
> RSS 2.0 spec for generator @
> http://cyber.law.harvard.edu/rss/rss.html#optionalChannelElements
> seems to suggest that the content for the tag in RSS feeds is pretty
> much free-form and we might use the same string we have in HTML pages.
> Requirements for Atom (see
> http://www.atomenabled.org/developers/syndication/atom-format-spec.php#element.generator
> ) are rather more stringent, so it needs its own code anyway.

I don't see there in given above Atom spec _how_ 'version' attribute
should be formatted. Here is relevant excerpt from mentioned page:

  4.2.4 The "atom:generator" Element

  The "atom:generator" element's content identifies the agent used
  to generate a feed, for debugging and other purposes.
  [...]

  The content of this element, when present, MUST be a string that
  is a human-readable name for the generating agent.
  [...]

  The atom:generator element MAY have a "version" attribute that
  indicates the version of the generating agent.

So why not use something like:

  <generator version="gitweb/$version git/$git_version$mod_perl_version">
  gitweb v$version</generator>
 
for Atom? Perhaps with 'Server:'-like version generation refactored
to its own subroutine?

>>> +             print "<generator>gitweb v.$version/$git_version</generator>\n";
>>>       } elsif ($format eq 'atom') {

>>> +             print "<generator version='$version/$git_version'>gitweb</generator>\n";

-- 
Jakub Narebski
Poland
