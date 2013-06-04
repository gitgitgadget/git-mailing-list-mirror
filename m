From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] dir.c: fix ignore processing within not-ignored directories
Date: Tue, 04 Jun 2013 18:10:24 +0200
Message-ID: <51AE1170.8090402@gmail.com>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com> <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com> <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com> <51A62A96.6040009@gmail.com> <51A665E4.9080307@gmail.com> <CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com> <7vk3mcnwlj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Misty De Meo <misty@brew.sh>,
	=?ISO-8859-1?Q?=D8ystein_Walle?= <oystwa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 18:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujtop-0002iO-S3
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 18:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab3FDQKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 12:10:33 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:44052 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab3FDQK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 12:10:26 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so284904bkc.29
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jTXuCLcmQD5QIqf9RwEjm1sb7XiaBTuQYXy86Sljih0=;
        b=gB4iMM8v/Dr3sneQlScDwaivW5KCT5IjPG4mQQkS7t3rEP288ihb5Qen7dq6gXeF6W
         aoA034NeGSkVwArp8lZ5Z3TWSxsyazAnomvvbbt1EOOXYItslR0fiGvZ2HLwJ7DIf+oN
         VJBPObSQXAcdpM7VRYeS45c4jT5bxA91Dqhi+3Fw3Fn5N84exqkR985t4Oe3jtzr0Ui/
         yu6yWFBatC8XXQDufcgXaIfzgEFTurHWMcAMgAAjyYXvKDDAYnvgyYzaHIvsm85dgq1v
         gCSu6LbUEOvN1F8kYKzFaWgxhpxHhb44Pwzek4QKYFbvY+d+iwJYm6xBuBLfFwto3aS5
         cvaw==
X-Received: by 10.204.171.136 with SMTP id h8mr8208526bkz.18.1370362223692;
        Tue, 04 Jun 2013 09:10:23 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id jy7sm15180755bkb.6.2013.06.04.09.10.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 09:10:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vk3mcnwlj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226372>

Am 02.06.2013 21:25, schrieb Junio C Hamano:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>>> +       then
>>> +               false
>>> +       fi
>>> +'
>>
>> Nit pick, maybe this instead?
>>
>> test_must_fail grep "^one/a.1" output
> 
> Neither.
> 
> 	! grep "^one/a.1" output
> 

Nice. I actually tried "!" but without the space - which didn't work so I took the other t3001 tests as example...
