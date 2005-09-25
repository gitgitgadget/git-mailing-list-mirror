From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 14:57:14 -0700 (PDT)
Message-ID: <20050925215714.54670.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 23:58:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJeUt-0004Gb-Dq
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 23:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVIYV5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 17:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVIYV5U
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 17:57:20 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:23947 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932308AbVIYV5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 17:57:20 -0400
Received: (qmail 54672 invoked by uid 60001); 25 Sep 2005 21:57:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=U0X7Z0xlmASTNcGOf1+8fN3bx8OsIqSAjp/01Xni906yabns1JwmKDM6HGFSNBUyIJtmo+s24eNH3WkaPY8xU/AbY1pceNKfbxNwLT5wCxomykq86zUBkqmosPah9ocFQpXKOu1ewLQ96NR3nfseAV7ufwkRqTA2Hyf0c8rITm4=  ;
Received: from [151.42.224.4] by web26303.mail.ukl.yahoo.com via HTTP; Sun, 25 Sep 2005 14:57:14 PDT
To: Robin Farine <robin.farine@terminus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9289>

Robin Farine wrote:

>Josef Weidendorfer <Josef.Weidendorfer <at> gmx.de> writes:    
>  
>
>>On Sunday 25 September 2005 09:07, Marco Costalba wrote:    
>>
>>>>>src/rangeselectbase.h QSettings: error creating /.qt    
>>>>>QSettings: error creating /.qt    
>>>
>>>...    
>>>QSettings are there from day one :-<    
>>>I am not able to let them disappear.....very bad. In any case should be    
>>>harmless.    
>>
>
>    
>With SCons, key-value pairs that are meant to appear in process    
>environment need to be added to the env['ENV'] mapping. In this  
>case:  
>   
>    env = Environment(...)  
>    env['ENV']['HOME'] = os.environ['HOME']   
>   
>Environment() creates an SCons build environment which is unrelated  
>to subprocess environments (even though the same word is used :)).  
>As a special case, SCons handles the mapping assigned to env['ENV']  
>as process environment for subprocesses.  
>  
>Hope this helps,  
>  

This helps a lot!

I added the line

env['ENV']['HOME'] = os.environ['HOME'] 

to my SConstruct and the warning disappeard :-)  :-)  :-)

This fix is greatly appreciated, thanks a lot Robin.

Marco

P.S: I have just pushed the fix, togheter with some other updates, 
to http://digilander.libero.it/mcostalba/qgit.git



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
