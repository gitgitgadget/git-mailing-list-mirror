From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Mon, 27 Sep 2010 15:37:16 +0200
Message-ID: <AANLkTik5mr7MTPzrWPG00T40a08oiV7X8ZXBHkXva+DO@mail.gmail.com>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
 <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
 <7vy6asoz0i.fsf@alter.siamese.dyndns.org> <AANLkTi=p13eTY-dqGZJYaogRyj0Z5uO3YM8n1RW4iBUi@mail.gmail.com>
 <AANLkTikv8M8xuESQzO7qfPB72d51hTcosUgKreLu7Y=C@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com, git@vger.kernel.org, 
	"Shawn O. Pearce" <spearce@spearce.org>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncCOPdven-DxCsvILlBBoEd9jS0A@googlegroups.com Mon Sep 27 15:38:13 2010
Return-path: <msysgit+bncCOPdven-DxCsvILlBBoEd9jS0A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCsvILlBBoEd9jS0A@googlegroups.com>)
	id 1P0DuG-0007p8-5M
	for gcvm-msysgit@m.gmane.org; Mon, 27 Sep 2010 15:38:12 +0200
Received: by fxm14 with SMTP id 14sf1147468fxm.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 27 Sep 2010 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:mime-version:received
         :reply-to:in-reply-to:references:from:date:message-id:subject:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=vAquFP0/PcTTTZkAy7sFLGoJ6VXDXq/yENADcdhrqwM=;
        b=UE3vQhGNV6Vn13VLpnzo+okgnjzQ740vzRKYtveTMGt1Rlqq1Q2m+NB2j4NMIv+5Q9
         BROfLR0atPuJEfQwAC8JUfDayOAq6/mG2hB7B1gQgSejLhXGMGmFQmfdYCAUekJ839y4
         3BmCwY1gNxiKJLv5gd0pqE7vtVKcV761G1344=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        b=kkP6H3OEVux+0hbjPMir8CSlD+1grduTXEXO8FHdlwbjJZm83NxlxtQBNvyo+PjhBg
         xFyqDfGc5fXCYuzZ3wsDPK9nH2bqXg76ZmXZgRd19OAD+0W4JrVEVNbF8SrIItzKMIGr
         boxh7hIc+rmb4dFSATsm5kExvszfdadJMAHQ0=
Received: by 10.223.92.153 with SMTP id r25mr349350fam.38.1285594668859;
        Mon, 27 Sep 2010 06:37:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.27.83 with SMTP id h19ls1259948fac.0.p; Mon, 27 Sep 2010
 06:37:48 -0700 (PDT)
Received: by 10.223.104.198 with SMTP id q6mr405079fao.14.1285594668107;
        Mon, 27 Sep 2010 06:37:48 -0700 (PDT)
Received: by 10.223.104.198 with SMTP id q6mr405078fao.14.1285594668068;
        Mon, 27 Sep 2010 06:37:48 -0700 (PDT)
Received: from mail-fx0-f52.google.com (mail-fx0-f52.google.com [209.85.161.52])
        by gmr-mx.google.com with ESMTP id y11si1548559faj.10.2010.09.27.06.37.47;
        Mon, 27 Sep 2010 06:37:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.161.52 as permitted sender) client-ip=209.85.161.52;
Received: by mail-fx0-f52.google.com with SMTP id 17so3892504fxm.11
        for <msysgit@googlegroups.com>; Mon, 27 Sep 2010 06:37:47 -0700 (PDT)
Received: by 10.103.221.5 with SMTP id y5mr525064muq.134.1285594666430; Mon,
 27 Sep 2010 06:37:46 -0700 (PDT)
Received: by 10.220.95.193 with HTTP; Mon, 27 Sep 2010 06:37:16 -0700 (PDT)
In-Reply-To: <AANLkTikv8M8xuESQzO7qfPB72d51hTcosUgKreLu7Y=C@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.161.52 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157331>

On Mon, Sep 27, 2010 at 3:31 PM, Pat Thoyts <patthoyts@gmail.com> wrote:
> On 27 September 2010 14:19, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Fri, Sep 24, 2010 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>
>>>> On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>>>>> Since open() already sets errno correctly for the NULL-case, let's ju=
st
>>>>> avoid the problematic strcmp.
>>>>>
>>>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>>>
>>>> I guess I should add a comment as to why this patch is needed:
>>>>
>>>> This seems to be the culprit for issue 523 in the msysGit issue
>>>> tracker: http://code.google.com/p/msysgit/issues/detail?id=3D523
>>>>
>>>> fetch_and_setup_pack_index() apparently pass a NULL-pointer to
>>>> parse_pack_index(), which in turn pass it to check_packed_git_idx(),
>>>> which again pass it to open(). This all looks intentional to my
>>>> (http.c-untrained) eye.
>>>
>>> Surely, open(NULL) should be rejected by a sane system, and your patch
>>> looks sane to me.
>>>
>>
>> Since this doesn't seem to be in git.git yet, perhaps you could squash
>> this on top? I didn't notice it in time, but fopen lacked the same
>> check (freopen already had the check). It's not as important, because
>> it doesn't seem like we have any code reaching this path so far, but
>> it would IMO be better to fix this now rather than having to chase
>> down the issue again later...
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 4595aaa..f069fea 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -160,7 +160,7 @@ ssize_t mingw_write(int fd, const void *buf, size_t =
count)
>> =A0#undef fopen
>> =A0FILE *mingw_fopen (const char *filename, const char *otype)
>> =A0{
>> - =A0 =A0 =A0 if (!strcmp(filename, "/dev/null"))
>> + =A0 =A0 =A0 if (filename && !strcmp(filename, "/dev/null"))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0filename =3D "nul";
>> =A0 =A0 =A0 =A0return fopen(filename, otype);
>> =A0}
>>
>
> I'll apply this to the devel branch and try to remember to squash it
> on the next rebase-merge.
> Cheers,
> Pat
>

Wouldn't it be better to just get this squashed in git.git, and drop
the patch in the next rebase-merge? Since this bug is in git.git as
well, it makes sense to get the patch merged there, no?
