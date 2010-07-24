From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [WIP/RFC 09/13] git notes merge: Initial implementation handling
 trivial merges only
Date: Sat, 24 Jul 2010 01:32:00 -0700
Message-ID: <4C4AA500.7010205@gmail.com>
References: <1279880104-29796-1-git-send-email-johan@herland.net> <1279880104-29796-10-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jul 24 10:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oca9g-0004qq-UU
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 10:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab0GXIcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 04:32:09 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53786 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0GXIcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 04:32:07 -0400
Received: by pxi14 with SMTP id 14so3967802pxi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 01:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=htp4WrPzKwodAWfquQMtGfKfqHpbug48EM8bhVQR6Pw=;
        b=T35xvYoOkVYiheicVMTX9c97/JLd1x9xqeUEt24H1Zj9IJBx3iUHmW6/eVrQ91Qo08
         gR9EF5yHBKbXtcSoJ5B+4fCQI7duGfNEmaEaWn0aNsTyEUfOfxn+2d/sF+lskGaE78h+
         iDX3iDpnxsmjjTOSMjVmynyPBhvvI7MCNA50o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=G7n0mFPVki+Q0fU0jADIvrIXwsz/sDu63bXnQhYHi/4bbDTJnNfRo6F8qirw01nrGG
         N64il8G9a1yxUFxpbNRGcj3R+9siEcKudqWYHd76dF9VdDeoc8IfFTU2fFyPVT+/638H
         /VlCfcWprR5bjnYMEoPeYFZXnGqdJI3X8B9Jw=
Received: by 10.114.107.10 with SMTP id f10mr6634486wac.165.1279960326854;
        Sat, 24 Jul 2010 01:32:06 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id s5sm2055991wak.0.2010.07.24.01.32.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 01:32:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <1279880104-29796-10-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151606>

  On 07/23/2010 03:15 AM, Johan Herland wrote:
> +	if (1<  argc) {
> +		error("too many parameters");
> +		usage_with_options(git_notes_merge_usage, options);
> +	} else if (1>  argc) {
> +		error("too few parameters");
> +		usage_with_options(git_notes_merge_usage, options);
> +	}
> +
>

Looks like it only takes one <notes_ref>. In that case wouldn't it be better to say

     if (argc != 1) {
         error("Must specify a note ref to merge");
         usage_with_options(git_notes_merge_usage, options)
     }
