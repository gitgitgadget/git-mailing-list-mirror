From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] format-patch: Add a signature option (--signature)
Date: Tue, 15 Jun 2010 21:31:42 -0700
Message-ID: <4C1853AE.4010104@gmail.com>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com> <7viq5k6xbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 06:34:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOkKf-0007gq-Nu
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 06:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab0FPEbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 00:31:46 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37166 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab0FPEbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 00:31:46 -0400
Received: by vws13 with SMTP id 13so2168886vws.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7G4dIGBhR7O8yCB+/op3TTyMPmVafN1JO2ZR6ek9k10=;
        b=qWvGt6SeVFvcmpjHoZ+o7VwoDFsc49ksS7sScVfWidRyUPW3b91HvmSk8d41K9Trxw
         3Tmhf+TqEm0S5NRxd1i0ndKHKcALqPmgprOIqiwBiwdyj99oCR2U/Ady/JJ1y/jH6PnW
         jEjpXqUbUbl6CApIUc5Ysbbe9sklxEajrdnYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uKOqUCKMRMSlAo3sUAjA4WWISXolXohskEppozaULlEFvpyPcFSiyG5tF6sIBJO4z/
         009OucRaq0P4dyYE02AeD2QcMp3HnQRnNP9JT3W53w8RPPpB3LzPnDdz6CK0jAgj1tpS
         5L3lknYlz6Zwergu7i7wgaZdm6n9IHh0oS+No=
Received: by 10.220.125.7 with SMTP id w7mr4413379vcr.201.1276662705123;
        Tue, 15 Jun 2010 21:31:45 -0700 (PDT)
Received: from [192.168.1.5] ([24.152.169.138])
        by mx.google.com with ESMTPS id i40sm6893648vcr.8.2010.06.15.21.31.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 21:31:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7viq5k6xbj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149245>

On 06/15/2010 10:05 AM, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> write
>> @@ -180,6 +180,12 @@ will want to ensure that threading is disabled for `git send-email`.
>>  	containing the shortlog and the overall diffstat.  You can
>>  	fill in a description in the file before sending it out.
>>  
>> +--signature=<signature>::
>> +	Add a signature to each patch and, if --cover-letter is specified,
>> +	the cover letter. Per RFC 3676 the signature is separated from the
>> +	body by '-- '.
>
> Wouldn't "Add a signature to each message produced" be easier to understand?
> Also perhaps s/body by '-- '/& a line with '-- ' on it/?
>
> Don't we want either an extra header to this entry ("--no-signature::")
> and advertise it as a way to disable signature generation?

Both sound good.

>
>  (3) there is no way to say "no signature, ever" in the configuration.
>
> Perhaps we would want to do this instead?
>
>         static void print_signature(void)
>         {
>                 if (signature && *signature)
>                         printf("-- \n%s\n\n", signature);
>         }

Sounds good too. It's not entirely obvious that format.signature=""
means no signature ever, but that's where documentation steps in I guess.
