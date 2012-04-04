From: Emanuel Rietveld <codehotter@gmail.com>
Subject: Re: Git push to samba/cifs share fails
Date: Wed, 04 Apr 2012 10:35:16 +0200
Message-ID: <4F7C07C4.4010601@gmail.com>
References: <4F75DDF9.8060305@gmail.com> <4F77514C.10205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 10:34:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFLfW-0005t9-Su
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 10:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab2DDIeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 04:34:13 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46397 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2DDIeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 04:34:12 -0400
Received: by bkcik5 with SMTP id ik5so25124bkc.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vNu1CKhvI3jaBcWXTw6ypHVKIHIfld2gqxu/ZYt6/jI=;
        b=S+0+b9lfTQlVJ8Kwdjbi9x3XuOVxlVZFrtY+5r3n3rnGFueUKK0CQ0RhHtEPjujONm
         qA4kWg+62/XYs+qa/Y6ivK94GWfEnTGXL0Xw6dhvG6lHAFza1qfsnWtZ8yMdr7S1Yvz1
         Q/p/wux+rzgh1mUhuyrVtpvuvrtH5K02xxO/5eZMajl0GU+gvcgDfekzW07k7PWp9/Zg
         teJMQfIaOYaBS4OqmTgEZIS6vqI4SvASsJWpJZgZCBG6HsRffZicSW8mx/1ZSsnCPqr6
         ME7GK2Wfi6hQcEO4Wcnr1TNzCLMRFOBCTTOQsrn63PhrB1pDwVmrQwvkjZDYmDPq8GAm
         bOWQ==
Received: by 10.205.122.73 with SMTP id gf9mr6841452bkc.96.1333528450705;
        Wed, 04 Apr 2012 01:34:10 -0700 (PDT)
Received: from [192.168.2.53] (82-204-15-146.dsl.bbeyond.nl. [82.204.15.146])
        by mx.google.com with ESMTPS id r14sm51208486bkv.11.2012.04.04.01.34.09
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 01:34:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120316 Thunderbird/11.0
In-Reply-To: <4F77514C.10205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194688>

On 03/31/2012 08:47 PM, Sebastian Schuberth wrote:
> On 30.03.2012 18:23, Emanuel Rietveld wrote:
>
>> I get an error message when I try to push my git repository to a share
>> mounted with mount.cifs.
>
> Hmm, I wonder if this is related to msysgit's "Cannot fetch to mapped
> network drives (Samba)" issue here:
>
> http://code.google.com/p/msysgit/issues/detail?id=130
>
> Please note that the msysgit issue tracker is closed, so you should not
> place any comments there. Post to the msysgit mailing list instead.
>

Thank you for the link.

I am not using msysgit. My client is Fedora Linux 16 using git version 
1.7.7.6. What excuse can I use to post to the msysgit mailing list for 
this non-msys git problem?

I tried a git fetch as mentioned in the ticket and it fails with the 
below error message (same as git clone/git push).

[emanuel@f16machine /mnt/win2003share/frog.git]$ git fetch ~/proj/frog/
remote: Counting objects: 18, done.
remote: Compressing objects: 100% (16/16), done.
fatal: error when closing sha1 file: Bad file descriptor

I tried the suggestion in comment #14, which links to 
http://marc.info/?l=git&m=123797834905157&w=2 That is a very interesting 
email thread, but the suggestions do not solve the problem.

Doing git config core.fsyncobjectfiles = true on both source and 
destination git repositories makes no difference. Same error.

My cifs server OS is not samba on Linux, but a windows 2003 server.
A comment in the linked ticket claims that he only has problems on linux 
samba shares, not on windows shares. The ticket says it was eventually 
fixed on the server side. Is windows 2003 broken? Do I need to upgrade 
to windows 2008 to use git over cifs shares?

Thanks for your time.

Kind Regards,

Emanuel Rietveld
