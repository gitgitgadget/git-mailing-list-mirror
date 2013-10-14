From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/20] alias: trivial style fix
Date: Mon, 14 Oct 2013 07:18:06 -0700
Message-ID: <20131014141806.GB21200@google.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
 <1381561636-20717-18-git-send-email-felipe.contreras@gmail.com>
 <52590E97.6060308@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 16:18:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VViyN-00052I-Tz
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 16:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab3JNOSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 10:18:11 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38119 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab3JNOSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 10:18:10 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so7307411pbc.25
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XO60FAsO3epDKMNQmrFF/KLlKXCjKt81MJz5sF0JIS8=;
        b=IzmBk0DMr3fgn21GT2VX+xe8k2z1cf4Thcyf7qrTFoGb2F0m0Ard2wAwTrX4Y5sgyN
         rBaBsMDiItRM9/FcCOmYDkbrsf1PB0XGxop9kDhtcpnadPe+k/XHWdmWErx4biUdBWPI
         7D4e5DXitJDYhcPvm9Bql2+PICTMupvrPP58czMZFrejPzMnJopgqKjuNcwROVpoti33
         QHgkD/u3Wo09Ud/BCa7lF/HYYaQnL7zwxBw0G0HVwNbD7zuGAF4U3HxqYXMsEKXvjxuo
         lXVXcL3ipVr8AGUTKcEZutKhfa2bdpmJbXMGuZGGeM0lk3Jk3riAZnb45eckW9qYRIse
         wfRg==
X-Received: by 10.68.98.36 with SMTP id ef4mr36496693pbb.27.1381760289487;
        Mon, 14 Oct 2013 07:18:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fa4sm91710000pab.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 07:18:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52590E97.6060308@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236101>

Stefan Beller wrote:
> On 10/12/2013 09:07 AM, Felipe Contreras wrote:

>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Not sure if it's worth by a newcomer. ;)

A second set of eyes is always welcome.

My thoughts: I have to admit I don't see much value in mechanical
replacements like this one when done piecemeal and without other more
significant changes on top.  If this was fixing some particular
eyesore, I would understand, and a little preparatory cleanup to make
another patch on top more readable is always welcome, but this kind of
thing:

>> --- a/alias.c
>> +++ b/alias.c
>> @@ -5,7 +5,7 @@ static char *alias_val;
>>  
>>  static int alias_lookup_cb(const char *k, const char *v, void *cb)
>>  {
>> -	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
>> +	if (!prefixcmp(k, "alias.") && !strcmp(k + 6, alias_key)) {

does not look worth the churn and mailing list noise to me.

A patch that globally took care of these var+constant constructs
without surrounding space and did nothing else, once and for all to
avoid later noise, may or may not be useful.  I suspect even that
wouldn't be worth it, since "k+6" already seems perfectly readable.

So, not too excited by this change.

Hope that helps,
Jonathan
