From: t.gummerer@gmail.com
Subject: Re: fatal: Unable to mark file .ruby-version
Date: Sun, 15 Mar 2015 13:30:04 +0100
Message-ID: <20150315123004.GB12619@hank>
References: <1645103.91WotSCBpm@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 13:30:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX7gR-0008JG-Sk
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 13:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbCOMaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 08:30:09 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34907 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbCOMaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 08:30:08 -0400
Received: by wibdy8 with SMTP id dy8so18363558wib.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/+kmQCqeAIgp5OSeAHb1pkK1utKeNCNxhtQP7wzb1R8=;
        b=BwakgYXs85mIdZZatQJWFCeimig+ogIK60i4CT4Q4+VZD3XR7Sp1u/73nelx/CR4qP
         QVos3sXqm4tWaiXPmZbjhTK91YAiSSwXs/7qZ3T9ai3SiaFE/7pyIR+QFJPU4D/4lsl6
         HUgnoNeK4iNrfuuws/wMJ/uV+SGVbAuf0CiUC0ummWzITzVa2U6SmXo2hJzdPdLMgYOf
         IJoQXUrDM1YMrCyqA+6nHKRFQ9kA3eNp6ewFauVJsOUIOAOnPs0HJ2vGKgjycAJlrXHy
         iRb2/aIo4lMVuKtFxDtdmIZcCO5HUgXxp1MKhSR4t9z0A+aw3plFeweTFgMGiEPxYh7P
         agAw==
X-Received: by 10.180.184.136 with SMTP id eu8mr100941554wic.45.1426422606981;
        Sun, 15 Mar 2015 05:30:06 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id fs8sm10831683wib.8.2015.03.15.05.30.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2015 05:30:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1645103.91WotSCBpm@linux-wzza.site>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265492>

Hi,

On 03/15, Arup Rakshit wrote:
> Hi,
> 
> I am trying to ignore 2 files, but getting error -
> 
> [arup@sztukajedzenia (SJ002)]$ git status
> # On branch SJ002
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       .ruby-gemset
> #       .ruby-version
> nothing added to commit but untracked files present (use "git add" to track)
> [arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-gemset
> fatal: Unable to mark file .ruby-gemset
> [arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-version
> fatal: Unable to mark file .ruby-version
> [arup@sztukajedzenia (SJ002)]$

With --assume-unchanged you're promising git that you will not change
a file that is already in the repository.  Git doesn't check those
files for changes anymore, which can improve performance.

> Why it is throwing error ? And how to achieve this without taking
> the help of the file `.gitignore` ?

You can create a file .git/info/exclude in the root directory of the
repository with the same syntax as .gitignore to ignore these files.
This rules will not be commited in the repository.

> -- 
> ================
> Regards,
> Arup Rakshit
> ================
> Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.
> 
> --Brian Kernighan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
