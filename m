From: David Srbecky <dsrbecky@gmail.com>
Subject: Why is the name of a blob SHA1("$type $size\0$data") and not SHA1("$data")?
Date: Thu, 30 Apr 2009 20:55:00 +0100
Message-ID: <49FA0214.70009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 21:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzcLi-0003nv-1e
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 21:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZD3TzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbZD3TzE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 15:55:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:56441 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZD3TzD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 15:55:03 -0400
Received: by ey-out-2122.google.com with SMTP id 9so519226eyd.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=BA8h2aRowTpVkBGjbJ8j2BHFVeVBrgUtSBSuRabpxm0=;
        b=lqNt+0V7Yf38uVkZEPbykfRMKmU31ooF2ppeGAfTWmFryX4Nd+8cUO1HD9t859+H6t
         G33cvPomYkqbM51cLSwrM3xFw2EApduFzY/qe5WUgSOIlhLCxrY0gKMXgUenC1Ko+RlA
         BvyTX+RLxefLbhk3VJY2sM52z+BS2pkUlclhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=mUpyE3w3W+5Eeptg3MyqqQZL1GRyngEvsX6wD6uz3uicCmT6HDzD/kxpYIWypnALoR
         W3t5CAdRc8tdzU9OCSblfsLoAAcG70LT4pGxpNaCtypFHeZmXVbGPY6QMQhimLVmQNoF
         yXrgsaraquMIvc7qq2nAnY1liZ2aSNaydfsWU=
Received: by 10.210.10.8 with SMTP id 8mr2147243ebj.13.1241121302236;
        Thu, 30 Apr 2009 12:55:02 -0700 (PDT)
Received: from ?172.31.60.173? (zone-7.jesus.cam.ac.uk [131.111.243.37])
        by mx.google.com with ESMTPS id 7sm4649301eyg.57.2009.04.30.12.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 12:55:00 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118042>

Hi,


First of all, congratulations on makeing such a great version control 
system.  I love the storage model - in comparison with other systems, it 
is just birantly simple and ingenious.


I started digging into the details and there is one thing that is really 
bugging me - why is the name of a blob SHA1("$type $size\0$data") and 
not SHA1("$data")?  I mean, wouldn't it be beautiful if the name of the 
blob would really just be the SHA1 of the uncompressed file content? :-)


Furthermore, is the header really necessary?  Wouldn't it be 
eqvivalently effective to put the blobs into own subdirectory? For 
example:  .git\objects\blob\22\22a3d28c5b2fca0eae83be1a2ed619e357f6a1e6
So the blob would contatin just be the compressed content and nothing 
else - beautiful :-)


I would really appriciate some comments on the design decisions so that 
I can sleep well at night :-)


David
