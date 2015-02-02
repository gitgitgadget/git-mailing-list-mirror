From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Mon, 2 Feb 2015 08:11:02 -0800
Message-ID: <8103CEFD-4160-4C03-B58B-A3CCCA52748B@gmail.com>
References: <54CA3611.1000804@statsbiblioteket.dk> <1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk> <20150130230516.GA7867@vauxhall.crustytoothpaste.net> <a924a58108ea8ad8aece1ee66cbdc3f@74d39fa044aa309eaea14b9f57fe79c> <xmqqmw4x85bw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git mailing list <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 17:11:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIJai-0002Uw-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 17:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbbBBQLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 11:11:08 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:38863 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbbBBQLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 11:11:07 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so84084904pab.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 08:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=fSsVMQD4MHSqeE8ggTK58Onm7U3FpuuCj4MwiCtvbDE=;
        b=BJtDHNPscDXgqHHXJ0zS/8FhpIG1DGWd2M3HQh0D5u2T9rXL+gtFGmXz4JHvVAwMYa
         wp3Uy6wnGm03SzOZ2uKy2ouQy55WpbHRKtSgWvx6rozpuQiWaIrevSUSABcQmriN7Sa8
         /1F44vhLuIR9RgNBngUjqB9QayvDpJXOrkBdsc5+kRAofKBhoofUPLvZpWjonbaYk8t3
         ikMl/fOFPN9ZsMwtH+WhfnVEAAmCCupYmUVcKJJhuqZ3/e3GwN9I7ct+0S3glxN3lep/
         xPdDdzLJMTnHMRT8dUVgfX7pJoURhqexAoZJp7LZt9QLn5MQv76mN3Z+GxWji/a9A6/8
         Y3kQ==
X-Received: by 10.70.15.2 with SMTP id t2mr30138952pdc.47.1422893465670;
        Mon, 02 Feb 2015 08:11:05 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kp1sm19197696pbd.54.2015.02.02.08.11.03
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 02 Feb 2015 08:11:04 -0800 (PST)
In-Reply-To: <xmqqmw4x85bw.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263260>

On Feb 1, 2015, at 17:33, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>>> use 5.008;
>>
>> So either that needs to change or the code should properly deal with
>> the version of Getopt::Long that comes with 5.8.0.
>>
>> Since it's really not very difficult or invasive to add support for
>> the no- variants, here's a patch to do so:
>
> Doesn't that approach add "what does --no-no-chain-rely-to even
> mean?" confusion to the resulting system?  If that is not the case,
> then I am all for it, but otherwise, let's not.

No.  You have to append the '!' to get the automagic no prefix  
alternative(s), so while 'chain-reply-to!' means support chain-reply- 
to, nochain-reply-to and (if you have a new enough Getopt::Long) no- 
chain-reply-to, just using 'no-chain-reply-to' without the trailing  
'!' means that nono-chain-reply-to and no-no-chain-reply-to remain  
invalid options that will generate an error.
