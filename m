From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 1/7] gitweb: refactor author name insertion
Date: Wed, 1 Jul 2009 09:41:39 +0200
Message-ID: <200907010941.40641.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <200906302308.58488.jnareb@gmail.com> <cb7bb73a0906301615l1352f7c6i6a9939ccca6a70dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 09:43:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLuTH-0003tj-0l
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:43:11 +0200
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLuS9-00029M-Vj
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:42:01 +0200
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLuS9-00029J-UR
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:42:01 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx1.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLuS9-0004yp-7F
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZGAHlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 03:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbZGAHlo
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 03:41:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:64233 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbZGAHln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 03:41:43 -0400
Received: by fg-out-1718.google.com with SMTP id e21so203497fga.17
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gHIoUn8BjMcvjZJ6Qz6QiAHd97m9+Fx2rPECUUE2IXM=;
        b=fatkdeoHpuDY+gLPap7BakM0/3TvURR6WkrtwtsXRLzdxjK1GH3YurDEcE05p6K3N4
         Ag8GqEdBUT1X8WbeY4UWQCW1JATUjlZheGgp0RYXVr4gQoLx3hLikgtT7kVdD9NQoqHA
         5Ecv8/hsWdnsvBNwkIJaRvIvfpsyQjSrPBSy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Kj27WkXvgQnKpoAkTWA96BrZc8XQt2tObZ7JTq1dzm74/oSJltP2577T+YCKQ3LLnC
         ULxCWj/p+sVjy6RFuCvjk9fMLTt0AxdICFk6BkE0yApveVYtv3AQMngXFBs6rX5Brs1g
         fOylQU1kP0oprYiBZ7vOvKMzsFqSpCWQFTJ5Y=
Received: by 10.86.81.16 with SMTP id e16mr3588457fgb.78.1246434105362;
        Wed, 01 Jul 2009 00:41:45 -0700 (PDT)
Received: from ?192.168.1.13? (abwo245.neoplus.adsl.tpnet.pl [83.8.238.245])
        by mx.google.com with ESMTPS id d6sm1704240fga.0.2009.07.01.00.41.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 00:41:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906301615l1352f7c6i6a9939ccca6a70dc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 6B998BAB2F8C01C7DC5CDF6E6C3DE7C0DFADF0C3
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 217 total 2552028 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122570>

On Wed, 1 July 2009, Giuseppe Bilotta wrote:
> On Tue, Jun 30, 2009 at 11:08 PM, Jakub Narebski<jnareb@gmail.com> wrote:

>> # prints time in local timezone, from result of parse_date
>> # in the following format: " (HH:MM +/-tz_offset)" or " (%H:%M %z)"
>> # with "atnight" warning when 0 <= hour_local < 6
>>
>> or something like that.  Or just
>>
>> # prints time in local timezone, from result of parse_date
> 
> How about
> 
> # prints time in local timezone, highlight night hours

Or

# prints local part of parse_date, highlight night hours

It important, I think, to state that print_local_time takes result of
parse_date as an argument.

Nevertheless that is just nitpicking and bikeshedding.
 
>>>>> +sub print_local_time {
>>>>> +     my %date = @_;
>>>>> +     if ($date{'hour_local'} < 6) {
>>>>> +             printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
>>>>> +                     $date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
>>>>> +     } else {
>>>>> +             printf(" (%02d:%02d %s)",
>>>>> +                     $date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
>>>>> +     }
>>>>> +}
> 
> -- 
> Giuseppe "Oblomov" Bilotta
> 

-- 
Jakub Narebski
Poland
