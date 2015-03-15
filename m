From: t.gummerer@gmail.com
Subject: Re: fatal: Unable to mark file .ruby-version
Date: Sun, 15 Mar 2015 17:58:19 +0100
Message-ID: <20150315165819.GA17591@hank>
References: <1645103.91WotSCBpm@linux-wzza.site>
 <20150315123004.GB12619@hank>
 <7217253.Nyz2WfkBbo@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 17:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXBrw-0002ax-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 17:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbbCOQ6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 12:58:24 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33083 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbCOQ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 12:58:23 -0400
Received: by wgbcc7 with SMTP id cc7so22845391wgb.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r2Fde+8d0x1ju6UZvb9QRN6EQyePKVwmIXmaupfGSWg=;
        b=Ai4V1/LOxGvis++1DAn79zRf9tL2YkMuF8wyXia6MoOLMW/65W15byC5k32oU9WwNf
         iPQhPSqFyQUEU+sPqFNP7rT/F3oqncKpQZrW48yhmLm991TRL3INYnpHMPYcMKinbGxF
         6DPfk1I9KBXpTNYErhq0HWvkmpA0rUaSCty15ysxUCUSUgpDS0UDPLHWxWK866nQPsL+
         mhurL7s0t3m53Dsg8usLCo6JllYdZ+ffeEw7i4KX6YQvXSxFq+RqlJrR0cF/+khfX1+m
         Js6nqT2lQI4cmvsijPg6SXK/wfdrWFLYjdZ/AFAj4cwhIgtwUDVDUI420gXgBmD+aiab
         N60w==
X-Received: by 10.194.59.112 with SMTP id y16mr118120670wjq.36.1426438701898;
        Sun, 15 Mar 2015 09:58:21 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id v13sm11653835wij.10.2015.03.15.09.58.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2015 09:58:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7217253.Nyz2WfkBbo@linux-wzza.site>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265498>

On 03/15, Arup Rakshit wrote:
> On Sunday, March 15, 2015 01:30:04 PM you wrote:
> > Hi,
> > 
> > On 03/15, Arup Rakshit wrote:
> > > Hi,
> > > 
> > > I am trying to ignore 2 files, but getting error -
> > > 
> > > [arup@sztukajedzenia (SJ002)]$ git status
> > > # On branch SJ002
> > > # Untracked files:
> > > #   (use "git add <file>..." to include in what will be committed)
> > > #
> > > #       .ruby-gemset
> > > #       .ruby-version
> > > nothing added to commit but untracked files present (use "git add" to track)
> > > [arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-gemset
> > > fatal: Unable to mark file .ruby-gemset
> > > [arup@sztukajedzenia (SJ002)]$ git update-index --assume-unchanged .ruby-version
> > > fatal: Unable to mark file .ruby-version
> > > [arup@sztukajedzenia (SJ002)]$
> > 
> > With --assume-unchanged you're promising git that you will not change
> > a file that is already in the repository.  Git doesn't check those
> > files for changes anymore, which can improve performance.
> > 
> 
> I didn't understand your point. Could you please elaborate more on it ?

--assume-unchanged only works on files that you added on the
repository, not on untracked files.  Because you don't seem to want
these files in the repository, update-index --assume-unchanged will
not work for you.

> > > Why it is throwing error ? And how to achieve this without taking
> > > the help of the file `.gitignore` ?
> > 
> > You can create a file .git/info/exclude in the root directory of the
> > repository with the same syntax as .gitignore to ignore these files.
> > This rules will not be commited in the repository.
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
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

-- 
Thomas Gummerer
