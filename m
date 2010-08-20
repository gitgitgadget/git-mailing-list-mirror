From: Chris Packham <judge.packham@gmail.com>
Subject: Re: stgit: command to remove file from patch
Date: Thu, 19 Aug 2010 17:27:54 -0700
Message-ID: <4C6DCC0A.5040006@gmail.com>
References: <829548.96589.qm@web45501.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: av78us vaal <av78us@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 02:28:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmFSi-0001Iy-GF
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 02:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab0HTA1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 20:27:55 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53383 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0HTA1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 20:27:54 -0400
Received: by pxi10 with SMTP id 10so975482pxi.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=IgDvFVvADBEdIHirQXL6N322tz1p45InQUK2N4lr9+w=;
        b=RxZa4EIm6/h7+sDnkndNZPWGukCIrkXPPoEUI8LlHaob2Db3DIyvRTm6h20QkZSKf8
         5XOpT4+ReCpaZK4WwVFNFEex/avfY7rZzNfWeTq/SMumYWEolXiZpHKI/h3bLVUJaLNk
         H9xg0tDpWNbL2I+A42zYHTRCws+9PZCdQO+Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dmJuK6cypzwE8LA57swO3/5115p2eOhc91YhllpDGDW2yyWwxfAniedd78o8Au0wh4
         eGwMpp2IrEnnqlar3cigndv7ESeonaDg9xTkBP1dfmoh7KEwtjJjcr7XIYKk1nXaEa8n
         VWYZFpgKU/+UAKiYq571Mifrvwgrm28bh5FuQ=
Received: by 10.114.107.12 with SMTP id f12mr750377wac.21.1282264073683;
        Thu, 19 Aug 2010 17:27:53 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d39sm3662608wam.4.2010.08.19.17.27.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 17:27:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <829548.96589.qm@web45501.mail.sp1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153966>

On 19/08/10 09:29, av78us vaal wrote:
> Hi, 
> 
> Is there a command to remove a file from a patch in stgit? I mean, something like "quilt remove". 
> 
> I searched a lot but I couldn't find any. 
> 
> If such a command is not available, is there an easy way to achieve this by other means. I tried this by changing the git commit and using "stg repair". That didn't work for me.
> 
> I would like to propose "stg remove" to be placed very high on stgit wish-list. 
> 
> Thanks,
> Aneesh

What do you mean by remove?

If you want to undo changes that are in the current patch you can do
something like:

  git checkout HEAD~1 filename
  stg refresh

If you want to retain the changes but move them to another patch:

   git reset HEAD filename
   stg refresh -i

I regularly use the first method, the second method I _think_ will work
but haven't tried it.
