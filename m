From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: show no difference message
Date: Mon, 26 Mar 2007 22:01:38 +0100
Message-ID: <200703262301.38858.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261911.54013.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:04:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzAf-0008Jy-NO
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933827AbXC0AEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933834AbXC0AEO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:04:14 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:55744 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933827AbXC0AEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:04:12 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2920865muf
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 17:04:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h/1338NiHxqDD89xOosVpaAoOR7ZTzhFVcSOcnQnfDBByWgQl2SJgM0ZXIbImpjuoYsZvEV8I929IwNnrU9aMJbjaRC6+plECpVkVK3BtSd1ijRvI/HNsPyubFp4KOFdh37gj9SbznoKBHNMb4c5nImPLdc3iqgMT2zOOqRARr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YYDM62Hc7HYVGgoHSYUeHfx4rIT8ufK7+NHsx89vMznY99dmYlIrTgeFP+PS5ffA/Ol1BnTF2Dtf5Ypfda2xTw8r4DlUIDG6B4w91YM+T5Lw3yeBm++RyqPuTQClxB5MhV/+/Qidr/2SnSD1IzoKwWKWWGc+K7++d8L+8+F0pKQ=
Received: by 10.82.108.9 with SMTP id g9mr14974519buc.1174953850502;
        Mon, 26 Mar 2007 17:04:10 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y2sm30209120mug.2007.03.26.17.04.08;
        Mon, 26 Mar 2007 17:04:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200703261911.54013.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43211>

On Mon, Mar 26, 2007, Jakub Narebski wrote:
> On Sun, Mar 25, 2007, Martin Koegler wrote:

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 5214050..fbadab4 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2376,6 +2376,7 @@ sub git_patchset_body {
>>  
>>  	my $patch_idx = 0;
>>  	my $patch_line;
>> +	my $empty = 0;
>>  	my $diffinfo;
>>  	my (%from, %to);
>>  
>> @@ -2396,6 +2397,7 @@ sub git_patchset_body {
>>  		# git diff header
>>  		#assert($patch_line =~ m/^diff /) if DEBUG;
>>  		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
>> +		$empty++;
>>  		push @diff_header, $patch_line;
>>  
>>  		# extended diff header
[...]
> First, programming style. You named the variable $empty, when it
> evaluates to true when the patch is _not_ empty, i.e. when some
> differences are found.

By the way, I _think_ that you can use $patch_idx instead of creating
new variable for that.

-- 
Jakub Narebski
Poland
