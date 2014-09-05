From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Fri, 5 Sep 2014 07:47:37 +0700
Message-ID: <CACsJy8CpxEn9Ubh1HzmMxY09agFqPbu0qEvY0PHFMSBj1Hrv3w@mail.gmail.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com> <CACsJy8C_=aNX9LT2V_zhw++tC22C5SDfwbpTS=juONMxwcV9pA@mail.gmail.com>
 <xmqqtx4nuy5k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 02:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPhhF-0002gq-PD
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 02:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbaIEAsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 20:48:09 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37970 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaIEAsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 20:48:08 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so2137914igd.17
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v5nk3ouhqcLQYJGMs5xROSwhyByBdj3lG3Xn6L8hasg=;
        b=qZTwMxrN7ERqVhnu0x0b6KVHSH2ndJB/gTr9oyrs75qeMt2zsyfiXRC8qyFNQd/WKQ
         sIP7laSE4jtU1w+w+lmV45cd0+ft5yQuJoLxTuFRlTGITrSM/PsyHPIPzYxXQ3bjpb9Y
         uADAjuywL7i2QIHr5ZGxlDSNgdVnTIlLo072JhG5umlE4FA1edpOoaApit3LJSn74M1k
         3CGSvRu/9IS5QoSKRyHsbMnyV7TPWLulMj/ifHpsDnoW7VBL7Kv5yfMeDIjSxr686SRs
         CteH2VvNZpuBBChM6iAchvuPSQImdrR9bXEBQQlYM800avZKyeM5bJM1OFGaOUBozJVV
         yIKA==
X-Received: by 10.42.204.76 with SMTP id fl12mr10365324icb.80.1409878087935;
 Thu, 04 Sep 2014 17:48:07 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Thu, 4 Sep 2014 17:47:37 -0700 (PDT)
In-Reply-To: <xmqqtx4nuy5k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256493>

On Thu, Sep 4, 2014 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Sep 3, 2014 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> * nd/multiple-work-trees (2014-07-29) 39 commits
>>>
>>>  Reroll posted, but haven't picked up yet.  How would this interact
>>>  with rr/transaction series which is pretty much all about the refs?
>>
>> Haven't checked out that topic yet. But ref changes in
>> multiple-work-trees are to make sure ref path construction goess
>> through git_path(), and some cleaning up after strbuf_git_path() is
>> introduced. So basically textual conflicts only.
>
> Up to the point that is queued on 'pu', the other topic(s) still
> keep the assumption that all refs are files in $GIT_DIR/refs/, and I
> think I managed the textual conflicts correctly in 'pu' before.
>
> But starting from $gmane/255476 the assumption gradually gets lifted
> and eventually we may have refs and reflogs expressed in a different
> backend, without these files that represent the refs at all.
>
> I am not yet sure how this "I have $GIR_DIR/ but that is not a real
> one but borrows most of the stuff from elsewhere" meshes with that
> new world.

The refs/* path conversion should stay with the current filesystem
backend. How to share new backends in multiple worktrees is another
interesting problem. But I should stop saying any more until I read
this backend-struct-db  topic.
-- 
Duy
