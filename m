From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH] pull: replace unnecessary sed invocation
Date: Thu, 18 Mar 2010 09:30:22 -0400
Message-ID: <4BA22AEE.8000606@gmail.com>
References: <1268889045-21751-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 14:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsFtF-00062z-J2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 14:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab0CRNfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 09:35:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:48351 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab0CRNfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 09:35:52 -0400
Received: by qw-out-2122.google.com with SMTP id 8so352449qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=F9w5zERfGsF4xqpQtYhHbPVNgknyROAfdMMBFBitm+4=;
        b=uN+qqnovDi0WqjCYFXnHP+yYjWbtKN//ZF2+GqiTxcELxNpFslmKVa6rPnTfdt7sbe
         AzIRuSbw2I3mCEsGAjN0X6qsFDJopL24EY5wxceNPGCjq1TCqX035jzq0uT+wroNm3v2
         bW6JusLPcbrFLD6j5+2TMsLtZCsL87bV9ZKxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=B+GjKUH++HtctVx/U/LyG7NGVuFnAnTIUvzPGkII1s4Cyo49CUaWc1hde3T5AsEHH8
         t3bJ4IAaHYAVJXlF/g4LoMdsjOaV74Hp1ITqkJ/oHq+VleYTLu0XFjSy8z7GV0p0GxCJ
         eMU71Otgdv7kfTZg21gJpZK/X3BYFIFKbz4ds=
Received: by 10.224.53.105 with SMTP id l41mr742607qag.365.1268919027749;
        Thu, 18 Mar 2010 06:30:27 -0700 (PDT)
Received: from [192.168.10.101] (modemcable074.180-22-96.mc.videotron.ca [96.22.180.74])
        by mx.google.com with ESMTPS id 2sm2164949qwi.1.2010.03.18.06.30.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 06:30:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <1268889045-21751-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142468>

On 2010-03-18 01:10, Stephen Boyd wrote:
> Getting the shortened branch name is as easy as using the shell's
> parameter expansion.
> 
>  curr_branch=$(git symbolic-ref -q HEAD)
> -curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
> +curr_branch_short="${curr_branch#refs/heads/}"

This modification is a bashism. This syntax is not compatible with other
shells.

-- 
Gabriel Filion
