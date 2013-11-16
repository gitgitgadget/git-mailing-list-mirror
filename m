From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Access different NAMESPACE of remote repo from client side
Date: Sat, 16 Nov 2013 14:43:30 +0530
Message-ID: <5287373A.8030604@gmail.com>
References: <CANYiYbGiXkBQdXMGbcGV6WjtG82ax6z94TMatP2ZTQ54=KgMjg@mail.gmail.com>	<52862EEE.8010800@gmail.com>	<52863410.9090508@gmail.com> <CANYiYbHzHEFLshU8r-m=0CUo7JTu-iyv1W4N291hX8+r1BYY-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Jamey Sharp <jamey@minilop.net>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 10:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhbx1-0002n8-F8
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 10:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab3KPJNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 04:13:41 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61299 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab3KPJNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 04:13:37 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so2531248pbb.2
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=74Xa5VeEdo/vY2opDBVkxwJGsHHfPA7aOMWKUln/2/g=;
        b=ocL5NhLPA8DQER2CuknVb0d4JsEepSC51HZ2LYq7tOllXKDUlfRZWvZnSc83vre8fi
         dSZtwYFK+2unNv2rZ7AMf/9B+jsGcbSTkvxAwoxOaowJLdQuUtLzspLtowU+EctsNVwn
         GdLAOdhgc/rkSTFG8njzZ+AhsEb3KxVJAudgEDyPAmQYgl8V3DYuwvAb6OvMBNjkHHZl
         3KhJrMe7/JEg11kl4Aud3oxhyIXz+oBS+i49uLn+7i/yxsFsqnWucwZl4111XaDqQnVj
         PQSxjWpkhHOStCvucsZde5w+H3pL0fnM6REy+OugNMt6zsoJUIwJNc5zGgPaglWJs7Wr
         seGw==
X-Received: by 10.68.217.33 with SMTP id ov1mr10552282pbc.6.1384593216705;
        Sat, 16 Nov 2013 01:13:36 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([14.96.31.122])
        by mx.google.com with ESMTPSA id py4sm9734060pbb.33.2013.11.16.01.13.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Nov 2013 01:13:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CANYiYbHzHEFLshU8r-m=0CUo7JTu-iyv1W4N291hX8+r1BYY-w@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237926>

On 11/16/2013 01:30 PM, Jiang Xin wrote:
> 2013/11/15 Sitaram Chamarty <sitaramc@gmail.com>:
>> On 11/15/2013 07:55 PM, Sitaram Chamarty wrote:

[snip]

>> I should add that the Gitolite model is: the user doesn't need to know
>> about namespaces, because namespaces are just things that the server
>> admin is setting up for his own reasons...
>>
> 
> I want to say something that git-namespace is sometimes significant
> for normal user not only for admin.

Sure.  I only meant in the model that I wrote that branch for.

But consider a slight change of syntax:

    repo dev/CREATOR/..*
        C   =   @team
        RW+ =   CREATOR
        R   =   @all
        option namespace.pattern-1 = dev/%/%/NS/* is @1/@3 in @2

Let's say linux and git are parent repos already created (maybe earlier
in the conf).

This conf will let you use URLs like

    dev/u1/git/NS/bar   (becomes namespace u1/bar in git)
    dev/u2/git/NS/baz   (becomes namespace u2/baz in git)

Yeah it looks like a kludge, but all I wanted to do was to show you that
it's not entirely true to say the client cannot control the namespace!
