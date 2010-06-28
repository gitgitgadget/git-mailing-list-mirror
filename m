From: Karl Stenerud <kstenerud@gmail.com>
Subject: Re: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 12:56:49 -0400
Message-ID: <ECC14D96-DAA0-4165-9FC5-43328504CE09@gmail.com>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com> <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 18:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTHdi-0001Qb-TW
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 18:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab0F1Q4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 12:56:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59622 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab0F1Q4w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 12:56:52 -0400
Received: by vws5 with SMTP id 5so246802vws.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:mime-version
         :subject:from:in-reply-to:date:content-transfer-encoding:message-id
         :references:to:x-mailer;
        bh=eaWZJz5v3F7HsERtXUAm1+ITI/rS1nKOFSR+W3l7jDc=;
        b=Z9ZEUJ4tpTb54yvGgJskALiPUg+sU/2+w7Pbu6uvV3vAMiUYrGuL5PGLQrFqHr6rVZ
         fr7sJ8m6x6/KYEf3I4s117cTmkPexOK5ImJ6fHzAAWmVlrQ3vGMK1jSqo+c5Ho2UTMFE
         GVIKrsTjdb5e1eNbwXRw451n1TsW4K7JM0F9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=UPychhRofBlR/I3nnGWVM/7ik73GSctTRePdAxoxtpOJ5w+1fqJuX5hPlSflMPvPD6
         dEyLIn25ZAnu9yWVkGerFmI1umzytTmAdNUWMhCQvXOadPj2JV9D1PkG9PpD1c1ToT7H
         aiY2BPMc/aNq3NQpDxfgA+whuaXfVNNz70aXg=
Received: by 10.224.85.196 with SMTP id p4mr3538757qal.6.1277744210909;
        Mon, 28 Jun 2010 09:56:50 -0700 (PDT)
Received: from [192.168.3.101] ([38.98.193.18])
        by mx.google.com with ESMTPS id e16sm25534526qcg.23.2010.06.28.09.56.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 09:56:50 -0700 (PDT)
In-Reply-To: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149840>


On 2010-06-28, at 12:29 PM, Chris Packham wrote:

> On Mon, Jun 28, 2010 at 9:10 AM, Karl Stenerud <kstenerud@gmail.com> wrote:
>> Hi,
>> 
>> As I did a git pull on my project today, git went into some kind of auto gc mode:
>> 
>> Auto packing the repository for optimum performance. You may also
>> run "git gc" manually. See "git help gc" for more information.
>> Counting objects: 4531, done.
>> 
>> This is, of course, quite an annoying feature since it could hit at any (inconvenient) time.
>> 
>> The git help tells me I can disable it by setting gc.auto to 0, while the mailing list archive tells me I also have to set gc.autopacklimit to 0.  This is fine, but if I do that, I won't know when the repo is in need of cleanup.  Is there any option I can set to instruct it to simply TELL me when it's in need of gc?
>> 
> 
> I don't think there is an existing configuration for this but I think
> you can achieve what you want with the "pre-auto-gc" hook. From the
> githooks(5) man page
> 
>  pre-auto-gc
>     This hook is invoked by git gc --auto. It takes no parameter, and
>     exiting with non-zero status from this script causes the git gc --auto
>     to abort.
> 
> So a hook like
> 
>  #! /bin/sh
>  echo "repository needs git gc"
>  exit 1
> 
> Should cause the auto gc to be skipped.


Cool thanks!  I'll give that a shot.
