From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v3 2/4] generate-cmdlist.sh: parse common command groups
Date: Sun, 03 May 2015 22:53:15 +0200
Message-ID: <55468ABB.8050504@gmail.com>
References: <554405D5.9080702@gmail.com>	<55456990.6000509@gmail.com>	<55456A40.80806@gmail.com>	<xmqqpp6hv94x.fsf@gitster.dls.corp.google.com> <CAPig+cSRiw7QeAzuxAJF8mikeK1YiNoNATKzMz71L8E29LLp4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 03 22:53:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp0t9-0007a7-S1
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 22:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbbECUxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 16:53:20 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38487 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbECUxT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 16:53:19 -0400
Received: by wiun10 with SMTP id n10so92451769wiu.1
        for <git@vger.kernel.org>; Sun, 03 May 2015 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=L9nZAqV1eFkGvvfb3LydSuFrTEn9HMu6Rerw2TAHtXM=;
        b=Bb7kQud/KLY8vTil6vkDM6t1z74ntrjc3VHifA1W0P0fX2JQaxFaHxNFMbvihd9F0t
         GOcd37NOCJquR2UxVmn0euvuf9yGZ+FbGQ1yR1MY/sLiB1P1Q5mi1y2pxwgC+ySAvbx8
         GpbOnGWk37O1tepx6LKWrGto5y2Bk4uxW91ujqOrKBBIkQvDXgunwG741iKyYDRgqvfq
         pzft2+aVj/gb/lU15V2PqdeityPwHfeqs7ZkfOzk5BKPlIruNZavlRcosoSa2qtr449a
         Lf9p+InRq2EUnWGCKmrGe9vRlhGm/lMAuU0JIldGQS34kDD6aOjxE88Al1H5sWjWEPXg
         Abvw==
X-Received: by 10.180.93.193 with SMTP id cw1mr14482209wib.12.1430686398029;
        Sun, 03 May 2015 13:53:18 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id e10sm8104146wij.11.2015.05.03.13.53.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 13:53:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cSRiw7QeAzuxAJF8mikeK1YiNoNATKzMz71L8E29LLp4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268292>

On 05/03/2015 10:40 PM, Eric Sunshine wrote:
>> These people may have helped you to polish your earlier round to
>> come up with this version, but I do not think they should be listed
>> as reviewed-by (in the sense that they would say "Yes, I read this
>> version and consider it very good--I endorse the change!") yet.
>
> Minor addendum: If you'd like to acknowledge Luke for $(...) and
> Andreas for IFS munging, then Helped-by: would be appropriate (and
> doesn't require their consent).

Thanks for the precision, I got confused with this one.

> So, something like this, perhaps:
>
>      [groups]
>      init    starting a working area
>      info    examining history and state
>      ...
>      branching    branching and merging histories
>
>      [commands]
>      git-branch    mainporcelain branching
>      ...
>      git-clone    mainporcelain init
>      ...
>
> This way, the 'N' in "N_group" is unnecessary since presentation order
> is implied by the [groups] table, and you don't need the "common-"
> prefix anymore since any command having an attribute from the [groups]
> table is automatically considered common.
>

It's a good idea. I'll look into it.
