From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 8/8] update-ref: add test cases covering --stdin signature
Date: Mon, 02 Sep 2013 13:23:42 -0400
Message-ID: <5224C99E.3050209@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <944b2af0ff064577734fd13cf40039fa4ebc10ec.1377885441.git.brad.king@kitware.com> <CAPig+cQhH+t6unkea=0O2neJm8gOFaiKzPdSnuBaRy=Sdruu=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 19:25:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGXse-0002GQ-KT
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557Ab3IBRZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:25:33 -0400
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:55229 "HELO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755527Ab3IBRZc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 13:25:32 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]) (using TLSv1) by na3sys009aob138.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiTKC4yFpUQh4MKD3EwA8xarpBJYPJ3t@postini.com; Mon, 02 Sep 2013 10:25:32 PDT
Received: by mail-ob0-f173.google.com with SMTP id ta17so4771109obb.18
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 10:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=DMixh23DTMjSzGumRmRqdsTSPUT0ezFjZYzLlyUC81g=;
        b=OniyB+mC05qhn8I/iec4/qH4pVwVoUyH3POk4emOCeJfLD9pN82z1Ph/NqaX8bjiu6
         tUExh3UkBWr0IBCCRltt7XEerbsauJS3hAj0YehA6yx6LUftxxOKG5fHcuwRfenzDUj8
         QpHnXIVGyqtXTXisLGovSCwZWDcFn4R4G9wojFspjJZ0s0Lqkmv2usmvrzaIz249aBdj
         cNNVx0xMfELqJaRTvjnn+Dh5vaa9usAKpnazpnMffH0b2yzxUcejnCPx2IYw4JO5Mh/o
         1jwI1AWPEfzVszbXX1eC/APPiTgR4FcOPnEvPjGogf2xP64PkU7T9MfS3sbMIHzN3ygD
         g3wQ==
X-Gm-Message-State: ALoCoQl1VyKUmBS3q0NwgpljBs6v7u/alf1P4jgcLM5F68dPbtxDKiXQPEWvmQ0cxf2iVwJab78GB4UJ8jCpr3o3ZclKX4+ivqefhJ5YvIdO8Neyibeog9DfKzN6Wahp4CfSH7B6AtqdoX2c0/ZOIewD/2zB+BUF5w==
X-Received: by 10.182.199.74 with SMTP id ji10mr17718812obc.69.1378142731524;
        Mon, 02 Sep 2013 10:25:31 -0700 (PDT)
X-Received: by 10.182.199.74 with SMTP id ji10mr17718807obc.69.1378142731458;
        Mon, 02 Sep 2013 10:25:31 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id xr8sm13918019obc.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 10:25:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <CAPig+cQhH+t6unkea=0O2neJm8gOFaiKzPdSnuBaRy=Sdruu=g@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233643>

On 08/31/2013 11:41 PM, Eric Sunshine wrote:
>> +       rm -f stdin &&
>> +       touch stdin &&
> 
> Unless the timestamp of 'stdin' has particular significance, modern
> git tests avoid 'touch' in favor of creating the empty file like this
> 
>     >stdin &&

Fixed.

>> +       git update-ref --stdin < stdin &&
> 
> Style: Git test scripts omit whitespace following <, >, <<, and >>.

Fixed.

>> +test_expect_success 'stdin fails with bad line lines' '
> 
> Despite the semantic relationship between all these cases, if there is
> a regression in one case, the person reading the verbose output has to
> study it carefully to determine the offending case. If you decompose
> this monolith so that each case is in its own test_expect_success,
> then the regressed case becomes immediately obvious.

Yes, of course.  Fixed.

> multi-line preparations of 'stdin' might be more readable with a heredoc:
> 
>     cat >stdin <<-EOF &&
>     $a $m
>     $b $m
>     $a $m
>     EOF

Fixed.

Thanks,
-Brad
