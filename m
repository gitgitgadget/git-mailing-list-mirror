From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Thu, 16 Apr 2015 13:31:02 +0200
Organization: gmx
Message-ID: <27f1120c2c5231d8c7add8bdac7e3b21@www.dscho.org>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Andreas Mohr <andi@lisas.de>, git@vger.kernel.org, msysGit
 <msysgit@googlegroups.com>, git-owner@vger.kernel.org
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBCZPH74Q5YNRB6F2X2UQKGQEM2AWFOI@googlegroups.com Thu Apr 16 13:31:09 2015
Return-path: <msysgit+bncBCZPH74Q5YNRB6F2X2UQKGQEM2AWFOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB6F2X2UQKGQEM2AWFOI@googlegroups.com>)
	id 1Yii0f-0006SQ-Tb
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 13:31:05 +0200
Received: by lbiv13 with SMTP id v13sf23649193lbi.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Bhz9Vge8EQwXVY4QamNHlJI1jUA3QiklKzVKS2eX5l8=;
        b=zDSkQLLA1/cYEKRXZFgoEjLDGid2bt2lY6G6n+9I/EoK9fFOc3HnlurymbgaySxmbm
         zNI/323GP6merwiDlR9fuMZE0CTCReXsiTX4KTmgDq1otE4xQjfOXcutZp8BeeVF8xrU
         RP72xNg3U4tNDoojfLumTe/vYpCVPBPV1Q6duHulnOKdT6OuGj9w0e6rrjRPsuqBlfxK
         0y+xwelINs7WjYVJ5pZNf+Hn/a3o0sIppMHNahlRDWbyjP9yzg+kWLsuI1jV+3Urih/T
         epQb/PtJDceBb5RUQ0w0u7zx/ctbM7FIDDDoyNOQkP4xFf9jCT5F3iI3E3wQlphbSvmr
         kR4Q==
X-Received: by 10.152.22.198 with SMTP id g6mr373676laf.28.1429183865551;
        Thu, 16 Apr 2015 04:31:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.67 with SMTP id o3ls272715laj.67.gmail; Thu, 16 Apr
 2015 04:31:04 -0700 (PDT)
X-Received: by 10.112.160.197 with SMTP id xm5mr7296324lbb.15.1429183864336;
        Thu, 16 Apr 2015 04:31:04 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id m3si1135491wia.1.2015.04.16.04.31.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 04:31:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MTSmp-1YpgOn3Wvn-00SN13; Thu, 16 Apr 2015 13:31:02
 +0200
In-Reply-To: <552F98AC.5030603@virtuell-zuhause.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:5LGXKi2a5ZxOTEAcxY2LiKqPuJypyImpc6vsmvcq4QJO4HktN/c
 QhqtvNyBWdDtBcnuSqzDmLGJ7trEiBkNwdabnj/h5Sgtd5mQ4nxB8uepN/9cTXzst9pt9NX
 eNtjbVtwmPd9GqnUlY/UryjMEQ8GqWbDoLegswUmiz0iSSEIqerbtB0mWbFisNA5el+y96U
 gB7ilKXgDyhjtNCnUM/Jg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267277>

Hi,

On 2015-04-16 13:10, Thomas Braun wrote:
> Am 16.04.2015 um 12:03 schrieb Andreas Mohr:
>>
>> over the years I've had the same phenomenon with various versions of msy=
sgit
>> (now at 1.9.5.msysgit.0, on Windows 7 64bit), so I'm now sufficiently
>> confident of it being a long-standing, longer-term issue and thus I'm
>> reporting it now.
>=20
> (CC'ing msysgit)

Good idea.

>> Since I'm doing development in a sufficiently rebase-heavy manner,
>> I seem to aggregate a lot of objects.
>> Thus, when fetching content I'm sufficiently frequently greeted with
>> a git gc run.
>> This, however, does not work fully reliably:
>>
>>     Auto packing the repository for optimum performance. You may also
>>     run "git gc" manually. See "git help gc" for more information.
>>     Counting objects: 206527, done.
>>     Delta compression using up to 4 threads.
>>     Compressing objects: 100% (27430/27430), done.
>>     Writing objects: 100% (206527/206527), done.
>>     Total 206527 (delta 178632), reused 206527 (delta 178632)
>>     Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb366=
0cedc264c3c.pack' failed. Should I try again? (y/n) n
>>     Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb366=
0cedc264c3c.idx' failed. Should I try again? (y/n) n
>>     Checking connectivity: 206527, done.
>>
>> A workable workaround for this recurring issue
>> (such a fetch will fail repeatedly,
>> thereby hampering my ability to update properly)
>> is to manually do a "git gc --auto"
>> prior to the fetch (which will then succeed).
>=20
> I've never had this issue. The error message from unlinking the file
> means that someone is still accessing the file and thus it can not be
> deleted (due to the implicit file locking on windows).

Best guess is that an antivirus is still accessing it. There is a tool call=
ed `WhoUses.exe` in msysGit (I do not remember if I included it into Git fo=
r Windows 1.x for end users) which could be used to figure out which proces=
s accesses a given file still: https://github.com/msysgit/msysgit/blob/mast=
er/mingw/bin/WhoUses.exe (maybe that would help you identify the cause of t=
he problem).

Ciao,
Johannes

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
