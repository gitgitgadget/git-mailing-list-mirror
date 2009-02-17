From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [DRY HUMOR PATCH] Add a few more values for receive.denyCurrentBranch
Date: Tue, 17 Feb 2009 02:10:33 +0100
Message-ID: <237967ef0902161710k4672e972rdffab0357b8872a8@mail.gmail.com>
References: <cover.1234820890u.git.johannes.schindelin@gmx.de>
	 <bfeaa5d164c9dc2d1080545e4bb9480920762ff2.1234820890u.git.johannes.schindelin@gmx.de>
	 <20090217005824.GA23892@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 02:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEVW-0004pY-TA
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 02:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbZBQBKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 20:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbZBQBKg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 20:10:36 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:36600 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbZBQBKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 20:10:35 -0500
Received: by ewy14 with SMTP id 14so2108305ewy.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 17:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VOdY0DArezm8CXiyk0I4Y95RXbbrJSMwsFSrOGJFjwE=;
        b=KBKVGYfEsIsjQ5v/jKHRM41uIpu5gRhvFm1o9f4xn39HUXvmbSDtZHLh0gYcuC3HUc
         vEFKBuL+/pGR5YOKalK63uE/7pPcVsR1NWQR15EUqUAVFpOkM3xM13gUkeI+0j6l8bel
         deIQvSHNLbm9mhJveBavHEkUm7UM6OcqVbYz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g6H4mzEI8ZgqZ1lB3ngBcD+Mc5ubGJZTYu8YdrcRvtm+3XNi4NwUtT/0io5kO4yFll
         /kpm7msCfOS/OOw9K3dhJIJJkVifbcBZNMOb00mW91CE9+xbiEq2sVCCev9Dorsykswm
         0DEAohpVSrjZf0KAytyryIiogtae27Cj8wGho=
Received: by 10.210.117.1 with SMTP id p1mr2106865ebc.107.1234833033778; Mon, 
	16 Feb 2009 17:10:33 -0800 (PST)
In-Reply-To: <20090217005824.GA23892@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110287>

2009/2/17 Jeff King <peff@peff.net>:
> On Mon, Feb 16, 2009 at 10:52:05PM +0100, Johannes Schindelin wrote:
>
>> @@ -75,7 +77,12 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>>       }
>>
>>       if (!strcmp(var, "receive.denycurrentbranch")) {
>> -             deny_current_branch = parse_deny_action(var, value);
>> +             if (value && !strcasecmp(value, "updateinstead"))
>> +                     deny_current_branch = DENY_UPDATE_INSTEAD;
>> +             else if (value && !strcasecmp(value, "detachinstead"))
>
> Config variables are already lower-cased. ;P

But surely the values are not?

-- 
Mikael Magnusson
