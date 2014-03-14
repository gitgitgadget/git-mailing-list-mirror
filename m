From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Sat, 15 Mar 2014 06:30:47 +0700
Message-ID: <CACsJy8DtuCCYmmsEFB_m-YPHOOQ4FuchvnYQeuv75-vcSMej_w@mail.gmail.com>
References: <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org> <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net> <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net> <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
 <20140311203650.GA31173@sigill.intra.peff.net> <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
 <CAJo=hJvy6KKMNT9iyZAnKy18Pa+rQkKPQtfqT1e+ddXoVwX0yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 00:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WObZU-0002R3-4C
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 00:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438AbaCNXbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 19:31:19 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36618 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbaCNXbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 19:31:18 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so9374247qgd.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rXe6vU9KGUNXV0clH1vAjsjRQL/Amw2lUUJd8Y6ooRs=;
        b=BC1xljaYlCc/LafTYU7DDLGrvlDYJPwiuwtbKloctkcCtja9XzysLlCmU5DsADD63m
         3MhRs/Wkl242Ly58tPN/BSfvCsg49BUXi85xgzuHvX42R01VpMBpV9wwKI61MpC1Ufo7
         PS6+EmYbcEKJyjRWl3RRcCpf1fWUdtP6S7cV8XrTP51EjWIxxVdTPipztQSHlyxLzEP1
         q26voO/juOViulgU6WMmZYC530KI2LlWGK6R3Rel1gVs6V9xQACGCgQyVdFcV3bh+qpY
         ttOnnZhdzJoiG2ELGpFSV84HJpAJyQ1sDNlYbs8uHT5tQ+sIlke8OMaRf08+mZBNmxlK
         XC/g==
X-Received: by 10.140.51.109 with SMTP id t100mr12348033qga.50.1394839878101;
 Fri, 14 Mar 2014 16:31:18 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 14 Mar 2014 16:30:47 -0700 (PDT)
In-Reply-To: <CAJo=hJvy6KKMNT9iyZAnKy18Pa+rQkKPQtfqT1e+ddXoVwX0yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244122>

On Fri, Mar 14, 2014 at 11:45 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Fri, Mar 14, 2014 at 5:37 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Mar 12, 2014 at 3:36 AM, Jeff King <peff@peff.net> wrote:
>>> If the client is limited to setting a few flags, then something like
>>> http can get away with:
>>>
>>>   GET foo.git/info/refs?service=git-upload-pack&advertise-symrefs&refspec=refs/heads/*
>>>
>>> And it does not need to worry about upload-pack2 at all. Either the
>>> server recognizes and acts on them, or it ignores them.
>>>
>>> But given that we do not have such a magic out-of-band method for
>>> passing values over ssh and git, maybe it is not worth worrying about.
>>
>> git could go the same if we lift the restriction in 73bb33a (daemon:
>> Strictly parse the "extra arg" part of the command - 2009-06-04). It's
>> been five years. Old daemons hopefully have all died out by now. For
>> ssh, I suppose upload-pack and receive-pack can take an extra argument
>> like "advertise-symrefs&refspec=refs/heads/*" (daemon would use it too
>> to pass the advertiment to upload-pack and receive-pack).
>
> Heh. IIRC you are talking about the DoS attack for git-daemon where
> you send an extra header and the process infinite loops forever? We
> really don't want a modern client attempting to upgrade the protocol
> with an ancient daemon to DoS attack that server.

Shouldn't vulnerable daemons be upgraded anyway? If they keep using
the vulnerable version for all these 5 years, I feel no sorry for new
clients DoSing them. Jeff's idea about "remote.*.useUploadPack2" still
applies here so after we attack the server once, it'll be black listed
for a while (or forever).

>> That would make all three not need to change the underlying protocol
>> for capability advertisement. Old git-daemon, upload-pack and
>> receive-pack will fail hard on the new advertisement though, unlike
>> http. But that's no worse than upload-pack2.
>
> You missed the SSH case. It doesn't have this slot to hide the data into.

Right now we run this for ssh case: "ssh <host> git-upload-pack
<repo-path>". New client can do this instead

ssh <host> git-upload-pack <repo-path> <client capability flags>
-- 
Duy
