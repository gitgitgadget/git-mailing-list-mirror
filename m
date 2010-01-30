From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] builtin-name-rev.c: remove the remaining "typedef struct
 rev_name" from git.
Date: Fri, 29 Jan 2010 23:53:16 -0800
Message-ID: <4B63E56C.5000100@gmail.com>
References: <8678db190a73997c7bd757b9d78f0fa9e8721055.1264815015.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 08:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb896-0007Rq-T0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 08:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab0A3Hx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 02:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036Ab0A3Hx0
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 02:53:26 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:57480 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0A3HxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 02:53:25 -0500
Received: by iwn3 with SMTP id 3so2461661iwn.23
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 23:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WcCv8LTF1wsiXml6thMIzXw1QBw0pCMM+B+ZTtTJpBs=;
        b=M3JCd21YA/2fCVmNTwEm0i3sSAZFLyS8BBr8M0woDi5igLdNSV9ghHi986zemDj/m/
         Wsbc6KQrpz5hQ82AGQqUu0X9m4AKH7HvJd1nvg8WpH8dkQ7K0uZ1vCklC9gnzclZakEz
         VFvHCHU2Uhwut4VrYnO9SaPU+L1ODqJOb7H7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MNm+s21Z4igwgkclPba5ps6qeI9Ss6T+P9TQ/zp7oWBAf8olT9RR5byg/jScehPjo9
         0ZzwtBSI0/eGEG/gJOdAloQSAfS3h0xAIVdHheeiUAfJetZFVkvXZ6BKtfJyPJynt/Xy
         zHj3Q4sakhKz0rJJbVJmRcgGljhTiGKMh3M5g=
Received: by 10.231.151.207 with SMTP id d15mr2524044ibw.44.1264838002294;
        Fri, 29 Jan 2010 23:53:22 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm2756233iwn.10.2010.01.29.23.53.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 23:53:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <8678db190a73997c7bd757b9d78f0fa9e8721055.1264815015.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138461>

On 01/29/2010 05:32 PM, Thiago Farina wrote:
> @@ -43,7 +43,7 @@ static void name_rev(struct commit *commit,
>   	}
>
>   	if (name == NULL) {
> -		name = xmalloc(sizeof(rev_name));
> +		name = xmalloc(sizeof(struct rev_name));

How about sizeof(*name) instead? This way we don't have to change it 
when the type changes again.
