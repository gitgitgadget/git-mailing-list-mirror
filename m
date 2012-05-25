From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Fri, 25 May 2012 22:15:47 +0200
Message-ID: <20120525201547.GB86874@tgummerer>
References: <20120523122135.GA58204@tgummerer.unibz.it>
 <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 22:16:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0vZ-0002o7-IY
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab2EYUP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:15:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60395 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab2EYUP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:15:56 -0400
Received: by pbbrp8 with SMTP id rp8so2181269pbb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NQU+EA2DzkW27va2VkQvCvqN17PgiE0BubUq5sppw50=;
        b=WFSzW6IpVC4XvUqG+HzXeSoZx6TUCiehm02k8v1DaGZLTivGqQaDZ/rh3kHU3y7X+/
         Z4TLFvN9HHNbSTiX6pQU1wunO+9Wx8z6iTqAVPAevIFAV/ix5/Tss0Qnsw/IealRVje6
         lO2RPmSVHBWyomIUHY0q7fnHCjnsh11h9mddQpaZQP6dNlibedsXhPd8D4NmPHAO4W2p
         CgTyKWul8XzTZIWNMQawJsBrct+EEoG5JLLvhjCP43yR5sBddPJcqruUTXshgtYkd92Q
         5PnI4prUZhHeBKXLsoFFYtghGLaUxOi0w5t3GQbuhPX2AgyQfo7T/+gCR9tTrULbIG2n
         7QHw==
Received: by 10.68.197.41 with SMTP id ir9mr979540pbc.20.1337976955917;
        Fri, 25 May 2012 13:15:55 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id qt10sm10050592pbc.57.2012.05.25.13.15.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 May 2012 13:15:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198521>

On 05/25, Nguyen Thai Ngoc Duy wrote:
> On Wed, May 23, 2012 at 7:21 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > == Outlook for the next week ==
> >
> > - Start working on actual git code
> > - Read the header of the new format
> 
> I know it's out of scope, but it would be great if you could make
> ls-files read the new index format directly. Having something that
> actual works will ensure we don't overlook anything in the new format.
> We can then learn from ls-files lesson (especially how to handle both
> new/old format) and come up with api/in-core structures for the rest
> of git later.

Thanks for your suggestion. How did you think this should be done?
Writing a extra function in ls-files, just for outputting? I don't
think it is necessary to write a extra function, since the result
from the read_index_from function in read-cache is used for that
anyway. Or did you have something different in mind, that I'm missing
here?

--
Thomas
