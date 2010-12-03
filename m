From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Thu, 02 Dec 2010 20:16:21 -0500
Message-ID: <4CF844E5.5010808@gmail.com>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <4CF80B71.3010309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, ben@ben.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 03 02:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POKGH-0007Is-18
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 02:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758234Ab0LCBQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 20:16:27 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61411 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0LCBQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 20:16:26 -0500
Received: by qwb7 with SMTP id 7so9037157qwb.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 17:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=tuhzxTSRFIdfINACLZFHTpu07f/vFll7P6jzqDpELbo=;
        b=ekvGUxMjKMJBbzObmDpAVWdxurXqlXOl+mRh+UA1yD8LlY4BaPynRLqnvzYHqe6wxB
         ejpw+ri9ndIBhlvBTVkiLQL23mseZ9n+5CpueWnFb88toH3BHpCCeA82D/eBk6LjCNEq
         zPkL3d2xnFkzIESeVmE/41ZjJQwmjw3fmZbgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IaI/YTGRJnJbFYLcZkqDw/WY8UVLDXvgtNgdFq5c5SqzSV3P/v3mVvKQ84Zyr1mEMS
         sxUDpyHtNM/659AQJx8Qg5VLfCUoRl9MSueHgExp/CFMRCEw59lGIrxGNXNHtUztz6xz
         GUrxEgo/NA2WfBAQINBqXXZLzIpvlFgKQYvuc=
Received: by 10.229.222.65 with SMTP id if1mr685665qcb.159.1291338985421;
        Thu, 02 Dec 2010 17:16:25 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-111-224.washdc.fios.verizon.net [173.79.111.224])
        by mx.google.com with ESMTPS id s34sm805001qcp.8.2010.12.02.17.16.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 17:16:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <4CF80B71.3010309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162756>

On 12/02/2010 04:11 PM, Jens Lehmann wrote:
> Nope, these lines date back to the time before I got involved in the
> submodule business ... Seems like this "git checkout" was added in
> March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
> that.
>
> But to me your change looks good, so feel free to add:
> Acked-by: Jens Lehmann<Jens.Lehmann@web.de>
>
>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 33bc41f..6242d7f 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -241,7 +241,7 @@ cmd_add()
>>   			# ash fails to wordsplit ${branch:+-b "$branch"...}
>>   			case "$branch" in
>>   			'') git checkout -f -q ;;
>> -			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
>> +			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
>>   			esac
>>   		) || die "Unable to checkout submodule '$path'"
>>   	fi
>>
These lines were actually added by Ben Jackson in commit ea10b60c91 in 
2009, long after I last touched that module.

Mark
