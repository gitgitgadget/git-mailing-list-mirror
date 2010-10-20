From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] t/gitweb-lib: Don't pass constant to decode_utf8
Date: Thu, 21 Oct 2010 00:28:05 +0200
Message-ID: <201010210028.06569.jnareb@gmail.com>
References: <1287554231-84196-1-git-send-email-brian@gernhardtsoftware.com> <201010202105.59370.jnareb@gmail.com> <3E0E134D-276A-4CA1-965D-274A6AA188C1@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Sven Verdoolaege <skimo@kotnet.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 00:28:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8h8x-0003pM-4h
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 00:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0JTW2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 18:28:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45796 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab0JTW2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 18:28:13 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so3175815fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=71naUSeYGRVS/caS9AlsnjyNkCBMeUCAQsVueX8MIIU=;
        b=R+cIhl3MQgSjkeQF7tRPPAAUnnUzrf6v2+a7iIRFnzFKNhjuFd6xJLfuwIDMC+LWZE
         jgnvKu8GC6CSS4wVf6idnmpJc1xAzsc2NgoRf5LfnRJAiAfW1BhT1g7Dm51dMHj7s7W7
         +/zUqNr1xWTCg2bx7F7X5ImEW1/k1NUFufb9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YgWIgPhs3Ml3hXedp7g+Lf7wFX/ZW8CZLd8tGFN1FxqcycnCQWEaRV1zFcgWSjygGM
         eS+HhVXSwHKnzUNjKRXt8SSoYelK4aAgiMNpzXm45LJ7c3L0SdDgG4RxBuJzfo9De3pA
         nrD40xwI9EJssNaGUEw7r0o8p+SsR2m3oXjTY=
Received: by 10.103.161.18 with SMTP id n18mr7705723muo.31.1287613692714;
        Wed, 20 Oct 2010 15:28:12 -0700 (PDT)
Received: from [192.168.1.13] (abvx10.neoplus.adsl.tpnet.pl [83.8.221.10])
        by mx.google.com with ESMTPS id o6sm459430fal.39.2010.10.20.15.28.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 15:28:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <3E0E134D-276A-4CA1-965D-274A6AA188C1@gernhardtsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159445>

On Thu, 21 Oct 2010, Brian Gernhardt wrote:
> On Oct 20, 2010, at 3:05 PM, Jakub Narebski wrote:
>> On Wed, 20 Oct 2010, Brian Gernhardt wrote:
>> 
>>> Encode.pm started updating the string to decode in-place when a second
>>> argument is passed in version 2.40.  This causes 'decode_utf8("",
>>> Encode::FB_CROAK)' to die with a message like:
>> 
>> Very minor complaint: line break here makes it less readable.
>> 
>> Perhaps this?
>> 
>>  Encode.pm started updating the string to decode in-place when a second argument
>>  is passed in version 2.40.  This causes 'decode_utf8("", Encode::FB_CROAK)' to
>>  die with a message like:
> 
> The wrapping was automatically done by vim.  I'll try tweaking
> width/contents to make it flow better.

Note that it is just nitpicking: the commit message is quite fine as
it is.

>>> Changes since v1:
>>> - Use an explicitly empty variable instead of $_
>> 
>> ...which was undefined, not empty, I think.
> 
> It still served to test the two argument case, but I thought an explicit
> variable that exactly matched the previous call would be better. 

It is better, IMHO.

>>> - based against maint
>> 
>> Was there any difference versus being based against 'master'?
> 
> Whitespace in context lines.  The skip_all and test_done lines were
> re-indented at some point.  Minor, but I thought I'd mention it. 

O.K.

Thanks again.
-- 
Jakub Narebski
Poland
