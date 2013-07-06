From: Kyle McKay <mackyle@gmail.com>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and skelta mode
Date: Fri, 5 Jul 2013 20:41:53 -0700
Message-ID: <EAE13443-DA86-4965-999D-3CA36962AFE2@gmail.com>
References: <kr7beq$ilk$1@ger.gmane.org> <kr7jvu$62n$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Rothenberger <daveroth@acm.org>
X-From: git-owner@vger.kernel.org Sat Jul 06 05:42:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvJNp-00044Z-7V
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 05:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab3GFDl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 23:41:57 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:47556 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab3GFDl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 23:41:56 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so4235589oag.31
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 20:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=v7BY9bWRekZMx3fevYcF1Anxr/aAUDl6pV4kV84UoRg=;
        b=ToBX6dfgqaJZCsZLcLpi8upp5huILwth+O9vLhmbmiX1iszydauaBs6jy7BkQoTkOp
         Fi3bRAKk786NraAQSf3546g2VWxCDdfT1OT7MWxoi/e7/sFrr7YwUXb8WiYLJ3Gc5lfe
         KUIN1PRnv1grXmh5hvY8Qg3owUZhak+OMRoSjfD0j9kioFWl8cjRe0fjHUIm4dVGNSYS
         sZyce4lY5tIuPruKuwNKIOm7m+1kx2HQROBUB1aX+Icam8w0Qt8e5VkWKR/IjdXARLlE
         cILe6q1glBWm53Rv8dl6lpox1+e0XSqVzoqi/2xdiu5h33U4wXEd8febLMuv5kQvA7O/
         6eqg==
X-Received: by 10.182.95.71 with SMTP id di7mr13727197obb.12.1373082115759;
        Fri, 05 Jul 2013 20:41:55 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id q4sm20111033obl.1.2013.07.05.20.41.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 20:41:55 -0700 (PDT)
In-Reply-To: <kr7jvu$62n$1@ger.gmane.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229690>

On Jul 5, 2013, at 16:14, David Rothenberger wrote:
> On 7/5/2013 1:48 PM, David Rothenberger wrote:
>> I recently upgraded my Subversion server to 1.8.0 and started
>> receiving the following error from "git svn fetch":
>>
>> Temp file with moniker 'svn_delta' already in use at /usr/lib/perl5/ 
>> vendor_perl/5.10/Git.pm line 1024.
>>
>> This occurs only when using an http:// URL; svn:// URLs work fine.

I have created a patch (separate emails) that seems to work.  However,  
if the server being fetched against is not configured well for use  
with serf then "Error retrieving REPORT (54): Connection reset by peer  
Git/SVN/Ra.pm line 282" errors can occur and/or the fetch can be  
horribly slow compared to using neon.  If the "Connection reset" error  
occurs, the fetch can be restarted to get more revisions until it dies  
again.

Kyle
