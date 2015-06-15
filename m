From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] Documentation/i18n.txt: clarify character encoding support
Date: Mon, 15 Jun 2015 12:08:33 +0200
Message-ID: <557EA421.5050706@gmail.com>
References: <557C9161.6020703@gmail.com> <xmqqmw01ltid.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 12:08:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4RJo-0004YE-Sr
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 12:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbbFOKIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 06:08:37 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35954 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbbFOKIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 06:08:35 -0400
Received: by wgzl5 with SMTP id l5so39682111wgz.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 03:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YyIRmV8uPfm6PxlQtCwB4CAI1LQVVaKZV1axm0ZXeZA=;
        b=D4VHadyK1UNMZxgaeZdgi1/s0ylSO2bIuO2BAxZKHI6bpv4Chlut8sySd+t7w2uvUs
         34MKDjOLfW4SeUp87N4UIXg2og8Q/z3GxrWp9E9xwNDw8i3iRv7AnJzbsvf7sdHx4ehD
         n2vfa48RDF+SeejI9f9H5LFG3XYFmAGdzHlng98+FSTLMfOvSNy7x9CwLOL2GvpnGWLJ
         IeAjvi0WMlBeHE1W5iS+ZludLf3+dOj0yYoeyn1oJv+fGi4YqYK4Vf93mX37xbfhSS2h
         NbBLiPr5kp8QxksyiMrP/IIwVNSme2n/tYk73lTMa4wHQFA+hqExojjC46V8/ilRCsoc
         dH3g==
X-Received: by 10.194.109.229 with SMTP id hv5mr51416291wjb.119.1434362914386;
        Mon, 15 Jun 2015 03:08:34 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v3sm15074443wix.8.2015.06.15.03.08.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2015 03:08:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqmw01ltid.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271670>

Am 15.06.2015 um 02:12 schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
>> index e9a1d5d..e5f6233 100644
>> --- a/Documentation/i18n.txt
>> +++ b/Documentation/i18n.txt
>> @@ -1,18 +1,28 @@
>> -At the core level, Git is character encoding agnostic.
>> -
>> - - The pathnames recorded in the index and in the tree objects
>> -   are treated as uninterpreted sequences of non-NUL bytes.
>> -   What readdir(2) returns are what are recorded and compared
>> -   with the data Git keeps track of, which in turn are expected
>> -   to be what lstat(2) and creat(2) accepts.  There is no such
>> -   thing as pathname encoding translation.
>> +Git is to some extent character encoding agnostic.
> 
> I do not think the removal of the text makes much sense here unless
> you add the equivalent to the new text below.
> 
>>   - The contents of the blob objects are uninterpreted sequences
>>     of bytes.  There is no encoding translation at the core
>>     level.
>>  
>> - - The commit log messages are uninterpreted sequences of non-NUL
>> -   bytes.
>> + - Pathnames are encoded in UTF-8 normalization form C. This
> 
> That is true only on some systems like OSX (with HFS+) and Windows,
> no?  BSDs in general and Linux do not do any such mangling IIRC.

Modern Unices don't need any such mangling because UTF-8 NFC should
be the default system encoding. I'm not sure for BSDs, but it has
been the default on all major Linux distros for more than 10 years.

> I
> am OK with mangling described as a notable oddball to warn users,
> though; i.e. not as a norm as your new text suggests but as an
> exception.
> 

I would guess that non-UTF-8 Unices (or file systems) are the oddball
case, which is why I described them last. But I could be wrong.

>> +   platforms. If file system APIs don't use UTF-8 (which may be
>> +   file system specific), it is recommended to stick to pure
>> +   ASCII file names.
> 
> Hmph, who endorsed such a recommendation?  It is recommended to
> stick to whatever naming scheme that would not cause troubles to
> project participants.  If your participants all want to (and can)
> use ISO-8859-1, we do not discourage them from doing so.
> 

ISO-8859-x file names may be fine if you won't ever need to:
- use git-web, JGit, gitk, git-gui...
- exchange repos with "normal" (UTF-8) Unices, Mac and Windows systems
- publish your work on a git hosting service (and expect file and
  ref names to show up correctly in the web interface)
- store the repo on Unicode-based file systems (JFS, Joliet, UDF,
  exFat, NTFS, HFS, CIFS...)

These restrictions are not that obvious when you start a new git
project, and while converting file names after the fact is possible
(e.g. using the recodetree script we shipped with Git for Windows
1.7.10), it will destroy history.

Thus I think we should strongly discourage users from using anything
but UTF-8.
