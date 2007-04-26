From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git submodule support feedback
Date: Thu, 26 Apr 2007 22:28:44 +0100
Message-ID: <200704262228.46864.andyparkins@gmail.com>
References: <200704261238.51234.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 23:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBWf-0001Ll-LL
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXDZV3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbXDZV3O
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:29:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:57148 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbXDZV3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:29:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so701488uga
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 14:29:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K3g/nZqhUjtm6WRhtdKYJxjJhiYOf1nvc+zIW8a9rXqujkG76wDmYTqeUj6asacjvJUXlFXgxqUfZ7G3/R1+35i09zQf7b5J2kyoNCSQCarFKKWg2iC5pEsy9xFcy3hytkitBZzVKTGCFHv/6Nk6Zjw1QunxJDNnUb5/iV5CPWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ASuQipAVXa5ocuRrfmhvKvgTvQNEk+ZH1JnYnR6UYY0Y7epsUc+qsmRx6NDqmGZ60CzS1f+dgFO2aT1bVCwsq5HzQmNCRP2ZPH4mSj9q+mj3res+3z9a8ELupfDJeVkQSVBZv5jxfZs0wH2Y4rPan1LoKg/6kUj0vGpOU817ZLM=
Received: by 10.67.15.15 with SMTP id s15mr2498501ugi.1177622952015;
        Thu, 26 Apr 2007 14:29:12 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id u1sm1101652uge.2007.04.26.14.29.05;
        Thu, 26 Apr 2007 14:29:09 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200704261238.51234.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45661>

On Thursday 2007, April 26, Andy Parkins wrote:

> I'll report further as I come across any stumbling blocks; but here

The submodule support requires the latest version of git right?  That's 
going to cause trouble for people running different versions of git 
(I've already experienced it in my own limited way - I had to upgrade 
all the copies of git I have on my various computers before fetching 
and pushing would work).  If the repository contains a submodule 
reference it effectively becomes inaccessible by a version of git 
without submodule support.

I think that we might be able to avoid that problem though - am I right 
in thinking that the problem is that all the tools need teaching not to 
follow the gitlink object because that hash doesn't exist in _this_ 
tree it is a reference to a commit in another tree.

Wouldn't it be better if the gitlink reference pointed at an object in 
this tree which in turn referred to the submodule commit?  That way the 
old versions of git would still work with submodule objects in the 
repository because they would just see submodules as pointing at a 
blob.

Have I oversimplified it in my head?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
