From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Thu, 8 Aug 2013 15:37:42 -0700
Message-ID: <C525FA0D-D22C-4C78-8C97-45819FD58DD7@gmail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com> <52040F27.4050908@googlemail.com> <20130808221807.GA8518@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Andrew Ruder <andy@aeruder.net>, Git List <git@vger.kernel.org>
To: Justin Collum <jcollum@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 00:37:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Yq6-0000lX-CT
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 00:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966822Ab3HHWhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 18:37:47 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:54000 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966767Ab3HHWhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 18:37:46 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so4153425pab.35
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=75PhQA7tIwUgFLdsDYf2o7KKKNfcoNz9hDITygecR5I=;
        b=i7ro4HubAJfTjT/1AmwdKc28s4BZwWS9fsma+bN2Y15rvCQS3othEwpZsMznSQAoH7
         KjlzcwbVmARXu9lZG9qOeyFK/vg8Ex40AJ415gXX0m0qy++aNI1xLD91Zlh/ORAxl41H
         f35K8Z1szODi/ZdtPx/g720w4wKRgmCGMqNPcVIc1T02mqkRfaRqUa9qDZlYl3V0Z520
         0PjMSsLZoOp7purhj7UraNATF5VdhbhjKG6eo8LOl47Let5myJpxm+/btCG5A3NM4hLl
         sY63yMI5LRSXhCvoMdQD7ydRIWqUpUnGXJiOeGb9az0999WbHbplU0Ng84/DHCfr5QJU
         VgJw==
X-Received: by 10.68.253.138 with SMTP id aa10mr8400591pbd.24.1376001465582;
        Thu, 08 Aug 2013 15:37:45 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qp10sm18708175pab.13.2013.08.08.15.37.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 15:37:44 -0700 (PDT)
In-Reply-To: <20130808221807.GA8518@gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231948>

On Aug 8, 2013, at 15:18, Andrew Ruder wrote:
> On Thu, Aug 08, 2013 at 11:35:35PM +0200, Stefan Beller wrote:
>> On 08/08/2013 10:27 PM, Justin Collum wrote:
>>> [...]
>>> -rwxrwxrwx   1 dev dev  17K Aug  8 13:12 index
>>> [...]
>>> -rw-rw-r--   1 dev dev  17K Aug  8 13:16 index   # <---------------
>>
>> The permissions are set to reading for all and writing for you(r  
>> user)
>> and your group. This should be no problem with standard git commands.
>> Before you had the index file executable, why would you need that?
>
> I'm about 90% sure the issue he's having is that the write bit for
> other/world goes away and he is neither the user dev or the group dev
> and the reason for all the executable bits is that he is regularly
> running
>
>    chmod -R 777 .
>
> Justin, if this is true, I will tell you that git respects your umask
> but I just can't bring myself to really suggest someone type umask 000
> ever. :(


Justin,

If you really want a repository that's writable by everyone, why not  
just do "git config core.sharedRepository 0666" ?

If you just want them to be group-writable you may be happier with  
"git config core.sharedRepository true" or possibly "git config  
core.sharedRepository all".  The setting is described fully in "git  
help config".
