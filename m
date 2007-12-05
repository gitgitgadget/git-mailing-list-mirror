From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 22:26:53 +0100
Message-ID: <200712052226.53543.jnareb@gmail.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <1196869526-2197-1-git-send-email-jnareb@gmail.com> <7vtzmxortn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 22:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01mA-0002kD-4x
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbXLEV1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 16:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbXLEV1E
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:27:04 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:14187 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXLEV1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:27:01 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1274174mue
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=XtlOBRNeE2kJF2MjBl1vn8WcsH6+SWKBKqXbxFkAWSU=;
        b=b46v+IutJ/uhMnw95ks634C6ljTpQqk9440MUBS6+211w6ZKDvRNaKPYMMyUIp9wS4ACa4lCFXoDhYEe495DLSFgMgzgDqYMjKmhB1BiExIaWKbBBFX6QQrPNgBckQ1lRSy5KrHwy1tp9zyeyoncADz/RH62666ShiMaNiIS3u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nnThVa0Z8WY/Ydv/wFxeYatvNX/2YAcNQ5TGs8qqKn/dNAebeSAuIxo0pPgfiA96taptOboiuosedoVHKgUI2zLsvpOa1pwZlE1sRfFAZsODir3iP2mvQo6yQUGz9RdEluNJBm5t1XZcfdHOM29Xi37EM8FvwcAj5XWGstD8mfo=
Received: by 10.82.105.13 with SMTP id d13mr884460buc.1196890015811;
        Wed, 05 Dec 2007 13:26:55 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.243.182])
        by mx.google.com with ESMTPS id p9sm111561fkb.2007.12.05.13.26.52
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 13:26:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtzmxortn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67196>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> +AC_MSG_CHECKING([for old iconv()])
>> +AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
>> +	[AC_MSG_RESULT([no])],
>> +	[AC_MSG_RESULT([yes])
>> +	OLD_ICONV=YesPlease])
>> +AC_SUBST(OLD_ICONV)
>>  
> 
> Which result does COMPILE_IFELSE give for non error warnings?  Ok, or
> Bad?

 - Macro: AC_COMPILE_IFELSE (INPUT, [ACTION-IF-FOUND],
          [ACTION-IF-NOT-FOUND])
     Run the compiler and compilation flags of the current language
     (*note Language Choice::) on the INPUT, run the shell commands
     ACTION-IF-TRUE on success, ACTION-IF-FALSE otherwise.  The INPUT
     can be made by `AC_LANG_PROGRAM' and friends.

And if I have checked correctly code which causes only warnings
returns Ok (in this case print 'no' after 'checking for old iconv()... '
and do not set OLD_ICONV, which means it will be unset).
-- 
Jakub Narebski
Poland
