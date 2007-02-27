From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 13:43:53 +0100
Message-ID: <46d6db660702270443w22361619p8cfb624780ee5a57@mail.gmail.com>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 27 13:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1gX-0004kN-5t
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030599AbXB0Mn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030601AbXB0Mn6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:43:58 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:2313 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030599AbXB0Mn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:43:57 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1681848wxd
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 04:43:56 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UXs5Ky5JMShFVVTXERHrUTZpZ/DYhMiLqIpuF2olrnvWW9uvx9DXH+9iD9ml5S01xrZrSOu6I98mvL5uatu4cvHlg/8aSl54hjrNEv/BND6N5kpe5F42eYJiN7wmUWoNBiK+2pJ/0S4icByYU+HZs/qfX+uRYo8wePSiO3dvRmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SnWyjfDVBsumLhpmkfFcZvfUE9ATT/zdDEVeOrpPnV7reX6HPFW88ZD2qkXrsU7gAFOy49BW/4JLmH2HC1klXWwm09lMNp3MOHN98OJlR8AqLqLyzAu2pR6wwIyWNEDWlWiKWaBwo7GoVEIFoAAXA467J7EI80rg7kVgqFGlOZY=
Received: by 10.115.19.16 with SMTP id w16mr459965wai.1172580233178;
        Tue, 27 Feb 2007 04:43:53 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Tue, 27 Feb 2007 04:43:53 -0800 (PST)
In-Reply-To: <E1HM1XL-00071C-N5@candygram.thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40722>

quoting Linus:

Well, you can just add

       [alias]
               cat=-p cat-file -p

to your ~/.gitconfig file, and you're there.

[ For all the non-git people here: the first "-p" is shorthand for
 "--paginate", and means that git will automatically start a pager for
 the output. The second "-p" is shorthand for "pretty" (there's no
 long-format command line switch for it, though), and means that git
 cat-file will show the result in a human-readable way, regardless of
 whether it's just a text-file, or a git directory ]

So then you can do just

       git cat todo:TODO

and you're done.

[ So for the non-git people, what that will actually _do_ is to show the
 TODO file in the "todo" branch - regardless of whether it is checked out
 or not, and start a pager for you. ]

I actually do this sometimes, but I've never done it for branches (and I
do it seldom enough that I haven't added the alias). I do it for things
like

       git cat v2.6.16:Makefile

-- 
Christian
