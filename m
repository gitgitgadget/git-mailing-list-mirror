From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v7 3/4] tests: add new test for the url_normalize function
Date: Mon, 22 Jul 2013 03:21:54 -0700
Message-ID: <278AD60F-D7A7-4ED2-853C-306E8612920E@gmail.com>
References: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79> <185ed81d5965642db680fa361ee07ce@f74d39fa044aa309eaea14b9f57fe79> <7veharqip6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 12:22:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1DFn-0007XP-RV
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 12:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab3GVKWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 06:22:00 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58049 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365Ab3GVKV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 06:21:58 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so6907664pab.41
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mauler;
        bh=+XBas9ZzAFJ0wGC00xGCjsqWW2FGN6yI3mGAtmSoSc0=;
        b=k1A9AC9I/rfnzUrKAT2Tt8wDt0oszVEmorxo3ObLDDvACaNFUYEnroaWZlSxOCW9RA
         IHOc5uuyDLtfYJQSqTf/jl2D4Pr46lEZFIcAJeKK1tyaB3zRi8/GffuJ87DafxlNMgzq
         Cnl8hL7G2/vlhWc0orKOuqY0rfJZKh/wy9X/woHjy7I10tnvsUjIGjKkx06eN+zmFL8d
         9d2H6w336DnoU4ESeu2OyOnl3qGDGYQzABdXayp72lHSjBXf/JHXDzmK4gCJObkDQWhQ
         lz/uasrOic3LB/7kqH57G+++LXbxmXY5x7lfMOZI48Tc3SSBLUsfvlzwweDCjD5S72nQ
         CSjg==
X-Received: by 10.66.51.102 with SMTP id j6mr30592694pao.80.1374488517965;
        Mon, 22 Jul 2013 03:21:57 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id vi8sm35021706pbc.31.2013.07.22.03.21.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 03:21:56 -0700 (PDT)
In-Reply-To: <7veharqip6.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230969>

On Jul 21, 2013, at 22:15, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> +test_expect_success 'url general escapes' '
>> +	! test-url-normalize "http://x.y?%fg" &&
>> +	test "$(test-url-normalize -p "X://W/%7e%41^%3a")" = "x://w/~A%5E 
>> %3A" &&
>> +	test "$(test-url-normalize -p "X://W/:/?#[]@")" = "x://w/:/?#[]@"  
>> &&
>> +	test "$(test-url-normalize -p "X://W/$&()*+,;=")" = "x://w/$&()* 
>> +,;=" &&
>> +	test "$(test-url-normalize -p "X://W/'\''")" = "x://w/'\''" &&
>> +	test "$(test-url-normalize -p "X://W?'\!'")" = "x://w/?'\!'"
>> +';#'
>
> Hmm,... what is the magic on the last line about?

A left-over concession for my stupid editor. ;)  I'll remove it from  
the new version.
