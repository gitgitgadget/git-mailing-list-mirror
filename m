From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sat, 07 Dec 2013 23:32:21 +0100
Message-ID: <52A3A1F5.3080906@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>	<52A37D70.3090400@gmail.com> <87fvq41esw.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Dec 07 23:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpQQB-00062V-Ew
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 23:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902Ab3LGWcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 17:32:20 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:56832 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab3LGWcT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 17:32:19 -0500
Received: by mail-ee0-f44.google.com with SMTP id b57so882466eek.31
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 14:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0hCY5hQ+Rf5eKgBHtG7C5z0jLkV/84G/HOBox0jEpdI=;
        b=rKjs3r1Gvy3fUTpe/N4CIig2xh7HJ5E/9W9wnnr6TBJbev3hzeqHPTz9a9adFTpvhh
         sqvExE3zlhKFXWB+2o0yW0E5UcwZM8QWAVKmtXTr8HM8rskjqdYeaGXx+6ExpbdgOh5O
         gwMN5bnWx1VoYk9hMp1xODeT0SAmM5NMmNvNeVVdUiNSrcSQbRpItCzodj/0Bq0TjxIR
         i4usb5PpUbrB4EHokmZcQl/TBYK4e7ifflJenuqAoLz1Hrlh/DEelDexCFEgeGbM5hA7
         5pA3LMRyjYnBcpKzlQaYaweWvRnac2t3D9yrtXwxdpyj9+CFURLbUQrvcHjVhbzxEMNW
         S2OA==
X-Received: by 10.14.184.66 with SMTP id r42mr962462eem.86.1386455537857;
        Sat, 07 Dec 2013 14:32:17 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id m1sm10874823eeg.0.2013.12.07.14.32.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Dec 2013 14:32:17 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <87fvq41esw.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239028>

Am 07.12.2013 23:23, schrieb Thomas Rast:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Extending 'struct hashmap_entry' with an int-sized member shouldn't waste
>> memory on 64-bit systems. This is already documented in api-hashmap.txt,
>> but needs '__attribute__((__packed__))' to work. Reduces e.g.
> 
> You'd have to guard __attribute__((__packed__)) with some compiler
> detection in git-compat-util.h though.
> 

Isn't that already handled? __attribute__ is already widely used (e.g. for printf formats), and platforms that don't support it define it as empty (e.g. MSVC). Or do you mean I should account for compiler-specific variants (#pragma pack...)?
