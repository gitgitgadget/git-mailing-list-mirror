From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/6] parse-options: do not infer PARSE_OPT_NOARG from
 option type
Date: Tue, 30 Nov 2010 00:13:31 -0800
Message-ID: <4CF4B22B.4060307@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com> <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino> <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino> <20101024081316.GA29630@burratino> <20101130025223.GA5326@burratino> <20101130030441.GC5326@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLLX-0006M6-11
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab0K3INq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 03:13:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36938 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab0K3INp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 03:13:45 -0500
Received: by gxk3 with SMTP id 3so177036gxk.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 00:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6pzvsirTQ4q3TaFOXtkEI6vfyWyVozSx3ADWBeqCMKU=;
        b=Ymo2aEa5ZGl8ZvZQiCEseT2deOLL44FzjSR3ByossHvR+f82rzbxEfd+jLuHubJiMe
         K2yjdhQrmPHQVSsStl6AsH1kE+EwuWXNGUA9HfBFbceiqlMLmHEPWMRsdbKGowlw8W93
         D3Jxd/AC01hBM/txWBjBlEnRrfXSS2YVzSJY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=td/9mgV34pV5JqSr6TZ6YMhaA3Max8eBPE7j7r/MZ+QYCAwe8cSG00bcRRwmYjMWrn
         RJQNaPA505IdwS8XfMGt6kSsrkXglvLG7cRFLHqIuyTvsH9v5W72CIsrJn3JpmZFZJOo
         CHd3uBaCQPO/72Ea4pK+1ukBLiA+28R4expIo=
Received: by 10.151.12.17 with SMTP id p17mr12397086ybi.83.1291104822954;
        Tue, 30 Nov 2010 00:13:42 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id 54sm2667504yhl.32.2010.11.30.00.13.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 00:13:42 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101130030441.GC5326@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162478>

On 11/29/10 19:04, Jonathan Nieder wrote:
> From: Stephen Boyd <bebarino@gmail.com>
> 
> Simplify the "takes no value" error path by relying on PARSE_OPT_NOARG
> being set correctly.  That is:
> 
>  - if the PARSE_OPT_NOARG flag is set, reject --opt=value
>    regardless of the option type;
>  - if the PARSE_OPT_NOARG flag is unset, accept --opt=value
>    regardless of the option type.
> 
> This way, the accepted usage more closely matches the usage advertised
> with --help-all.
> 
> No functional change intended, since the NOARG flag is only used
> with "boolean-only" option types in existing parse_options callers.
> 

Signed-off-by: Stephen Boyd <bebarino@gmail.com>

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Thanks for the nice words.
